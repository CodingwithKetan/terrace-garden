import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/features/garden/garden.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/garden_designer.dart';
import 'package:terrace_garden/features/plant_catalog/data/catalogue_providers.dart';
import 'package:terrace_garden/features/plant_catalog/domain/recommendation_engine.dart';

part 'recommendation_providers.g.dart';

/// Containers on a layout whose soil volume and depth are known.
List<ContainerSpace> containerSpaces(List<LayoutElement> elements) => [
  for (final e in elements)
    if (e.kind.isContainer && e.soilLitres != null)
      ContainerSpace(id: e.id, soilLitres: e.soilLitres!, depthCm: e.depthCm!),
];

/// Ranked catalogue for one garden, recomputed when the garden, its layout or
/// the catalogue changes. Null when the garden no longer exists.
@riverpod
Future<List<Recommendation>?> gardenRecommendations(
  Ref ref,
  String gardenId,
) async {
  final garden = await ref.watch(gardenProvider(gardenId).future);
  if (garden == null) return null;
  final catalogue = await ref.watch(plantCatalogueProvider.future);
  final elements = await ref.watch(layoutElementsProvider(gardenId).future);
  return RecommendationEngine.rank(
    garden: garden,
    species: catalogue.species,
    containers: containerSpaces(elements),
    month: ref.watch(clockProvider).now().month,
  );
}
