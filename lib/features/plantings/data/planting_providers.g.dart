// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planting_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(plantingRepository)
final plantingRepositoryProvider = PlantingRepositoryProvider._();

final class PlantingRepositoryProvider
    extends
        $FunctionalProvider<
          PlantingRepository,
          PlantingRepository,
          PlantingRepository
        >
    with $Provider<PlantingRepository> {
  PlantingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'plantingRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$plantingRepositoryHash();

  @$internal
  @override
  $ProviderElement<PlantingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PlantingRepository create(Ref ref) {
    return plantingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlantingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlantingRepository>(value),
    );
  }
}

String _$plantingRepositoryHash() =>
    r'd1fe5213e4386be0e47b45d9fba36e3838174aa7';

@ProviderFor(shortlistRepository)
final shortlistRepositoryProvider = ShortlistRepositoryProvider._();

final class ShortlistRepositoryProvider
    extends
        $FunctionalProvider<
          ShortlistRepository,
          ShortlistRepository,
          ShortlistRepository
        >
    with $Provider<ShortlistRepository> {
  ShortlistRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shortlistRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shortlistRepositoryHash();

  @$internal
  @override
  $ProviderElement<ShortlistRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShortlistRepository create(Ref ref) {
    return shortlistRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShortlistRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShortlistRepository>(value),
    );
  }
}

String _$shortlistRepositoryHash() =>
    r'65b60d8fe99acdd9a00694ea89d3a3002c17baee';

@ProviderFor(gardenPlantings)
final gardenPlantingsProvider = GardenPlantingsFamily._();

final class GardenPlantingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Planting>>,
          List<Planting>,
          Stream<List<Planting>>
        >
    with $FutureModifier<List<Planting>>, $StreamProvider<List<Planting>> {
  GardenPlantingsProvider._({
    required GardenPlantingsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'gardenPlantingsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$gardenPlantingsHash();

  @override
  String toString() {
    return r'gardenPlantingsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Planting>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Planting>> create(Ref ref) {
    final argument = this.argument as String;
    return gardenPlantings(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GardenPlantingsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$gardenPlantingsHash() => r'865cf69a5a16e2dd8a965dca56dc33014e0e0fe1';

final class GardenPlantingsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Planting>>, String> {
  GardenPlantingsFamily._()
    : super(
        retry: null,
        name: r'gardenPlantingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GardenPlantingsProvider call(String gardenId) =>
      GardenPlantingsProvider._(argument: gardenId, from: this);

  @override
  String toString() => r'gardenPlantingsProvider';
}

@ProviderFor(allPlantings)
final allPlantingsProvider = AllPlantingsProvider._();

final class AllPlantingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Planting>>,
          List<Planting>,
          Stream<List<Planting>>
        >
    with $FutureModifier<List<Planting>>, $StreamProvider<List<Planting>> {
  AllPlantingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allPlantingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allPlantingsHash();

  @$internal
  @override
  $StreamProviderElement<List<Planting>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Planting>> create(Ref ref) {
    return allPlantings(ref);
  }
}

String _$allPlantingsHash() => r'69d0e13acf2413ef272433a6c7bb63276ee10462';

@ProviderFor(shortlist)
final shortlistProvider = ShortlistFamily._();

final class ShortlistProvider
    extends
        $FunctionalProvider<
          AsyncValue<Set<String>>,
          Set<String>,
          Stream<Set<String>>
        >
    with $FutureModifier<Set<String>>, $StreamProvider<Set<String>> {
  ShortlistProvider._({
    required ShortlistFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'shortlistProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$shortlistHash();

  @override
  String toString() {
    return r'shortlistProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Set<String>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Set<String>> create(Ref ref) {
    final argument = this.argument as String;
    return shortlist(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ShortlistProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$shortlistHash() => r'c11a73379f80f2b8683069218bfb2d1186b25e0c';

final class ShortlistFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Set<String>>, String> {
  ShortlistFamily._()
    : super(
        retry: null,
        name: r'shortlistProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ShortlistProvider call(String gardenId) =>
      ShortlistProvider._(argument: gardenId, from: this);

  @override
  String toString() => r'shortlistProvider';
}
