import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/care/domain/notification_planner.dart';

CareTask _task(LocalDate due, {TaskStatus status = TaskStatus.pending}) =>
    CareTask(
      id: 't-$due-${status.name}',
      ruleId: 'r',
      gardenId: 'g',
      plantingId: 'p',
      type: CareTaskType.checkSoil,
      dueOn: due,
      status: status,
    );

void main() {
  final today = LocalDate(2026, 10, 18);
  // 06:00, before the 07:00 digest.
  final morning = DateTime(2026, 10, 18, 6);

  List<PlannedDigest> plan(
    List<CareTask> tasks, {
    DateTime? now,
    bool enabled = true,
  }) => NotificationPlanner.plan(
    tasks: tasks,
    now: now ?? morning,
    enabled: enabled,
    minutesOfDay: 7 * 60,
  );

  test('one digest per day with tasks, at the chosen time', () {
    final digests = plan([
      _task(today),
      _task(today),
      _task(today.addDays(2)),
    ]);
    expect(digests.map((d) => d.taskCount), [2, 1]);
    expect(digests.first.fireAt, DateTime(2026, 10, 18, 7));
    expect(digests.first.id, 20261018);
    expect(digests.last.day, today.addDays(2));
  });

  test("overdue tasks are counted in today's digest", () {
    final digests = plan([_task(today.addDays(-3)), _task(today)]);
    expect(digests.single.taskCount, 2);
  });

  test('skips times already past, done tasks and days beyond 14', () {
    final afterDigest = DateTime(2026, 10, 18, 8);
    expect(plan([_task(today)], now: afterDigest), isEmpty);
    expect(plan([_task(today, status: TaskStatus.done)]), isEmpty);
    expect(plan([_task(today.addDays(15))]), isEmpty);
    expect(plan([_task(today.addDays(14))]), hasLength(1));
  });

  test('disabled means no notifications', () {
    expect(plan([_task(today)], enabled: false), isEmpty);
  });

  test('capped at 50 pending', () {
    // The horizon already limits this to 15 days; the cap is a safeguard.
    final many = [for (var i = 0; i < 100; i++) _task(today.addDays(i % 15))];
    expect(plan(many).length, lessThanOrEqualTo(50));
  });

  group('diff', () {
    final a = PlannedDigest(
      id: 1,
      day: today,
      fireAt: DateTime(2026, 10, 18, 7),
      taskCount: 2,
    );
    final b = PlannedDigest(
      id: 2,
      day: today.addDays(1),
      fireAt: DateTime(2026, 10, 19, 7),
      taskCount: 1,
    );

    test('schedules new, cancels stale', () {
      final d = NotificationPlanner.diff(desired: [a], current: [b]);
      expect(d.schedule, [a]);
      expect(d.cancel, [2]);
    });

    test('re-applying the same plan changes nothing', () {
      expect(
        NotificationPlanner.diff(desired: [a, b], current: [a, b]).isEmpty,
        isTrue,
      );
    });

    test('a changed count or time replaces the digest', () {
      final changed = PlannedDigest(
        id: 1,
        day: today,
        fireAt: DateTime(2026, 10, 18, 8),
        taskCount: 2,
      );
      final d = NotificationPlanner.diff(desired: [changed], current: [a]);
      expect(d.cancel, [1]);
      expect(d.schedule, [changed]);
    });
  });
}
