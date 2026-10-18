import 'package:meta/meta.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/journal/domain/journal_entry.dart';

/// One day on the journal timeline (JRN-01): the user's entries plus a
/// summary of care tasks completed that day.
@immutable
final class TimelineDay {
  const TimelineDay({
    required this.date,
    required this.entries,
    required this.doneTasks,
  });

  final LocalDate date;
  final List<JournalEntry> entries;
  final List<CareTask> doneTasks;
}

/// Restricts the timeline to one garden and, optionally, one planting.
@immutable
final class TimelineFilter {
  const TimelineFilter({this.gardenId, this.plantingId});

  final String? gardenId;
  final String? plantingId;

  bool _matches(String gardenId, String? plantingId) =>
      (this.gardenId == null || this.gardenId == gardenId) &&
      (this.plantingId == null || this.plantingId == plantingId);
}

/// Merges entries and completed tasks into days, newest first.
List<TimelineDay> buildTimeline({
  required List<JournalEntry> entries,
  required List<CareTask> doneTasks,
  TimelineFilter filter = const TimelineFilter(),
}) {
  final byDay = <LocalDate, (List<JournalEntry>, List<CareTask>)>{};
  for (final e in entries) {
    if (!filter._matches(e.gardenId, e.plantingId)) continue;
    (byDay[e.date] ??= ([], [])).$1.add(e);
  }
  for (final t in doneTasks) {
    final on = t.completedOn;
    if (on == null || t.status != TaskStatus.done) continue;
    if (!filter._matches(t.gardenId, t.plantingId)) continue;
    (byDay[on] ??= ([], [])).$2.add(t);
  }
  final days = byDay.keys.toList()..sort((a, b) => b.compareTo(a));
  return [
    for (final d in days)
      TimelineDay(date: d, entries: byDay[d]!.$1, doneTasks: byDay[d]!.$2),
  ];
}
