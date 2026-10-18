import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/care/presentation/care_calendar_screen.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_repository.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/plantings/data/drift_planting_repository.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';

import '../../../helpers/test_app.dart';

void main() {
  late TestApp app;
  final now = DateTime(2026, 10, 18, 6);
  final today = LocalDate.fromDateTime(now);

  setUp(() => app = TestApp(now: now));

  Future<void> seed({String speciesId = 'tomato'}) async {
    final clock = FixedClock(now);
    const logger = DeveloperLogger();
    final gardenId = (await DriftGardenRepository(
      app.database,
      clock,
      SequentialIdGenerator('g'),
      logger,
    ).create(const GardenDraft(name: 'Home garden'))).valueOrNull!.id;
    await DriftPlantingRepository(
      app.database,
      clock,
      SequentialIdGenerator('p'),
      logger,
    ).create(
      PlantingDraft(
        gardenId: gardenId,
        speciesId: speciesId,
        plantedOn: today,
        startedFrom: PlantingStart.seedling,
      ),
    );
  }

  Future<List<CareTaskRowView>> tasks() async => [
    for (final r in await app.database.select(app.database.careTasks).get())
      (type: r.type, status: r.status, dueOn: r.dueOn, skip: r.skipReason),
  ];

  Finder taskRow(String text) => find.ancestor(
    of: find.text(text),
    matching: find.byType(Row),
  );

  testWidgets('a new planting brings sourced checks to Today', (tester) async {
    await seed();
    await app.pump(tester);

    expect(find.text('2 tasks due today'), findsOneWidget);
    expect(find.text('Check the soil'), findsOneWidget);
    expect(find.text('Look for pests'), findsOneWidget);
    expect(find.text('Tomato'), findsNWidgets(2));
  });

  testWidgets('marking a soil check done schedules the next one', (
    tester,
  ) async {
    await seed();
    await app.pump(tester);

    final soilRow = find.ancestor(
      of: find.text('Check the soil'),
      matching: find.byType(Column),
    );
    await tester.tap(
      find.descendant(of: soilRow.first, matching: find.byTooltip('Mark done')),
    );
    await tester.pumpAndSettle();
    expect(find.text('Marked done'), findsOneWidget);
    expect(find.text('Done today'), findsOneWidget);
    expect(find.text('1 task due today'), findsOneWidget);

    final rows = await tasks();
    expect(
      rows.where((r) => r.type == CareTaskType.checkSoil).map((r) => r.status),
      containsAll([TaskStatus.done, TaskStatus.pending]),
    );
    expect(
      rows
          .firstWhere(
            (r) =>
                r.type == CareTaskType.checkSoil &&
                r.status == TaskStatus.pending,
          )
          .dueOn,
      today.addDays(1).toIso8601(),
    );
  });

  testWidgets('skip asks why and records the reason', (tester) async {
    await seed();
    await app.pump(tester);

    final pestMenu = find.descendant(
      of: find
          .ancestor(
            of: find.text('Look for pests'),
            matching: find.byType(Column),
          )
          .first,
      matching: find.byTooltip('Task options'),
    );
    await tester.tap(pestMenu);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.text('Why skip it?'), findsOneWidget);
    await tester.tap(find.text('Not needed'));
    await tester.pumpAndSettle();
    expect(find.text('Skipped'), findsOneWidget);

    final skipped = (await tasks()).firstWhere(
      (r) => r.status == TaskStatus.skipped,
    );
    expect(skipped.type, CareTaskType.inspectPests);
    expect(skipped.skip, SkipReason.notNeeded);
  });

  testWidgets('the soil-check guide adapts to the plant and cites sources', (
    tester,
  ) async {
    await seed(speciesId: 'aloeVera');
    await app.pump(tester);

    final soilMenu = find.descendant(
      of: find
          .ancestor(
            of: find.text('Check the soil'),
            matching: find.byType(Column),
          )
          .first,
      matching: find.byTooltip('Task options'),
    );
    await tester.tap(soilMenu);
    await tester.pumpAndSettle();
    await tester.tap(find.text('How to'));
    await tester.pumpAndSettle();
    expect(find.text('Check the soil · Aloe vera'), findsOneWidget);
    expect(find.textContaining('should dry out between'), findsOneWidget);
    expect(find.text('Sources: NC State Extension'), findsOneWidget);
  });

  testWidgets('turning reminders on asks permission and schedules a digest', (
    tester,
  ) async {
    await seed();
    await app.pump(tester);
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Daily care digest'),
      200,
      scrollable: find.byType(Scrollable).last,
    );

    app.notifications.permissionGranted = false;
    await tester.tap(find.text('Daily care digest'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Notifications are turned off'), findsOneWidget);
    expect(app.settings.stored.reminderEnabled, isFalse);

    app.notifications.permissionGranted = true;
    await tester.tap(find.text('Daily care digest'));
    await tester.pumpAndSettle();
    expect(app.settings.stored.reminderEnabled, isTrue);
    expect(app.notifications.permissionRequests, 2);
    final digest = app.notifications.scheduled[20261018]!;
    expect(digest.digest.fireAt, DateTime(2026, 10, 18, 7));
    expect(digest.body, startsWith('2 care tasks are due'));
  });

  testWidgets("the calendar shows counts per day and the day's tasks", (
    tester,
  ) async {
    await seed();
    await app.pump(tester);
    Finder dayCell(String label) => find.byWidgetPredicate(
      (w) => w is Semantics && w.properties.label == label,
    );

    Finder calendarList() => find
        .descendant(
          of: find.byType(CareCalendarScreen),
          matching: find.byType(Scrollable),
        )
        .first;

    await tester.tap(find.byTooltip('Care calendar'));
    await tester.pumpAndSettle();

    expect(find.text('October 2026'), findsOneWidget);
    // Today (18th) has the soil and pest checks.
    expect(dayCell('October 18, 2 tasks'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Look for pests · Tomato'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Check the soil · Tomato'), findsOneWidget);
    expect(find.text('Look for pests · Tomato'), findsOneWidget);

    await tester.scrollUntilVisible(
      dayCell('October 20'),
      -200,
      scrollable: calendarList(),
    );
    await tester.tap(dayCell('October 20'));
    await tester.pumpAndSettle();
    expect(find.text('Nothing scheduled on this day.'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.byTooltip('Next month'),
      -200,
      scrollable: calendarList(),
    );
    await tester.tap(find.byTooltip('Next month'));
    await tester.pumpAndSettle();
    expect(find.text('November 2026'), findsOneWidget);
  });

  testWidgets('the care plan can switch a check off', (tester) async {
    await seed();
    await app.pump(tester);
    await tester.tap(find.text('Garden'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home garden'));
    await tester.pumpAndSettle();

    final summary = find.text('1 plant · since Oct 18, 2026');
    await tester.scrollUntilVisible(summary, 200);
    final menu = find.descendant(
      of: find.ancestor(of: summary, matching: find.byType(ListTile)),
      matching: find.byTooltip('More actions'),
    );
    await Scrollable.ensureVisible(tester.element(menu), alignment: 0.5);
    await tester.pumpAndSettle();
    await tester.tap(menu);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Care plan'));
    await tester.pumpAndSettle();
    expect(find.text('Care plan: Tomato'), findsOneWidget);
    expect(
      find.text('Every 3 days after the last one is done'),
      findsOneWidget,
    );

    final pestSwitch = find.descendant(
      of: taskRow('Look for pests').first,
      matching: find.byType(Switch),
    );
    await tester.tap(pestSwitch);
    await tester.pumpAndSettle();
    final pending = (await tasks()).where(
      (r) =>
          r.type == CareTaskType.inspectPests && r.status == TaskStatus.pending,
    );
    expect(pending, isEmpty);
  });
}

typedef CareTaskRowView = ({
  CareTaskType type,
  TaskStatus status,
  String dueOn,
  SkipReason? skip,
});
