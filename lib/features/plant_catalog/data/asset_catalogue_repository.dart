import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:terrace_garden/features/plant_catalog/data/catalogue_parser.dart';
import 'package:terrace_garden/features/plant_catalog/domain/catalogue_repository.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';

/// Reads the catalogue bundled under `assets/catalogue/` (ADR-021).
final class AssetCatalogueRepository implements CatalogueRepository {
  AssetCatalogueRepository(this._bundle);

  static const plantsAsset = 'assets/catalogue/plants.json';
  static const sourcesAsset = 'assets/catalogue/sources.json';

  final AssetBundle _bundle;
  Future<PlantCatalogue>? _loaded;

  @override
  Future<PlantCatalogue> load() => _loaded ??= _read();

  Future<PlantCatalogue> _read() async {
    // Decoded here rather than with `loadString`, which moves large files to
    // a background isolate; the catalogue is small and this keeps tests
    // deterministic.
    Future<String> text(String key) async =>
        utf8.decode((await _bundle.load(key)).buffer.asUint8List());
    return CatalogueParser.parse(
      plantsJson: await text(plantsAsset),
      sourcesJson: await text(sourcesAsset),
    );
  }
}
