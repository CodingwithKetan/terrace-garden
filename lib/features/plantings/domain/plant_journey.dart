import 'package:meta/meta.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';

enum MilestoneKind {
  /// Seed went in (the planting started from seed).
  sown,

  /// A seedling, cutting or plant went in.
  planted,

  /// Nursery seedlings are ready to move, after the documented days.
  transplant,

  /// The documented days to harvest have passed: harvest may start.
  harvest,
}

/// One step on a plant's way, as a date or a date range.
@immutable
final class JourneyMilestone {
  const JourneyMilestone({
    required this.kind,
    required this.from,
    LocalDate? to,
    this.sources = const [],
  }) : to = to ?? from;

  final MilestoneKind kind;
  final LocalDate from;
  final LocalDate to;

  /// Source IDs behind the dates; empty for the user's own planting date.
  final List<String> sources;

  bool get isRange => from != to;
}

/// A planting's sourced milestones (PLT-02, Living Terrace): the user's
/// planting date, then only steps the catalogue documents. Uses the same
/// rules as the care planner, so the journey and Today's tasks agree.
@immutable
final class PlantJourney {
  const PlantJourney._(this.milestones, this._today);

  /// Builds the journey for [planting] of [species] as seen on [today].
  factory PlantJourney.of({
    required Planting planting,
    required PlantSpecies species,
    required LocalDate today,
  }) {
    final planted = planting.plantedOn;
    final propagation = species.propagation;
    final harvest = species.daysToHarvest;
    return PlantJourney._([
      JourneyMilestone(
        kind: planting.startedFrom == PlantingStart.seed
            ? MilestoneKind.sown
            : MilestoneKind.planted,
        from: planted,
      ),
      if (planting.startedFrom == PlantingStart.seed &&
          propagation != null &&
          propagation.method == PropagationMethod.transplant &&
          propagation.nurseryDaysMin != null)
        JourneyMilestone(
          kind: MilestoneKind.transplant,
          from: planted.addDays(propagation.nurseryDaysMin!),
          to: planted.addDays(
            propagation.nurseryDaysMax ?? propagation.nurseryDaysMin!,
          ),
          sources: propagation.sources,
        ),
      if (harvest != null && edibleCategories.contains(species.category))
        JourneyMilestone(
          kind: MilestoneKind.harvest,
          from: planted.addDays(harvest.minDays),
          to: planted.addDays(harvest.maxDays),
          sources: harvest.sources,
        ),
    ], today);
  }

  /// Categories grown to be eaten, where "harvest may start" makes sense.
  static const Set<PlantCategory> edibleCategories = {
    PlantCategory.vegetable,
    PlantCategory.leafyGreen,
    PlantCategory.climber,
    PlantCategory.herb,
  };

  final List<JourneyMilestone> milestones;
  final LocalDate _today;

  LocalDate get start => milestones.first.from;

  LocalDate get end => milestones.last.to;

  /// Day 1 is the planting day; null before it.
  int? get day {
    final days = start.daysUntil(_today);
    return days < 0 ? null : days + 1;
  }

  /// Whether there is anything documented beyond the planting date.
  bool get hasSourcedSteps => milestones.length > 1;

  /// Where today falls between [start] and [end], from 0 to 1.
  double get progress {
    final total = start.daysUntil(end);
    if (total <= 0) return 1;
    return (start.daysUntil(_today) / total).clamp(0, 1).toDouble();
  }

  /// Every source behind the journey's dates.
  Set<String> get sources => {for (final m in milestones) ...m.sources};
}
