import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';

part 'layout.freezed.dart';

/// How an element takes part in validation.
enum ElementRole {
  /// Holds soil and plants; must not overlap other solids.
  container,

  /// Walls and railings; must not overlap other solids.
  structure,

  /// Walkways; containers on a path are allowed but flagged.
  walkway,

  /// Small markers (e.g. a tap) that may sit anywhere.
  marker,

  /// Areas the user marks as sunny or shady; they never conflict.
  zone,

  /// Part of the rectangle that is not usable floor (an L-shaped terrace,
  /// a stairwell). Nothing may stand on it.
  cutOut,
}

/// Element types for the designer (PRD FR-C2). Default sizes are starting
/// points the user edits; they are not recommendations. Kinds are stored by
/// name, so new values need no migration.
enum ElementKind {
  roundPot(ElementRole.container, round: true, w: 30, h: 30, depth: 30),
  roundGrowBag(ElementRole.container, round: true, w: 30, h: 30, depth: 30),
  rectPlanter(ElementRole.container, w: 60, h: 25, depth: 25),
  growBag(ElementRole.container, w: 60, h: 45, depth: 30),
  raisedBed(ElementRole.container, w: 120, h: 60, depth: 30),
  verticalPlanter(ElementRole.container, w: 60, h: 30, depth: 20),

  /// Hangs from a hook or railing above the floor.
  hangingPot(
    ElementRole.container,
    round: true,
    overhead: true,
    w: 25,
    h: 25,
    depth: 15,
  ),
  wall(ElementRole.structure, w: 100, h: 10),
  railing(ElementRole.structure, w: 100, h: 5),
  trellis(ElementRole.structure, w: 100, h: 5),
  waterTank(ElementRole.structure, round: true, w: 110, h: 110),

  /// A staircase head room, lift room or any built block on the terrace.
  stairs(ElementRole.structure, w: 120, h: 240),
  seating(ElementRole.structure, w: 120, h: 45),
  path(ElementRole.walkway, w: 100, h: 60),

  /// The space a door opens into, which should stay clear.
  door(ElementRole.walkway, w: 90, h: 90),
  waterPoint(ElementRole.marker, round: true, w: 15, h: 15),

  /// A floor drain or outlet, which should stay uncovered.
  drain(ElementRole.marker, round: true, w: 15, h: 15),

  /// Points north; the user rotates it. One per layout.
  northArrow(ElementRole.marker, w: 40, h: 40),

  /// Sun areas, as the user observes them (never computed).
  sunFull(ElementRole.zone, w: 150, h: 100),
  sunPart(ElementRole.zone, w: 150, h: 100),
  shade(ElementRole.zone, w: 150, h: 100),
  cutOut(ElementRole.cutOut, w: 100, h: 100);

  const ElementKind(
    this.role, {
    required this.w,
    required this.h,
    this.round = false,
    this.overhead = false,
    this.depth,
  });

  final ElementRole role;

  /// Circular footprint: `width` is the diameter and rotation is ignored.
  final bool round;

  /// Hangs above the floor, so it never collides with floor objects.
  final bool overhead;

  /// Default footprint in cm.
  final double w;
  final double h;

  /// Default soil depth in cm (containers only).
  final double? depth;

  bool get isContainer => role == ElementRole.container;

  /// Lies under everything else: a tap selects it only when nothing else is
  /// there, and a drag that starts on it pans the view unless it is
  /// already selected.
  bool get isBackground =>
      role == ElementRole.zone || role == ElementRole.cutOut;

  /// Back-to-front layer for drawing and hit testing: sun areas, cut-outs,
  /// walkways, structures, markers, containers, hanging pots, then the north
  /// arrow. Within a layer, later elements are on top.
  int get drawLayer => this == northArrow
      ? 7
      : overhead
      ? 6
      : switch (role) {
          ElementRole.zone => 0,
          ElementRole.cutOut => 1,
          ElementRole.walkway => 2,
          ElementRole.structure => 3,
          ElementRole.marker => 4,
          ElementRole.container => 5,
        };

  /// Smallest side accepted (cm), to keep elements tappable and meaningful.
  static const double minSide = 5;
}

/// A placed object (data-model.md §3 LayoutElement). Geometry is in world
/// centimetres: centre, size and clockwise rotation about the centre.
@freezed
abstract class LayoutElement with _$LayoutElement {
  const factory LayoutElement({
    required String id,
    required ElementKind kind,
    required Vec2 center,
    required double width,
    required double height,
    @Default(0) double rotationDeg,
    double? depthCm,
    String? label,
  }) = _LayoutElement;

  const LayoutElement._();

  Shape get shape => kind.round
      ? CircleShape(center: center, diameter: width)
      : RectShape(
          center: center,
          width: width,
          height: height,
          rotationDeg: rotationDeg,
        );

  double get footprintArea => shape.area;

  /// The narrowest side of the footprint (the diameter of a round one), cm.
  double get narrowestSide => kind.round ? width : math.min(width, height);

  /// Soil volume in litres when the element is a container with a depth.
  double? get soilLitres {
    if (!kind.isContainer || depthCm == null) return null;
    return footprintArea * depthCm! / 1000;
  }
}

/// One garden's layout. The boundary comes from the garden's own dimensions
/// so the garden profile stays the single source of truth for its size.
@freezed
abstract class LayoutDocument with _$LayoutDocument {
  const factory LayoutDocument({
    required String gardenId,

    /// Garden size along x (length) and y (width), in cm.
    required double length,
    required double width,
    @Default(<LayoutElement>[]) List<LayoutElement> elements,
  }) = _LayoutDocument;

  const LayoutDocument._();

  double get area => length * width;

  LayoutElement? elementById(String id) =>
      elements.where((e) => e.id == id).firstOrNull;

  /// [elements] back to front, by [ElementKind.drawLayer] and then list
  /// order.
  List<LayoutElement> get drawOrder {
    final indexed = [...elements.indexed]
      ..sort((a, b) {
        final byLayer = a.$2.kind.drawLayer.compareTo(b.$2.kind.drawLayer);
        return byLayer != 0 ? byLayer : a.$1.compareTo(b.$1);
      });
    return [for (final (_, e) in indexed) e];
  }

  /// Replaces the element with the same id, or appends it (on top).
  LayoutDocument upsert(LayoutElement element) {
    final index = elements.indexWhere((e) => e.id == element.id);
    final next = [...elements];
    if (index < 0) {
      next.add(element);
    } else {
      next[index] = element;
    }
    return copyWith(elements: next);
  }

  LayoutDocument remove(String id) =>
      copyWith(elements: elements.where((e) => e.id != id).toList());
}

/// Space summary (DSN-05).
class LayoutSummary {
  const LayoutSummary({
    required this.gardenArea,
    required this.containerArea,
    required this.walkwayArea,
    required this.soilLitres,
    required this.countsByKind,
  });

  factory LayoutSummary.of(LayoutDocument doc) {
    var containers = 0.0;
    var walkways = 0.0;
    var soil = 0.0;
    var cutOut = 0.0;
    final counts = <ElementKind, int>{};
    for (final e in doc.elements) {
      counts[e.kind] = (counts[e.kind] ?? 0) + 1;
      switch (e.kind.role) {
        case ElementRole.container:
          containers += e.footprintArea;
          soil += e.soilLitres ?? 0;
        case ElementRole.walkway:
          walkways += e.footprintArea;
        case ElementRole.cutOut:
          cutOut += e.footprintArea;
        case ElementRole.structure || ElementRole.marker || ElementRole.zone:
          break;
      }
    }
    return LayoutSummary(
      // Usable floor: the rectangle less its cut-outs.
      gardenArea: math.max(0, doc.area - cutOut),
      containerArea: containers,
      walkwayArea: walkways,
      soilLitres: soil,
      countsByKind: counts,
    );
  }

  /// All in cm² except [soilLitres].
  final double gardenArea;
  final double containerArea;
  final double walkwayArea;
  final double soilLitres;
  final Map<ElementKind, int> countsByKind;

  /// Share of the floor covered by containers, 0..1 (overlaps not deducted).
  double get containerShare =>
      gardenArea <= 0 ? 0 : math.min(1, containerArea / gardenArea);

  int get containerCount => countsByKind.entries
      .where((e) => e.key.isContainer)
      .fold(0, (sum, e) => sum + e.value);
}
