import 'package:meta/meta.dart';
import 'package:terrace_garden/core/time/local_date.dart';

/// When a care rule produces tasks (ADR-009). All arithmetic is on calendar
/// dates ([LocalDate]), so daylight-saving changes never shift a due date.
@immutable
sealed class Recurrence {
  const Recurrence();

  /// The first due date on or after [from], or null if there is none.
  ///
  /// For [FromCompletion] this is [from] itself: the rule's first task is due
  /// on its start date, and later ones are counted from each completion (see
  /// [FromCompletion.nextAfterCompletion]).
  LocalDate? firstOnOrAfter(LocalDate from);

  /// Every due date in `[start, end]` (inclusive), in order. Rules that count
  /// from completion only ever have one pending occurrence, so they return at
  /// most the first.
  List<LocalDate> occurrencesBetween(LocalDate start, LocalDate end) {
    final result = <LocalDate>[];
    var next = firstOnOrAfter(start);
    while (next != null && !next.isAfter(end)) {
      result.add(next);
      if (this is FromCompletion) break;
      next = firstOnOrAfter(next.addDays(1));
    }
    return result;
  }
}

/// Every [days] days counted from when the previous task was done or skipped
/// (e.g. "check the soil again tomorrow"). Missing a day doesn't pile up
/// overdue tasks: only one is ever pending.
final class FromCompletion extends Recurrence {
  const FromCompletion({required this.days, required this.start})
    : assert(days > 0, 'interval must be positive');

  final int days;
  final LocalDate start;

  @override
  LocalDate? firstOnOrAfter(LocalDate from) =>
      from.isBefore(start) ? start : from;

  LocalDate nextAfterCompletion(LocalDate completedOn) =>
      completedOn.addDays(days);

  @override
  bool operator ==(Object other) =>
      other is FromCompletion && other.days == days && other.start == start;

  @override
  int get hashCode => Object.hash(days, start);
}

/// Every [days] days on a fixed grid from [anchor], whatever happens to
/// earlier tasks (e.g. a feed every 28 days from planting).
final class FixedInterval extends Recurrence {
  const FixedInterval({required this.days, required this.anchor})
    : assert(days > 0, 'interval must be positive');

  final int days;
  final LocalDate anchor;

  @override
  LocalDate? firstOnOrAfter(LocalDate from) {
    if (!from.isAfter(anchor)) return anchor;
    final elapsed = anchor.daysUntil(from);
    final steps = (elapsed + days - 1) ~/ days;
    return anchor.addDays(steps * days);
  }

  @override
  bool operator ==(Object other) =>
      other is FixedInterval && other.days == days && other.anchor == anchor;

  @override
  int get hashCode => Object.hash(days, anchor);
}

/// On the given weekdays (1 = Monday … 7 = Sunday), from [start].
final class Weekly extends Recurrence {
  const Weekly({required this.weekdays, required this.start});

  final Set<int> weekdays;
  final LocalDate start;

  @override
  LocalDate? firstOnOrAfter(LocalDate from) {
    if (weekdays.isEmpty) return null;
    var day = from.isBefore(start) ? start : from;
    for (var i = 0; i < 7; i++) {
      if (weekdays.contains(day.toLocalDateTime().weekday)) return day;
      day = day.addDays(1);
    }
    return null;
  }

  @override
  bool operator ==(Object other) =>
      other is Weekly &&
      other.start == start &&
      other.weekdays.length == weekdays.length &&
      other.weekdays.containsAll(weekdays);

  @override
  int get hashCode => Object.hash(start, Object.hashAllUnordered(weekdays));
}

/// Once a year on [month]/[day] (a seasonal job such as pruning), from
/// [start]. A 29 February date falls on 28 February in other years.
final class Yearly extends Recurrence {
  const Yearly({required this.month, required this.day, required this.start})
    : assert(month >= 1 && month <= 12, 'month is 1–12'),
      assert(day >= 1 && day <= 31, 'day is 1–31');

  final int month;
  final int day;
  final LocalDate start;

  LocalDate _inYear(int year) {
    final lastDay = LocalDate(year, month + 1, 1).addDays(-1).day;
    return LocalDate(year, month, day > lastDay ? lastDay : day);
  }

  @override
  LocalDate? firstOnOrAfter(LocalDate from) {
    final base = from.isBefore(start) ? start : from;
    final thisYear = _inYear(base.year);
    return thisYear.isBefore(base) ? _inYear(base.year + 1) : thisYear;
  }

  @override
  bool operator ==(Object other) =>
      other is Yearly &&
      other.month == month &&
      other.day == day &&
      other.start == start;

  @override
  int get hashCode => Object.hash(month, day, start);
}

/// A single occurrence on [date].
final class Once extends Recurrence {
  const Once(this.date);

  final LocalDate date;

  @override
  LocalDate? firstOnOrAfter(LocalDate from) =>
      date.isBefore(from) ? null : date;

  @override
  bool operator ==(Object other) => other is Once && other.date == date;

  @override
  int get hashCode => date.hashCode;
}
