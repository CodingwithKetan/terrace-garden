import 'package:meta/meta.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';

/// A ready-made size for a new element. Sizes are the ones containers are
/// commonly sold in, labelled the way shops label them (inches for grow bags
/// and pots in India). They are starting points the user edits, not
/// recommendations; a pot's depth varies by maker, so it starts equal to its
/// diameter.
@immutable
final class ElementPreset {
  const ElementPreset(
    this.kind, {
    required this.widthIn,
    this.heightIn,
    this.depthIn,
  });

  final ElementKind kind;

  /// Diameter for round kinds, otherwise length.
  final double widthIn;

  /// Width of rectangular kinds; null for round ones.
  final double? heightIn;

  /// Soil depth (the bag's height for grow bags).
  final double? depthIn;

  double get widthCm => widthIn * cmPerInch;
  double get heightCm =>
      kind.round ? widthCm : (heightIn ?? widthIn) * cmPerInch;
  double? get depthCm => depthIn == null ? null : depthIn! * cmPerInch;

  /// The numbers shops print, e.g. `12 × 12` or `24 × 12 × 9`.
  String get sizeLabel => [
    widthIn,
    ?heightIn,
    ?depthIn,
  ].map(_number).join(' × ');

  static String _number(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toString();

  LayoutElement toElement({required String id, required Vec2 center}) =>
      LayoutElement(
        id: id,
        kind: kind,
        center: center,
        width: widthCm,
        height: heightCm,
        depthCm: depthCm ?? kind.depth,
      );
}

/// Sizes offered in the add sheet, by kind. Kinds without presets add at
/// their default size.
const Map<ElementKind, List<ElementPreset>> elementPresets = {
  ElementKind.roundGrowBag: [
    ElementPreset(ElementKind.roundGrowBag, widthIn: 9, depthIn: 9),
    ElementPreset(ElementKind.roundGrowBag, widthIn: 12, depthIn: 12),
    ElementPreset(ElementKind.roundGrowBag, widthIn: 15, depthIn: 15),
    ElementPreset(ElementKind.roundGrowBag, widthIn: 18, depthIn: 18),
    ElementPreset(ElementKind.roundGrowBag, widthIn: 24, depthIn: 24),
  ],
  ElementKind.growBag: [
    ElementPreset(ElementKind.growBag, widthIn: 24, heightIn: 12, depthIn: 9),
    ElementPreset(ElementKind.growBag, widthIn: 36, heightIn: 12, depthIn: 12),
    ElementPreset(ElementKind.growBag, widthIn: 24, heightIn: 24, depthIn: 12),
    ElementPreset(ElementKind.growBag, widthIn: 48, heightIn: 24, depthIn: 12),
  ],
  ElementKind.roundPot: [
    ElementPreset(ElementKind.roundPot, widthIn: 8, depthIn: 8),
    ElementPreset(ElementKind.roundPot, widthIn: 10, depthIn: 10),
    ElementPreset(ElementKind.roundPot, widthIn: 12, depthIn: 12),
    ElementPreset(ElementKind.roundPot, widthIn: 14, depthIn: 14),
    ElementPreset(ElementKind.roundPot, widthIn: 18, depthIn: 18),
  ],
  ElementKind.raisedBed: [
    ElementPreset(
      ElementKind.raisedBed,
      widthIn: 48,
      heightIn: 24,
      depthIn: 12,
    ),
    ElementPreset(
      ElementKind.raisedBed,
      widthIn: 72,
      heightIn: 36,
      depthIn: 12,
    ),
    ElementPreset(
      ElementKind.raisedBed,
      widthIn: 96,
      heightIn: 48,
      depthIn: 12,
    ),
  ],
};
