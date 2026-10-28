import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/features/subscription/domain/plan.dart';

void main() {
  group('free plan', () {
    const free = Entitlements.free;

    test('covers one garden', () {
      expect(free.canAddGarden(existing: 0), isTrue);
      expect(free.canAddGarden(existing: 1), isFalse);
    });

    test('limits journal photos but never removes saved ones', () {
      const limit = PlanLimits.freeJournalPhotos;
      expect(free.canAddJournalPhotos(existing: limit - 1, adding: 1), isTrue);
      expect(free.canAddJournalPhotos(existing: limit, adding: 1), isFalse);
      expect(free.journalPhotosLeft(existing: limit - 3), 3);
      // Already over the limit (e.g. after Plus ended): nothing left, but
      // no negative count and nothing taken away.
      expect(free.journalPhotosLeft(existing: limit + 5), 0);
    });

    test('does not include Plus features', () {
      for (final feature in PlusFeature.values) {
        expect(free.allows(feature), isFalse, reason: feature.name);
      }
    });
  });

  test('Plus has no limits', () {
    const plus = Entitlements.plus;
    expect(plus.canAddGarden(existing: 40), isTrue);
    expect(plus.canAddJournalPhotos(existing: 5000, adding: 6), isTrue);
    expect(plus.journalPhotosLeft(existing: 5000), isNull);
    for (final feature in PlusFeature.values) {
      expect(plus.allows(feature), isTrue, reason: feature.name);
    }
  });
}
