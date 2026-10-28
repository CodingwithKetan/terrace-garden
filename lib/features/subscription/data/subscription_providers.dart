import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/features/subscription/data/play_purchase_service.dart';
import 'package:terrace_garden/features/subscription/domain/plan.dart';
import 'package:terrace_garden/features/subscription/domain/purchase_service.dart';

part 'subscription_providers.g.dart';

@Riverpod(keepAlive: true)
PurchaseService purchaseService(Ref ref) {
  final service = PlayPurchaseService(
    InAppPurchase.instance,
    ref.watch(sharedPreferencesProvider),
    ref.watch(appLoggerProvider),
  );
  ref.onDispose(service.dispose);
  return service;
}

/// The current plan; free until the store or the cache says otherwise.
@Riverpod(keepAlive: true)
Stream<Plan> currentPlan(Ref ref) =>
    ref.watch(purchaseServiceProvider).watchPlan();

/// What the current plan allows. Free while the plan is loading, so a
/// slow store never blocks the app; limits are checked again on use.
@riverpod
Entitlements entitlements(Ref ref) => switch (ref.watch(currentPlanProvider)) {
  AsyncData(value: Plan.plus) => Entitlements.plus,
  _ => Entitlements.free,
};

/// Plus offers with store prices (empty when not on sale).
@riverpod
Future<List<PlanOffer>> planOffers(Ref ref) =>
    ref.watch(purchaseServiceProvider).offers();
