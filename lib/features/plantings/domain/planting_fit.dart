import 'package:meta/meta.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';

enum PlantingIssueKind {
  /// Soil volume below the species' documented minimum.
  lowVolume,

  /// Soil depth below the documented minimum.
  shallow,

  /// More plants of this species than the rough capacity estimate.
  crowded,

  /// Other plantings already use this container.
  shared,

  /// The container has no soil depth, so volume can't be checked.
  noDepth,
}

@immutable
final class PlantingIssue {
  const PlantingIssue(this.kind, {this.required, this.actual, this.capacity});

  final PlantingIssueKind kind;

  /// The documented minimum (L or cm) for [PlantingIssueKind.lowVolume] and
  /// [PlantingIssueKind.shallow].
  final double? required;

  /// The container's value in the same unit.
  final double? actual;

  /// Estimated plant capacity for [PlantingIssueKind.crowded]; the count of
  /// other plantings for [PlantingIssueKind.shared].
  final int? capacity;
}

/// A one-word answer to "does this plant go in this container?", for the
/// add-plant picker on the terrace plan.
enum ContainerVerdict {
  /// Documented figures are met and nothing else grows there.
  fits,

  /// Figures are met; another plant already grows there.
  fitsShared,

  /// Less soil than the documented minimum.
  tooSmall,

  /// Shallower than the documented minimum.
  tooShallow,

  /// More plants than the rough capacity estimate.
  full,

  /// Nothing to check against: no documented size, or no depth recorded.
  unknown;

  /// The verdict for [issues] from [PlantingFit.check] on [species].
  static ContainerVerdict of(
    List<PlantingIssue> issues, {
    required PlantSpecies species,
  }) {
    final kinds = {for (final i in issues) i.kind};
    if (kinds.contains(PlantingIssueKind.lowVolume)) return tooSmall;
    if (kinds.contains(PlantingIssueKind.shallow)) return tooShallow;
    if (kinds.contains(PlantingIssueKind.crowded)) return full;
    if (kinds.contains(PlantingIssueKind.noDepth) ||
        !species.container.hasSize) {
      return unknown;
    }
    return kinds.contains(PlantingIssueKind.shared) ? fitsShared : fits;
  }

  bool get suitable => this == fits || this == fitsShared;
}

/// Checks a planting against its container (P4-06), using only figures the
/// catalogue documents. With no documented size the check returns nothing
/// rather than guessing.
abstract final class PlantingFit {
  static List<PlantingIssue> check({
    required PlantSpecies species,
    required LayoutElement container,
    required int quantity,
    required List<Planting> othersInContainer,
  }) {
    final need = species.container;
    final litres = container.soilLitres;
    final depth = container.depthCm;
    final issues = <PlantingIssue>[];

    if (need.minVolumeL != null) {
      if (litres == null) {
        issues.add(const PlantingIssue(PlantingIssueKind.noDepth));
      } else if (litres < need.minVolumeL!) {
        issues.add(
          PlantingIssue(
            PlantingIssueKind.lowVolume,
            required: need.minVolumeL,
            actual: litres,
          ),
        );
      }
    }
    if (need.minDepthCm != null && depth != null && depth < need.minDepthCm!) {
      issues.add(
        PlantingIssue(
          PlantingIssueKind.shallow,
          required: need.minDepthCm,
          actual: depth,
        ),
      );
    }

    final sameSpecies = othersInContainer
        .where((p) => p.speciesId == species.id)
        .fold(0, (sum, p) => sum + p.quantity);
    final capacity = estimatedCapacity(need, litres);
    if (capacity != null && quantity + sameSpecies > capacity) {
      issues.add(
        PlantingIssue(PlantingIssueKind.crowded, capacity: capacity),
      );
    }
    final others = othersInContainer
        .where((p) => p.speciesId != species.id)
        .length;
    if (others > 0) {
      issues.add(PlantingIssue(PlantingIssueKind.shared, capacity: others));
    }
    return issues;
  }

  /// Rough number of plants a container holds: the source's "N plants per
  /// minimum container" scaled by how many minimum volumes fit. Null when the
  /// source gives no per-container count or the volume is unknown.
  static int? estimatedCapacity(ContainerNeed need, double? litres) {
    final perContainer = need.plantsPerContainer;
    final minVolume = need.minVolumeL;
    if (perContainer == null || minVolume == null || litres == null) {
      return null;
    }
    final units = (litres / minVolume).floor();
    return units < 1 ? perContainer : units * perContainer;
  }
}
