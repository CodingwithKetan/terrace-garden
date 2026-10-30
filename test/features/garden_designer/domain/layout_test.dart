import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/features/garden_designer/domain/container_presets.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_history.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_validator.dart';

LayoutElement el(
  String id,
  ElementKind kind,
  double x,
  double y, {
  double? w,
  double? h,
  double rotation = 0,
  double? depth,
}) => LayoutElement(
  id: id,
  kind: kind,
  center: Vec2(x, y),
  width: w ?? kind.w,
  height: h ?? kind.h,
  rotationDeg: rotation,
  depthCm: depth ?? kind.depth,
);

void main() {
  // A 3 m × 1.2 m balcony (PRD FR-C acceptance scenario).
  LayoutDocument balcony([List<LayoutElement> elements = const []]) =>
      LayoutDocument(
        gardenId: 'g',
        length: 300,
        width: 120,
        elements: elements,
      );

  group('LayoutElement', () {
    test('round elements use width as diameter', () {
      final pot = el('p', ElementKind.roundPot, 50, 50, w: 30);
      expect(pot.shape, isA<CircleShape>());
      expect(pot.footprintArea, closeTo(math.pi * 15 * 15, 1e-9));
    });

    test('soil volume only for containers with a depth', () {
      final bag = el('b', ElementKind.growBag, 50, 50, w: 60, h: 45, depth: 30);
      expect(bag.soilLitres, closeTo(60 * 45 * 30 / 1000, 1e-9));
      expect(el('w', ElementKind.wall, 50, 5).soilLitres, isNull);
    });
  });

  group('LayoutDocument', () {
    test('upsert replaces or appends; remove deletes', () {
      var doc = balcony();
      doc = doc.upsert(el('a', ElementKind.roundPot, 20, 20));
      doc = doc.upsert(el('b', ElementKind.roundPot, 80, 20));
      doc = doc.upsert(el('a', ElementKind.roundPot, 40, 20));
      expect(doc.elements.map((e) => e.id), ['a', 'b']);
      expect(doc.elementById('a')!.center, const Vec2(40, 20));
      expect(doc.remove('a').elements.single.id, 'b');
    });
  });

  group('validateLayout', () {
    test('a tidy layout has no issues', () {
      final doc = balcony([
        el('p1', ElementKind.roundPot, 20, 20),
        el('p2', ElementKind.roundPot, 60, 20),
        el('bag', ElementKind.growBag, 200, 60),
        el('rail', ElementKind.railing, 150, 117.5, w: 300),
      ]);
      expect(validateLayout(doc), isEmpty);
    });

    test('flags elements outside the garden', () {
      final doc = balcony([el('p', ElementKind.roundPot, 5, 60)]);
      expect(validateLayout(doc), [
        const LayoutIssue(elementId: 'p', type: IssueType.outOfBounds),
      ]);
    });

    test('rotation can push an element out of bounds', () {
      // 60 × 20 cm near the top edge: fits flat, crosses the edge upright.
      final ok = el('b', ElementKind.growBag, 150, 20, w: 60, h: 20);
      expect(validateLayout(balcony([ok])), isEmpty);
      final rotated = ok.copyWith(rotationDeg: 90);
      expect(
        validateLayout(balcony([rotated])).single.type,
        IssueType.outOfBounds,
      );
    });

    test('overlapping containers are an error on both', () {
      final doc = balcony([
        el('p1', ElementKind.roundPot, 50, 50),
        el('p2', ElementKind.roundPot, 60, 50),
      ]);
      final issues = validateLayout(doc);
      expect(issues.map((i) => i.elementId).toSet(), {'p1', 'p2'});
      expect(issues.every((i) => i.severity == IssueSeverity.error), isTrue);
    });

    test('pots touching side by side are fine', () {
      final doc = balcony([
        el('p1', ElementKind.roundPot, 50, 50, w: 30),
        el('p2', ElementKind.roundPot, 80, 50, w: 30),
      ]);
      expect(validateLayout(doc), isEmpty);
    });

    test('a container overlapping a wall is an error', () {
      final doc = balcony([
        el('wall', ElementKind.wall, 150, 5, w: 300),
        el('p', ElementKind.roundPot, 50, 15),
      ]);
      expect(
        validateLayout(doc).where((i) => i.type == IssueType.overlap),
        hasLength(2),
      );
    });

    test('a container on a path is a warning on the container only', () {
      final doc = balcony([
        el('path', ElementKind.path, 150, 60, w: 100, h: 60),
        el('p', ElementKind.roundPot, 150, 60),
      ]);
      final issue = validateLayout(doc).single;
      expect(issue.elementId, 'p');
      expect(issue.type, IssueType.onPath);
      expect(issue.severity, IssueSeverity.warning);
    });

    test('markers never conflict', () {
      final doc = balcony([
        el('tap', ElementKind.waterPoint, 50, 50),
        el('p', ElementKind.roundPot, 50, 50),
        el('path', ElementKind.path, 50, 60, w: 60, h: 60),
      ]);
      expect(
        validateLayout(doc).where((i) => i.elementId == 'tap'),
        isEmpty,
      );
    });

    test('anything solid where a door opens is a warning', () {
      final doc = balcony([
        el('door', ElementKind.door, 45, 45),
        el('p', ElementKind.roundPot, 40, 40),
        el('bench', ElementKind.seating, 60, 30),
      ]);
      final issues = validateLayout(doc).where(
        (i) => i.type == IssueType.blocksDoor,
      );
      expect(issues.map((i) => i.elementId), unorderedEquals(['p', 'bench']));
      expect(issues.first.severity, IssueSeverity.warning);
    });

    test('a container over a drain is a warning; a tap is not', () {
      final doc = balcony([
        el('drain', ElementKind.drain, 20, 20),
        el('tap', ElementKind.waterPoint, 100, 20),
        el('a', ElementKind.roundPot, 20, 20),
        el('b', ElementKind.roundPot, 100, 20),
      ]);
      final issue = validateLayout(doc).single;
      expect(issue.elementId, 'a');
      expect(issue.type, IssueType.coversDrain);
    });

    test('hanging pots only clash with each other', () {
      final doc = balcony([
        el('bag', ElementKind.growBag, 100, 60),
        el('h1', ElementKind.hangingPot, 100, 60),
        el('h2', ElementKind.hangingPot, 110, 60),
      ]);
      final issues = validateLayout(doc);
      expect(issues.map((i) => i.elementId), unorderedEquals(['h1', 'h2']));
      expect(issues.every((i) => i.type == IssueType.overlap), isTrue);
    });

    test('a water tank is solid', () {
      final doc = balcony([
        el('tank', ElementKind.waterTank, 60, 60),
        el('p', ElementKind.roundPot, 60, 60),
      ]);
      expect(validateLayout(doc), hasLength(2));
    });
  });

  group('drawOrder', () {
    test('back to front by layer, then list order', () {
      final doc = balcony([
        el('hang', ElementKind.hangingPot, 50, 50),
        el('pot', ElementKind.roundPot, 50, 50),
        el('drain', ElementKind.drain, 50, 50),
        el('tank', ElementKind.waterTank, 200, 60),
        el('path', ElementKind.path, 50, 60),
        el('door', ElementKind.door, 250, 60),
      ]);
      expect(doc.drawOrder.map((e) => e.id), [
        'path',
        'door',
        'tank',
        'drain',
        'pot',
        'hang',
      ]);
    });
  });

  group('ElementPreset', () {
    test('converts shop inches to centimetres', () {
      const bag = ElementPreset(
        ElementKind.growBag,
        widthIn: 24,
        heightIn: 12,
        depthIn: 9,
      );
      final e = bag.toElement(id: 'b', center: Vec2.zero);
      expect(e.width, closeTo(60.96, 1e-9));
      expect(e.height, closeTo(30.48, 1e-9));
      expect(e.depthCm, closeTo(22.86, 1e-9));
      expect(bag.sizeLabel, '24 × 12 × 9');
    });

    test('round presets are as tall as they are wide', () {
      const pot = ElementPreset(ElementKind.roundPot, widthIn: 12, depthIn: 12);
      expect(pot.heightCm, pot.widthCm);
      expect(pot.sizeLabel, '12 × 12');
    });

    test(
      'every preset matches its kind and container presets have a depth',
      () {
        for (final MapEntry(key: kind, value: presets)
            in elementPresets.entries) {
          for (final p in presets) {
            expect(p.kind, kind);
            expect(p.kind.round, p.heightIn == null);
            if (kind.isContainer) expect(p.depthIn, isNotNull);
          }
        }
      },
    );
  });

  group('LayoutSummary', () {
    test('counts containers, walkways and soil', () {
      final doc = balcony([
        el('p', ElementKind.roundPot, 20, 20, w: 30, depth: 30),
        el('bag', ElementKind.growBag, 200, 60, w: 60, h: 45, depth: 30),
        el('path', ElementKind.path, 100, 60, w: 100, h: 60),
        el('wall', ElementKind.wall, 150, 5),
      ]);
      final s = LayoutSummary.of(doc);
      const potArea = math.pi * 15 * 15;
      expect(s.gardenArea, 36000);
      expect(s.containerArea, closeTo(potArea + 2700, 1e-9));
      expect(s.walkwayArea, 6000);
      expect(s.soilLitres, closeTo((potArea * 30 + 2700 * 30) / 1000, 1e-9));
      expect(s.containerCount, 2);
      expect(s.countsByKind[ElementKind.wall], 1);
      expect(s.containerShare, closeTo((potArea + 2700) / 36000, 1e-9));
    });
  });

  group('LayoutHistory', () {
    test('undo and redo walk through snapshots', () {
      final history = LayoutHistory();
      final v0 = balcony();
      final v1 = v0.upsert(el('a', ElementKind.roundPot, 20, 20));
      final v2 = v1.upsert(el('b', ElementKind.roundPot, 80, 20));
      history
        ..record(v0)
        ..record(v1);

      expect(history.undo(v2), v1);
      expect(history.undo(v1), v0);
      expect(history.canUndo, isFalse);
      expect(history.redo(v0), v1);
      expect(history.redo(v1), v2);
      expect(history.canRedo, isFalse);
    });

    test('a new change clears redo', () {
      final history = LayoutHistory();
      final v0 = balcony();
      final v1 = v0.upsert(el('a', ElementKind.roundPot, 20, 20));
      history
        ..record(v0)
        ..undo(v1);
      expect(history.canRedo, isTrue);
      history.record(v0);
      expect(history.canRedo, isFalse);
    });

    test('keeps at most maxDepth undo points', () {
      final history = LayoutHistory(maxDepth: 3);
      for (var i = 0; i < 5; i++) {
        history.record(balcony());
      }
      expect(history.undoDepth, 3);
    });
  });
}
