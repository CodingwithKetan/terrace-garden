import 'package:drift/drift.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/garden/data/garden_tables.dart';
import 'package:terrace_garden/features/plantings/data/planting_tables.dart';

/// Care rules per planting. The recurrence is stored as a kind plus the
/// fields that kind uses (see `RecurrenceCodec`). Deleted with the planting.
@DataClassName('CareRuleRow')
class CareRules extends Table {
  TextColumn get id => text()();
  TextColumn get gardenId =>
      text().references(Gardens, #id, onDelete: KeyAction.cascade)();
  TextColumn get plantingId =>
      text().references(Plantings, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => textEnum<CareTaskType>()();

  /// `fromCompletion`, `fixedInterval`, `weekly`, `yearly` or `once`.
  TextColumn get kind => text()();
  IntColumn get days => integer().nullable()();

  /// Start, anchor or date (`yyyy-MM-dd`), depending on [kind].
  TextColumn get startOn => text()();

  /// Comma-separated ISO weekdays for `weekly`.
  TextColumn get weekdays => text().nullable()();
  IntColumn get month => integer().nullable()();
  IntColumn get day => integer().nullable()();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  TextColumn get createdOn => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Materialised task occurrences; at most one per rule and date.
@DataClassName('CareTaskRow')
class CareTasks extends Table {
  TextColumn get id => text()();
  TextColumn get ruleId =>
      text().references(CareRules, #id, onDelete: KeyAction.cascade)();
  TextColumn get gardenId =>
      text().references(Gardens, #id, onDelete: KeyAction.cascade)();
  TextColumn get plantingId =>
      text().references(Plantings, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => textEnum<CareTaskType>()();
  TextColumn get dueOn => text()();
  TextColumn get status => textEnum<TaskStatus>()();
  TextColumn get completedOn => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get skipReason => textEnum<SkipReason>().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {ruleId, dueOn},
  ];
}

/// Digest notifications currently scheduled with the platform, so the
/// planner can diff instead of rescheduling everything (ADR-008).
@DataClassName('ScheduledNotificationRow')
class ScheduledNotifications extends Table {
  IntColumn get id => integer()();
  TextColumn get day => text()();
  DateTimeColumn get fireAt => dateTime()();
  IntColumn get taskCount => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
