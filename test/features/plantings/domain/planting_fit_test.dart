import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';
import 'package:terrace_garden/features/plantings/domain/planting_fit.dart';

PlantSpecies _species({
  String id = 'radish',
  double? minVolumeL = 3.8,
  double? minDepthCm = 10,
  int? perContainer = 3,
}) => PlantSpecies(
  id: id,
  commonName: id,
  scientificName: id,
  category: PlantCategory.vegetable,
  lifecycle: PlantLifecycle.annual,
  container: ContainerNeed(
    status: minVolumeL == null
        ? EvidenceStatus.unverified
        : EvidenceStatus.verified,
    minVolumeL: minVolumeL,
    minDepthCm: minDepthCm,
    plantsPerContainer: perContainer,
    sources: minVolumeL == null ? const [] : const ['S1'],
  ),
  petSafety: const PetSafety(
    status: PetSafetyStatus.notAssessed,
    sources: [],
  ),
  dataStatus: DataStatus.verified,
);

/// A 20 × 20 cm planter; [depth] cm deep → 20·20·depth / 1000 litres.
LayoutElement _planter({double? depth = 20}) => LayoutElement(
  id: 'planter',
  kind: ElementKind.rectPlanter,
  center: const Vec2(50, 50),
  width: 20,
  height: 20,
  depthCm: depth,
);

Planting _planting(String speciesId, int quantity) => Planting(
  id: 'p-$speciesId',
  gardenId: 'g',
  speciesId: speciesId,
  elementId: 'planter',
  quantity: quantity,
  plantedOn: LocalDate(2026, 10, 1),
  startedFrom: PlantingStart.seed,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

List<PlantingIssueKind> _kinds(List<PlantingIssue> issues) =>
    issues.map((i) => i.kind).toList();

void main() {
  test('no issues when the container meets the documented minimum', () {
    // 8 L, 20 cm deep: two 3.8 L units → capacity 6.
    final issues = PlantingFit.check(
      species: _species(),
      container: _planter(),
      quantity: 3,
      othersInContainer: const [],
    );
    expect(issues, isEmpty);
  });

  test('low volume and shallow depth report required vs actual', () {
    final issues = PlantingFit.check(
      species: _species(minVolumeL: 19, minDepthCm: 30),
      container: _planter(),
      quantity: 1,
      othersInContainer: const [],
    );
    expect(_kinds(issues), [
      PlantingIssueKind.lowVolume,
      PlantingIssueKind.shallow,
    ]);
    expect(issues.first.required, 19);
    expect(issues.first.actual, closeTo(8, 0.01));
    expect(issues[1].actual, 20);
  });

  test('crowding counts existing plantings of the same species', () {
    final issues = PlantingFit.check(
      species: _species(),
      container: _planter(),
      quantity: 2,
      othersInContainer: [_planting('radish', 5)],
    );
    expect(_kinds(issues), [PlantingIssueKind.crowded]);
    expect(issues.single.capacity, 6);
  });

  test('other species in the container are reported as shared', () {
    final issues = PlantingFit.check(
      species: _species(),
      container: _planter(),
      quantity: 1,
      othersInContainer: [_planting('mint', 1), _planting('okra', 1)],
    );
    expect(_kinds(issues), [PlantingIssueKind.shared]);
    expect(issues.single.capacity, 2);
  });

  test('a container without depth cannot be volume-checked', () {
    final issues = PlantingFit.check(
      species: _species(),
      container: _planter(depth: null),
      quantity: 1,
      othersInContainer: const [],
    );
    expect(_kinds(issues), [PlantingIssueKind.noDepth]);
  });

  test('undocumented sizes produce no warnings', () {
    final issues = PlantingFit.check(
      species: _species(minVolumeL: null, minDepthCm: null, perContainer: null),
      container: _planter(depth: 5),
      quantity: 50,
      othersInContainer: const [],
    );
    expect(issues, isEmpty);
  });

  test('capacity estimate scales whole minimum volumes', () {
    const need = ContainerNeed(
      status: EvidenceStatus.verified,
      minVolumeL: 3.8,
      plantsPerContainer: 2,
      sources: ['S1'],
    );
    expect(PlantingFit.estimatedCapacity(need, 3), 2);
    expect(PlantingFit.estimatedCapacity(need, 7.6), 4);
    expect(PlantingFit.estimatedCapacity(need, 11), 4);
    expect(PlantingFit.estimatedCapacity(need, null), isNull);
  });
}
