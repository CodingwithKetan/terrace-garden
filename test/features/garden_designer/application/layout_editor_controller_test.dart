import 'dart:async';

import 'package:drift/native.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_repository.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/garden_designer/application/layout_editor_controller.dart';
import 'package:terrace_garden/features/garden_designer/data/drift_layout_repository.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_repository.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_validator.dart';

class RecordingLayoutRepository implements LayoutRepository {
  final saves = <List<LayoutElement>>[];
  bool fail = false;

  @override
  Future<List<LayoutElement>> loadElements(String gardenId) async => [];

  @override
  Stream<List<LayoutElement>> watchElements(String gardenId) =>
      Stream.value(const []);

  @override
  Future<Result<void>> saveElements(
    String gardenId,
    List<LayoutElement> elements,
  ) async {
    if (fail) return const Err(StorageFailure());
    saves.add(elements);
    return const Ok(null);
  }
}

void main() {
  const balcony = LayoutDocument(gardenId: 'g', length: 300, width: 120);
  late RecordingLayoutRepository repository;

  LayoutEditorController controller({
    LayoutDocument initial = balcony,
  }) => LayoutEditorController(
    initial: initial,
    repository: repository,
    ids: SequentialIdGenerator('e'),
  );

  setUp(() => repository = RecordingLayoutRepository());

  group('adding and selecting', () {
    test('adds a default-sized element at a snapped position', () {
      final c = controller();
      final pot = c.add(ElementKind.roundPot, const Vec2(52, 61));
      expect(pot.width, 30);
      expect(pot.center, const Vec2(50, 60));
      expect(c.selectedId, pot.id);
      expect(c.canUndo, isTrue);
    });

    test('snaps flush against a nearby edge', () {
      final c = controller();
      final pot = c.add(ElementKind.roundPot, const Vec2(18, 60));
      expect(pot.center.x, 15, reason: 'radius 15 → touching the left edge');
    });

    test('adds without snapping when snapping is off', () {
      final c = controller()..snapEnabled = false;
      final pot = c.add(ElementKind.roundPot, const Vec2(52.3, 61.7));
      expect(pot.center, const Vec2(52.3, 61.7));
    });

    test('hit testing finds the topmost element and tolerates near misses', () {
      final c = controller();
      final a = c.add(ElementKind.growBag, const Vec2(100, 60));
      final b = c.add(ElementKind.roundPot, const Vec2(100, 60));
      expect(c.hitTest(const Vec2(100, 60))!.id, b.id);
      expect(c.hitTest(const Vec2(125, 60))!.id, a.id);
      expect(c.hitTest(const Vec2(250, 10)), isNull);
      final far = c.add(ElementKind.waterPoint, const Vec2(250, 100));
      expect(c.hitTest(const Vec2(250, 112), tolerance: 10)!.id, far.id);
    });
  });

  group('gestures', () {
    test('a drag is a single undoable change', () {
      final c = controller();
      final pot = c.add(ElementKind.roundPot, const Vec2(100, 60));
      c.beginGesture();
      for (var i = 1; i <= 10; i++) {
        c.moveSelected(Vec2(i * 5.0, 0));
      }
      c.endGesture();
      expect(c.selected!.center, const Vec2(150, 60));

      c.undo();
      expect(c.document.elementById(pot.id)!.center, const Vec2(100, 60));
      c.undo();
      expect(c.document.elements, isEmpty);
      c
        ..redo()
        ..redo();
      expect(
        c.selected?.center ?? c.document.elements.single.center,
        const Vec2(150, 60),
      );
    });

    test('a gesture that changes nothing records no undo point', () {
      final c = controller()..add(ElementKind.roundPot, const Vec2(100, 60));
      c
        ..beginGesture()
        ..endGesture()
        ..undo();
      expect(c.document.elements, isEmpty, reason: 'only the add was undone');
    });

    test('resizing keeps the centre and snaps the size', () {
      final c = controller()..add(ElementKind.growBag, const Vec2(150, 60));
      c
        ..beginGesture()
        ..resizeSelectedTo(const Vec2(150 + 41, 60 + 19))
        ..endGesture();
      final bag = c.selected!;
      expect(bag.center, const Vec2(150, 60));
      expect((bag.width, bag.height), (80.0, 40.0));
    });

    test('resizing never goes below the minimum size', () {
      final c = controller()..add(ElementKind.roundPot, const Vec2(150, 60));
      c
        ..beginGesture()
        ..resizeSelectedTo(const Vec2(150, 60))
        ..endGesture();
      expect(c.selected!.width, ElementKind.minSide);
    });

    test('rotation follows the handle and snaps to 15°', () {
      final c = controller()..add(ElementKind.growBag, const Vec2(150, 60));
      c
        ..beginGesture()
        // Pointer to the right of the centre → rotated 90° clockwise.
        ..rotateSelectedTo(const Vec2(200, 62))
        ..endGesture();
      expect(c.selected!.rotationDeg, 90);
    });

    test('round elements ignore rotation', () {
      final c = controller()..add(ElementKind.roundPot, const Vec2(150, 60));
      c
        ..beginGesture()
        ..rotateSelectedTo(const Vec2(200, 60))
        ..endGesture();
      expect(c.selected!.rotationDeg, 0);
    });
  });

  group('edits and validation', () {
    test('dragging onto another pot reports an overlap; undo clears it', () {
      final c = controller()
        ..add(ElementKind.roundPot, const Vec2(50, 60))
        ..add(ElementKind.roundPot, const Vec2(150, 60));
      c
        ..beginGesture()
        ..moveSelected(const Vec2(-90, 0))
        ..endGesture();
      expect(c.errorCount, 2);
      expect(c.issuesFor(c.selectedId!).single.type, IssueType.overlap);
      c.undo();
      expect(c.errorCount, 0);
    });

    test('duplicate offsets and selects the copy; delete removes it', () {
      final c = controller();
      final original = c.add(ElementKind.growBag, const Vec2(100, 60));
      c.duplicateSelected();
      final copy = c.selected!;
      expect(copy.id, isNot(original.id));
      expect(copy.center, const Vec2(120, 80));
      c.deleteSelected();
      expect(c.selectedId, isNull);
      expect(c.document.elements.single.id, original.id);
    });

    test('inspector updates and quarter turns', () {
      final c = controller()..add(ElementKind.growBag, const Vec2(150, 60));
      c
        ..updateSelected((e) => e.copyWith(depthCm: 40, label: 'Tomatoes'))
        ..rotateSelectedBy90()
        ..rotateSelectedBy90()
        ..rotateSelectedBy90()
        ..rotateSelectedBy90();
      expect(c.selected!.depthCm, 40);
      expect(c.selected!.label, 'Tomatoes');
      expect(c.selected!.rotationDeg, 0);
    });
  });

  group('autosave', () {
    test('debounces bursts of changes into one save', () {
      fakeAsync((async) {
        final c = controller()
          ..add(ElementKind.roundPot, const Vec2(50, 60))
          ..add(ElementKind.roundPot, const Vec2(150, 60));
        expect(c.status, SaveStatus.pending);
        async.elapse(const Duration(milliseconds: 500));
        c.add(ElementKind.roundPot, const Vec2(250, 60));
        async.elapse(const Duration(milliseconds: 900));
        expect(repository.saves, hasLength(1));
        expect(repository.saves.single, hasLength(3));
        expect(c.status, SaveStatus.saved);
      });
    });

    test('reports failure and retries on flush', () {
      fakeAsync((async) {
        repository.fail = true;
        final c = controller()..add(ElementKind.roundPot, const Vec2(50, 60));
        async.elapse(const Duration(seconds: 1));
        expect(c.status, SaveStatus.failed);
        repository.fail = false;
        unawaited(c.flush());
        async.flushMicrotasks();
        expect(c.status, SaveStatus.saved);
      });
    });
  });

  group('DriftLayoutRepository', () {
    test(
      'round-trips elements in drawing order and replaces on save',
      () async {
        final db = AppDatabase(NativeDatabase.memory());
        addTearDown(db.close);
        final gardens = DriftGardenRepository(
          db,
          FixedClock(DateTime.utc(2026)),
          SequentialIdGenerator('g'),
          const DeveloperLogger(),
        );
        final gardenId = (await gardens.create(
          const GardenDraft(name: 'Roof'),
        )).valueOrNull!.id;
        final layouts = DriftLayoutRepository(db, const DeveloperLogger());

        const a = LayoutElement(
          id: 'a',
          kind: ElementKind.growBag,
          center: Vec2(100, 60),
          width: 60,
          height: 45,
          rotationDeg: 30,
          depthCm: 30,
          label: 'Chilli',
        );
        const b = LayoutElement(
          id: 'b',
          kind: ElementKind.roundPot,
          center: Vec2(200, 60),
          width: 30,
          height: 30,
        );
        expect((await layouts.saveElements(gardenId, [b, a])).isOk, isTrue);
        expect(await layouts.loadElements(gardenId), [b, a]);

        await layouts.saveElements(gardenId, [a]);
        expect(await layouts.loadElements(gardenId), [a]);

        // Deleting the garden removes its layout.
        await gardens.delete(gardenId);
        expect(await layouts.loadElements(gardenId), isEmpty);
      },
    );
  });
}
