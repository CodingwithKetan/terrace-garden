import 'package:flutter/material.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// Localised labels and icons for garden vocabularies.
extension SpaceTypeLabel on SpaceType {
  String label(AppLocalizations l10n) => switch (this) {
    SpaceType.terrace => l10n.spaceTerrace,
    SpaceType.balcony => l10n.spaceBalcony,
    SpaceType.rooftop => l10n.spaceRooftop,
    SpaceType.windowsill => l10n.spaceWindowsill,
    SpaceType.courtyard => l10n.spaceCourtyard,
    SpaceType.other => l10n.spaceOther,
  };

  IconData get icon => switch (this) {
    SpaceType.terrace || SpaceType.rooftop => Icons.roofing_outlined,
    SpaceType.balcony => Icons.balcony_outlined,
    SpaceType.windowsill => Icons.window_outlined,
    SpaceType.courtyard => Icons.yard_outlined,
    SpaceType.other => Icons.place_outlined,
  };
}

extension SunExposureLabel on SunExposure {
  String label(AppLocalizations l10n) => switch (this) {
    SunExposure.lessThan3Hours => l10n.sunLessThan3,
    SunExposure.from3To6Hours => l10n.sun3To6,
    SunExposure.moreThan6Hours => l10n.sunMoreThan6,
    SunExposure.unknown => l10n.notSure,
  };
}

extension FacingLabel on Facing {
  String label(AppLocalizations l10n) => switch (this) {
    Facing.north => l10n.facingNorth,
    Facing.northEast => l10n.facingNorthEast,
    Facing.east => l10n.facingEast,
    Facing.southEast => l10n.facingSouthEast,
    Facing.south => l10n.facingSouth,
    Facing.southWest => l10n.facingSouthWest,
    Facing.west => l10n.facingWest,
    Facing.northWest => l10n.facingNorthWest,
    Facing.unknown => l10n.notSure,
  };
}

extension WindExposureLabel on WindExposure {
  String label(AppLocalizations l10n) => switch (this) {
    WindExposure.sheltered => l10n.windSheltered,
    WindExposure.moderate => l10n.windModerate,
    WindExposure.exposed => l10n.windExposed,
    WindExposure.unknown => l10n.notSure,
  };
}

extension WaterAccessLabel on WaterAccess {
  String label(AppLocalizations l10n) => switch (this) {
    WaterAccess.tapNearby => l10n.waterTapNearby,
    WaterAccess.carried => l10n.waterCarried,
    WaterAccess.unknown => l10n.notSure,
  };
}

extension GardenGoalLabel on GardenGoal {
  String label(AppLocalizations l10n) => switch (this) {
    GardenGoal.vegetables => l10n.goalVegetables,
    GardenGoal.herbs => l10n.goalHerbs,
    GardenGoal.flowers => l10n.goalFlowers,
    GardenGoal.ornamental => l10n.goalOrnamental,
    GardenGoal.fruit => l10n.goalFruit,
  };
}

extension GardenStyleLabel on GardenStyle {
  String label(AppLocalizations l10n) => switch (this) {
    GardenStyle.modernMinimalist => l10n.styleModernMinimalist,
    GardenStyle.tropical => l10n.styleTropical,
    GardenStyle.edibleKitchen => l10n.styleEdibleKitchen,
    GardenStyle.indianTerraceVegetable => l10n.styleIndianTerraceVegetable,
    GardenStyle.herbGarden => l10n.styleHerbGarden,
    GardenStyle.flowerGarden => l10n.styleFlowerGarden,
    GardenStyle.lowMaintenance => l10n.styleLowMaintenance,
    GardenStyle.verticalSpaceSaving => l10n.styleVerticalSpaceSaving,
  };
}

extension ExperienceLevelLabel on ExperienceLevel {
  String label(AppLocalizations l10n) => switch (this) {
    ExperienceLevel.beginner => l10n.experienceBeginner,
    ExperienceLevel.intermediate => l10n.experienceIntermediate,
    ExperienceLevel.experienced => l10n.experienceExperienced,
  };
}

extension WeeklyTimeLabel on WeeklyTime {
  String label(AppLocalizations l10n) => switch (this) {
    WeeklyTime.underOneHour => l10n.weeklyUnderOneHour,
    WeeklyTime.oneToThreeHours => l10n.weeklyOneToThree,
    WeeklyTime.moreThanThreeHours => l10n.weeklyMoreThanThree,
    WeeklyTime.unknown => l10n.notSure,
  };
}

extension BudgetBandLabel on BudgetBand {
  String label(AppLocalizations l10n) => switch (this) {
    BudgetBand.low => l10n.budgetLow,
    BudgetBand.medium => l10n.budgetMedium,
    BudgetBand.high => l10n.budgetHigh,
    BudgetBand.unknown => l10n.notSure,
  };
}

extension GrowingRegionLabel on GrowingRegion {
  String label(AppLocalizations l10n) => switch (this) {
    GrowingRegion.northIndia => l10n.regionNorthIndia,
    GrowingRegion.southIndia => l10n.regionSouthIndia,
    GrowingRegion.telangana => l10n.regionTelangana,
    GrowingRegion.tamilNadu => l10n.regionTamilNadu,
    GrowingRegion.kerala => l10n.regionKerala,
  };
}
