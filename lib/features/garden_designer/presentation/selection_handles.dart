import 'package:terrace_garden/features/garden_designer/domain/canvas_transform.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';

/// Screen positions of the selected element's handles. Shared by the painter
/// and the gesture hit test so what is drawn is exactly what is grabbable.
class SelectionHandles {
  SelectionHandles._(this.resize, this.rotate);

  factory SelectionHandles.of(LayoutElement e, CanvasTransform t) {
    final shape = e.shape;
    if (shape is CircleShape) {
      return SelectionHandles._([
        t.worldToScreen(shape.center + Vec2(shape.radius, 0)),
      ], null);
    }
    final rect = shape as RectShape;
    final corners = rect.corners.map(t.worldToScreen).toList();
    // Rotation handle sits a fixed screen distance above the top edge.
    final offsetCm = t.screenToWorldDistance(rotateHandleGapPx);
    final topMid = Vec2(0, -(rect.height / 2 + offsetCm));
    final rotate = t.worldToScreen(
      topMid.rotate(rect.rotationDeg) + rect.center,
    );
    return SelectionHandles._(corners, rotate);
  }

  /// Visual radius of a handle (px).
  static const double visualRadiusPx = 7;

  /// Touch radius of a handle (px): at least a 48 dp target (design §10).
  static const double hitRadiusPx = 24;

  static const double rotateHandleGapPx = 32;

  final List<Vec2> resize;
  final Vec2? rotate;

  bool hitsRotate(Vec2 screen) =>
      rotate != null && (rotate! - screen).length <= hitRadiusPx;

  bool hitsResize(Vec2 screen) =>
      resize.any((h) => (h - screen).length <= hitRadiusPx);

  /// Distance (px) from [screen] to the nearest resize handle.
  double nearestResizeDistance(Vec2 screen) =>
      resize.map((h) => (h - screen).length).reduce((a, b) => a < b ? a : b);
}
