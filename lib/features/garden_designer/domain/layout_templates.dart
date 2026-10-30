import 'package:terrace_garden/features/garden_designer/domain/container_presets.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';

/// Starting layouts, generated to fit the garden's own size. They arrange
/// common containers with room to walk; they make no claim about what grows
/// well, and the user moves or removes anything afterwards.
enum LayoutTemplate {
  /// Planter boxes in a line along the railing (the top edge).
  railingPlanters,

  /// Rows of 15 × 15 in grow bags along the long edges, a path between.
  growBagRows,

  /// 4 × 2 ft raised beds along the top, grow bags along the bottom.
  bedsAndBags,
}

/// Space between neighbouring containers, cm.
const double _gap = 10;

/// Narrowest and widest walkway a template lays, cm.
const double _minPath = 45;
const double _maxPath = 75;

const _bag = ElementPreset(ElementKind.roundGrowBag, widthIn: 15, depthIn: 15);
const _bed = ElementPreset(
  ElementKind.raisedBed,
  widthIn: 48,
  heightIn: 24,
  depthIn: 12,
);

/// Elements for [template] on a [length] × [width] cm floor, or an empty
/// list when it does not fit.
List<LayoutElement> buildTemplate(
  LayoutTemplate template, {
  required double length,
  required double width,
  required String Function() newId,
}) {
  final out = <LayoutElement>[];

  /// Centres of as many items of [size] as fit along the length, centred.
  List<double> row(double size) {
    final n = ((length - _gap) / (size + _gap)).floor();
    if (n < 1) return const [];
    final used = n * size + (n - 1) * _gap;
    final start = (length - used) / 2 + size / 2;
    return [for (var i = 0; i < n; i++) start + i * (size + _gap)];
  }

  void preset(ElementPreset p, double x, double y) =>
      out.add(p.toElement(id: newId(), center: Vec2(x, y)));

  /// A walkway in the free band from [top] to [bottom]: centred when it
  /// runs between two rows, otherwise just in front of the row above.
  void path(double top, double bottom, {bool between = false}) {
    final free = bottom - top;
    if (free < _minPath) return;
    final h = free < _maxPath ? free : _maxPath;
    final y = between ? (top + bottom) / 2 : top + h / 2;
    out.add(
      LayoutElement(
        id: newId(),
        kind: ElementKind.path,
        center: Vec2(length / 2, y),
        width: length,
        height: h,
      ),
    );
  }

  switch (template) {
    case LayoutTemplate.railingPlanters:
      const k = ElementKind.rectPlanter;
      if (width < k.h + ElementKind.railing.h) return const [];
      out.add(
        LayoutElement(
          id: newId(),
          kind: ElementKind.railing,
          center: Vec2(length / 2, ElementKind.railing.h / 2),
          width: length,
          height: ElementKind.railing.h,
        ),
      );
      final y = ElementKind.railing.h + k.h / 2;
      for (final x in row(k.w)) {
        out.add(
          LayoutElement(
            id: newId(),
            kind: k,
            center: Vec2(x, y),
            width: k.w,
            height: k.h,
            depthCm: k.depth,
          ),
        );
      }
      path(ElementKind.railing.h + k.h + _gap, width);
    case LayoutTemplate.growBagRows:
      final d = _bag.widthCm;
      if (width < d + 2 * _gap) return const [];
      final xs = row(d);
      final twoRows = width >= 2 * d + 4 * _gap + _minPath;
      for (final x in xs) {
        preset(_bag, x, _gap + d / 2);
        if (twoRows) preset(_bag, x, width - _gap - d / 2);
      }
      path(
        d + 2 * _gap,
        twoRows ? width - d - 2 * _gap : width,
        between: twoRows,
      );
    case LayoutTemplate.bedsAndBags:
      final bedH = _bed.heightCm;
      final d = _bag.widthCm;
      if (width < bedH + 2 * _gap) return const [];
      for (final x in row(_bed.widthCm)) {
        preset(_bed, x, _gap + bedH / 2);
      }
      final withBags = width >= bedH + d + 4 * _gap + _minPath;
      if (withBags) {
        for (final x in row(d)) {
          preset(_bag, x, width - _gap - d / 2);
        }
      }
      path(
        bedH + 2 * _gap,
        withBags ? width - d - 2 * _gap : width,
        between: withBags,
      );
  }
  return out.any((e) => e.kind.isContainer) ? out : const [];
}
