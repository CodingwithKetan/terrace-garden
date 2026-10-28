import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/features/subscription/domain/plan.dart';
import 'package:terrace_garden/features/subscription/domain/purchase_service.dart';

/// Plus through Google Play Billing (ADR-028).
///
/// Google Play is the source of truth. The last confirmed plan is cached
/// so Plus keeps working offline; it is re-checked against the store at
/// start-up and whenever a purchase update arrives. Purchases are verified
/// on the device only (no server yet, KI-037).
final class PlayPurchaseService implements PurchaseService {
  PlayPurchaseService(this._store, this._prefs, this._logger) {
    _subscription = _store.purchaseStream.listen(
      _onPurchases,
      onError: (Object error, StackTrace stackTrace) => _logger.error(
        'Purchase stream failed',
        error: error,
        stackTrace: stackTrace,
      ),
    );
  }

  /// Store product IDs. They must match the subscriptions set up in the
  /// Play Console.
  static const monthlyId = 'terrace_plus_monthly';
  static const yearlyId = 'terrace_plus_yearly';

  /// A one-time in-app product, not a subscription.
  static const lifetimeId = 'terrace_plus_lifetime';
  static const Set<String> productIds = {monthlyId, yearlyId, lifetimeId};

  static const cacheKey = 'subscription.plan';
  static const packageName = 'com.terracegarden.terrace_garden';

  final InAppPurchase _store;
  final SharedPreferencesAsync _prefs;
  final AppLogger _logger;
  final _plan = StreamController<Plan>.broadcast();
  late final StreamSubscription<List<PurchaseDetails>> _subscription;
  final Map<String, ProductDetails> _details = {};
  Plan? _current;

  @override
  Uri get manageUrl => Uri.parse(
    'https://play.google.com/store/account/subscriptions?package=$packageName',
  );

  @override
  Stream<Plan> watchPlan() async* {
    final cached = _current ?? await _readCache();
    _current = cached;
    yield cached;
    unawaited(_refresh());
    yield* _plan.stream;
  }

  @override
  Future<List<PlanOffer>> offers() async {
    try {
      if (!await _store.isAvailable()) return const [];
      final response = await _store.queryProductDetails(productIds);
      if (response.error != null) {
        _logger.error('Product query failed: ${response.error!.message}');
      }
      final offers = <PlanOffer>[];
      for (final details in response.productDetails) {
        // One offer per product: the first (base plan) entry.
        if (_details.containsKey(details.id)) continue;
        _details[details.id] = details;
        offers.add(
          PlanOffer(
            id: details.id,
            period: switch (details.id) {
              yearlyId => PlanPeriod.yearly,
              lifetimeId => PlanPeriod.lifetime,
              _ => PlanPeriod.monthly,
            },
            priceLabel: details.price,
          ),
        );
      }
      return offers..sort((a, b) => a.period.index.compareTo(b.period.index));
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Could not load Plus offers',
        error: error,
        stackTrace: stackTrace,
      );
      return const [];
    }
  }

  @override
  Future<Result<void>> buy(PlanOffer offer) async {
    final details = _details[offer.id];
    if (details == null) return const Err(NotFoundFailure());
    try {
      // Play subscriptions and the lifetime product are both bought as
      // non-consumables.
      final started = await _store.buyNonConsumable(
        purchaseParam: PurchaseParam(productDetails: details),
      );
      return started ? const Ok(null) : const Err(UnexpectedFailure());
    } on Object catch (error, stackTrace) {
      _logger.error('Purchase failed', error: error, stackTrace: stackTrace);
      return Err(UnexpectedFailure(error));
    }
  }

  @override
  Future<Result<void>> restore() async {
    try {
      await _refresh(strict: true);
      return const Ok(null);
    } on Object catch (error, stackTrace) {
      _logger.error('Restore failed', error: error, stackTrace: stackTrace);
      return Err(UnexpectedFailure(error));
    }
  }

  /// Asks Play which subscriptions are active. Offline, the cached plan
  /// stands (unless [strict], when the error is passed on).
  Future<void> _refresh({bool strict = false}) async {
    try {
      if (!await _store.isAvailable()) return;
      final addition = _store
          .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      final response = await addition.queryPastPurchases();
      if (response.error != null) {
        throw StateError(response.error!.message);
      }
      final active = response.pastPurchases.any(
        (p) =>
            productIds.contains(p.productID) &&
            p.status == PurchaseStatus.purchased,
      );
      for (final p in response.pastPurchases) {
        if (p.pendingCompletePurchase) await _store.completePurchase(p);
      }
      await _set(active ? Plan.plus : Plan.free);
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Could not check purchases; keeping the cached plan',
        error: error,
        stackTrace: stackTrace,
      );
      if (strict) rethrow;
    }
  }

  Future<void> _onPurchases(List<PurchaseDetails> purchases) async {
    for (final p in purchases) {
      if (!productIds.contains(p.productID)) continue;
      switch (p.status) {
        case PurchaseStatus.purchased || PurchaseStatus.restored:
          await _set(Plan.plus);
        case PurchaseStatus.error:
          _logger.error('Purchase error: ${p.error?.message}');
        case PurchaseStatus.pending || PurchaseStatus.canceled:
          break;
      }
      if (p.pendingCompletePurchase) await _store.completePurchase(p);
    }
  }

  Future<void> _set(Plan plan) async {
    if (plan == _current) return;
    _current = plan;
    _plan.add(plan);
    try {
      await _prefs.setString(cacheKey, plan.name);
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Could not cache the plan',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<Plan> _readCache() async {
    try {
      final name = await _prefs.getString(cacheKey);
      return Plan.values.where((p) => p.name == name).firstOrNull ?? Plan.free;
    } on Object {
      return Plan.free;
    }
  }

  Future<void> dispose() async {
    await _subscription.cancel();
    await _plan.close();
  }
}
