import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/features/subscription/domain/plan.dart';

/// The store behind Plus (Google Play on Android). Hidden behind an
/// interface so tests and builds without a store use a fake.
abstract interface class PurchaseService {
  /// The current plan. Emits the cached plan first (so the app works
  /// offline), then whatever the store confirms.
  Stream<Plan> watchPlan();

  /// Plus offers with store prices. Empty when the store is unavailable
  /// or Plus is not on sale yet.
  Future<List<PlanOffer>> offers();

  /// Starts the store's purchase flow. Completes when the flow has been
  /// shown; the outcome arrives through [watchPlan].
  Future<Result<void>> buy(PlanOffer offer);

  /// Asks the store again for active purchases (e.g. on a new phone).
  Future<Result<void>> restore();

  /// Where the user manages or cancels the subscription.
  Uri get manageUrl;
}
