import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_repository.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/journal/domain/journal_entry.dart';
import 'package:terrace_garden/features/plantings/data/drift_planting_repository.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';

import '../../../helpers/test_app.dart';

void main() {
  late TestApp app;
  final now = DateTime(2026, 10, 18, 9);
  final today = LocalDate.fromDateTime(now);

  setUp(() => app = TestApp(now: now));

  Future<void> seed() async {
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
        speciesId: 'tomato',
        plantedOn: today,
        startedFrom: PlantingStart.seedling,
      ),
    );
  }

  Future<void> openJournal(WidgetTester tester) async {
    await tester.tap(find.text('Journal'));
    await tester.pumpAndSettle();
  }

  testWidgets('records a harvest for a plant and shows it on the timeline', (
    tester,
  ) async {
    await seed();
    await app.pump(tester);
    await openJournal(tester);
    expect(find.text('Watch your garden grow'), findsOneWidget);

    await tester.tap(find.text('New entry'));
    await tester.pumpAndSettle();
    expect(find.text('New journal entry'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilterChip, 'Tomato'));
    await tester.tap(find.widgetWithText(FilterChip, 'Harvest'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Harvest amount'),
      '250',
    );
    await tester.tap(find.widgetWithText(FilterChip, 'Grams'));
    await tester.enterText(
      find.widgetWithText(TextField, 'Note'),
      'First ripe ones',
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Save entry'),
      300,
      scrollable: find
          .descendant(
            of: find.byType(ListView),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save entry'));
    await tester.pumpAndSettle();

    expect(find.text('Entry saved'), findsOneWidget);
    expect(find.text('Harvest · Tomato · 250 g'), findsOneWidget);
    expect(find.text('First ripe ones'), findsOneWidget);

    final rows = await app.database.select(app.database.journalEntries).get();
    expect(rows.single.milestone, Milestone.harvest);
    expect(rows.single.harvestUnit, HarvestUnit.grams);
  });

  testWidgets('an empty entry is not saved', (tester) async {
    await seed();
    await app.pump(tester);
    await openJournal(tester);
    await tester.tap(find.text('New entry'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Save entry'),
      300,
      scrollable: find
          .descendant(
            of: find.byType(ListView),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save entry'));
    await tester.pumpAndSettle();
    expect(find.text('Add a note, a milestone or a photo.'), findsOneWidget);
    expect(
      await app.database.select(app.database.journalEntries).get(),
      isEmpty,
    );
  });

  testWidgets('completed care appears on the timeline', (tester) async {
    await seed();
    await app.pump(tester);
    final soilGroup = find.ancestor(
      of: find.text('Check the soil'),
      matching: find.byType(Column),
    );
    await tester.tap(
      find.descendant(
        of: soilGroup.first,
        matching: find.byTooltip('Mark done'),
      ),
    );
    await tester.pumpAndSettle();

    await openJournal(tester);
    expect(find.text('1 care task done'), findsOneWidget);
    expect(find.text('Check the soil · Tomato'), findsOneWidget);
  });

  testWidgets('delete all data returns to onboarding', (tester) async {
    await seed();
    await app.pump(tester);
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Delete all data'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Delete all data'));
    await tester.pumpAndSettle();
    expect(find.text('Delete everything?'), findsOneWidget);
    await tester.tap(find.text('Delete everything'));
    await tester.pumpAndSettle();

    expect(find.text('Grow a garden that suits your terrace'), findsOneWidget);
    expect(await app.database.select(app.database.gardens).get(), isEmpty);
    expect(await app.database.select(app.database.plantings).get(), isEmpty);
    expect(await app.database.select(app.database.careTasks).get(), isEmpty);
    expect(app.settings.stored.onboardingCompleted, isFalse);
  });
}
