import 'package:meta/meta.dart';

/// A calendar date without time or time zone.
///
/// Care tasks are due on a *date* ("every 3 days" is a calendar concept, not
/// 72 hours), so arithmetic here is done in whole days via UTC to avoid
/// daylight-saving shifts.
@immutable
final class LocalDate implements Comparable<LocalDate> {
  factory LocalDate(int year, int month, int day) {
    // Normalise overflow such as (2026, 2, 30) the same way DateTime does.
    final utc = DateTime.utc(year, month, day);
    return LocalDate._(utc.year, utc.month, utc.day);
  }

  const LocalDate._(this.year, this.month, this.day);

  factory LocalDate.fromDateTime(DateTime dateTime) =>
      LocalDate._(dateTime.year, dateTime.month, dateTime.day);

  /// Parses `yyyy-MM-dd`.
  factory LocalDate.parse(String iso) {
    final parts = iso.split('-');
    if (parts.length != 3) {
      throw FormatException('Expected yyyy-MM-dd', iso);
    }
    final date = LocalDate(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
    if (date.toIso8601() != iso) {
      throw FormatException('Invalid calendar date', iso);
    }
    return date;
  }

  final int year;
  final int month;
  final int day;

  DateTime _asUtc() => DateTime.utc(year, month, day);

  LocalDate addDays(int days) =>
      LocalDate.fromDateTime(_asUtc().add(Duration(days: days)));

  /// Whole days from this date to [other] (negative if [other] is earlier).
  int daysUntil(LocalDate other) => other._asUtc().difference(_asUtc()).inDays;

  /// Midnight of this date in the device's local time zone.
  DateTime toLocalDateTime() => DateTime(year, month, day);

  bool isBefore(LocalDate other) => compareTo(other) < 0;

  bool isAfter(LocalDate other) => compareTo(other) > 0;

  String toIso8601() =>
      '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}';

  @override
  int compareTo(LocalDate other) {
    if (year != other.year) return year.compareTo(other.year);
    if (month != other.month) return month.compareTo(other.month);
    return day.compareTo(other.day);
  }

  @override
  bool operator ==(Object other) =>
      other is LocalDate &&
      other.year == year &&
      other.month == month &&
      other.day == day;

  @override
  int get hashCode => Object.hash(year, month, day);

  @override
  String toString() => toIso8601();
}
