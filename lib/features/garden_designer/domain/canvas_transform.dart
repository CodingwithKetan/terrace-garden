import 'dart:math' as math;

import 'package:meta/meta.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';

/// Maps world centimetres to screen pixels and back (data-model.md §2):
/// `screen = world * pxPerCm + offset`. Pure Dart so the math is testable;
/// the canvas widget only converts to and from Flutter `Offset`.
@immutable
final class CanvasTransform {
  const CanvasTransform({required this.pxPerCm, required this.offset});

  /// Fits a garden of [gardenLength] × [gardenWidth] cm into a viewport of
  /// [viewportWidth] × [viewportHeight] px with [padding] px around it,
  /// centred.
  factory CanvasTransform.fit({
    required double gardenLength,
    required double gardenWidth,
    required double viewportWidth,
    required double viewportHeight,
    double padding = 24,
  }) {
    final availableW = math.max(1, viewportWidth - 2 * padding);
    final availableH = math.max(1, viewportHeight - 2 * padding);
    final scale = math.min(availableW / gardenLength, availableH / gardenWidth);
    final offset = Vec2(
      (viewportWidth - gardenLength * scale) / 2,
      (viewportHeight - gardenWidth * scale) / 2,
    );
    return CanvasTransform(pxPerCm: scale, offset: offset);
  }

  final double pxPerCm;
  final Vec2 offset;

  Vec2 worldToScreen(Vec2 world) => world * pxPerCm + offset;

  Vec2 screenToWorld(Vec2 screen) => (screen - offset) * (1 / pxPerCm);

  /// Converts a screen distance (px) to world centimetres.
  double screenToWorldDistance(double px) => px / pxPerCm;

  CanvasTransform pan(Vec2 deltaPx) =>
      CanvasTransform(pxPerCm: pxPerCm, offset: offset + deltaPx);

  /// Scales by [factor] keeping the world point under [focalPx] fixed on
  /// screen; the scale is clamped to [minPxPerCm]..[maxPxPerCm].
  CanvasTransform zoomAt(
    Vec2 focalPx,
    double factor, {
    required double minPxPerCm,
    required double maxPxPerCm,
  }) {
    final newScale = (pxPerCm * factor).clamp(minPxPerCm, maxPxPerCm);
    final worldFocal = screenToWorld(focalPx);
    return CanvasTransform(
      pxPerCm: newScale,
      offset: focalPx - worldFocal * newScale,
    );
  }
}
