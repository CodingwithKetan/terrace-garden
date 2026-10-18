// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalogue_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(catalogueRepository)
final catalogueRepositoryProvider = CatalogueRepositoryProvider._();

final class CatalogueRepositoryProvider
    extends
        $FunctionalProvider<
          CatalogueRepository,
          CatalogueRepository,
          CatalogueRepository
        >
    with $Provider<CatalogueRepository> {
  CatalogueRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'catalogueRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$catalogueRepositoryHash();

  @$internal
  @override
  $ProviderElement<CatalogueRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CatalogueRepository create(Ref ref) {
    return catalogueRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CatalogueRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CatalogueRepository>(value),
    );
  }
}

String _$catalogueRepositoryHash() =>
    r'4e32227906a6a9be7ffcc92088b66563ce145d18';

@ProviderFor(plantCatalogue)
final plantCatalogueProvider = PlantCatalogueProvider._();

final class PlantCatalogueProvider
    extends
        $FunctionalProvider<
          AsyncValue<PlantCatalogue>,
          PlantCatalogue,
          FutureOr<PlantCatalogue>
        >
    with $FutureModifier<PlantCatalogue>, $FutureProvider<PlantCatalogue> {
  PlantCatalogueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'plantCatalogueProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$plantCatalogueHash();

  @$internal
  @override
  $FutureProviderElement<PlantCatalogue> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PlantCatalogue> create(Ref ref) {
    return plantCatalogue(ref);
  }
}

String _$plantCatalogueHash() => r'1b57f88e47eee1d00258ccccaa50a57f30264986';
