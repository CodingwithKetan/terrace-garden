import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/care/application/care_sync.dart';
import 'package:terrace_garden/features/care/data/drift_care_repository.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/care/domain/recurrence.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_repository.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';
import 'package:terrace_garden/features/plant_catalog/data/catalogue_parser.dart';
import 'package:terrace_garden/features/plant_catalog/domain/catalogue_repository.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plantings/data/drift_planting_repository.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';

import '../../../helpers/fake_notification_scheduler.dart';

class _FileCatalogue implements CatalogueRepository {
  @override
  Future<PlantCatalogue> load() async => CatalogueParser.parse(
    plantsJson: File('assets/catalogue/plants.json').readAsStringSync(),
    sourcesJson: File('assets/catalogue/sources.json').readAsStringSync(),
  );
}

void main() {
  late AppDatabase db;
  late FixedClock clock;
  late DriftCareRepository care;
  late DriftPlantingRepository plantings;
  late CareSync sync;
  late String gardenId;
  final today = LocalDate(2026, 10, 18);

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    clock = FixedClock(DateTime(2026, 10, 18, 9));
    const logger = DeveloperLogger();
    care = DriftCareRepository(db, SequentialIdGenerator('c'), logger);
    plantings = DriftPlantingRepository(
      db,
      clock,
      SequentialIdGenerator('p'),
      logger,
    );
    final gardens = DriftGardenRepository(
      db,
      clock,
      SequentialIdGenerator('g'),
      logger,
    );
    gardenId = (await gardens.create(
      const GardenDraft(name: 'Chennai roof', region: GrowingRegion.tamilNadu),
    )).valueOrNull!.id;
    sync = CareSync(
      care: care,
      plantings: plantings,
      gardens: gardens,
      catalogue: _FileCatalogue(),
      clock: clock,
      logger: logger,
    );
  });

  tearDown(() => db.close());

  Future<String> plant(String speciesId) async => (await plantings.create(
    PlantingDraft(gardenId: gardenId, speciesId: speciesId, plantedOn: today),
  )).valueOrNull!.id;

  test("gives new plantings a plan and today's tasks, idempotently", () async {
    final tomato = await plant('tomato');
    await sync.reconcile();
    final rules = await care.watchRules(tomato).first;
    expect(rules.map((r) => r.type).toSet(), {
      CareTaskType.checkSoil,
      CareTaskType.inspectPests,
      CareTaskType.feed,
      CareTaskType.transplant,
      CareTaskType.harvest,
    });
    final pending = await care.watchPending().first;
    expect(
      pending.where((t) => t.dueOn == today).map((t) => t.type).toSet(),
      {CareTaskType.checkSoil, CareTaskType.inspectPests},
    );

    await sync.reconcile();
    expect(await care.watchRules(tomato).first, hasLength(rules.length));
    expect(await care.watchPending().first, hasLength(pending.length));
  });

  test('uses the garden region (jasmine pruning in Tamil Nadu)', () async {
    final jasmine = await plant('jasmine');
    await sync.reconcile();
    final types = (await care.watchRules(jasmine).first).map((r) => r.type);
    expect(types, contains(CareTaskType.prune));
  });

  test('skips plantings whose species is not in the catalogue', () async {
    await plant('notAPlant');
    await sync.reconcile();
    expect(await care.plantingIdsWithRules(), isEmpty);
  });

  test('overlapping calls coalesce without duplicating plans', () async {
    final okra = await plant('okra');
    await Future.wait([sync.reconcile(), sync.reconcile(), sync.reconcile()]);
    final rules = await care.watchRules(okra).first;
    expect(rules.where((r) => r.type == CareTaskType.checkSoil), hasLength(1));
  });

  group('after a planting edit (KI-027)', () {
    Future<Map<CareTaskType, CareRule>> rulesOf(String id) async => {
      for (final r in await care.rulesFor(id)) r.type: r,
    };

    test('moving the planting date moves transplant and harvest', () async {
      final tomato = await plant('tomato');
      await sync.reconcile();
      final before = await rulesOf(tomato);
      expect(
        before[CareTaskType.transplant]!.recurrence,
        Once(today.addDays(25)),
      );

      final planting = (await plantings.find(tomato))!;
      await plantings.update(
        tomato,
        PlantingDraft.of(planting).copyWith(plantedOn: today.addDays(-10)),
      );
      await sync.reconcile();
      final after = await rulesOf(tomato);
      expect(
        after[CareTaskType.transplant]!.recurrence,
        Once(today.addDays(15)),
      );
      expect(after[CareTaskType.harvest]!.recurrence, Once(today.addDays(80)));
      // Repeating checks are untouched.
      expect(
        after[CareTaskType.checkSoil]!.id,
        before[CareTaskType.checkSoil]!.id,
      );
    });

    test('switching to a seedling removes the transplant task', () async {
      final tomato = await plant('tomato');
      await sync.reconcile();
      final planting = (await plantings.find(tomato))!;
      await plantings.update(
        tomato,
        PlantingDraft.of(
          planting,
        ).copyWith(startedFrom: PlantingStart.seedling),
      );
      await sync.reconcile();
      expect(
        (await rulesOf(tomato)).keys,
        isNot(contains(CareTaskType.transplant)),
      );
      expect(
        (await care.watchPending().first).where(
          (t) => t.type == CareTaskType.transplant,
        ),
        isEmpty,
      );
    });

    test(
      'a rule the user switched off stays off when its date moves',
      () async {
        final tomato = await plant('tomato');
        await sync.reconcile();
        final harvest = (await rulesOf(tomato))[CareTaskType.harvest]!;
        await care.updateRule(harvest.copyWith(enabled: false), today: today);
        final planting = (await plantings.find(tomato))!;
        await plantings.update(
          tomato,
          PlantingDraft.of(planting).copyWith(plantedOn: today.addDays(-5)),
        );
        await sync.reconcile();
        final after = (await rulesOf(tomato))[CareTaskType.harvest]!;
        expect(after.enabled, isFalse);
        expect(after.recurrence, Once(today.addDays(85)));
      },
    );
  });

  group('NotificationSync', () {
    test('schedules digests, then only applies changes', () async {
      await plant('tomato');
      await sync.reconcile();
      final scheduler = FakeNotificationScheduler();
      final notifications = NotificationSync(
        care: care,
        scheduler: scheduler,
        clock: FixedClock(DateTime(2026, 10, 18, 6)),
        logger: const DeveloperLogger(),
      );
      Future<void> run({required bool enabled}) async => notifications.sync(
        tasks: await care.watchPending().first,
        enabled: enabled,
        minutesOfDay: 7 * 60,
        title: 'Your garden today',
        body: (n) => '$n tasks',
      );

      await run(enabled: true);
      final today = scheduler.scheduled[20261018]!;
      expect(today.body, '2 tasks');
      expect(today.digest.fireAt, DateTime(2026, 10, 18, 7));
      expect(
        await care.scheduledDigests(),
        hasLength(scheduler.scheduled.length),
      );

      await run(enabled: true);
      expect(
        await care.scheduledDigests(),
        hasLength(scheduler.scheduled.length),
      );

      await run(enabled: false);
      expect(scheduler.scheduled, isEmpty);
      expect(await care.scheduledDigests(), isEmpty);
    });
  });
}
