import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';

abstract interface class CatalogueRepository {
  /// The bundled catalogue. Loaded once; later calls return the same value.
  Future<PlantCatalogue> load();
}
