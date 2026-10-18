import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_repository.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';
import 'package:terrace_garden/features/garden_designer/data/drift_layout_repository.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/plant_catalog/presentation/plant_detail_screen.dart';

import '../../../helpers/test_app.dart';

void main() {
  Finder detailScroll() => find
      .descendant(
        of: find.byType(PlantDetailScreen),
        matching: find.byType(Scrollable),
      )
      .first;

  testWidgets('browse: search by local name and read a sourced detail page', (
    tester,
  ) async {
    final app = TestApp();
    await app.pump(tester);

    await tester.tap(find.text('Plants'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('plantSearch')), 'bhindi');
    await tester.pumpAndSettle();
    expect(find.text('Okra'), findsOneWidget);
    expect(find.text('Tomato'), findsNothing);

    await tester.tap(find.text('Okra'));
    await tester.pumpAndSettle();
    expect(find.text('Abelmoschus esculentus'), findsOneWidget);
    // No verified container figure: shown honestly, not guessed.
    await tester.scrollUntilVisible(
      find.text('Size not documented'),
      200,
      scrollable: detailScroll(),
    );
    expect(find.text('Size not documented'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('TNAU Agritech: Bhendi (okra)'),
      200,
      scrollable: detailScroll(),
    );
    expect(find.text('TNAU Agritech: Bhendi (okra)'), findsOneWidget);
  });

  testWidgets('category filter narrows the list', (tester) async {
    final app = TestApp();
    await app.pump(tester);
    await tester.tap(find.text('Plants'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.widgetWithText(FilterChip, 'Herbs'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilterChip, 'Herbs'));
    await tester.pumpAndSettle();
    expect(find.text('Coriander'), findsOneWidget);
    expect(find.text('Tomato'), findsNothing);
  });

  group('ideas and plantings', () {
    late TestApp app;
    late String gardenId;

    Future<void> seed() async {
      final clock = FixedClock(DateTime(2026, 7, 15, 9));
      gardenId =
          (await DriftGardenRepository(
                app.database,
                clock,
                SequentialIdGenerator('garden'),
                const DeveloperLogger(),
              ).create(
                const GardenDraft(
                  name: 'Terrace',
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
      await DriftLayoutRepository(
        app.database,
        const DeveloperLogger(),
      ).saveElements(gardenId, const [
        // 60 × 45 × 30 cm = 81 L.
        LayoutElement(
          id: 'bag',
          kind: ElementKind.growBag,
          center: Vec2(100, 100),
          width: 60,
          height: 45,
          depthCm: 30,
        ),
        // 20 cm across, 20 cm deep ≈ 6.3 L.
        LayoutElement(
          id: 'pot',
          kind: ElementKind.roundPot,
          center: Vec2(250, 100),
          width: 20,
          height: 20,
          depthCm: 20,
        ),
      ]);
    }

    Future<void> openIdeas(WidgetTester tester) async {
      await tester.tap(find.text('Garden'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Terrace'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Plant ideas').first);
      await tester.pumpAndSettle();
    }

    setUp(() => app = TestApp(now: DateTime(2026, 7, 15, 9)));

    testWidgets('ranks a sourced match first with its reasons; shortlist', (
      tester,
    ) async {
      await seed();
      await app.pump(tester);
      await openIdeas(tester);

      expect(find.text('For Terrace in July'), findsOneWidget);
      expect(find.text('Good choices now'), findsOneWidget);
      final firstCard = find.byType(Card).first;
      expect(
        find.descendant(of: firstCard, matching: find.text('Tomato')),
        findsOneWidget,
      );
      for (final reason in [
        'Light suits your space',
        'Sow now',
        '1 of your containers is big enough',
        'Matches your goals',
        'Toxic to pets',
      ]) {
        expect(
          find.descendant(of: firstCard, matching: find.text(reason)),
          findsOneWidget,
          reason: reason,
        );
      }

      await tester.tap(find.byTooltip('Save to shortlist').first);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilterChip, 'Shortlist'));
      await tester.pumpAndSettle();
      expect(find.text('Tomato'), findsOneWidget);
      expect(find.text('Okra'), findsNothing);
      expect(find.byTooltip('Remove from shortlist'), findsOneWidget);
    });

    testWidgets('adds a planting with fit warnings and lists it in My plants', (
      tester,
    ) async {
      await seed();
      await app.pump(tester);
      await openIdeas(tester);

      await tester.tap(find.text('Add to a garden').first);
      await tester.pumpAndSettle();
      expect(find.text('Add Tomato'), findsOneWidget);

      // The small pot fails both documented minimums.
      await tester.tap(find.textContaining('Round pot'));
      await tester.pumpAndSettle();
      expect(find.textContaining('holds about 6.3 L'), findsOneWidget);
      expect(find.textContaining('is 20 cm deep'), findsOneWidget);

      await tester.tap(find.textContaining('Grow bag'));
      await tester.pumpAndSettle();
      expect(find.textContaining('needs at least'), findsNothing);

      await tester.tap(find.byTooltip('More'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Add planting'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add planting'));
      await tester.pumpAndSettle();
      expect(find.text('Tomato added to Terrace'), findsOneWidget);

      // A one-off read; drift stream queries don't complete under the
      // test's fake clock.
      final saved = await app.database.select(app.database.plantings).get();
      expect(saved.single.speciesId, 'tomato');
      expect(saved.single.elementId, 'bag');
      expect(saved.single.quantity, 2);

      await tester.pageBack();
      await tester.pumpAndSettle();
      final summary = find.text('2 plants · since Jul 15, 2026');
      await tester.scrollUntilVisible(summary, 200);
      expect(summary, findsOneWidget);
      expect(find.text('Grow bag'), findsWidgets);
    });

    testWidgets('removes a planting after confirmation', (tester) async {
      await seed();
      await app.pump(tester);
      await openIdeas(tester);
      await tester.tap(find.text('Add to a garden').first);
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Add planting'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add planting'));
      await tester.pumpAndSettle();
      await tester.pageBack();
      // Let the "added" snack bar time out so the next one shows.
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      final summary = find.text('1 plant · since Jul 15, 2026');
      await tester.scrollUntilVisible(summary, 200);
      final menu = find.descendant(
        of: find.ancestor(of: summary, matching: find.byType(ListTile)),
        matching: find.byTooltip('More actions'),
      );
      // Centre the row: clear of the pinned app bar and the floating
      // navigation bar.
      await Scrollable.ensureVisible(tester.element(menu), alignment: 0.5);
      await tester.pumpAndSettle();
      await tester.tap(menu);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Remove planting'));
      await tester.pumpAndSettle();
      expect(find.text('Remove Tomato?'), findsOneWidget);
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      expect(find.text('Planting removed'), findsOneWidget);
      expect(summary, findsNothing);
    });
  });
}
