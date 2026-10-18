import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:terrace_garden/features/plant_catalog/data/asset_catalogue_repository.dart';
import 'package:terrace_garden/features/plant_catalog/domain/catalogue_repository.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';

part 'catalogue_providers.g.dart';

@Riverpod(keepAlive: true)
CatalogueRepository catalogueRepository(Ref ref) =>
    AssetCatalogueRepository(rootBundle);

@Riverpod(keepAlive: true)
Future<PlantCatalogue> plantCatalogue(Ref ref) =>
    ref.watch(catalogueRepositoryProvider).load();
