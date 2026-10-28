import 'dart:async';

import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/features/subscription/domain/plan.dart';
import 'package:terrace_garden/features/subscription/domain/purchase_service.dart';

/// A store that sells Plus instantly, or not at all when [onSale] is false.
class FakePurchaseService implements PurchaseService {
  FakePurchaseService({this.plan = Plan.free, this.onSale = true});

  Plan plan;
  bool onSale;
  final List<String> bought = [];
  int restores = 0;
  final _plans = StreamController<Plan>.broadcast();

  static const monthly = PlanOffer(
    id: 'terrace_plus_monthly',
    period: PlanPeriod.monthly,
    priceLabel: '₹49.00',
  );
  static const yearly = PlanOffer(
    id: 'terrace_plus_yearly',
    period: PlanPeriod.yearly,
    priceLabel: '₹399.00',
  );
  static const lifetime = PlanOffer(
    id: 'terrace_plus_lifetime',
    period: PlanPeriod.lifetime,
    priceLabel: '₹999.00',
  );

  @override
  Stream<Plan> watchPlan() async* {
    yield plan;
    yield* _plans.stream;
  }

  @override
  Future<List<PlanOffer>> offers() async =>
      onSale ? const [monthly, yearly, lifetime] : const [];

  @override
  Future<Result<void>> buy(PlanOffer offer) async {
    bought.add(offer.id);
    plan = Plan.plus;
    _plans.add(plan);
    return const Ok(null);
  }

  @override
  Future<Result<void>> restore() async {
    restores++;
    _plans.add(plan);
    return const Ok(null);
  }

  @override
  Uri get manageUrl =>
      Uri.parse('https://play.google.com/store/account/subscriptions');
}
