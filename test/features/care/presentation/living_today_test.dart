import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_repository.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';
import 'package:terrace_garden/features/garden_designer/data/drift_layout_repository.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/plantings/data/drift_planting_repository.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';

import '../../../helpers/test_app.dart';

/// Living Terrace Today and Seasons: the plan with pins, the soil-check
/// sheet's two answers, garden switching and the sowing almanac.
void main() {
  late TestApp app;
  final now = DateTime(2026, 10, 18, 7);
  final today = LocalDate.fromDateTime(now);
  final clock = FixedClock(now);
  const logger = DeveloperLogger();

  setUp(() => app = TestApp(now: now, surface: const Size(412, 915)));

  Future<String> garden(String name, {bool layout = true}) async {
    final id =
        (await DriftGardenRepository(
              app.database,
              clock,
              SequentialIdGenerator(name),
              logger,
            ).create(
              GardenDraft(
                name: name,
                cityName: 'Delhi',
                region: GrowingRegion.northIndia,
                length: const Length.cm(400),
                width: const Length.cm(300),
              ),
            ))
            .valueOrNull!
            .id;
    if (layout) {
      await DriftLayoutRepository(app.database, logger).saveElements(id, const [
        LayoutElement(
          id: 'bag',
          kind: ElementKind.growBag,
          center: Vec2(100, 100),
          width: 60,
          height: 45,
          depthCm: 30,
        ),
        LayoutElement(
          id: 'pot',
          kind: ElementKind.roundPot,
          center: Vec2(250, 100),
          width: 40,
          height: 40,
          depthCm: 30,
        ),
      ]);
    }
    return id;
  }

  Future<void> plant(
    String gardenId, {
    String? elementId,
    String speciesId = 'tomato',
  }) async {
    await DriftPlantingRepository(
      app.database,
      clock,
      SequentialIdGenerator('p$gardenId'),
      logger,
    ).create(
      PlantingDraft(
        gardenId: gardenId,
        speciesId: speciesId,
        plantedOn: today,
        startedFrom: PlantingStart.seedling,
        elementId: elementId,
      ),
    );
  }

  testWidgets('the plan pins a due check; "still moist" records a skip', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await plant(await garden('Terrace'), elementId: 'bag');
    await app.pump(tester);

    expect(find.text('1 plant would like a soil check'), findsOneWidget);
    expect(find.bySemanticsLabel('Plan of Terrace'), findsOneWidget);
    expect(find.bySemanticsLabel('Round pot, empty'), findsOneWidget);
    final pin = find.bySemanticsLabel('Tomato, Grow bag, check due');
    expect(pin, findsOneWidget);

    await tester.tap(pin);
    await tester.pumpAndSettle();
    expect(find.text('Tomato'), findsWidgets);
    expect(find.text('It was dry, I watered'), findsOneWidget);
    await tester.tap(find.text('Still moist, skip today'));
    await tester.pumpAndSettle();
    expect(find.text('Skipped'), findsOneWidget);

    final soil = await (app.database.select(
      app.database.careTasks,
    )..where((t) => t.type.equalsValue(CareTaskType.checkSoil))).get();
    expect(
      soil.map((t) => (t.status, t.skipReason)),
      contains((TaskStatus.skipped, SkipReason.soilStillMoist)),
    );
    handle.dispose();
  });

  testWidgets('without a layout, Today invites drawing one', (tester) async {
    await plant(await garden('Balcony', layout: false));
    await app.pump(tester);
    expect(find.text('Draw your terrace to see it here'), findsOneWidget);
    expect(find.text('Design your layout'), findsOneWidget);
  });

  testWidgets('switching garden changes what Today shows', (tester) async {
    await garden('Roof', layout: false);
    await garden('Balcony', layout: false);
    await app.pump(tester);

    final shown = find.widgetWithText(TextButton, 'Roof').evaluate().isNotEmpty
        ? 'Roof'
        : 'Balcony';
    final other = shown == 'Roof' ? 'Balcony' : 'Roof';
    expect(find.widgetWithText(TextButton, shown), findsOneWidget);

    await tester.tap(find.byTooltip('Switch garden'));
    await tester.pumpAndSettle();
    expect(find.text('All gardens'), findsOneWidget);
    await tester.tap(find.widgetWithText(ListTile, other));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(TextButton, other), findsOneWidget);
    expect(find.widgetWithText(TextButton, shown), findsNothing);
  });

  testWidgets('plant detail shows the sourced journey and care rhythm', (
    tester,
  ) async {
    final id = await garden('Terrace');
    await plant(id, elementId: 'bag');
    await app.pump(tester);
    await app.open(tester, AppRoutes.plantDetail('tomato', gardenId: id));

    expect(find.text('Tomato'), findsOneWidget);
    expect(find.text('Day 1'), findsOneWidget);
    expect(find.text('Harvest may start'), findsOneWidget);
    expect(find.textContaining('Varieties and weather differ.'), findsOne);
    expect(find.text('Care rhythm'), findsOneWidget);
    expect(find.text('Soil check due'), findsOneWidget);
  });

  testWidgets('Seasons shows the month and an almanac for my plants', (
    tester,
  ) async {
    await plant(await garden('Terrace'), elementId: 'bag');
    await app.pump(tester);
    await tester.tap(find.text('Seasons'));
    await tester.pumpAndSettle();

    expect(find.text('Delhi · North India calendar'), findsOneWidget);
    expect(find.text('October'), findsOneWidget);
    expect(find.text('sow now'), findsOneWidget);
    expect(find.text('YOUR PLANTS AND SAVED'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('^Tomato: ')), findsOneWidget);

    // A long "sow now" list folds behind a chip that unfolds it.
    final more = find.textContaining(RegExp(r'^\d+ more$'));
    expect(more, findsOneWidget);
    await tester.tap(more);
    await tester.pumpAndSettle();
    expect(more, findsNothing);
  });

  testWidgets('a long later group folds until "Show more" is tapped', (
    tester,
  ) async {
    final id = await garden('Terrace');
    final repo = DriftPlantingRepository(
      app.database,
      clock,
      SequentialIdGenerator('many'),
      logger,
    );
    for (var i = 0; i < 5; i++) {
      await repo.create(
        PlantingDraft(
          gardenId: id,
          speciesId: 'tomato',
          plantedOn: today,
          startedFrom: PlantingStart.seedling,
          elementId: 'bag',
        ),
      );
    }
    await app.pump(tester);

    // The first group (soil checks) stays open; the pest checks fold.
    final more = find.text('Show 2 more');
    await tester.scrollUntilVisible(
      more,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    // Lift the button clear of the floating navigation bar before tapping.
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -300));
    await tester.pumpAndSettle();
    await tester.tap(more);
    await tester.pumpAndSettle();
    expect(more, findsNothing);
  });

  testWidgets("the plant page puts my garden's calendar first", (
    tester,
  ) async {
    final id = await garden('Terrace');
    await app.pump(tester);
    await app.open(tester, AppRoutes.plantDetail('tomato', gardenId: id));

    final mine = find.text('Your garden · North India');
    await tester.scrollUntilVisible(
      mine,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(mine, findsOneWidget);
    expect(find.textContaining('other regions'), findsOneWidget);
    // Other regions stay folded until asked for.
    expect(find.text('South India'), findsNothing);
  });

  testWidgets('Seasons asks for a city when the garden has none', (
    tester,
  ) async {
    await DriftGardenRepository(
      app.database,
      clock,
      SequentialIdGenerator('nocity'),
      logger,
    ).create(const GardenDraft(name: 'Balcony'));
    await app.pump(tester);
    await tester.tap(find.text('Seasons'));
    await tester.pumpAndSettle();

    expect(
      find.text('Add your city to this garden to see what to sow each month.'),
      findsOneWidget,
    );
    expect(find.text('Add my city'), findsOneWidget);
  });

  testWidgets('the almanac uses short names', (tester) async {
    await plant(await garden('Terrace'), elementId: 'pot', speciesId: 'tulsi');
    await app.pump(tester);
    await tester.tap(find.text('Seasons'));
    await tester.pumpAndSettle();
    expect(find.text('Tulsi'), findsOneWidget);
    expect(
      // Screen readers still get the full name.
      find.bySemanticsLabel(RegExp(r'^Tulsi \(holy basil\): ')),
      findsOneWidget,
    );
  });
}
