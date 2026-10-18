import 'package:meta/meta.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/care/domain/recurrence.dart';

/// Kinds of care job (data-model.md §3 CareRule). Watering is deliberately a
/// *check*: the user tests the soil and waters only if it is dry.
enum CareTaskType { checkSoil, inspectPests, feed, transplant, harvest, prune }

enum TaskStatus { pending, done, skipped }

enum SkipReason { rained, soilStillMoist, notNeeded, other }

/// A recurring (or one-off) care job for one planting.
@immutable
final class CareRule {
  const CareRule({
    required this.id,
    required this.gardenId,
    required this.plantingId,
    required this.type,
    required this.recurrence,
    required this.createdOn,
    this.enabled = true,
  });

  final String id;
  final String gardenId;
  final String plantingId;
  final CareTaskType type;
  final Recurrence recurrence;
  final bool enabled;

  /// Tasks are never created for dates before this, so a back-dated planting
  /// doesn't arrive with a pile of overdue work.
  final LocalDate createdOn;

  CareRule copyWith({Recurrence? recurrence, bool? enabled}) => CareRule(
    id: id,
    gardenId: gardenId,
    plantingId: plantingId,
    type: type,
    recurrence: recurrence ?? this.recurrence,
    createdOn: createdOn,
    enabled: enabled ?? this.enabled,
  );
}

/// A rule the planner proposes, before it has an id.
@immutable
final class CareRuleDraft {
  const CareRuleDraft({required this.type, required this.recurrence});

  final CareTaskType type;
  final Recurrence recurrence;
}

/// One concrete occurrence of a rule.
@immutable
final class CareTask {
  const CareTask({
    required this.id,
    required this.ruleId,
    required this.gardenId,
    required this.plantingId,
    required this.type,
    required this.dueOn,
    this.status = TaskStatus.pending,
    this.completedOn,
    this.note,
    this.skipReason,
  });

  final String id;
  final String ruleId;
  final String gardenId;
  final String plantingId;
  final CareTaskType type;
  final LocalDate dueOn;
  final TaskStatus status;

  /// The date it was done or skipped.
  final LocalDate? completedOn;
  final String? note;
  final SkipReason? skipReason;

  bool get isPending => status == TaskStatus.pending;

  bool isOverdue(LocalDate today) => isPending && dueOn.isBefore(today);
}
