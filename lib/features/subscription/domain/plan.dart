import 'package:meta/meta.dart';

/// The user's plan (ADR-028). Free covers everything that runs on the
/// phone to keep plants alive; Plus adds room to grow and conveniences.
enum Plan { free, plus }

/// How a Plus offer is paid: a renewing subscription or once for life.
enum PlanPeriod { monthly, yearly, lifetime }

/// What Plus unlocks beyond the free limits. Safety and honesty features
/// (soil checks, pet toxicity, structural cautions, sources) and data
/// rights (export, delete) are never on this list.
enum PlusFeature {
  /// More than [PlanLimits.freeGardens] gardens (home terrace, balcony,
  /// a parent's roof).
  moreGardens,

  /// More than [PlanLimits.freeJournalPhotos] journal photos.
  morePhotos,

  /// Side-by-side photo comparison.
  photoComparison,

  /// The printable garden report.
  gardenReport,
}

/// The free plan's limits, in one place so they are easy to review.
abstract final class PlanLimits {
  static const freeGardens = 1;
  static const freeJournalPhotos = 60;
}

/// A purchasable Plus offer as the store describes it. The price label
/// comes from the store, formatted for the user's country; the app never
/// hard-codes what someone will be charged.
@immutable
final class PlanOffer {
  const PlanOffer({
    required this.id,
    required this.period,
    required this.priceLabel,
    this.trialDays,
  });

  /// The store product ID.
  final String id;
  final PlanPeriod period;

  /// e.g. "₹399.00", from the store.
  final String priceLabel;

  /// Free trial length when the store offers one.
  final int? trialDays;

  @override
  bool operator ==(Object other) =>
      other is PlanOffer &&
      other.id == id &&
      other.period == period &&
      other.priceLabel == priceLabel &&
      other.trialDays == trialDays;

  @override
  int get hashCode => Object.hash(id, period, priceLabel, trialDays);
}

/// What the current plan allows. Pure, so every limit is unit-tested.
@immutable
final class Entitlements {
  const Entitlements(this.plan);

  static const free = Entitlements(Plan.free);
  static const plus = Entitlements(Plan.plus);

  final Plan plan;

  bool get isPlus => plan == Plan.plus;

  bool allows(PlusFeature feature) => isPlus;

  /// Whether one more garden fits, given how many exist.
  bool canAddGarden({required int existing}) =>
      isPlus || existing < PlanLimits.freeGardens;

  /// Whether [adding] more journal photos fit, given [existing] ones.
  bool canAddJournalPhotos({required int existing, required int adding}) =>
      isPlus || existing + adding <= PlanLimits.freeJournalPhotos;

  /// How many more journal photos fit on this plan (null: no limit).
  int? journalPhotosLeft({required int existing}) => isPlus
      ? null
      : (PlanLimits.freeJournalPhotos - existing).clamp(
          0,
          PlanLimits.freeJournalPhotos,
        );

  @override
  bool operator ==(Object other) => other is Entitlements && other.plan == plan;

  @override
  int get hashCode => plan.hashCode;
}
