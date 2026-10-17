// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garden_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(gardenRepository)
final gardenRepositoryProvider = GardenRepositoryProvider._();

final class GardenRepositoryProvider
    extends
        $FunctionalProvider<
          GardenRepository,
          GardenRepository,
          GardenRepository
        >
    with $Provider<GardenRepository> {
  GardenRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gardenRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gardenRepositoryHash();

  @$internal
  @override
  $ProviderElement<GardenRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GardenRepository create(Ref ref) {
    return gardenRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GardenRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GardenRepository>(value),
    );
  }
}

String _$gardenRepositoryHash() => r'004b2338e0c7e111a6cc1080d5a2a8a6f8d133cc';

@ProviderFor(gardenPhotoRepository)
final gardenPhotoRepositoryProvider = GardenPhotoRepositoryProvider._();

final class GardenPhotoRepositoryProvider
    extends
        $FunctionalProvider<
          GardenPhotoRepository,
          GardenPhotoRepository,
          GardenPhotoRepository
        >
    with $Provider<GardenPhotoRepository> {
  GardenPhotoRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gardenPhotoRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gardenPhotoRepositoryHash();

  @$internal
  @override
  $ProviderElement<GardenPhotoRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GardenPhotoRepository create(Ref ref) {
    return gardenPhotoRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GardenPhotoRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GardenPhotoRepository>(value),
    );
  }
}

String _$gardenPhotoRepositoryHash() =>
    r'313271402a680c313b3f38b594a6371ec5837110';

@ProviderFor(gardenService)
final gardenServiceProvider = GardenServiceProvider._();

final class GardenServiceProvider
    extends $FunctionalProvider<GardenService, GardenService, GardenService>
    with $Provider<GardenService> {
  GardenServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gardenServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gardenServiceHash();

  @$internal
  @override
  $ProviderElement<GardenService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GardenService create(Ref ref) {
    return gardenService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GardenService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GardenService>(value),
    );
  }
}

String _$gardenServiceHash() => r'58000df6b1b5157a4445f50fa501a572f9862e16';

@ProviderFor(gardens)
final gardensProvider = GardensProvider._();

final class GardensProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Garden>>,
          List<Garden>,
          Stream<List<Garden>>
        >
    with $FutureModifier<List<Garden>>, $StreamProvider<List<Garden>> {
  GardensProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gardensProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gardensHash();

  @$internal
  @override
  $StreamProviderElement<List<Garden>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Garden>> create(Ref ref) {
    return gardens(ref);
  }
}

String _$gardensHash() => r'1889473f2eceb0a8cee8d58705690cf33b7bbe7f';

@ProviderFor(garden)
final gardenProvider = GardenFamily._();

final class GardenProvider
    extends $FunctionalProvider<AsyncValue<Garden?>, Garden?, Stream<Garden?>>
    with $FutureModifier<Garden?>, $StreamProvider<Garden?> {
  GardenProvider._({
    required GardenFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'gardenProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$gardenHash();

  @override
  String toString() {
    return r'gardenProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Garden?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Garden?> create(Ref ref) {
    final argument = this.argument as String;
    return garden(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GardenProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$gardenHash() => r'1740ee69302d67484798b19307c92718f4f83c92';

final class GardenFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Garden?>, String> {
  GardenFamily._()
    : super(
        retry: null,
        name: r'gardenProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GardenProvider call(String id) => GardenProvider._(argument: id, from: this);

  @override
  String toString() => r'gardenProvider';
}

@ProviderFor(gardenPhotos)
final gardenPhotosProvider = GardenPhotosFamily._();

final class GardenPhotosProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<GardenPhoto>>,
          List<GardenPhoto>,
          Stream<List<GardenPhoto>>
        >
    with
        $FutureModifier<List<GardenPhoto>>,
        $StreamProvider<List<GardenPhoto>> {
  GardenPhotosProvider._({
    required GardenPhotosFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'gardenPhotosProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$gardenPhotosHash();

  @override
  String toString() {
    return r'gardenPhotosProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<GardenPhoto>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<GardenPhoto>> create(Ref ref) {
    final argument = this.argument as String;
    return gardenPhotos(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GardenPhotosProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$gardenPhotosHash() => r'ab9105bf5a846fad84b82e28c4a0af6ca567fb9f';

final class GardenPhotosFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<GardenPhoto>>, String> {
  GardenPhotosFamily._()
    : super(
        retry: null,
        name: r'gardenPhotosProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GardenPhotosProvider call(String gardenId) =>
      GardenPhotosProvider._(argument: gardenId, from: this);

  @override
  String toString() => r'gardenPhotosProvider';
}
