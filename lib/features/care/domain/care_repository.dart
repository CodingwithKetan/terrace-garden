import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/care/domain/notification_planner.dart';

abstract interface class CareRepository {
  /// Pending tasks due up to [until] (overdue included), plus tasks done or
  /// skipped on [doneOn], ordered by due date.
  Stream<List<CareTask>> watchAgenda({
    required LocalDate until,
    required LocalDate doneOn,
  });

  /// Every pending task (for notification planning).
  Stream<List<CareTask>> watchPending();

  /// Tasks marked done, newest first (for the journal timeline).
  Stream<List<CareTask>> watchDone();

  Stream<List<CareRule>> watchRules(String plantingId);

  /// Plantings that already have a care plan.
  Future<Set<String>> plantingIdsWithRules();

  Future<Result<void>> addRules({
    required String gardenId,
    required String plantingId,
    required List<CareRuleDraft> drafts,
    required LocalDate createdOn,
  });

  /// Saves a changed rule and replaces its pending tasks.
  Future<Result<void>> updateRule(CareRule rule, {required LocalDate today});

  /// Creates missing tasks for every enabled rule (idempotent). Returns how
  /// many were created.
  Future<Result<int>> materialize(LocalDate today);

  /// Marks a task done; a completion-based rule gets its next task.
  Future<Result<void>> complete(
    String taskId, {
    required LocalDate on,
    String? note,
  });

  /// Marks a task skipped; a completion-based rule gets its next task.
  Future<Result<void>> skip(
    String taskId, {
    required LocalDate on,
    required SkipReason reason,
  });

  /// Moves a pending task to another date.
  Future<Result<void>> reschedule(String taskId, LocalDate to);

  Future<List<PlannedDigest>> scheduledDigests();

  Future<void> recordScheduled(NotificationDiff applied);
}
