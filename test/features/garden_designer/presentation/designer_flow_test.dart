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
import 'package:terrace_garden/features/garden_designer/domain/layout_validator.dart';
import 'package:terrace_garden/features/garden_designer/presentation/designer_add.dart';
import 'package:terrace_garden/features/garden_designer/presentation/designer_canvas.dart';
import 'package:terrace_garden/features/garden_designer/presentation/garden_canvas_painter.dart';

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
    // The garden name on Today opens the garden.
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

  Future<void> deselect(WidgetTester tester) async {
    // While an object is selected the bar shows it; deselect first.
    if (find.byTooltip('Done').evaluate().isNotEmpty) {
      await tester.tap(find.byTooltip('Done'));
      await tester.pumpAndSettle();
    }
  }

  /// Adds [kindLabel] from the tray at the given shop [size], or at its
  /// standard size.
  Future<void> addObject(
    WidgetTester tester,
    String kindLabel, {
    String size = 'Standard size',
  }) async {
    await deselect(tester);
    await tester.tap(find.widgetWithText(KindTile, kindLabel));
    await tester.pumpAndSettle();
    if (find.textContaining('Choose a size').evaluate().isNotEmpty) {
      await tester.tap(find.text(size));
      await tester.pumpAndSettle();
    }
  }

  Future<void> openMore(WidgetTester tester) async {
    await tester.ensureVisible(find.text('More'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('More'));
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
    expect(find.textContaining('Tap or drag a pot'), findsOneWidget);
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

  LayoutDocument document(WidgetTester tester) =>
      canvas(tester).widget.controller.document;

  testWidgets('the tray places shop sizes, labelled the way shops sell them', (
    tester,
  ) async {
    await createGarden(length: Length.metres(3), width: Length.metres(1.2));
    await app.pump(tester);
    await openDesigner(tester);

    await tester.tap(find.widgetWithText(KindTile, 'Round grow bag'));
    await tester.pumpAndSettle();
    // 15 × 15 in: Ø 38.1 cm, 38.1 cm deep → 43.4 L.
    expect(find.text('15 × 15 in'), findsOneWidget);
    expect(find.textContaining('43.4 L'), findsOneWidget);
    await tester.tap(find.text('15 × 15 in'));
    await tester.pumpAndSettle();

    final bag = document(tester).elements.single;
    expect(bag.kind, ElementKind.roundGrowBag);
    expect(bag.width, closeTo(38.1, 1e-9));
    expect(bag.depthCm, closeTo(38.1, 1e-9));

    // The tile now shows the size it will place next.
    await deselect(tester);
    expect(
      find.descendant(
        of: find.widgetWithText(KindTile, 'Round grow bag'),
        matching: find.text('15 × 15 in'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('More adds terrace features; a pot by the door is flagged', (
    tester,
  ) async {
    await createGarden(length: Length.metres(3), width: Length.metres(1.2));
    await app.pump(tester);
    await openDesigner(tester);

    await openMore(tester);
    expect(find.text('Water tank'), findsOneWidget);
    expect(find.text('Drain'), findsOneWidget);
    await tester.ensureVisible(find.text('Door'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Door'));
    await tester.pumpAndSettle();
    expect(document(tester).elements.single.kind, ElementKind.door);

    // A pot dropped in the middle lands in the door's swing.
    await addObject(tester, 'Round pot');
    final pot = document(tester).elements.last;
    expect(
      canvas(tester).widget.controller.issuesFor(pot.id).single.type,
      IssueType.blocksDoor,
    );
    await tester.tap(find.byTooltip('Objects'));
    await tester.pumpAndSettle();
    expect(find.textContaining('In front of a door'), findsOneWidget);
  });

  testWidgets('repeat in a row adds evenly spaced copies in one undo step', (
    tester,
  ) async {
    tester.setScreenSize(const Size(420, 860));
    await createGarden(length: Length.metres(3), width: Length.metres(1.2));
    await app.pump(tester);
    await openDesigner(tester);
    await addObject(tester, 'Round pot');
    await dragObject(tester, const Vec2(150, 60), const Vec2(-120, 0));

    await tester.tap(find.byTooltip('Repeat in a row'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('More'));
    await tester.pumpAndSettle();
    expect(find.text('Add 3'), findsOneWidget);
    await tester.tap(find.text('Add 3'));
    await tester.pumpAndSettle();

    final xs = document(tester).elements.map((e) => e.center.x).toList();
    // 30 cm pots with the default 10 cm gap: 40 cm apart.
    expect(xs, [30, 70, 110, 150]);
    expect(find.textContaining('problem'), findsNothing);

    await tester.tap(find.byTooltip('Undo'));
    await tester.pumpAndSettle();
    expect(document(tester).elements, hasLength(1));
  });

  testWidgets('dragging from the tray drops the object where it is let go', (
    tester,
  ) async {
    tester.setScreenSize(const Size(420, 860));
    await createGarden(length: Length.metres(3), width: Length.metres(1.2));
    await app.pump(tester);
    await openDesigner(tester);

    final tile = tester.getCenter(find.widgetWithText(KindTile, 'Round pot'));
    final target = screenOf(tester, const Vec2(60, 40));
    final gesture = await tester.startGesture(tile);
    for (var i = 1; i <= 8; i++) {
      await gesture.moveTo(Offset.lerp(tile, target, i / 8)!);
      await tester.pump();
    }
    await gesture.up();
    await tester.pumpAndSettle();

    final pot = document(tester).elements.single;
    expect(pot.kind, ElementKind.roundPot);
    // Snapped to the 5 cm grid near the drop point.
    expect(pot.center.isCloseTo(const Vec2(60, 40), 5), isTrue);
  });

  testWidgets('switches between the garden and blueprint views', (
    tester,
  ) async {
    await createGarden(length: Length.metres(3), width: Length.metres(1.2));
    await app.pump(tester);
    await openDesigner(tester);

    expect(canvas(tester).widget.style, CanvasStyle.garden);
    await tester.tap(find.text('Blueprint'));
    await tester.pumpAndSettle();
    expect(canvas(tester).widget.style, CanvasStyle.blueprint);
  });

  testWidgets('marks sun on the map and shows it for the selected pot', (
    tester,
  ) async {
    tester.setScreenSize(const Size(420, 860));
    await createGarden(length: Length.metres(3), width: Length.metres(1.2));
    await app.pump(tester);
    await openDesigner(tester);
    expect(find.text('Mark sun and shade'), findsNothing);

    await addObject(tester, 'Round pot');
    await deselect(tester);
    await tester.tap(find.text('Mark sun and shade'));
    await tester.pumpAndSettle();
    expect(find.textContaining('never guesses sun'), findsOneWidget);
    await tester.tap(find.text('Full sun area'));
    await tester.pumpAndSettle();
    expect(find.text('Mark sun and shade'), findsNothing);

    // Select the pot (on top of the area) and read its sun.
    await deselect(tester);
    await tester.tapAt(screenOf(tester, const Vec2(150, 60)));
    await tester.pumpAndSettle();
    expect(find.textContaining('Sun here: 6+ hours'), findsOneWidget);
  });

  testWidgets('dragging on an unselected sun area pans instead of moving it', (
    tester,
  ) async {
    tester.setScreenSize(const Size(420, 860));
    await createGarden(length: Length.metres(3), width: Length.metres(1.2));
    await app.pump(tester);
    await openDesigner(tester);
    await openMore(tester);
    await tester.ensureVisible(find.text('Shade area'));
    await tester.tap(find.text('Shade area'));
    await tester.pumpAndSettle();
    await deselect(tester);
    final before = document(tester).elements.single.center;

    await dragObject(tester, before, const Vec2(40, 0));
    expect(document(tester).elements.single.center, before);
  });

  testWidgets('starts from a template sized to the terrace', (tester) async {
    await createGarden(length: Length.metres(3), width: Length.metres(1.2));
    await app.pump(tester);
    await openDesigner(tester);

    expect(find.text('Grow bag rows with a path'), findsOneWidget);
    await tester.tap(find.text('Grow bag rows with a path'));
    await tester.pumpAndSettle();
    final elements = document(tester).elements;
    expect(
      elements.where((e) => e.kind == ElementKind.roundGrowBag),
      isNotEmpty,
    );
    expect(find.textContaining('problem'), findsNothing);
    await tester.tap(find.byTooltip('Undo'));
    await tester.pumpAndSettle();
    expect(document(tester).elements, isEmpty);
  });
}
