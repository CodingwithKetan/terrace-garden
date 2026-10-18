import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/journal/domain/journal_entry.dart';
import 'package:terrace_garden/features/journal/domain/journal_stats.dart';

void main() {
  final today = LocalDate(2026, 10, 18);

  CareTask done(int daysAgo, {TaskStatus status = TaskStatus.done}) => CareTask(
    id: 't$daysAgo${status.name}',
    ruleId: 'r',
    gardenId: 'g',
    plantingId: 'p',
    type: CareTaskType.checkSoil,
    dueOn: today.addDays(-daysAgo),
    status: status,
    completedOn: today.addDays(-daysAgo),
  );

  JournalEntry entry({double? qty, HarvestUnit? unit, int photos = 0}) =>
      JournalEntry(
        id: 'e$qty$unit$photos',
        gardenId: 'g',
        date: today,
        createdAt: DateTime(2026),
        milestone: qty == null ? null : Milestone.harvest,
        harvestQuantity: qty,
        harvestUnit: unit,
        photos: [
          for (var i = 0; i < photos; i++)
            JournalPhoto(id: '$i', relativePath: 'a', thumbnailPath: 'b'),
        ],
      );

  test('streak counts consecutive days ending today', () {
    final s = JournalStats.of(
      entries: const [],
      doneTasks: [done(0), done(1), done(1), done(2), done(4)],
      today: today,
    );
    expect(s.streakDays, 3);
    expect(s.tasksDone, 5);
  });

  test("a streak survives the morning before today's tasks", () {
    final s = JournalStats.of(
      entries: const [],
      doneTasks: [done(1), done(2)],
      today: today,
    );
    expect(s.streakDays, 2);
  });

  test('skipped tasks do not count', () {
    final s = JournalStats.of(
      entries: const [],
      doneTasks: [done(0, status: TaskStatus.skipped)],
      today: today,
    );
    expect(s.streakDays, 0);
    expect(s.tasksDone, 0);
  });

  test('harvests add up per unit; photos and entries are counted', () {
    final s = JournalStats.of(
      entries: [
        entry(qty: 250, unit: HarvestUnit.grams, photos: 2),
        entry(qty: 100, unit: HarvestUnit.grams),
        entry(qty: 6, unit: HarvestUnit.pieces, photos: 1),
      ],
      doneTasks: const [],
      today: today,
    );
    expect(s.harvests, {HarvestUnit.grams: 350, HarvestUnit.pieces: 6});
    expect(s.entries, 3);
    expect(s.photos, 3);
  });
}
