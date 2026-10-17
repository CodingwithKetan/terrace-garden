import 'dart:math' as math;

import 'package:meta/meta.dart';

/// Pure 2D geometry for the designer, in world centimetres, y-down
/// (data-model.md §2, ADR-017). No Flutter imports so it is fully testable.
@immutable
final class Vec2 {
  const Vec2(this.x, this.y);

  static const zero = Vec2(0, 0);

  final double x;
  final double y;

  Vec2 operator +(Vec2 o) => Vec2(x + o.x, y + o.y);
  Vec2 operator -(Vec2 o) => Vec2(x - o.x, y - o.y);
  Vec2 operator *(double s) => Vec2(x * s, y * s);

  double dot(Vec2 o) => x * o.x + y * o.y;
  double get length => math.sqrt(x * x + y * y);

  /// Rotates clockwise on screen (y-down) by [degrees].
  Vec2 rotate(double degrees) {
    final r = degrees * math.pi / 180;
    final c = math.cos(r);
    final s = math.sin(r);
    return Vec2(x * c - y * s, x * s + y * c);
  }

  bool isCloseTo(Vec2 o, [double tolerance = 1e-6]) =>
      (x - o.x).abs() <= tolerance && (y - o.y).abs() <= tolerance;

  @override
  bool operator ==(Object other) =>
      other is Vec2 && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => 'Vec2($x, $y)';
}

/// Axis-aligned bounds.
@immutable
final class Bounds {
  const Bounds(this.left, this.top, this.right, this.bottom);

  final double left;
  final double top;
  final double right;
  final double bottom;

  double get width => right - left;
  double get height => bottom - top;
}

/// A footprint on the garden floor.
sealed class Shape {
  const Shape();

  Vec2 get center;
  Bounds get bounds;
  double get area;

  /// Whether [point] lies inside (or on the edge of) the shape.
  bool contains(Vec2 point);
}

/// A rectangle of [width] × [height] centred on [center], rotated clockwise
/// by [rotationDeg] about its centre.
final class RectShape extends Shape {
  const RectShape({
    required this.center,
    required this.width,
    required this.height,
    this.rotationDeg = 0,
  });

  @override
  final Vec2 center;
  final double width;
  final double height;
  final double rotationDeg;

  /// Corners in clockwise order starting top-left (before rotation).
  List<Vec2> get corners {
    final hw = width / 2;
    final hh = height / 2;
    return [
      Vec2(-hw, -hh),
      Vec2(hw, -hh),
      Vec2(hw, hh),
      Vec2(-hw, hh),
    ].map((c) => c.rotate(rotationDeg) + center).toList();
  }

  /// Unit vectors along the rectangle's local x and y axes.
  (Vec2, Vec2) get axes => (
    const Vec2(1, 0).rotate(rotationDeg),
    const Vec2(0, 1).rotate(rotationDeg),
  );

  /// [point] in the rectangle's local, unrotated frame (origin at centre).
  Vec2 toLocal(Vec2 point) => (point - center).rotate(-rotationDeg);

  @override
  Bounds get bounds => _boundsOf(corners);

  @override
  double get area => width * height;

  @override
  bool contains(Vec2 point) {
    final p = toLocal(point);
    const e = 1e-9;
    return p.x.abs() <= width / 2 + e && p.y.abs() <= height / 2 + e;
  }
}

final class CircleShape extends Shape {
  const CircleShape({required this.center, required this.diameter});

  @override
  final Vec2 center;
  final double diameter;

  double get radius => diameter / 2;

  @override
  Bounds get bounds => Bounds(
    center.x - radius,
    center.y - radius,
    center.x + radius,
    center.y + radius,
  );

  @override
  double get area => math.pi * radius * radius;

  @override
  bool contains(Vec2 point) => (point - center).length <= radius + 1e-9;
}

Bounds _boundsOf(List<Vec2> points) {
  var left = double.infinity;
  var top = double.infinity;
  var right = double.negativeInfinity;
  var bottom = double.negativeInfinity;
  for (final p in points) {
    left = math.min(left, p.x);
    top = math.min(top, p.y);
    right = math.max(right, p.x);
    bottom = math.max(bottom, p.y);
  }
  return Bounds(left, top, right, bottom);
}

/// Shapes that merely touch (gap of [touchTolerance] cm or less) do not
/// overlap, so items can stand side by side.
const double touchTolerance = 0.01;

/// Whether two footprints overlap by more than [touchTolerance].
bool shapesOverlap(Shape a, Shape b) => switch ((a, b)) {
  (final CircleShape c1, final CircleShape c2) =>
    (c1.center - c2.center).length < c1.radius + c2.radius - touchTolerance,
  (final RectShape r, final CircleShape c) => _rectCircleOverlap(r, c),
  (final CircleShape c, final RectShape r) => _rectCircleOverlap(r, c),
  (final RectShape r1, final RectShape r2) => _rectRectOverlap(r1, r2),
};

bool _rectCircleOverlap(RectShape r, CircleShape c) {
  final p = r.toLocal(c.center);
  final closest = Vec2(
    p.x.clamp(-r.width / 2, r.width / 2),
    p.y.clamp(-r.height / 2, r.height / 2),
  );
  return (p - closest).length < c.radius - touchTolerance;
}

/// Separating axis theorem for two oriented rectangles.
bool _rectRectOverlap(RectShape a, RectShape b) {
  final (ax, ay) = a.axes;
  final (bx, by) = b.axes;
  final ca = a.corners;
  final cb = b.corners;
  for (final axis in [ax, ay, bx, by]) {
    final (minA, maxA) = _project(ca, axis);
    final (minB, maxB) = _project(cb, axis);
    // A gap (or mere touching) on any axis means no overlap.
    if (maxA <= minB + touchTolerance || maxB <= minA + touchTolerance) {
      return false;
    }
  }
  return true;
}

(double, double) _project(List<Vec2> points, Vec2 axis) {
  var min = double.infinity;
  var max = double.negativeInfinity;
  for (final p in points) {
    final d = p.dot(axis);
    if (d < min) min = d;
    if (d > max) max = d;
  }
  return (min, max);
}

/// Whether [shape] lies fully inside the garden rectangle from (0, 0) to
/// ([gardenLength], [gardenWidth]).
bool insideGarden(Shape shape, double gardenLength, double gardenWidth) {
  final b = shape.bounds;
  const e = touchTolerance;
  return b.left >= -e &&
      b.top >= -e &&
      b.right <= gardenLength + e &&
      b.bottom <= gardenWidth + e;
}

/// Free distance from the shape's bounds to each garden edge (negative when
/// the shape crosses that edge).
({double left, double top, double right, double bottom}) distancesToEdges(
  Shape shape,
  double gardenLength,
  double gardenWidth,
) {
  final b = shape.bounds;
  return (
    left: b.left,
    top: b.top,
    right: gardenLength - b.right,
    bottom: gardenWidth - b.bottom,
  );
}

/// Rounds [value] to the nearest multiple of [step].
double snapTo(double value, double step) =>
    step <= 0 ? value : (value / step).roundToDouble() * step;

/// Snaps a rotation to the nearest multiple of [stepDeg], normalised to
/// [0, 360).
double snapAngle(double degrees, {double stepDeg = 15}) =>
    normaliseAngle(snapTo(degrees, stepDeg));

double normaliseAngle(double degrees) {
  final r = degrees % 360;
  return r < 0 ? r + 360 : r;
}

/// Moves [center] onto the grid, then nudges the shape flush against a garden
/// edge when its bounds come within [edgeThreshold] cm of it.
Vec2 snapCenter({
  required Vec2 center,
  required Bounds boundsAtCenter,
  required double gridStep,
  required double gardenLength,
  required double gardenWidth,
  double edgeThreshold = 5,
}) {
  var x = snapTo(center.x, gridStep);
  var y = snapTo(center.y, gridStep);
  final halfW = boundsAtCenter.width / 2;
  final halfH = boundsAtCenter.height / 2;
  if ((x - halfW).abs() <= edgeThreshold) x = halfW;
  if ((gardenLength - (x + halfW)).abs() <= edgeThreshold) {
    x = gardenLength - halfW;
  }
  if ((y - halfH).abs() <= edgeThreshold) y = halfH;
  if ((gardenWidth - (y + halfH)).abs() <= edgeThreshold) {
    y = gardenWidth - halfH;
  }
  return Vec2(x, y);
}
