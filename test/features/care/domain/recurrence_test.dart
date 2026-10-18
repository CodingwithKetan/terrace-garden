import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/care/domain/recurrence.dart';

LocalDate d(int y, int m, int day) => LocalDate(y, m, day);

void main() {
  group('FromCompletion', () {
    final r = FromCompletion(days: 3, start: d(2026, 10, 18));

    test('first task is due on the start date, or today if later', () {
      expect(r.firstOnOrAfter(d(2026, 10, 1)), d(2026, 10, 18));
      expect(r.firstOnOrAfter(d(2026, 10, 20)), d(2026, 10, 20));
    });

    test('next is counted from completion, across month and year ends', () {
      expect(r.nextAfterCompletion(d(2026, 10, 30)), d(2026, 11, 2));
      expect(r.nextAfterCompletion(d(2026, 12, 30)), d(2027, 1, 2));
    });

    test('only ever one pending occurrence in a window', () {
      expect(r.occurrencesBetween(d(2026, 10, 18), d(2026, 12, 31)), [
        d(2026, 10, 18),
      ]);
    });
  });

  group('FixedInterval', () {
    final r = FixedInterval(days: 28, anchor: d(2026, 1, 31));

    test('stays on the grid from the anchor', () {
      expect(r.firstOnOrAfter(d(2026, 1, 1)), d(2026, 1, 31));
      expect(r.firstOnOrAfter(d(2026, 1, 31)), d(2026, 1, 31));
      expect(r.firstOnOrAfter(d(2026, 2, 1)), d(2026, 2, 28));
      expect(r.firstOnOrAfter(d(2026, 2, 28)), d(2026, 2, 28));
      expect(r.firstOnOrAfter(d(2026, 3, 1)), d(2026, 3, 28));
    });

    test('lists every occurrence in a window', () {
      expect(r.occurrencesBetween(d(2026, 2, 1), d(2026, 5, 1)), [
        d(2026, 2, 28),
        d(2026, 3, 28),
        d(2026, 4, 25),
      ]);
    });

    test('leap day handling is plain day counting', () {
      final leap = FixedInterval(days: 1, anchor: d(2028, 2, 28));
      expect(leap.occurrencesBetween(d(2028, 2, 28), d(2028, 3, 1)), [
        d(2028, 2, 28),
        d(2028, 2, 29),
        d(2028, 3, 1),
      ]);
    });
  });

  group('Weekly', () {
    // 2026-10-19 is a Monday.
    final r = Weekly(weekdays: const {1, 4}, start: d(2026, 10, 18));

    test('picks the listed weekdays', () {
      expect(r.occurrencesBetween(d(2026, 10, 18), d(2026, 10, 31)), [
        d(2026, 10, 19),
        d(2026, 10, 22),
        d(2026, 10, 26),
        d(2026, 10, 29),
      ]);
    });

    test('no weekdays means no occurrences', () {
      final none = Weekly(weekdays: const {}, start: d(2026, 1, 1));
      expect(none.firstOnOrAfter(d(2026, 1, 1)), isNull);
    });
  });

  group('Yearly', () {
    test('this year if not yet passed, otherwise next year', () {
      final r = Yearly(month: 11, day: 24, start: d(2026, 1, 1));
      expect(r.firstOnOrAfter(d(2026, 10, 18)), d(2026, 11, 24));
      expect(r.firstOnOrAfter(d(2026, 11, 25)), d(2027, 11, 24));
      expect(r.occurrencesBetween(d(2026, 1, 1), d(2028, 12, 31)), [
        d(2026, 11, 24),
        d(2027, 11, 24),
        d(2028, 11, 24),
      ]);
    });

    test('29 February falls on 28 February in common years', () {
      final r = Yearly(month: 2, day: 29, start: d(2027, 1, 1));
      expect(r.firstOnOrAfter(d(2027, 1, 1)), d(2027, 2, 28));
      expect(r.firstOnOrAfter(d(2027, 3, 1)), d(2028, 2, 29));
    });

    test('31st in a shorter month clamps to its last day', () {
      final r = Yearly(month: 4, day: 31, start: d(2026, 1, 1));
      expect(r.firstOnOrAfter(d(2026, 1, 1)), d(2026, 4, 30));
    });

    test('not before the start date', () {
      final r = Yearly(month: 3, day: 1, start: d(2026, 6, 1));
      expect(r.firstOnOrAfter(d(2026, 1, 1)), d(2027, 3, 1));
    });
  });

  group('Once', () {
    final r = Once(d(2026, 11, 12));

    test('occurs once and not after its date', () {
      expect(r.firstOnOrAfter(d(2026, 10, 18)), d(2026, 11, 12));
      expect(r.firstOnOrAfter(d(2026, 11, 13)), isNull);
      expect(r.occurrencesBetween(d(2026, 1, 1), d(2027, 1, 1)), [
        d(2026, 11, 12),
      ]);
    });
  });

  test('value equality', () {
    expect(
      FixedInterval(days: 2, anchor: d(2026, 1, 1)),
      FixedInterval(days: 2, anchor: d(2026, 1, 1)),
    );
    expect(
      Weekly(weekdays: const {1, 2}, start: d(2026, 1, 1)),
      Weekly(weekdays: const {2, 1}, start: d(2026, 1, 1)),
    );
    expect(Once(d(2026, 1, 1)), isNot(Once(d(2026, 1, 2))));
  });
}
