import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/care/domain/recurrence.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';

/// Builds a planting's default care plan from sourced guidance only
/// (gardening-references §4–§6, §9; P5-02). Every interval below traces to a
/// source; the user can change or switch off any rule afterwards.
abstract final class CarePlanner {
  /// "Monitor container gardens daily" (S10); daily checks in warm or windy
  /// weather (S4). The task is a soil *check*, never "water now" (S5, S6).
  static const soilCheckDays = 1;

  /// Look for aphids "at least twice a week when plants are growing rapidly"
  /// (S32); every 3 days meets that.
  static const pestCheckDays = 3;

  /// "Soluble fertiliser every 2–4 weeks" (S3); feed edibles regularly in
  /// the active season (S4). The conservative end of the range is used
  /// because excess nitrogen favours aphids (S32).
  static const feedDays = 28;

  /// Jasmine (J. sambac) in Tamil Nadu: prune back in the last week of
  /// November (S18).
  static const jasminePruneMonth = 11;
  static const jasminePruneDay = 24;

  /// Source IDs behind each task type's guidance, for the UI.
  static const sourcesFor = <CareTaskType, List<String>>{
    CareTaskType.checkSoil: ['S5', 'S6', 'S10'],
    CareTaskType.inspectPests: ['S1', 'S32'],
    CareTaskType.feed: ['S3', 'S4', 'S32'],
    CareTaskType.transplant: ['S11'],
    CareTaskType.harvest: [],
    CareTaskType.prune: ['S18'],
  };

  static const Set<PlantCategory> _fedCategories = {
    PlantCategory.vegetable,
    PlantCategory.leafyGreen,
    PlantCategory.climber,
    PlantCategory.herb,
    PlantCategory.flower,
  };

  static const Set<PlantCategory> _edibleCategories = {
    PlantCategory.vegetable,
    PlantCategory.leafyGreen,
    PlantCategory.climber,
    PlantCategory.herb,
  };

  static List<CareRuleDraft> plan({
    required Planting planting,
    required PlantSpecies species,
    required GrowingRegion? region,
    required LocalDate today,
  }) {
    final start = planting.plantedOn.isAfter(today)
        ? planting.plantedOn
        : today;
    final planted = planting.plantedOn;
    final propagation = species.propagation;
    final harvest = species.daysToHarvest;

    return [
      CareRuleDraft(
        type: CareTaskType.checkSoil,
        recurrence: FromCompletion(days: soilCheckDays, start: start),
      ),
      CareRuleDraft(
        type: CareTaskType.inspectPests,
        recurrence: FromCompletion(days: pestCheckDays, start: start),
      ),
      if (_fedCategories.contains(species.category))
        CareRuleDraft(
          type: CareTaskType.feed,
          recurrence: FromCompletion(
            days: feedDays,
            start: _notBefore(planted.addDays(feedDays), today),
          ),
        ),
      // Seed raised in a nursery tray: transplant after the documented days.
      if (planting.startedFrom == PlantingStart.seed &&
          propagation?.method == PropagationMethod.transplant &&
          propagation?.nurseryDaysMin != null)
        CareRuleDraft(
          type: CareTaskType.transplant,
          recurrence: Once(planted.addDays(propagation!.nurseryDaysMin!)),
        ),
      // "Harvest may start": the documented earliest days to harvest.
      if (harvest != null && _edibleCategories.contains(species.category))
        CareRuleDraft(
          type: CareTaskType.harvest,
          recurrence: Once(planted.addDays(harvest.minDays)),
        ),
      if (species.id == 'jasmine' && region == GrowingRegion.tamilNadu)
        CareRuleDraft(
          type: CareTaskType.prune,
          recurrence: Yearly(
            month: jasminePruneMonth,
            day: jasminePruneDay,
            start: today,
          ),
        ),
    ];
  }

  static LocalDate _notBefore(LocalDate date, LocalDate floor) =>
      date.isBefore(floor) ? floor : date;
}

/// Decides which tasks to create for a rule (P5-03). Pure and idempotent:
/// it returns only dates that don't already have a task.
abstract final class TaskMaterializer {
  /// How far ahead fixed-schedule tasks are created.
  static const horizonDays = 30;

  /// [existing] is every task the rule already has, pending or finished.
  static List<LocalDate> datesToCreate({
    required CareRule rule,
    required List<CareTask> existing,
    required LocalDate today,
  }) {
    if (!rule.enabled) return const [];
    final recurrence = rule.recurrence;
    final from = rule.createdOn.isAfter(today) ? rule.createdOn : today;
    if (recurrence is FromCompletion) {
      // Normally the next task is created when one is done or skipped. If
      // none is pending (new rule, re-enabled or changed interval), count
      // from the last finished task, but never schedule in the past.
      if (existing.any((t) => t.isPending)) return const [];
      final finished = [
        for (final t in existing) ?t.completedOn,
      ]..sort();
      var next = recurrence.firstOnOrAfter(from)!;
      if (finished.isNotEmpty) {
        final afterLast = recurrence.nextAfterCompletion(finished.last);
        if (afterLast.isAfter(next)) next = afterLast;
      }
      return [next];
    }
    final dueDates = {for (final t in existing) t.dueOn};
    return recurrence
        .occurrencesBetween(from, today.addDays(horizonDays))
        .where((d) => !dueDates.contains(d))
        .toList();
  }
}
