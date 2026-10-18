// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_garden.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The garden Today and Seasons show. Null until the user picks one, which
/// means "the first garden".

@ProviderFor(SelectedGardenId)
final selectedGardenIdProvider = SelectedGardenIdProvider._();

/// The garden Today and Seasons show. Null until the user picks one, which
/// means "the first garden".
final class SelectedGardenIdProvider
    extends $NotifierProvider<SelectedGardenId, String?> {
  /// The garden Today and Seasons show. Null until the user picks one, which
  /// means "the first garden".
  SelectedGardenIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedGardenIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedGardenIdHash();

  @$internal
  @override
  SelectedGardenId create() => SelectedGardenId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedGardenIdHash() => r'008dfbd5d7a668485acac1fec71755c4d6c3bb45';

/// The garden Today and Seasons show. Null until the user picks one, which
/// means "the first garden".

abstract class _$SelectedGardenId extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The garden to show: the selected one if it still exists, otherwise the
/// first. Null when there are no gardens (or while they load).

@ProviderFor(currentGarden)
final currentGardenProvider = CurrentGardenProvider._();

/// The garden to show: the selected one if it still exists, otherwise the
/// first. Null when there are no gardens (or while they load).

final class CurrentGardenProvider
    extends $FunctionalProvider<Garden?, Garden?, Garden?>
    with $Provider<Garden?> {
  /// The garden to show: the selected one if it still exists, otherwise the
  /// first. Null when there are no gardens (or while they load).
  CurrentGardenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentGardenProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentGardenHash();

  @$internal
  @override
  $ProviderElement<Garden?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Garden? create(Ref ref) {
    return currentGarden(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Garden? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Garden?>(value),
    );
  }
}

String _$currentGardenHash() => r'f65f6491bd70b5989786047412e4731488c34546';
