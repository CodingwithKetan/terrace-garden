import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:terrace_garden/app/theme/care_colors.dart';
import 'package:terrace_garden/features/garden/garden.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plant_catalog/domain/recommendation_engine.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// Localised labels for catalogue and recommendation vocabularies.
extension PlantCategoryLabel on PlantCategory {
  String label(AppLocalizations l10n) => switch (this) {
    PlantCategory.vegetable => l10n.categoryVegetable,
    PlantCategory.leafyGreen => l10n.categoryLeafyGreen,
    PlantCategory.herb => l10n.categoryHerb,
    PlantCategory.climber => l10n.categoryClimber,
    PlantCategory.flower => l10n.categoryFlower,
    PlantCategory.ornamental => l10n.categoryOrnamental,
  };

  IconData get icon => switch (this) {
    PlantCategory.vegetable => Icons.restaurant_outlined,
    PlantCategory.leafyGreen => Icons.eco_outlined,
    PlantCategory.herb => Icons.grass_outlined,
    PlantCategory.climber => Icons.fence_outlined,
    PlantCategory.flower => Icons.local_florist_outlined,
    PlantCategory.ornamental => Icons.spa_outlined,
  };
}

extension PlantLifecycleLabel on PlantLifecycle {
  String label(AppLocalizations l10n) => switch (this) {
    PlantLifecycle.annual => l10n.lifecycleAnnual,
    PlantLifecycle.perennial => l10n.lifecyclePerennial,
  };
}

extension DataStatusLabel on DataStatus {
  String label(AppLocalizations l10n) => switch (this) {
    DataStatus.verified => l10n.dataStatusVerified,
    DataStatus.partial => l10n.dataStatusPartial,
    DataStatus.unverified => l10n.dataStatusUnverified,
  };

  IconData get icon => switch (this) {
    DataStatus.verified => Icons.verified_outlined,
    DataStatus.partial => Icons.rule_outlined,
    DataStatus.unverified => Icons.help_outline,
  };

  Color color(CareColors colors) => switch (this) {
    DataStatus.verified => colors.success,
    DataStatus.partial || DataStatus.unverified => colors.warning,
  };
}

extension EvidenceStatusLabel on EvidenceStatus {
  String label(AppLocalizations l10n) => switch (this) {
    EvidenceStatus.verified => l10n.evidenceVerified,
    EvidenceStatus.proxy => l10n.evidenceProxy,
    EvidenceStatus.unverified => l10n.evidenceUnverified,
  };
}

extension SunNeedLabel on SunNeed {
  String label(AppLocalizations l10n) => switch ((level, minHours)) {
    (SunLevel.full, final int h) => l10n.sunFullHours(h),
    (SunLevel.full, null) => l10n.sunFull,
    (SunLevel.partial, final int h) when h > 0 => l10n.sunPartialHours(h),
    (SunLevel.partial, _) => l10n.sunPartial,
    (SunLevel.indirect, _) => l10n.sunIndirect,
  };
}

extension PropagationMethodLabel on PropagationMethod {
  String label(AppLocalizations l10n) => switch (this) {
    PropagationMethod.transplant => l10n.propagationTransplant,
    PropagationMethod.direct => l10n.propagationDirect,
    PropagationMethod.seed => l10n.propagationSeed,
    PropagationMethod.division => l10n.propagationDivision,
    PropagationMethod.cutting => l10n.propagationCutting,
  };
}

extension PetSafetyLabel on PetSafetyStatus {
  String label(AppLocalizations l10n) => switch (this) {
    PetSafetyStatus.toxic => l10n.petToxic,
    PetSafetyStatus.nonToxic => l10n.petNonToxic,
    PetSafetyStatus.notAssessed => l10n.petNotAssessed,
  };

  IconData get icon => switch (this) {
    PetSafetyStatus.toxic => Icons.warning_amber_rounded,
    PetSafetyStatus.nonToxic => Icons.pets_outlined,
    PetSafetyStatus.notAssessed => Icons.help_outline,
  };
}

extension PlantingStartLabel on PlantingStart {
  String label(AppLocalizations l10n) => switch (this) {
    PlantingStart.seed => l10n.startSeed,
    PlantingStart.seedling => l10n.startSeedling,
    PlantingStart.cutting => l10n.startCutting,
    PlantingStart.plant => l10n.startPlant,
  };
}

/// Short month name (e.g. "Jul") for month 1–12 in the app's locale.
String monthShort(BuildContext context, int month) => DateFormat.MMM(
  Localizations.localeOf(context).toLanguageTag(),
).format(DateTime(2026, month));

/// Full month name (e.g. "July").
String monthLong(BuildContext context, int month) => DateFormat.MMMM(
  Localizations.localeOf(context).toLanguageTag(),
).format(DateTime(2026, month));

/// One explained factor of a recommendation, ready to show.
class ReasonLine {
  const ReasonLine(this.text, this.fit, this.icon);

  final String text;
  final Fit fit;
  final IconData icon;
}

extension RecommendationText on Recommendation {
  List<ReasonLine> reasons(BuildContext context) {
    final l10n = context.l10n;
    return [
      ReasonLine(
        switch (sun.reason) {
          SunReason.matches => l10n.recSunMatches,
          SunReason.needsMoreSun => l10n.recSunNeedsMore,
          SunReason.tooShady => l10n.recSunTooShady,
          SunReason.prefersIndirect => l10n.recSunPrefersIndirect,
          SunReason.gardenUnknown => l10n.recSunGardenUnknown,
          SunReason.speciesUnknown => l10n.recSunSpeciesUnknown,
        },
        sun.fit,
        Icons.wb_sunny_outlined,
      ),
      ReasonLine(
        switch (season.reason) {
          SeasonReason.sowNow => l10n.recSowNow,
          SeasonReason.sowSoon => l10n.recSowSoon(
            monthLong(context, season.nextMonth!),
          ),
          SeasonReason.later => l10n.recSowLater(
            monthLong(context, season.nextMonth!),
          ),
          SeasonReason.noRegion => l10n.recNoRegion,
          SeasonReason.noData => l10n.recNoSeasonData,
        },
        season.fit,
        Icons.calendar_month_outlined,
      ),
      ReasonLine(
        switch (container.reason) {
          ContainerReason.fits => l10n.recContainerFits(container.fittingCount),
          ContainerReason.tooSmall => l10n.recContainerTooSmall,
          ContainerReason.noContainers => l10n.recNoContainers,
          ContainerReason.speciesUnknown => l10n.recContainerUnknown,
        },
        container.fit,
        Icons.inventory_2_outlined,
      ),
      if (goalMatch ?? false)
        ReasonLine(l10n.recGoalMatch, Fit.good, Icons.flag_outlined),
    ];
  }
}

extension CaveatLabel on Caveat {
  String label(AppLocalizations l10n) => switch (this) {
    Caveat.containerProxy => l10n.caveatContainerProxy,
    Caveat.regionFallback => l10n.caveatRegionFallback,
    Caveat.petToxic => l10n.caveatPetToxic,
    Caveat.incompleteData => l10n.caveatIncomplete,
  };

  IconData get icon => switch (this) {
    Caveat.petToxic => Icons.pets_outlined,
    Caveat.containerProxy ||
    Caveat.regionFallback ||
    Caveat.incompleteData => Icons.info_outline,
  };
}

extension FitStyle on Fit {
  IconData get icon => switch (this) {
    Fit.good => Icons.check_circle_outline,
    Fit.limited => Icons.error_outline,
    Fit.poor => Icons.cancel_outlined,
    Fit.unknown => Icons.help_outline,
  };

  Color color(BuildContext context) {
    final care = context.careColors;
    return switch (this) {
      Fit.good => care.success,
      Fit.limited => care.warning,
      Fit.poor => Theme.of(context).colorScheme.error,
      Fit.unknown => Theme.of(context).colorScheme.onSurfaceVariant,
    };
  }
}

extension RegionalSowingLabel on RegionalSowing {
  String regionLabel(AppLocalizations l10n) => window.region.label(l10n);
}
