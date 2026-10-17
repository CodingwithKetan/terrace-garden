import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/features/garden_designer/domain/canvas_transform.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';

void main() {
  const eps = 1e-6;

  group('Vec2', () {
    test('rotates clockwise on a y-down screen', () {
      expect(const Vec2(1, 0).rotate(90).isCloseTo(const Vec2(0, 1)), isTrue);
      expect(const Vec2(0, 1).rotate(90).isCloseTo(const Vec2(-1, 0)), isTrue);
      expect(const Vec2(3, 4).rotate(360).isCloseTo(const Vec2(3, 4)), isTrue);
      expect(const Vec2(3, 4).length, 5);
    });
  });

  group('RectShape', () {
    test('corners and bounds without rotation', () {
      const r = RectShape(center: Vec2(50, 30), width: 40, height: 20);
      expect(r.corners.first, const Vec2(30, 20));
      final b = r.bounds;
      expect((b.left, b.top, b.right, b.bottom), (30.0, 20.0, 70.0, 40.0));
      expect(r.area, 800);
    });

    test('bounds grow when rotated 45°', () {
      const r = RectShape(
        center: Vec2.zero,
        width: 10,
        height: 10,
        rotationDeg: 45,
      );
      expect(r.bounds.width, closeTo(10 * math.sqrt2, eps));
    });

    test('a 90° rotation swaps width and height in bounds', () {
      const r = RectShape(
        center: Vec2.zero,
        width: 40,
        height: 10,
        rotationDeg: 90,
      );
      expect(r.bounds.width, closeTo(10, eps));
      expect(r.bounds.height, closeTo(40, eps));
    });

    test('contains respects rotation', () {
      const r = RectShape(
        center: Vec2.zero,
        width: 40,
        height: 10,
        rotationDeg: 90,
      );
      expect(r.contains(const Vec2(0, 18)), isTrue);
      expect(r.contains(const Vec2(18, 0)), isFalse);
    });
  });

  group('CircleShape', () {
    test('bounds, area and contains', () {
      const c = CircleShape(center: Vec2(10, 10), diameter: 20);
      expect(c.bounds.left, 0);
      expect(c.area, closeTo(math.pi * 100, eps));
      expect(c.contains(const Vec2(10, 19.9)), isTrue);
      expect(c.contains(const Vec2(18, 18)), isFalse);
    });
  });

  group('shapesOverlap', () {
    test('axis-aligned rectangles: overlapping, touching, apart', () {
      const a = RectShape(center: Vec2.zero, width: 10, height: 10);
      expect(
        shapesOverlap(
          a,
          const RectShape(center: Vec2(8, 0), width: 10, height: 10),
        ),
        isTrue,
      );
      expect(
        shapesOverlap(
          a,
          const RectShape(center: Vec2(10, 0), width: 10, height: 10),
        ),
        isFalse,
        reason: 'side by side is allowed',
      );
      expect(
        shapesOverlap(
          a,
          const RectShape(center: Vec2(30, 0), width: 10, height: 10),
        ),
        isFalse,
      );
    });

    test(
      'rotated rectangles that only overlap in their bounds do not overlap',
      () {
        // Two thin bars crossing an empty corner: bounds overlap, shapes don't.
        const a = RectShape(
          center: Vec2.zero,
          width: 40,
          height: 2,
          rotationDeg: 45,
        );
        const b = RectShape(center: Vec2(14, -14), width: 4, height: 4);
        final ab = a.bounds;
        final bb = b.bounds;
        final boundsOverlap =
            ab.left < bb.right &&
            bb.left < ab.right &&
            ab.top < bb.bottom &&
            bb.top < ab.bottom;
        expect(boundsOverlap, isTrue);
        expect(shapesOverlap(a, b), isFalse);
      },
    );

    test('rotated rectangles that cross do overlap', () {
      const a = RectShape(
        center: Vec2.zero,
        width: 40,
        height: 4,
        rotationDeg: 45,
      );
      const b = RectShape(
        center: Vec2.zero,
        width: 40,
        height: 4,
        rotationDeg: -45,
      );
      expect(shapesOverlap(a, b), isTrue);
    });

    test('circles: overlapping, touching, apart', () {
      const a = CircleShape(center: Vec2.zero, diameter: 20);
      expect(
        shapesOverlap(a, const CircleShape(center: Vec2(15, 0), diameter: 20)),
        isTrue,
      );
      expect(
        shapesOverlap(a, const CircleShape(center: Vec2(20, 0), diameter: 20)),
        isFalse,
      );
    });

    test('circle and rectangle, including a rectangle corner', () {
      const r = RectShape(center: Vec2.zero, width: 20, height: 20);
      expect(
        shapesOverlap(r, const CircleShape(center: Vec2(15, 0), diameter: 12)),
        isTrue,
      );
      // Near the corner but outside it (distance to corner ≈ 7.07 > 6).
      expect(
        shapesOverlap(r, const CircleShape(center: Vec2(15, 15), diameter: 12)),
        isFalse,
      );
      expect(
        shapesOverlap(const CircleShape(center: Vec2(15, 0), diameter: 12), r),
        isTrue,
      );
    });
  });

  group('garden containment and distances', () {
    test('inside, touching the edge, and crossing it', () {
      const inside = RectShape(center: Vec2(50, 50), width: 20, height: 20);
      const atEdge = RectShape(center: Vec2(10, 10), width: 20, height: 20);
      const crossing = RectShape(center: Vec2(5, 50), width: 20, height: 20);
      expect(insideGarden(inside, 300, 120), isTrue);
      expect(insideGarden(atEdge, 300, 120), isTrue);
      expect(insideGarden(crossing, 300, 120), isFalse);
    });

    test('rotation can push a shape out of the garden', () {
      const r = RectShape(
        center: Vec2(150, 10),
        width: 60,
        height: 20,
        rotationDeg: 90,
      );
      expect(insideGarden(r, 300, 120), isFalse);
    });

    test('distances to edges', () {
      const r = RectShape(center: Vec2(50, 30), width: 40, height: 20);
      final d = distancesToEdges(r, 300, 120);
      expect((d.left, d.top, d.right, d.bottom), (30.0, 20.0, 230.0, 80.0));
    });
  });

  group('snapping', () {
    test('snapTo and snapAngle', () {
      expect(snapTo(23, 5), 25);
      expect(snapTo(22.4, 5), 20);
      expect(snapTo(7, 0), 7);
      expect(snapAngle(52), 45);
      expect(snapAngle(-10), 345);
      expect(snapAngle(359), 0);
    });

    test('snapCenter aligns to grid and to nearby garden edges', () {
      const bounds = Bounds(0, 0, 30, 30);
      final nearEdge = snapCenter(
        center: const Vec2(18, 61),
        boundsAtCenter: bounds,
        gridStep: 5,
        gardenLength: 300,
        gardenWidth: 120,
      );
      expect(nearEdge, const Vec2(15, 60), reason: 'x flush with left edge');

      final nearFarEdge = snapCenter(
        center: const Vec2(283, 102),
        boundsAtCenter: bounds,
        gridStep: 5,
        gardenLength: 300,
        gardenWidth: 120,
      );
      expect(nearFarEdge, const Vec2(285, 105));
    });
  });

  group('CanvasTransform', () {
    test('fit centres the garden and uses the limiting dimension', () {
      final t = CanvasTransform.fit(
        gardenLength: 300,
        gardenWidth: 120,
        viewportWidth: 400,
        viewportHeight: 800,
        padding: 20,
      );
      expect(t.pxPerCm, closeTo(360 / 300, eps));
      final topLeft = t.worldToScreen(Vec2.zero);
      final bottomRight = t.worldToScreen(const Vec2(300, 120));
      expect(topLeft.x, closeTo(20, eps));
      expect((topLeft.y + bottomRight.y) / 2, closeTo(400, eps));
    });

    test('world ↔ screen round-trips at several zooms and pans', () {
      var t = const CanvasTransform(pxPerCm: 1.3, offset: Vec2(17, -40));
      for (final step in [1.0, 2.5, 0.4]) {
        t = t
            .zoomAt(const Vec2(120, 80), step, minPxPerCm: 0.1, maxPxPerCm: 20)
            .pan(const Vec2(5, -3));
        for (final p in const [Vec2.zero, Vec2(123.4, 56.7), Vec2(-10, 999)]) {
          expect(
            t.screenToWorld(t.worldToScreen(p)).isCloseTo(p, 1e-9),
            isTrue,
          );
        }
      }
    });

    test('zoom keeps the focal point fixed and respects limits', () {
      const t = CanvasTransform(pxPerCm: 1, offset: Vec2(10, 10));
      const focal = Vec2(110, 60);
      final before = t.screenToWorld(focal);
      final zoomed = t.zoomAt(focal, 3, minPxPerCm: 0.5, maxPxPerCm: 2);
      expect(zoomed.pxPerCm, 2, reason: 'clamped to max');
      expect(zoomed.screenToWorld(focal).isCloseTo(before), isTrue);
      expect(t.screenToWorldDistance(48), 48);
      expect(zoomed.screenToWorldDistance(48), 24);
    });
  });
}
