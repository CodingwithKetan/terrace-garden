import 'package:meta/meta.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/care/domain/care.dart';

/// One daily-digest notification the app wants scheduled.
@immutable
final class PlannedDigest {
  const PlannedDigest({
    required this.id,
    required this.day,
    required this.fireAt,
    required this.taskCount,
  });

  /// Stable per day (`yyyyMMdd`), so re-planning replaces rather than adds.
  final int id;
  final LocalDate day;

  /// Local wall-clock time on [day].
  final DateTime fireAt;

  /// Tasks due that day (for today, overdue ones too).
  final int taskCount;

  @override
  bool operator ==(Object other) =>
      other is PlannedDigest &&
      other.id == id &&
      other.fireAt == fireAt &&
      other.taskCount == taskCount;

  @override
  int get hashCode => Object.hash(id, fireAt, taskCount);
}

/// What to change in the platform's schedule.
@immutable
final class NotificationDiff {
  const NotificationDiff({required this.cancel, required this.schedule});

  final List<int> cancel;
  final List<PlannedDigest> schedule;

  bool get isEmpty => cancel.isEmpty && schedule.isEmpty;
}

/// Plans daily digests from pending tasks (ADR-008, P5-07). Pure: the
/// in-app agenda stays the source of truth, and this only mirrors it.
abstract final class NotificationPlanner {
  /// Days ahead to schedule; re-planned on every app start and task change.
  static const horizonDays = 14;

  /// Well under iOS's 64 pending notifications.
  static const maxPending = 50;

  static List<PlannedDigest> plan({
    required List<CareTask> tasks,
    required DateTime now,
    required bool enabled,
    required int minutesOfDay,
  }) {
    if (!enabled) return const [];
    final today = LocalDate.fromDateTime(now);
    final counts = <LocalDate, int>{};
    for (final t in tasks.where((t) => t.isPending)) {
      final day = t.dueOn.isBefore(today) ? today : t.dueOn;
      if (today.daysUntil(day) > horizonDays) continue;
      counts[day] = (counts[day] ?? 0) + 1;
    }
    final days = counts.keys.toList()..sort();
    return [
      for (final day in days)
        if (_fireAt(day, minutesOfDay) case final at when at.isAfter(now))
          PlannedDigest(
            id: idFor(day),
            day: day,
            fireAt: at,
            taskCount: counts[day]!,
          ),
    ].take(maxPending).toList();
  }

  /// Cancels what is no longer wanted or has changed, and schedules what is
  /// new or changed. Applying the same plan twice yields an empty diff.
  static NotificationDiff diff({
    required List<PlannedDigest> desired,
    required List<PlannedDigest> current,
  }) {
    final wanted = {for (final d in desired) d.id: d};
    final existing = {for (final c in current) c.id: c};
    return NotificationDiff(
      cancel: [
        for (final c in current)
          if (wanted[c.id] != c) c.id,
      ],
      schedule: [
        for (final d in desired)
          if (existing[d.id] != d) d,
      ],
    );
  }

  static int idFor(LocalDate day) =>
      day.year * 10000 + day.month * 100 + day.day;

  static DateTime _fireAt(LocalDate day, int minutesOfDay) => DateTime(
    day.year,
    day.month,
    day.day,
    minutesOfDay ~/ 60,
    minutesOfDay % 60,
  );
}
