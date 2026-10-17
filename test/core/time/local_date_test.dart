import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/time/local_date.dart';

void main() {
  group('LocalDate', () {
    test('normalises overflowing dates like DateTime', () {
      expect(LocalDate(2026, 2, 30), LocalDate(2026, 3, 2));
      expect(LocalDate(2026, 13, 1), LocalDate(2027, 1, 1));
    });

    test('adds days across month, year and leap-day boundaries', () {
      expect(LocalDate(2026, 1, 31).addDays(1), LocalDate(2026, 2, 1));
      expect(LocalDate(2026, 12, 31).addDays(1), LocalDate(2027, 1, 1));
      expect(LocalDate(2028, 2, 28).addDays(1), LocalDate(2028, 2, 29));
      expect(LocalDate(2026, 3, 1).addDays(-1), LocalDate(2026, 2, 28));
    });

    test('daysUntil counts whole calendar days', () {
      expect(LocalDate(2026, 10, 18).daysUntil(LocalDate(2026, 10, 21)), 3);
      expect(LocalDate(2026, 10, 21).daysUntil(LocalDate(2026, 10, 18)), -3);
      // Spans a European DST change (25 Oct 2026); calendar days are
      // unaffected.
      expect(LocalDate(2026, 10, 24).daysUntil(LocalDate(2026, 10, 26)), 2);
    });

    test('compares and orders dates', () {
      final earlier = LocalDate(2026, 5, 1);
      final later = LocalDate(2026, 5, 2);
      expect(earlier.isBefore(later), isTrue);
      expect(later.isAfter(earlier), isTrue);
      expect([later, earlier]..sort(), [earlier, later]);
    });

    test('formats and parses ISO-8601 dates', () {
      expect(LocalDate(2026, 3, 7).toIso8601(), '2026-03-07');
      expect(LocalDate.parse('2026-03-07'), LocalDate(2026, 3, 7));
    });

    test('rejects malformed or impossible dates when parsing', () {
      expect(() => LocalDate.parse('2026-3'), throwsFormatException);
      expect(() => LocalDate.parse('2026-02-30'), throwsFormatException);
    });

    test('drops the time of day when created from a DateTime', () {
      final date = LocalDate.fromDateTime(DateTime(2026, 10, 18, 23, 59));
      expect(date, LocalDate(2026, 10, 18));
      expect(date.toLocalDateTime(), DateTime(2026, 10, 18));
    });

    test('equal dates share a hash code', () {
      expect(LocalDate(2026, 1, 1).hashCode, LocalDate(2026, 1, 1).hashCode);
    });
  });
}
