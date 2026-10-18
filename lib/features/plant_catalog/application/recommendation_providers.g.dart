// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Ranked catalogue for one garden, recomputed when the garden, its layout or
/// the catalogue changes. Null when the garden no longer exists.

@ProviderFor(gardenRecommendations)
final gardenRecommendationsProvider = GardenRecommendationsFamily._();

/// Ranked catalogue for one garden, recomputed when the garden, its layout or
/// the catalogue changes. Null when the garden no longer exists.

final class GardenRecommendationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Recommendation>?>,
          List<Recommendation>?,
          FutureOr<List<Recommendation>?>
        >
    with
        $FutureModifier<List<Recommendation>?>,
        $FutureProvider<List<Recommendation>?> {
  /// Ranked catalogue for one garden, recomputed when the garden, its layout or
  /// the catalogue changes. Null when the garden no longer exists.
  GardenRecommendationsProvider._({
    required GardenRecommendationsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'gardenRecommendationsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$gardenRecommendationsHash();

  @override
  String toString() {
    return r'gardenRecommendationsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Recommendation>?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Recommendation>?> create(Ref ref) {
    final argument = this.argument as String;
    return gardenRecommendations(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GardenRecommendationsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$gardenRecommendationsHash() =>
    r'6dfb7f76e55f98878fad846fe9b5458b9f1b4002';

/// Ranked catalogue for one garden, recomputed when the garden, its layout or
/// the catalogue changes. Null when the garden no longer exists.

final class GardenRecommendationsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Recommendation>?>, String> {
  GardenRecommendationsFamily._()
    : super(
        retry: null,
        name: r'gardenRecommendationsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Ranked catalogue for one garden, recomputed when the garden, its layout or
  /// the catalogue changes. Null when the garden no longer exists.

  GardenRecommendationsProvider call(String gardenId) =>
      GardenRecommendationsProvider._(argument: gardenId, from: this);

  @override
  String toString() => r'gardenRecommendationsProvider';
}
