import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/storage/photo_storage.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_repository.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';
import 'package:terrace_garden/features/journal/data/drift_journal_repository.dart';
import 'package:terrace_garden/features/journal/domain/journal_entry.dart';
import 'package:terrace_garden/features/plantings/data/drift_planting_repository.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';
import 'package:terrace_garden/features/settings/domain/app_settings.dart';

import '../helpers/test_app.dart';

/// P6-05. Runs Flutter's accessibility guidelines on every main screen with
/// realistic data: tap targets of at least 48 dp (Android) and 44 pt (iOS),
/// labels on every tappable element, and text contrast.
void main() {
  final now = DateTime(2026, 10, 18, 9);
  final today = LocalDate.fromDateTime(now);

  Future<TestApp> seeded({bool dark = false}) async {
    final app = TestApp(
      now: now,
      settings: AppSettings(
        onboardingCompleted: true,
        themePreference: dark ? ThemePreference.dark : ThemePreference.system,
      ),
    );
    final clock = FixedClock(now);
    const logger = DeveloperLogger();
    final gardenId =
        (await DriftGardenRepository(
              app.database,
              clock,
              SequentialIdGenerator('g'),
              logger,
            ).create(
              const GardenDraft(
                name: 'Home garden',
                cityName: 'Delhi',
                region: GrowingRegion.northIndia,
                length: Length.cm(400),
                width: Length.cm(300),
                sun: SunExposure.moreThan6Hours,
                goals: {GardenGoal.vegetables},
              ),
            ))
            .valueOrNull!
            .id;
    final plantingId =
        (await DriftPlantingRepository(
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
            ))
            .valueOrNull!
            .id;
    await DriftJournalRepository(
      app.database,
      FileSystemPhotoStorage(() async => app.photoRoot, app.compressor),
      clock,
      SequentialIdGenerator('j'),
      logger,
    ).create(
      JournalDraft(
        gardenId: gardenId,
        plantingId: plantingId,
        date: today,
        note: 'First flowers',
        milestone: Milestone.flowering,
      ),
    );
    return app;
  }

  Future<void> expectGuidelines(
    WidgetTester tester, {
    bool contrast = true,
  }) async {
    final handle = tester.ensureSemantics();
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    if (contrast) {
      await expectLater(tester, meetsGuideline(textContrastGuideline));
    }
    handle.dispose();
  }

  Future<void> go(WidgetTester tester, String tab) async {
    await tester.tap(find.text(tab));
    await tester.pumpAndSettle();
  }

  testWidgets('Today with tasks', (tester) async {
    final app = await seeded();
    await app.pump(tester);
    expect(find.text('Check the soil'), findsOneWidget);
    await expectGuidelines(tester);
  });

  testWidgets('Garden overview', (tester) async {
    final app = await seeded();
    await app.pump(tester);
    await go(tester, 'Today');
    await tester.tap(find.text('Home garden'));
    await tester.pumpAndSettle();
    await expectGuidelines(tester);
  });

  testWidgets('Plants catalogue and plant detail', (tester) async {
    final app = await seeded();
    await app.pump(tester);
    await go(tester, 'Plants');
    await expectGuidelines(tester);
    await tester.tap(find.text('Aloe vera'));
    await tester.pumpAndSettle();
    await expectGuidelines(tester);
  });

  testWidgets('Plant ideas', (tester) async {
    final app = await seeded();
    await app.pump(tester);
    await go(tester, 'Today');
    await tester.tap(find.text('Home garden'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Plant ideas').first);
    await tester.pumpAndSettle();
    await expectGuidelines(tester);
  });

  testWidgets('Journal timeline and new entry', (tester) async {
    final app = await seeded();
    await app.pump(tester);
    await go(tester, 'Journal');
    expect(find.text('First flowers'), findsOneWidget);
    await expectGuidelines(tester);
    await tester.tap(find.byTooltip('New entry'));
    await tester.pumpAndSettle();
    await expectGuidelines(tester);
  });

  testWidgets('200% text on a small phone: no overflow on new screens', (
    tester,
  ) async {
    tester.view.physicalSize =
        const Size(360, 780) * tester.view.devicePixelRatio;
    addTearDown(tester.view.resetPhysicalSize);
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    Future<void> tapText(String text) async {
      final target = find.text(text);
      await tester.scrollUntilVisible(
        target,
        150,
        scrollable: find
            .byWidgetPredicate(
              (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
            )
            .last,
      );
      await tester.pumpAndSettle();
      await tester.tap(target.first);
      await tester.pumpAndSettle();
    }

    final app = await seeded();
    await app.pump(tester);
    expect(tester.takeException(), isNull, reason: 'Today');

    await go(tester, 'Plants');
    expect(tester.takeException(), isNull, reason: 'Plants');
    await tapText('Aloe vera');
    expect(tester.takeException(), isNull, reason: 'Plant detail');
    await tester.pageBack();
    await tester.pumpAndSettle();

    await go(tester, 'Journal');
    expect(tester.takeException(), isNull, reason: 'Journal');
    await tester.tap(find.byTooltip('New entry'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull, reason: 'New entry');
    await tester.pageBack();
    await tester.pumpAndSettle();

    await go(tester, 'Today');
    await tapText('Home garden');
    expect(tester.takeException(), isNull, reason: 'Garden overview');
    await tapText('Plant ideas');
    expect(tester.takeException(), isNull, reason: 'Plant ideas');
    await tapText('Add to a garden');
    expect(tester.takeException(), isNull, reason: 'Planting sheet');
  });

  testWidgets('dark theme: Today, Plants, Journal, Settings', (tester) async {
    final app = await seeded(dark: true);
    await app.pump(tester);
    await expectGuidelines(tester);
    await go(tester, 'Plants');
    await expectGuidelines(tester);
    await go(tester, 'Journal');
    await expectGuidelines(tester);
    await go(tester, 'Today');
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    await expectGuidelines(tester);
  });

  testWidgets('care calendar on a 360 dp phone', (tester) async {
    tester.view.physicalSize =
        const Size(360, 780) * tester.view.devicePixelRatio;
    addTearDown(tester.view.resetPhysicalSize);
    final app = await seeded();
    await app.pump(tester);
    await tester.tap(find.byTooltip('Care calendar'));
    await tester.pumpAndSettle();
    await expectGuidelines(tester);
  });

  testWidgets('Settings', (tester) async {
    final app = await seeded();
    await app.pump(tester);
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    await expectGuidelines(tester);
  });
}
