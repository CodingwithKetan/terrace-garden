import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/care/data/drift_care_repository.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/care/domain/notification_planner.dart';
import 'package:terrace_garden/features/care/domain/recurrence.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_repository.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/plantings/data/drift_planting_repository.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';

void main() {
  late AppDatabase db;
  late DriftCareRepository care;
  late String gardenId;
  late String plantingId;
  final today = LocalDate(2026, 10, 18);

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    final clock = FixedClock(DateTime(2026, 10, 18, 9));
    const logger = DeveloperLogger();
    care = DriftCareRepository(db, SequentialIdGenerator('c'), logger);
    gardenId = (await DriftGardenRepository(
      db,
      clock,
      SequentialIdGenerator('g'),
      logger,
    ).create(const GardenDraft(name: 'Terrace'))).valueOrNull!.id;
    plantingId =
        (await DriftPlantingRepository(
              db,
              clock,
              SequentialIdGenerator('p'),
              logger,
            ).create(
              PlantingDraft(
                gardenId: gardenId,
                speciesId: 'tomato',
                plantedOn: today,
              ),
            ))
            .valueOrNull!
            .id;
  });

  tearDown(() => db.close());

  Future<void> addRules(List<CareRuleDraft> drafts) async {
    final result = await care.addRules(
      gardenId: gardenId,
      plantingId: plantingId,
      drafts: drafts,
      createdOn: today,
    );
    expect(result, isA<Ok<void>>());
  }

  Future<List<CareTask>> agenda({int days = 7, LocalDate? on}) => care
      .watchAgenda(
        until: (on ?? today).addDays(days),
        doneOn: on ?? today,
      )
      .first;

  test('rules round-trip every recurrence kind', () async {
    final recurrences = <Recurrence>[
      FromCompletion(days: 1, start: today),
      FixedInterval(days: 28, anchor: today),
      Weekly(weekdays: const {1, 4}, start: today),
      Yearly(month: 11, day: 24, start: today),
      Once(today.addDays(25)),
    ];
    await addRules([
      for (final r in recurrences)
        CareRuleDraft(type: CareTaskType.feed, recurrence: r),
    ]);
    final rules = await care.watchRules(plantingId).first;
    expect(rules.map((r) => r.recurrence).toList(), recurrences);
    expect(await care.plantingIdsWithRules(), {plantingId});
  });

  test('materialise is idempotent', () async {
    await addRules([
      CareRuleDraft(
        type: CareTaskType.checkSoil,
        recurrence: FromCompletion(days: 1, start: today),
      ),
      CareRuleDraft(
        type: CareTaskType.feed,
        recurrence: FixedInterval(days: 7, anchor: today),
      ),
    ]);
    expect((await care.materialize(today)).valueOrNull, 1 + 5);
    expect((await care.materialize(today)).valueOrNull, 0);
    expect(await care.watchPending().first, hasLength(6));
  });

  test('completing a check creates the next one from that day', () async {
    await addRules([
      CareRuleDraft(
        type: CareTaskType.checkSoil,
        recurrence: FromCompletion(days: 1, start: today),
      ),
    ]);
    await care.materialize(today);
    final first = (await agenda()).single;
    expect(first.dueOn, today);

    // Done two days late: the next check is the day after completion.
    final late = today.addDays(2);
    await care.complete(first.id, on: late, note: 'Dry, watered');
    final pending = await care.watchPending().first;
    expect(pending.single.dueOn, late.addDays(1));

    final done = (await agenda(on: late)).firstWhere(
      (t) => t.status == TaskStatus.done,
    );
    expect(done.completedOn, late);
    expect(done.note, 'Dry, watered');

    // Completing twice has no further effect.
    await care.complete(first.id, on: late);
    expect(await care.watchPending().first, hasLength(1));
  });

  test('skipping records the reason and also reschedules', () async {
    await addRules([
      CareRuleDraft(
        type: CareTaskType.checkSoil,
        recurrence: FromCompletion(days: 1, start: today),
      ),
    ]);
    await care.materialize(today);
    final task = (await agenda()).single;
    await care.skip(task.id, on: today, reason: SkipReason.rained);
    final all = await agenda();
    final skipped = all.firstWhere((t) => t.status == TaskStatus.skipped);
    expect(skipped.skipReason, SkipReason.rained);
    expect(all.where((t) => t.isPending).single.dueOn, today.addDays(1));
  });

  test('fixed rules do not add tasks on completion', () async {
    await addRules([
      CareRuleDraft(type: CareTaskType.harvest, recurrence: Once(today)),
    ]);
    await care.materialize(today);
    final task = (await agenda()).single;
    await care.complete(task.id, on: today);
    expect(await care.watchPending().first, isEmpty);
  });

  test('reschedule moves a pending task; unknown tasks fail', () async {
    await addRules([
      CareRuleDraft(type: CareTaskType.transplant, recurrence: Once(today)),
    ]);
    await care.materialize(today);
    final task = (await agenda()).single;
    await care.reschedule(task.id, today.addDays(3));
    expect((await care.watchPending().first).single.dueOn, today.addDays(3));
    expect(
      ((await care.reschedule('nope', today)) as Err).failure,
      isA<NotFoundFailure>(),
    );
  });

  test('disabling a rule removes its pending tasks', () async {
    await addRules([
      CareRuleDraft(
        type: CareTaskType.feed,
        recurrence: FixedInterval(days: 7, anchor: today),
      ),
    ]);
    await care.materialize(today);
    final rule = (await care.watchRules(plantingId).first).single;
    await care.updateRule(rule.copyWith(enabled: false), today: today);
    expect(await care.watchPending().first, isEmpty);
    expect((await care.materialize(today)).valueOrNull, 0);
  });

  test('changing an interval replaces pending tasks', () async {
    await addRules([
      CareRuleDraft(
        type: CareTaskType.inspectPests,
        recurrence: FromCompletion(days: 3, start: today),
      ),
    ]);
    await care.materialize(today);
    final rule = (await care.watchRules(plantingId).first).single;
    await care.updateRule(
      rule.copyWith(
        recurrence: FromCompletion(days: 7, start: today.addDays(2)),
      ),
      today: today,
    );
    expect((await care.watchPending().first).single.dueOn, today.addDays(2));
  });

  test('re-enabling a check after a completion counts from it', () async {
    await addRules([
      CareRuleDraft(
        type: CareTaskType.checkSoil,
        recurrence: FromCompletion(days: 2, start: today),
      ),
    ]);
    await care.materialize(today);
    await care.complete((await agenda()).single.id, on: today);
    var rule = (await care.watchRules(plantingId).first).single;
    await care.updateRule(rule.copyWith(enabled: false), today: today);
    expect(await care.watchPending().first, isEmpty);
    rule = (await care.watchRules(plantingId).first).single;
    await care.updateRule(rule.copyWith(enabled: true), today: today);
    expect((await care.watchPending().first).single.dueOn, today.addDays(2));
  });

  test('deleting the planting deletes its rules and tasks', () async {
    await addRules([
      CareRuleDraft(
        type: CareTaskType.checkSoil,
        recurrence: FromCompletion(days: 1, start: today),
      ),
    ]);
    await care.materialize(today);
    await (db.delete(db.plantings)..where((p) => p.id.equals(plantingId))).go();
    expect(await care.watchPending().first, isEmpty);
    expect(await care.plantingIdsWithRules(), isEmpty);
  });

  test('scheduled digests are recorded and diffed', () async {
    final a = PlannedDigest(
      id: 20261018,
      day: today,
      fireAt: DateTime(2026, 10, 18, 7),
      taskCount: 2,
    );
    await care.recordScheduled(
      NotificationDiff(cancel: const [], schedule: [a]),
    );
    expect(await care.scheduledDigests(), [a]);
    await care.recordScheduled(
      const NotificationDiff(cancel: [20261018], schedule: []),
    );
    expect(await care.scheduledDigests(), isEmpty);
  });
}
