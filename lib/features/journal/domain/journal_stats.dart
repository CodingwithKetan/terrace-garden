import 'package:meta/meta.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/journal/domain/journal_entry.dart';

/// Progress at a glance (JRN-04). Plain counts only: no scores or rankings
/// that could feel like judgement.
@immutable
final class JournalStats {
  const JournalStats({
    required this.tasksDone,
    required this.streakDays,
    required this.entries,
    required this.photos,
    required this.harvests,
  });

  factory JournalStats.of({
    required List<JournalEntry> entries,
    required List<CareTask> doneTasks,
    required LocalDate today,
  }) {
    final doneDays = {
      for (final t in doneTasks)
        if (t.status == TaskStatus.done) ?t.completedOn,
    };
    // Consecutive days with care done, ending today (or yesterday, so the
    // streak doesn't reset in the morning before today's checks).
    var day = doneDays.contains(today) ? today : today.addDays(-1);
    var streak = 0;
    while (doneDays.contains(day)) {
      streak++;
      day = day.addDays(-1);
    }
    final harvests = <HarvestUnit, double>{};
    for (final e in entries) {
      final unit = e.harvestUnit;
      final quantity = e.harvestQuantity;
      if (unit != null && quantity != null) {
        harvests[unit] = (harvests[unit] ?? 0) + quantity;
      }
    }
    return JournalStats(
      tasksDone: doneTasks.where((t) => t.status == TaskStatus.done).length,
      streakDays: streak,
      entries: entries.length,
      photos: entries.fold(0, (sum, e) => sum + e.photos.length),
      harvests: harvests,
    );
  }

  final int tasksDone;
  final int streakDays;
  final int entries;
  final int photos;

  /// Total harvested per unit (units are never mixed).
  final Map<HarvestUnit, double> harvests;
}
