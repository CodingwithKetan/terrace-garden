import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_repository.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/garden_designer/data/drift_layout_repository.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/presentation/designer_canvas.dart';

import '../../../helpers/pump_app.dart';
import '../../../helpers/test_app.dart';

void main() {
  late TestApp app;
  late String gardenId;

  Future<void> createGarden({Length? length, Length? width}) async {
    final gardens = DriftGardenRepository(
      app.database,
      FixedClock(DateTime.utc(2026)),
      SequentialIdGenerator('garden'),
      const DeveloperLogger(),
    );
    gardenId = (await gardens.create(
      GardenDraft(name: 'Balcony', length: length, width: width),
    )).valueOrNull!.id;
  }

  Future<void> openDesigner(WidgetTester tester) async {
    await tester.tap(find.text('Garden'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Balcony'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Design your layout'));
    await tester.pumpAndSettle();
  }

  DesignerCanvasState canvas(WidgetTester tester) =>
      tester.state<DesignerCanvasState>(find.byType(DesignerCanvas));

  Offset screenOf(WidgetTester tester, Vec2 world) {
    final s = canvas(tester).transform!.worldToScreen(world);
    final origin = tester.getTopLeft(find.byType(DesignerCanvas));
    return origin + Offset(s.x, s.y);
  }

  /// Drags the object at [from] by [delta] cm. The object follows the finger
  /// from where it touched down, including the gesture slop.
  Future<void> dragObject(WidgetTester tester, Vec2 from, Vec2 delta) async {
    final scale = canvas(tester).transform!.pxPerCm;
    final gesture = await tester.startGesture(screenOf(tester, from));
    final step = Offset(delta.x * scale, delta.y * scale) / 4;
    for (var i = 0; i < 4; i++) {
      await gesture.moveBy(step);
    }
    await gesture.up();
    await tester.pumpAndSettle();
  }

  Future<void> addObject(WidgetTester tester, String kindLabel) async {
    // While an object is selected the bar shows its actions; deselect first.
    if (find.byTooltip('Done').evaluate().isNotEmpty) {
      await tester.tap(find.byTooltip('Done'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.widgetWithText(FilledButton, 'Add'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(kindLabel));
    await tester.pumpAndSettle();
  }

  Future<List<LayoutElement>> savedElements() => DriftLayoutRepository(
    app.database,
    const DeveloperLogger(),
  ).loadElements(gardenId);

  setUp(() {
    app = TestApp();
  });

  testWidgets('asks for the garden size first, then opens the canvas', (
    tester,
  ) async {
    await createGarden();
    await app.pump(tester);
    await openDesigner(tester);

    expect(find.text("Add your garden's size"), findsOneWidget);
    await tester.tap(find.text('Start designing'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Enter a size'), findsNWidgets(2));

    await tester.enterText(find.byType(TextField).at(0), '3');
    await tester.enterText(find.byType(TextField).at(1), '1.2');
    await tester.tap(find.text('Start designing'));
    await tester.pumpAndSettle();

    expect(find.byType(DesignerCanvas), findsOneWidget);
    expect(find.textContaining('Tap Add to place'), findsOneWidget);
  });

  testWidgets('FR-C: arrange, catch an overlap, rotate, undo/redo, reopen', (
    tester,
  ) async {
    tester.setScreenSize(const Size(420, 860));
    await createGarden(length: Length.metres(3), width: Length.metres(1.2));
    await app.pump(tester);
    await openDesigner(tester);

    // Two pots dragged to the ends of the balcony.
    await addObject(tester, 'Round pot');
    await dragObject(tester, const Vec2(150, 60), const Vec2(-100, 0));
    await addObject(tester, 'Round pot');
    await dragObject(tester, const Vec2(150, 60), const Vec2(100, 0));
    // A grow bag in the middle, then a third pot dropped on top of it.
    await addObject(tester, 'Grow bag');
    await addObject(tester, 'Round pot');
    expect(find.text('2 problems'), findsOneWidget);

    // Dragging the pot clear of the bag fixes the overlap.
    await dragObject(tester, const Vec2(150, 60), const Vec2(0, 45));
    expect(find.text('2 problems'), findsNothing);

    // Rotate the bag a quarter turn, then undo and redo.
    await tester.tapAt(screenOf(tester, const Vec2(130, 50)));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Rotate 90°'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Undo'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Redo'));
    await tester.pumpAndSettle();

    // Autosave, leave, and reopen: the same layout comes back.
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    final saved = await savedElements();
    expect(saved.where((e) => e.kind == ElementKind.roundPot), hasLength(3));
    final bag = saved.singleWhere((e) => e.kind == ElementKind.growBag);
    expect(bag.rotationDeg, 90);
    final centers = saved
        .where((e) => e.kind == ElementKind.roundPot)
        .map((e) => e.center)
        .toSet();
    expect(centers, {
      const Vec2(50, 60),
      const Vec2(250, 60),
      const Vec2(150, 105),
    });

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('4 objects in your layout'), findsOneWidget);
    await tester.tap(find.text('Design your layout'));
    await tester.pumpAndSettle();
    expect(find.text('2 problems'), findsNothing);
    expect(
      canvas(tester).widget.controller.document.elements,
      hasLength(4),
    );
  });

  testWidgets('the objects list lets you edit without dragging', (
    tester,
  ) async {
    await createGarden(length: Length.metres(3), width: Length.metres(1.2));
    await app.pump(tester);
    await openDesigner(tester);
    await addObject(tester, 'Raised bed');
    await tester.tap(find.byTooltip('Done'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Objects'));
    await tester.pumpAndSettle();
    expect(find.text('Raised bed'), findsWidgets);
    await tester.tap(find.widgetWithText(ListTile, 'Raised bed'));
    await tester.pumpAndSettle();

    // The inspector opens for precise edits.
    expect(find.text('Edit object'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextField, 'Soil depth'), '40');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Done').last);
    await tester.pumpAndSettle();
    expect(
      canvas(tester).widget.controller.document.elements.single.depthCm,
      40,
    );
  });

  testWidgets('the space summary reports area and soil', (tester) async {
    await createGarden(length: Length.metres(3), width: Length.metres(1.2));
    await app.pump(tester);
    await openDesigner(tester);
    await addObject(tester, 'Grow bag');

    await tester.tap(find.byTooltip('Space summary'));
    await tester.pumpAndSettle();
    expect(find.text('3.6 m²'), findsOneWidget);
    // 60 × 45 cm bag, 30 cm deep → 81 L.
    expect(find.text('81 L'), findsOneWidget);
  });
}
