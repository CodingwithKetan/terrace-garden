import 'package:drift/drift.dart';
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/care/domain/care_planner.dart';
import 'package:terrace_garden/features/care/domain/care_repository.dart';
import 'package:terrace_garden/features/care/domain/notification_planner.dart';
import 'package:terrace_garden/features/care/domain/recurrence.dart';

final class DriftCareRepository implements CareRepository {
  DriftCareRepository(this._db, this._ids, this._logger);

  final AppDatabase _db;
  final IdGenerator _ids;
  final AppLogger _logger;

  // ISO dates sort correctly as text, so range queries compare strings.

  @override
  Stream<List<CareTask>> watchAgenda({
    required LocalDate until,
    required LocalDate doneOn,
  }) {
    final query = _db.select(_db.careTasks)
      ..where(
        (t) =>
            (t.status.equalsValue(TaskStatus.pending) &
                t.dueOn.isSmallerOrEqualValue(until.toIso8601())) |
            (t.status.equalsValue(TaskStatus.pending).not() &
                t.completedOn.equals(doneOn.toIso8601())),
      )
      ..orderBy([(t) => OrderingTerm.asc(t.dueOn)]);
    return query.watch().map((rows) => rows.map(_taskOf).toList());
  }

  @override
  Stream<List<CareTask>> watchPending() {
    final query = _db.select(_db.careTasks)
      ..where((t) => t.status.equalsValue(TaskStatus.pending))
      ..orderBy([(t) => OrderingTerm.asc(t.dueOn)]);
    return query.watch().map((rows) => rows.map(_taskOf).toList());
  }

  @override
  Stream<List<CareRule>> watchRules(String plantingId) {
    final query = _db.select(_db.careRules)
      ..where((r) => r.plantingId.equals(plantingId));
    return query.watch().map((rows) => rows.map(_ruleOf).toList());
  }

  @override
  Future<Set<String>> plantingIdsWithRules() async {
    final query = _db.selectOnly(_db.careRules, distinct: true)
      ..addColumns([_db.careRules.plantingId]);
    final rows = await query.get();
    return {for (final r in rows) r.read(_db.careRules.plantingId)!};
  }

  @override
  Future<Result<void>> addRules({
    required String gardenId,
    required String plantingId,
    required List<CareRuleDraft> drafts,
    required LocalDate createdOn,
  }) => _guard('add care rules', () async {
    await _db.batch((batch) {
      batch.insertAll(_db.careRules, [
        for (final d in drafts)
          _ruleCompanion(
            CareRule(
              id: _ids.newId(),
              gardenId: gardenId,
              plantingId: plantingId,
              type: d.type,
              recurrence: d.recurrence,
              createdOn: createdOn,
            ),
          ),
      ]);
    });
  });

  @override
  Future<Result<void>> updateRule(
    CareRule rule, {
    required LocalDate today,
  }) => _guard('update care rule', () async {
    await _db.transaction(() async {
      final updated = await (_db.update(
        _db.careRules,
      )..where((r) => r.id.equals(rule.id))).write(_ruleCompanion(rule));
      if (updated == 0) throw const NotFoundFailure();
      await (_db.delete(_db.careTasks)..where(
            (t) =>
                t.ruleId.equals(rule.id) &
                t.status.equalsValue(TaskStatus.pending),
          ))
          .go();
      await _materializeRule(rule, today);
    });
  });

  @override
  Future<Result<int>> materialize(LocalDate today) =>
      _guard('materialise tasks', () async {
        var created = 0;
        await _db.transaction(() async {
          final rules = await (_db.select(
            _db.careRules,
          )..where((r) => r.enabled.equals(true))).get();
          for (final row in rules) {
            created += await _materializeRule(_ruleOf(row), today);
          }
        });
        return created;
      });

  Future<int> _materializeRule(CareRule rule, LocalDate today) async {
    final existing = await (_db.select(
      _db.careTasks,
    )..where((t) => t.ruleId.equals(rule.id))).get();
    final dates = TaskMaterializer.datesToCreate(
      rule: rule,
      existing: existing.map(_taskOf).toList(),
      today: today,
    );
    for (final date in dates) {
      await _insertTask(rule, date);
    }
    return dates.length;
  }

  Future<void> _insertTask(CareRule rule, LocalDate dueOn) => _db
      .into(_db.careTasks)
      .insert(
        CareTasksCompanion.insert(
          id: _ids.newId(),
          ruleId: rule.id,
          gardenId: rule.gardenId,
          plantingId: rule.plantingId,
          type: rule.type,
          dueOn: dueOn.toIso8601(),
          status: TaskStatus.pending,
        ),
        mode: InsertMode.insertOrIgnore,
      );

  @override
  Future<Result<void>> complete(
    String taskId, {
    required LocalDate on,
    String? note,
  }) => _finish(
    taskId,
    on,
    CareTasksCompanion(
      status: const Value(TaskStatus.done),
      completedOn: Value(on.toIso8601()),
      note: Value(note),
    ),
  );

  @override
  Future<Result<void>> skip(
    String taskId, {
    required LocalDate on,
    required SkipReason reason,
  }) => _finish(
    taskId,
    on,
    CareTasksCompanion(
      status: const Value(TaskStatus.skipped),
      completedOn: Value(on.toIso8601()),
      skipReason: Value(reason),
    ),
  );

  Future<Result<void>> _finish(
    String taskId,
    LocalDate on,
    CareTasksCompanion change,
  ) => _guard('finish task', () async {
    await _db.transaction(() async {
      final task = await (_db.select(
        _db.careTasks,
      )..where((t) => t.id.equals(taskId))).getSingleOrNull();
      if (task == null) throw const NotFoundFailure();
      if (task.status != TaskStatus.pending) return;
      await (_db.update(
        _db.careTasks,
      )..where((t) => t.id.equals(taskId))).write(change);
      final ruleRow = await (_db.select(
        _db.careRules,
      )..where((r) => r.id.equals(task.ruleId))).getSingleOrNull();
      if (ruleRow == null || !ruleRow.enabled) return;
      final rule = _ruleOf(ruleRow);
      final recurrence = rule.recurrence;
      if (recurrence is FromCompletion) {
        await _insertTask(rule, recurrence.nextAfterCompletion(on));
      }
    });
  });

  @override
  Future<Result<void>> reschedule(String taskId, LocalDate to) =>
      _guard('reschedule task', () async {
        final updated =
            await (_db.update(_db.careTasks)..where(
                  (t) =>
                      t.id.equals(taskId) &
                      t.status.equalsValue(TaskStatus.pending),
                ))
                .write(CareTasksCompanion(dueOn: Value(to.toIso8601())));
        if (updated == 0) throw const NotFoundFailure();
      });

  @override
  Future<List<PlannedDigest>> scheduledDigests() async {
    final rows = await _db.select(_db.scheduledNotifications).get();
    return [
      for (final r in rows)
        PlannedDigest(
          id: r.id,
          day: LocalDate.parse(r.day),
          fireAt: r.fireAt,
          taskCount: r.taskCount,
        ),
    ];
  }

  @override
  Future<void> recordScheduled(NotificationDiff applied) =>
      _db.transaction(() async {
        if (applied.cancel.isNotEmpty) {
          await (_db.delete(
            _db.scheduledNotifications,
          )..where((n) => n.id.isIn(applied.cancel))).go();
        }
        for (final d in applied.schedule) {
          await _db
              .into(_db.scheduledNotifications)
              .insertOnConflictUpdate(
                ScheduledNotificationsCompanion.insert(
                  id: Value(d.id),
                  day: d.day.toIso8601(),
                  fireAt: d.fireAt,
                  taskCount: d.taskCount,
                ),
              );
        }
      });

  Future<Result<T>> _guard<T>(String action, Future<T> Function() body) async {
    try {
      return Ok(await body());
    } on AppFailure catch (failure) {
      return Err(failure);
    } on Object catch (error, stackTrace) {
      _logger.error('Failed to $action', error: error, stackTrace: stackTrace);
      return Err(StorageFailure(error));
    }
  }

  static CareTask _taskOf(CareTaskRow r) => CareTask(
    id: r.id,
    ruleId: r.ruleId,
    gardenId: r.gardenId,
    plantingId: r.plantingId,
    type: r.type,
    dueOn: LocalDate.parse(r.dueOn),
    status: r.status,
    completedOn: r.completedOn == null ? null : LocalDate.parse(r.completedOn!),
    note: r.note,
    skipReason: r.skipReason,
  );

  static CareRule _ruleOf(CareRuleRow r) => CareRule(
    id: r.id,
    gardenId: r.gardenId,
    plantingId: r.plantingId,
    type: r.type,
    recurrence: RecurrenceCodec.decode(
      kind: r.kind,
      days: r.days,
      startOn: LocalDate.parse(r.startOn),
      weekdays: r.weekdays,
      month: r.month,
      day: r.day,
    ),
    enabled: r.enabled,
    createdOn: LocalDate.parse(r.createdOn),
  );

  static CareRulesCompanion _ruleCompanion(CareRule rule) {
    final e = RecurrenceCodec.encode(rule.recurrence);
    return CareRulesCompanion.insert(
      id: rule.id,
      gardenId: rule.gardenId,
      plantingId: rule.plantingId,
      type: rule.type,
      kind: e.kind,
      days: Value(e.days),
      startOn: e.startOn.toIso8601(),
      weekdays: Value(e.weekdays),
      month: Value(e.month),
      day: Value(e.day),
      enabled: Value(rule.enabled),
      createdOn: rule.createdOn.toIso8601(),
    );
  }
}

/// Maps a [Recurrence] to and from its table columns.
abstract final class RecurrenceCodec {
  static ({
    String kind,
    int? days,
    LocalDate startOn,
    String? weekdays,
    int? month,
    int? day,
  })
  encode(Recurrence r) => switch (r) {
    FromCompletion(:final days, :final start) => (
      kind: 'fromCompletion',
      days: days,
      startOn: start,
      weekdays: null,
      month: null,
      day: null,
    ),
    FixedInterval(:final days, :final anchor) => (
      kind: 'fixedInterval',
      days: days,
      startOn: anchor,
      weekdays: null,
      month: null,
      day: null,
    ),
    Weekly(:final weekdays, :final start) => (
      kind: 'weekly',
      days: null,
      startOn: start,
      weekdays: (weekdays.toList()..sort()).join(','),
      month: null,
      day: null,
    ),
    Yearly(:final month, :final day, :final start) => (
      kind: 'yearly',
      days: null,
      startOn: start,
      weekdays: null,
      month: month,
      day: day,
    ),
    Once(:final date) => (
      kind: 'once',
      days: null,
      startOn: date,
      weekdays: null,
      month: null,
      day: null,
    ),
  };

  static Recurrence decode({
    required String kind,
    required int? days,
    required LocalDate startOn,
    required String? weekdays,
    required int? month,
    required int? day,
  }) => switch (kind) {
    'fromCompletion' => FromCompletion(days: days!, start: startOn),
    'fixedInterval' => FixedInterval(days: days!, anchor: startOn),
    'weekly' => Weekly(
      weekdays: {
        for (final w in (weekdays ?? '').split(','))
          if (w.isNotEmpty) int.parse(w),
      },
      start: startOn,
    ),
    'yearly' => Yearly(month: month!, day: day!, start: startOn),
    'once' => Once(startOn),
    _ => throw FormatException('Unknown recurrence kind', kind),
  };
}
