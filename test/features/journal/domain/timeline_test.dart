import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/journal/domain/journal_entry.dart';
import 'package:terrace_garden/features/journal/domain/timeline.dart';

void main() {
  final d1 = LocalDate(2026, 10, 16);
  final d2 = LocalDate(2026, 10, 18);

  JournalEntry entry(String id, LocalDate date, {String garden = 'g1'}) =>
      JournalEntry(
        id: id,
        gardenId: garden,
        plantingId: garden == 'g1' ? 'p1' : 'p2',
        date: date,
        note: id,
        createdAt: DateTime(2026),
      );

  CareTask task(
    String id,
    LocalDate? on, {
    TaskStatus status = TaskStatus.done,
    String garden = 'g1',
  }) => CareTask(
    id: id,
    ruleId: 'r',
    gardenId: garden,
    plantingId: garden == 'g1' ? 'p1' : 'p2',
    type: CareTaskType.checkSoil,
    dueOn: d1,
    status: status,
    completedOn: on,
  );

  test('groups entries and done tasks by day, newest first', () {
    final days = buildTimeline(
      entries: [entry('a', d1), entry('b', d2)],
      doneTasks: [task('t1', d2), task('t2', d2), task('t3', d1)],
    );
    expect(days.map((d) => d.date), [d2, d1]);
    expect(days.first.entries.single.id, 'b');
    expect(days.first.doneTasks, hasLength(2));
  });

  test('ignores skipped and unfinished tasks', () {
    final days = buildTimeline(
      entries: const [],
      doneTasks: [
        task('s', d1, status: TaskStatus.skipped),
        task('p', null, status: TaskStatus.pending),
      ],
    );
    expect(days, isEmpty);
  });

  test('filters by garden and planting', () {
    final all = (
      entries: [
        entry('a', d1),
        entry('b', d1, garden: 'g2'),
      ],
      tasks: [task('t', d2, garden: 'g2')],
    );
    final g2 = buildTimeline(
      entries: all.entries,
      doneTasks: all.tasks,
      filter: const TimelineFilter(gardenId: 'g2'),
    );
    expect(g2.expand((d) => d.entries).map((e) => e.id), ['b']);
    expect(g2.expand((d) => d.doneTasks), hasLength(1));

    final p1 = buildTimeline(
      entries: all.entries,
      doneTasks: all.tasks,
      filter: const TimelineFilter(plantingId: 'p1'),
    );
    expect(p1.single.entries.single.id, 'a');
  });
}
