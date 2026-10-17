/// Profile vocabularies (data-model.md §3). Every question the user may not
/// know the answer to has an explicit `unknown` value, so "Not sure" is stored
/// honestly instead of being replaced by a default that looks like real data.
library;

enum SpaceType { terrace, balcony, rooftop, windowsill, courtyard, other }

enum SunExposure { lessThan3Hours, from3To6Hours, moreThan6Hours, unknown }

enum Facing {
  north,
  northEast,
  east,
  southEast,
  south,
  southWest,
  west,
  northWest,
  unknown,
}

enum WindExposure { sheltered, moderate, exposed, unknown }

enum WaterAccess { tapNearby, carried, unknown }

enum GardenGoal { vegetables, herbs, flowers, ornamental, fruit }

enum GardenStyle {
  modernMinimalist,
  tropical,
  edibleKitchen,
  indianTerraceVegetable,
  herbGarden,
  flowerGarden,
  lowMaintenance,
  verticalSpaceSaving,
}

enum ExperienceLevel { beginner, intermediate, experienced }

/// Approximate weekly time the user can give the garden.
enum WeeklyTime { underOneHour, oneToThreeHours, moreThanThreeHours, unknown }

enum BudgetBand { low, medium, high, unknown }
