import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';

/// The direct sun a sun area stands for, in the garden profile's own bands,
/// or null when [kind] is not a sun area. The bands are what the user
/// observed, never a calculation.
SunExposure? sunExposureOf(ElementKind kind) => switch (kind) {
  ElementKind.sunFull => SunExposure.moreThan6Hours,
  ElementKind.sunPart => SunExposure.from3To6Hours,
  ElementKind.shade => SunExposure.lessThan3Hours,
  _ => null,
};

/// The sun the user marked at [point]: the topmost sun area covering it, or
/// null when no area covers it.
SunExposure? sunAt(LayoutDocument doc, Vec2 point) {
  for (final e in doc.drawOrder.reversed) {
    final sun = sunExposureOf(e.kind);
    if (sun != null && e.shape.contains(point)) return sun;
  }
  return null;
}

/// The sun at the centre of [element] (e.g. a container).
SunExposure? sunFor(LayoutDocument doc, LayoutElement element) =>
    sunAt(doc, element.center);

/// The layout's north arrow, if the user placed one.
LayoutElement? northArrowOf(LayoutDocument doc) =>
    doc.elements.where((e) => e.kind == ElementKind.northArrow).firstOrNull;
