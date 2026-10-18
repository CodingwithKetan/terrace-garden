import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

  Future<void> plant(String gardenId, {String? elementId}) async {
    await DriftPlantingRepository(
      app.database,
      clock,
      SequentialIdGenerator('p$gardenId'),
      logger,
    ).create(
      PlantingDraft(
        gardenId: gardenId,
        speciesId: 'tomato',
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
  });
}
