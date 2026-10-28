// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(purchaseService)
final purchaseServiceProvider = PurchaseServiceProvider._();

final class PurchaseServiceProvider
    extends
        $FunctionalProvider<PurchaseService, PurchaseService, PurchaseService>
    with $Provider<PurchaseService> {
  PurchaseServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchaseServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchaseServiceHash();

  @$internal
  @override
  $ProviderElement<PurchaseService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PurchaseService create(Ref ref) {
    return purchaseService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PurchaseService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PurchaseService>(value),
    );
  }
}

String _$purchaseServiceHash() => r'08ce9a7ad699817307aeec261b77190d625e78ca';

/// The current plan; free until the store or the cache says otherwise.

@ProviderFor(currentPlan)
final currentPlanProvider = CurrentPlanProvider._();

/// The current plan; free until the store or the cache says otherwise.

final class CurrentPlanProvider
    extends $FunctionalProvider<AsyncValue<Plan>, Plan, Stream<Plan>>
    with $FutureModifier<Plan>, $StreamProvider<Plan> {
  /// The current plan; free until the store or the cache says otherwise.
  CurrentPlanProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentPlanProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentPlanHash();

  @$internal
  @override
  $StreamProviderElement<Plan> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Plan> create(Ref ref) {
    return currentPlan(ref);
  }
}

String _$currentPlanHash() => r'1a407d6232ea9525adc30c609912cec68037ca28';

/// What the current plan allows. Free while the plan is loading, so a
/// slow store never blocks the app; limits are checked again on use.

@ProviderFor(entitlements)
final entitlementsProvider = EntitlementsProvider._();

/// What the current plan allows. Free while the plan is loading, so a
/// slow store never blocks the app; limits are checked again on use.

final class EntitlementsProvider
    extends $FunctionalProvider<Entitlements, Entitlements, Entitlements>
    with $Provider<Entitlements> {
  /// What the current plan allows. Free while the plan is loading, so a
  /// slow store never blocks the app; limits are checked again on use.
  EntitlementsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'entitlementsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$entitlementsHash();

  @$internal
  @override
  $ProviderElement<Entitlements> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Entitlements create(Ref ref) {
    return entitlements(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Entitlements value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Entitlements>(value),
    );
  }
}

String _$entitlementsHash() => r'da3754209ed1fbcaca29a6aee275b656f95f779b';

/// Plus offers with store prices (empty when not on sale).

@ProviderFor(planOffers)
final planOffersProvider = PlanOffersProvider._();

/// Plus offers with store prices (empty when not on sale).

final class PlanOffersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PlanOffer>>,
          List<PlanOffer>,
          FutureOr<List<PlanOffer>>
        >
    with $FutureModifier<List<PlanOffer>>, $FutureProvider<List<PlanOffer>> {
  /// Plus offers with store prices (empty when not on sale).
  PlanOffersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'planOffersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$planOffersHash();

  @$internal
  @override
  $FutureProviderElement<List<PlanOffer>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PlanOffer>> create(Ref ref) {
    return planOffers(ref);
  }
}

String _$planOffersHash() => r'524ab034b411480f639a7ebbc312ac55ae54587a';
