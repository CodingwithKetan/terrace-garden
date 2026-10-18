import 'package:meta/meta.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';

/// How well one factor suits the garden. `unknown` means either the garden
/// or the catalogue lacks the data; it never counts for or against a plant.
enum Fit { good, limited, poor, unknown }

/// Why the sun check came out as it did.
enum SunReason {
  /// The garden's sun matches the species' need.
  matches,

  /// Full-sun crop in a 3–6 h space.
  needsMoreSun,

  /// Full-sun or partial crop in a space with under 3 h.
  tooShady,

  /// Indirect-light plant in a space with 6+ h of direct sun.
  prefersIndirect,

  /// The garden's sun hours are not set.
  gardenUnknown,

  /// No verified sun requirement for the species.
  speciesUnknown,
}

enum SeasonReason {
  /// The current month is in the sowing window.
  sowNow,

  /// The window opens next month.
  sowSoon,

  /// The window is later in the year.
  later,

  /// The garden has no city, or the city has no sourced region (KI-017).
  noRegion,

  /// No sourced window for this species in the garden's region.
  noData,
}

enum ContainerReason {
  /// At least one container meets the documented minimum.
  fits,

  /// The layout has containers, but none meets the minimum.
  tooSmall,

  /// The layout has no containers with a known size.
  noContainers,

  /// No verified container figure for the species.
  speciesUnknown,
}

enum Caveat {
  /// The container figure comes from a similar crop or a size class.
  containerProxy,

  /// The sowing window is the macro region's, not the state's.
  regionFallback,

  /// Toxic to pets per a cited source.
  petToxic,

  /// Some facts for this species are not documented.
  incompleteData,
}

/// A container on the layout, reduced to what fit checks need.
@immutable
final class ContainerSpace {
  const ContainerSpace({
    required this.id,
    required this.soilLitres,
    required this.depthCm,
  });

  final String id;
  final double soilLitres;
  final double depthCm;
}

@immutable
final class SunCheck {
  const SunCheck(this.fit, this.reason);

  final Fit fit;
  final SunReason reason;
}

@immutable
final class SeasonCheck {
  const SeasonCheck(this.fit, this.reason, {this.window, this.nextMonth});

  final Fit fit;
  final SeasonReason reason;

  /// The window used, when there is one.
  final RegionalSowing? window;

  /// The next month (1–12) the window is open, for [SeasonReason.later] and
  /// [SeasonReason.sowSoon].
  final int? nextMonth;
}

@immutable
final class ContainerCheck {
  const ContainerCheck(this.fit, this.reason, {this.fittingCount = 0});

  final Fit fit;
  final ContainerReason reason;

  /// How many of the garden's containers meet the minimum.
  final int fittingCount;
}

/// Where a recommendation is shown.
enum RecommendationGroup {
  /// Suits the space and can be sown now or soon (or season is unknown).
  goodNow,

  /// Suits the space but the sowing window is later.
  later,

  /// A known factor rules against it.
  notSuited,
}

@immutable
final class Recommendation {
  const Recommendation({
    required this.species,
    required this.score,
    required this.group,
    required this.sun,
    required this.season,
    required this.container,
    required this.goalMatch,
    required this.caveats,
  });

  final PlantSpecies species;

  /// Ranking only; not shown as a rating.
  final int score;
  final RecommendationGroup group;
  final SunCheck sun;
  final SeasonCheck season;
  final ContainerCheck container;

  /// Null when the garden has no goals set.
  final bool? goalMatch;
  final List<Caveat> caveats;
}

/// Ranks catalogue species for one garden (PRD FR-E, P4-03).
///
/// Pure and explainable: each factor produces a structured reason the UI
/// shows, and missing data is reported as unknown instead of guessed. The
/// score only orders the list; it is not a prediction of success.
abstract final class RecommendationEngine {
  static List<Recommendation> rank({
    required Garden garden,
    required List<PlantSpecies> species,
    required List<ContainerSpace> containers,
    required int month,
  }) {
    final results = [
      for (final s in species)
        evaluate(
          garden: garden,
          species: s,
          containers: containers,
          month: month,
        ),
    ];
    return results..sort((a, b) {
      final byGroup = a.group.index.compareTo(b.group.index);
      if (byGroup != 0) return byGroup;
      final byScore = b.score.compareTo(a.score);
      if (byScore != 0) return byScore;
      return a.species.commonName.compareTo(b.species.commonName);
    });
  }

  static Recommendation evaluate({
    required Garden garden,
    required PlantSpecies species,
    required List<ContainerSpace> containers,
    required int month,
  }) {
    assert(month >= 1 && month <= 12, 'month is 1–12');
    final sun = checkSun(garden.sun, species.sun);
    final season = checkSeason(garden, species, month);
    final container = checkContainer(species.container, containers);
    final goalMatch = garden.goals.isEmpty
        ? null
        : garden.goals.contains(goalFor(species.category));

    final caveats = [
      if (species.container.status == EvidenceStatus.proxy)
        Caveat.containerProxy,
      if (season.window?.isFallback ?? false) Caveat.regionFallback,
      if (species.petSafety.status == PetSafetyStatus.toxic) Caveat.petToxic,
      if (species.dataStatus != DataStatus.verified) Caveat.incompleteData,
    ];

    final score =
        _fitScore(sun.fit, good: 3, limited: -2, poor: -4) +
        switch (season.reason) {
          SeasonReason.sowNow => 3,
          SeasonReason.sowSoon => 2,
          SeasonReason.later => -1,
          SeasonReason.noRegion || SeasonReason.noData => 0,
        } +
        _fitScore(container.fit, good: 2, limited: 0, poor: -2) +
        switch (goalMatch) {
          true => 2,
          false => -1,
          null => 0,
        } +
        (species.dataStatus == DataStatus.verified ? 1 : 0);

    final notSuited = sun.fit == Fit.poor || container.fit == Fit.poor;
    final group = notSuited
        ? RecommendationGroup.notSuited
        : season.reason == SeasonReason.later
        ? RecommendationGroup.later
        : RecommendationGroup.goodNow;

    return Recommendation(
      species: species,
      score: score,
      group: group,
      sun: sun,
      season: season,
      container: container,
      goalMatch: goalMatch,
      caveats: caveats,
    );
  }

  static int _fitScore(
    Fit fit, {
    required int good,
    required int limited,
    required int poor,
  }) => switch (fit) {
    Fit.good => good,
    Fit.limited => limited,
    Fit.poor => poor,
    Fit.unknown => 0,
  };

  static SunCheck checkSun(SunExposure garden, SunNeed? need) {
    if (need == null) {
      return const SunCheck(Fit.unknown, SunReason.speciesUnknown);
    }
    if (garden == SunExposure.unknown) {
      return const SunCheck(Fit.unknown, SunReason.gardenUnknown);
    }
    return switch ((need.level, garden)) {
      (SunLevel.full, SunExposure.moreThan6Hours) ||
      (SunLevel.partial, SunExposure.moreThan6Hours) ||
      (SunLevel.partial, SunExposure.from3To6Hours) ||
      (SunLevel.indirect, SunExposure.from3To6Hours) ||
      (SunLevel.indirect, SunExposure.lessThan3Hours) => const SunCheck(
        Fit.good,
        SunReason.matches,
      ),
      (SunLevel.full, SunExposure.from3To6Hours) => const SunCheck(
        Fit.limited,
        SunReason.needsMoreSun,
      ),
      (SunLevel.indirect, SunExposure.moreThan6Hours) => const SunCheck(
        Fit.limited,
        SunReason.prefersIndirect,
      ),
      // A source-stated minimum of 2 h is still within "under 3 h".
      (SunLevel.partial, SunExposure.lessThan3Hours) =>
        (need.minHours != null && need.minHours! <= 2)
            ? const SunCheck(Fit.limited, SunReason.tooShady)
            : const SunCheck(Fit.poor, SunReason.tooShady),
      (SunLevel.full, SunExposure.lessThan3Hours) => const SunCheck(
        Fit.poor,
        SunReason.tooShady,
      ),
      (_, SunExposure.unknown) => const SunCheck(
        Fit.unknown,
        SunReason.gardenUnknown,
      ),
    };
  }

  static SeasonCheck checkSeason(
    Garden garden,
    PlantSpecies species,
    int month,
  ) {
    final region = garden.region;
    if (region == null) {
      return const SeasonCheck(Fit.unknown, SeasonReason.noRegion);
    }
    final sowing = species.sowingFor(region);
    if (sowing == null) {
      return const SeasonCheck(Fit.unknown, SeasonReason.noData);
    }
    final months = sowing.window.months;
    if (months.contains(month)) {
      return SeasonCheck(Fit.good, SeasonReason.sowNow, window: sowing);
    }
    final next = nextMonthIn(months, after: month);
    final soon = next == month % 12 + 1;
    return SeasonCheck(
      soon ? Fit.good : Fit.limited,
      soon ? SeasonReason.sowSoon : SeasonReason.later,
      window: sowing,
      nextMonth: next,
    );
  }

  /// The first month in [months] after [after], wrapping past December.
  static int nextMonthIn(Set<int> months, {required int after}) {
    for (var i = 1; i <= 12; i++) {
      final m = (after + i - 1) % 12 + 1;
      if (months.contains(m)) return m;
    }
    throw ArgumentError.value(months, 'months', 'must not be empty');
  }

  static ContainerCheck checkContainer(
    ContainerNeed need,
    List<ContainerSpace> containers,
  ) {
    if (!need.hasSize) {
      return const ContainerCheck(Fit.unknown, ContainerReason.speciesUnknown);
    }
    if (containers.isEmpty) {
      return const ContainerCheck(Fit.unknown, ContainerReason.noContainers);
    }
    final fitting = containers.where((c) => fits(need, c)).length;
    return fitting > 0
        ? ContainerCheck(
            Fit.good,
            ContainerReason.fits,
            fittingCount: fitting,
          )
        : const ContainerCheck(Fit.poor, ContainerReason.tooSmall);
  }

  /// Whether [space] meets every documented minimum in [need].
  static bool fits(ContainerNeed need, ContainerSpace space) =>
      (need.minVolumeL == null || space.soilLitres >= need.minVolumeL!) &&
      (need.minDepthCm == null || space.depthCm >= need.minDepthCm!);

  static GardenGoal goalFor(PlantCategory category) => switch (category) {
    PlantCategory.vegetable ||
    PlantCategory.leafyGreen ||
    PlantCategory.climber => GardenGoal.vegetables,
    PlantCategory.herb => GardenGoal.herbs,
    PlantCategory.flower => GardenGoal.flowers,
    PlantCategory.ornamental => GardenGoal.ornamental,
  };
}
