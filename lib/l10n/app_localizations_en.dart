// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Terrace Garden';

  @override
  String get navToday => 'Today';

  @override
  String get navGarden => 'Garden';

  @override
  String get navSeasons => 'Seasons';

  @override
  String get navPlants => 'Plants';

  @override
  String get navJournal => 'Journal';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsTooltip => 'Settings';

  @override
  String get todayEmptyTitle => 'Your garden day starts here';

  @override
  String get todayEmptyBody =>
      'Once you\'ve set up a garden and added plants, your care tasks for today will appear here, with a reminder to check the soil before you water.';

  @override
  String get gardenEmptyTitle => 'Plan your terrace or balcony';

  @override
  String get gardenEmptyBody =>
      'Describe your space, add photos and keep everything about your terrace in one place.';

  @override
  String get journalEmptyTitle => 'Watch your garden grow';

  @override
  String get journalEmptyBody =>
      'Progress photos, notes and harvests will collect here once your garden is growing.';

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get todayCareHeading => 'Today\'s care';

  @override
  String get todayNoTasks => 'No care tasks yet';

  @override
  String get tipWateringTitle => 'Before you water';

  @override
  String get tipWateringBody =>
      'Push a finger about 2–3 cm into the soil. Water only if it feels dry, then water slowly until it drains from the bottom of the pot.';

  @override
  String get tipWateringSource => 'Source: Royal Horticultural Society';

  @override
  String get onbWelcomeTitle => 'Grow a garden that suits your terrace';

  @override
  String get onbBenefitPlan =>
      'Plan your real space with pots and grow bags to scale';

  @override
  String get onbBenefitSeason => 'Plant ideas for your city and season';

  @override
  String get onbBenefitCare =>
      'Care reminders that ask you to check the soil first';

  @override
  String get onbStart => 'Set up my garden';

  @override
  String get onbExplore => 'I\'ll explore first';

  @override
  String onbStepOf(int step, int total) {
    return 'Step $step of $total';
  }

  @override
  String get onbSpaceTitle => 'Tell us about your space';

  @override
  String get onbLightTitle => 'Light and location';

  @override
  String get onbOptionalHint =>
      'Everything here is optional. Choose \"Not sure\" if you don\'t know.';

  @override
  String get onbGoalsTitle => 'What would you like to grow?';

  @override
  String get onbReadyTitle => 'Ready to create your garden';

  @override
  String get onbReadyBody =>
      'You can add photos, measurements and plants at any time.';

  @override
  String get onbCreateGarden => 'Create my garden';

  @override
  String get actionContinue => 'Continue';

  @override
  String get actionSkip => 'Skip';

  @override
  String get actionSave => 'Save';

  @override
  String get actionEdit => 'Edit';

  @override
  String get actionAdd => 'Add';

  @override
  String get seeAll => 'See all';

  @override
  String get notSure => 'Not sure';

  @override
  String get notSet => 'Not set';

  @override
  String get notSetAdd => 'Not set · Add';

  @override
  String get fieldGardenName => 'Garden name';

  @override
  String get defaultGardenName => 'My terrace';

  @override
  String get fieldSpaceType => 'Type of space';

  @override
  String get spaceTerrace => 'Terrace';

  @override
  String get spaceBalcony => 'Balcony';

  @override
  String get spaceRooftop => 'Rooftop';

  @override
  String get spaceWindowsill => 'Windowsill';

  @override
  String get spaceCourtyard => 'Courtyard';

  @override
  String get spaceOther => 'Other';

  @override
  String get fieldDimensions => 'Size (optional)';

  @override
  String get fieldDimensionsHelp =>
      'Measure the usable floor area. You can add this later.';

  @override
  String get fieldLength => 'Length';

  @override
  String get fieldWidth => 'Width';

  @override
  String get unitMetresShort => 'm';

  @override
  String get unitFeetShort => 'ft';

  @override
  String get fieldCity => 'City';

  @override
  String get cityChoose => 'Choose your city';

  @override
  String get citySearchHint => 'Search city or state';

  @override
  String get cityNoResults => 'No matching city. You can leave this blank.';

  @override
  String get cityClear => 'No city';

  @override
  String get cityNoRegion =>
      'Sowing calendars for this city aren\'t available yet. Everything else works normally.';

  @override
  String get fieldSun => 'Direct sun per day';

  @override
  String get sunLessThan3 => 'Under 3 hours';

  @override
  String get sun3To6 => '3–6 hours';

  @override
  String get sunMoreThan6 => '6+ hours';

  @override
  String get fieldFacing => 'Which way does it face?';

  @override
  String get facingNorth => 'North';

  @override
  String get facingNorthEast => 'North-east';

  @override
  String get facingEast => 'East';

  @override
  String get facingSouthEast => 'South-east';

  @override
  String get facingSouth => 'South';

  @override
  String get facingSouthWest => 'South-west';

  @override
  String get facingWest => 'West';

  @override
  String get facingNorthWest => 'North-west';

  @override
  String get fieldWind => 'Wind';

  @override
  String get windSheltered => 'Sheltered';

  @override
  String get windModerate => 'Some wind';

  @override
  String get windExposed => 'Very windy';

  @override
  String get fieldWater => 'Water source';

  @override
  String get waterTapNearby => 'Tap nearby';

  @override
  String get waterCarried => 'Carried in buckets';

  @override
  String get fieldGoals => 'Goals';

  @override
  String get goalVegetables => 'Vegetables';

  @override
  String get goalHerbs => 'Herbs';

  @override
  String get goalFlowers => 'Flowers';

  @override
  String get goalOrnamental => 'Ornamental plants';

  @override
  String get goalFruit => 'Fruit';

  @override
  String get fieldStyle => 'Garden style (optional)';

  @override
  String get styleModernMinimalist => 'Modern minimalist';

  @override
  String get styleTropical => 'Tropical';

  @override
  String get styleEdibleKitchen => 'Edible kitchen garden';

  @override
  String get styleIndianTerraceVegetable => 'Indian terrace vegetable garden';

  @override
  String get styleHerbGarden => 'Herb garden';

  @override
  String get styleFlowerGarden => 'Flower garden';

  @override
  String get styleLowMaintenance => 'Low-maintenance';

  @override
  String get styleVerticalSpaceSaving => 'Vertical and space-saving';

  @override
  String get fieldExperience => 'Gardening experience';

  @override
  String get experienceBeginner => 'Beginner';

  @override
  String get experienceIntermediate => 'Some experience';

  @override
  String get experienceExperienced => 'Experienced';

  @override
  String get fieldWeeklyTime => 'Time per week';

  @override
  String get weeklyUnderOneHour => 'Under 1 hour';

  @override
  String get weeklyOneToThree => '1–3 hours';

  @override
  String get weeklyMoreThanThree => 'More than 3 hours';

  @override
  String get fieldBudget => 'Budget';

  @override
  String get budgetLow => 'Low';

  @override
  String get budgetMedium => 'Medium';

  @override
  String get budgetHigh => 'High';

  @override
  String get fieldNotes => 'Notes';

  @override
  String get fieldNotesHint => 'Anything worth remembering about this space';

  @override
  String get errNameRequired => 'Give your garden a name';

  @override
  String get errNameTooLong => 'Use 60 characters or fewer';

  @override
  String get errDimension => 'Enter a size above 0 and up to 200 m (656 ft)';

  @override
  String get regionNorthIndia => 'North India';

  @override
  String get regionSouthIndia => 'South India';

  @override
  String get regionTelangana => 'Telangana';

  @override
  String get regionTamilNadu => 'Tamil Nadu';

  @override
  String get regionKerala => 'Kerala';

  @override
  String get gardensTitle => 'Your gardens';

  @override
  String get gardenCreateAction => 'Create your garden';

  @override
  String get gardenNew => 'New garden';

  @override
  String get gardenEditTitle => 'Edit garden';

  @override
  String get gardenSectionSpace => 'Your space';

  @override
  String get gardenSectionLight => 'Light and weather';

  @override
  String get gardenSectionGoals => 'Goals and style';

  @override
  String get gardenSize => 'Size';

  @override
  String get gardenArea => 'Area';

  @override
  String gardenSizeValue(String length, String width) {
    return '$length × $width';
  }

  @override
  String get gardenLocation => 'Location';

  @override
  String get gardenRegion => 'Growing region';

  @override
  String get gardenPhotos => 'Photos';

  @override
  String get gardenPhotosEmpty =>
      'Add photos of your space from a few angles. Photos are for your records; measurements always come from what you enter.';

  @override
  String get gardenDelete => 'Delete garden';

  @override
  String gardenDeleteTitle(String name) {
    return 'Delete $name?';
  }

  @override
  String get gardenDeleteBody =>
      'This removes the garden, its photos and everything recorded for it. This can\'t be undone.';

  @override
  String get gardenDeleted => 'Garden deleted';

  @override
  String get gardenSaved => 'Garden saved';

  @override
  String get unsavedTitle => 'Discard changes?';

  @override
  String get unsavedBody => 'Your changes to this garden haven\'t been saved.';

  @override
  String get unsavedDiscard => 'Discard';

  @override
  String get moreActions => 'More actions';

  @override
  String get photosTitle => 'Photos';

  @override
  String get photoAdd => 'Add photo';

  @override
  String get photoTake => 'Take a photo';

  @override
  String get photoChoose => 'Choose from gallery';

  @override
  String get photoCaption => 'Caption';

  @override
  String get photoCaptionHint => 'e.g. View from the north corner';

  @override
  String get photoSetCover => 'Use as cover';

  @override
  String get photoIsCover => 'Cover photo';

  @override
  String get photoReplace => 'Replace photo';

  @override
  String get photoDelete => 'Delete photo';

  @override
  String get photoDeleteBody => 'This photo will be removed from your garden.';

  @override
  String get photoCoverUpdated => 'Cover photo updated';

  @override
  String get photoMissing => 'This photo is no longer on your device';

  @override
  String get photoPermission =>
      'Allow camera or photo access for Terrace Garden in your phone\'s settings, or choose a photo from your gallery instead.';

  @override
  String get photoAdding => 'Adding photo…';

  @override
  String photoCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count photos',
      one: '1 photo',
      zero: 'No photos',
    );
    return '$_temp0';
  }

  @override
  String get checklistTitle => 'Terrace care checklist';

  @override
  String get checklistSubtitle =>
      'Weight, drainage, waterproofing, monsoon and heat';

  @override
  String get checklistIntro =>
      'Practical points for terraces and balconies. This is general guidance, not a structural assessment of your building.';

  @override
  String get checkLoadTitle => 'Check the roof can take the weight';

  @override
  String get checkLoadBody =>
      'Under the Indian loading code, a flat roof you can walk on is designed for about 150 kg per square metre of people and objects. Wet soil, pots and stored water add up quickly. Ask a structural engineer before adding raised beds, large planters or water tanks.';

  @override
  String get checkLoadSources =>
      'Sources: IS 875 (Part 2), Bureau of Indian Standards; ICAR Indian Horticulture';

  @override
  String get checkWallsTitle => 'Keep heavy containers over walls';

  @override
  String get checkWallsBody =>
      'Place grow bags and heavy pots where there is a wall underneath, not in the middle of an open span.';

  @override
  String get checkWallsSources => 'Source: Kerala Agricultural University';

  @override
  String get checkDrainTitle => 'Keep water draining';

  @override
  String get checkDrainBody =>
      'Every container needs drainage holes. Raise pots on bricks or pot feet so water runs away, empty saucers after watering, and keep the roof outlets clear.';

  @override
  String get checkDrainSources =>
      'Sources: University of Maryland Extension; Kerala Agricultural University';

  @override
  String get checkWaterproofTitle => 'Protect the waterproofing';

  @override
  String get checkWaterproofBody =>
      'Make sure the roof is waterproofed with a root- and rot-resistant layer before planting. After each crop, shift bags and bricks slightly so no patch of roof stays permanently wet.';

  @override
  String get checkWaterproofSources =>
      'Sources: ICAR Indian Horticulture; Kerala Agricultural University';

  @override
  String get checkMonsoonTitle => 'Prepare for the monsoon';

  @override
  String get checkMonsoonBody =>
      'Overwatering is the most common cause of container plant loss. In very wet spells, move pots under cover, remove saucers, and check the soil before watering even after rain.';

  @override
  String get checkMonsoonSources => 'Sources: Royal Horticultural Society';

  @override
  String get checkHeatTitle => 'Protect plants from summer heat';

  @override
  String get checkHeatBody =>
      'Small, dark and metal pots heat up and dry out fast, and south- and west-facing spots dry quickest. Group pots together, mulch the soil, and water early in the morning.';

  @override
  String get checkHeatSources =>
      'Sources: Royal Horticultural Society; University of Maryland Extension';

  @override
  String get designOpen => 'Design your layout';

  @override
  String get designOpenSubtitle => 'Arrange pots, grow bags and beds to scale';

  @override
  String layoutObjectCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count objects in your layout',
      one: '1 object in your layout',
    );
    return '$_temp0';
  }

  @override
  String get designerTitle => 'Layout';

  @override
  String get designerAdd => 'Add';

  @override
  String get designerUndo => 'Undo';

  @override
  String get designerRedo => 'Redo';

  @override
  String get designerObjects => 'Objects';

  @override
  String get designerSummary => 'Space summary';

  @override
  String get designerSnap => 'Snap';

  @override
  String get designerFit => 'Fit to screen';

  @override
  String get designerSaved => 'Saved';

  @override
  String get designerSaving => 'Saving…';

  @override
  String get designerNotSaved => 'Not saved yet';

  @override
  String get designerSaveFailed =>
      'Couldn\'t save. Your changes are kept and will be saved again.';

  @override
  String get designerEmptyHint =>
      'Tap Add to place pots, grow bags, beds and more.';

  @override
  String get designerNeedsSizeTitle => 'Add your garden\'s size';

  @override
  String get designerNeedsSizeBody =>
      'The layout uses real measurements, so it needs the length and width of the usable floor.';

  @override
  String get designerStart => 'Start designing';

  @override
  String designerProblems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count problems',
      one: '1 problem',
    );
    return '$_temp0';
  }

  @override
  String designerCanvasLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count objects',
      one: '1 object',
      zero: 'no objects',
    );
    return 'Garden layout, $_temp0. Use the Objects list to review and edit them.';
  }

  @override
  String get issueOutOfBounds => 'Outside the garden';

  @override
  String get issueOverlap => 'Overlaps another object';

  @override
  String get issueOnPath => 'Standing on a path';

  @override
  String get paletteContainers => 'Containers';

  @override
  String get paletteStructures => 'Structures';

  @override
  String get paletteOther => 'Other';

  @override
  String get kindRoundPot => 'Round pot';

  @override
  String get kindRectPlanter => 'Planter box';

  @override
  String get kindGrowBag => 'Grow bag';

  @override
  String get kindRaisedBed => 'Raised bed';

  @override
  String get kindVerticalPlanter => 'Vertical planter';

  @override
  String get kindWall => 'Wall';

  @override
  String get kindRailing => 'Railing';

  @override
  String get kindPath => 'Path';

  @override
  String get kindWaterPoint => 'Water tap';

  @override
  String get inspectorTitle => 'Edit object';

  @override
  String get fieldDiameter => 'Diameter';

  @override
  String get fieldDepth => 'Soil depth';

  @override
  String get fieldRotation => 'Rotation';

  @override
  String get fieldLabel => 'Label (optional)';

  @override
  String get fieldLabelHint => 'e.g. Tomatoes';

  @override
  String degreesValue(int degrees) {
    return '$degrees°';
  }

  @override
  String get actionRotate => 'Rotate 90°';

  @override
  String get actionDuplicate => 'Duplicate';

  @override
  String get actionDone => 'Done';

  @override
  String get unitCmShort => 'cm';

  @override
  String get unitInShort => 'in';

  @override
  String get objectsEmpty => 'No objects yet';

  @override
  String get summaryGardenArea => 'Garden area';

  @override
  String get summaryContainerArea => 'Covered by containers';

  @override
  String summaryContainerShare(int percent) {
    return '$percent% of the floor';
  }

  @override
  String get summaryWalkway => 'Paths';

  @override
  String get summarySoil => 'Soil needed';

  @override
  String get summaryCounts => 'Objects';

  @override
  String get summaryNote =>
      'Soil is each container\'s footprint × the soil depth you entered. Fill grow bags to about three quarters (Kerala Agricultural University) and check the weight guidance in the terrace checklist.';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get settingsUnits => 'Measurement units';

  @override
  String get unitsMetric => 'Metric (cm, m)';

  @override
  String get unitsImperial => 'Imperial (in, ft)';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsLicences => 'Open-source licences';

  @override
  String get settingsLicencesSubtitle => 'Fonts and software used in this app';

  @override
  String get imageCreditsTitle => 'Image credits';

  @override
  String get imageCreditsSubtitle =>
      'Photographers and licences for the photos in this app';

  @override
  String imageCreditsBy(String author) {
    return 'Photo by $author';
  }

  @override
  String get errorGenericTitle => 'Something went wrong';

  @override
  String get errorGenericBody =>
      'Please try again. If it keeps happening, restart the app.';

  @override
  String get errorNotFound =>
      'We couldn\'t find that item. It may have been deleted.';

  @override
  String get errorStorage =>
      'We couldn\'t save or read your data on this device.';

  @override
  String get errorPermission => 'Permission is needed to continue.';

  @override
  String get actionRetry => 'Try again';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionConfirm => 'Confirm';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionOpenSettings => 'Open settings';

  @override
  String get loadingLabel => 'Loading';

  @override
  String get plantsTitle => 'Plants';

  @override
  String get plantsSearchHint => 'Search, e.g. bhindi or tulsi';

  @override
  String get plantsFilterAll => 'All';

  @override
  String get categoryVegetable => 'Vegetables';

  @override
  String get categoryLeafyGreen => 'Leafy greens';

  @override
  String get categoryHerb => 'Herbs';

  @override
  String get categoryClimber => 'Climbers';

  @override
  String get categoryFlower => 'Flowers';

  @override
  String get categoryOrnamental => 'Ornamentals';

  @override
  String get plantsNoResults => 'No plants match your search';

  @override
  String get plantsNoResultsBody =>
      'Try a common name, a local name or a different category.';

  @override
  String get plantsCatalogueNote =>
      'Every fact is linked to its source. Anything not documented is shown as such, never guessed.';

  @override
  String plantsIdeasFor(String garden) {
    return 'Ideas for $garden';
  }

  @override
  String get plantsIdeasSubtitle =>
      'Ranked for your space, season and containers';

  @override
  String get lifecycleAnnual => 'Annual';

  @override
  String get lifecyclePerennial => 'Perennial';

  @override
  String get dataStatusVerified => 'Well sourced';

  @override
  String get dataStatusPartial => 'Partly documented';

  @override
  String get dataStatusUnverified => 'Few sourced facts';

  @override
  String get notDocumented => 'Not documented';

  @override
  String get plantSectionSun => 'Sunlight';

  @override
  String get sunFull => 'Full sun';

  @override
  String sunFullHours(int hours) {
    return 'Full sun, at least $hours hours a day';
  }

  @override
  String get sunPartial => 'Tolerates partial shade';

  @override
  String sunPartialHours(int hours) {
    return 'Sun or partial shade, at least $hours hours of direct sun';
  }

  @override
  String get sunIndirect => 'Bright indirect light';

  @override
  String get plantSectionContainer => 'Container';

  @override
  String get containerMinSoil => 'Minimum soil';

  @override
  String get containerRecommendedSoil => 'Recommended soil';

  @override
  String get containerMinDepth => 'Minimum depth';

  @override
  String get containerRecommendedDepth => 'Recommended depth';

  @override
  String get containerPlantsPer => 'Plants per minimum container';

  @override
  String get evidenceVerified => 'Sourced';

  @override
  String get evidenceProxy => 'Based on a similar crop';

  @override
  String get evidenceUnverified => 'Size not documented';

  @override
  String get plantSectionHarvest => 'Time to first harvest';

  @override
  String harvestDays(int min, int max) {
    return '$min–$max days';
  }

  @override
  String harvestDaysSingle(int days) {
    return 'About $days days';
  }

  @override
  String get plantSectionSowing => 'Sowing or planting months';

  @override
  String get sowingYearRound => 'All year';

  @override
  String sowingFallback(String state, String region) {
    return 'No $state table for this plant; showing $region months.';
  }

  @override
  String get sowingNone => 'No sourced sowing calendar for this plant.';

  @override
  String get plantSectionPropagation => 'How to start';

  @override
  String get propagationTransplant => 'Raise seedlings, then transplant';

  @override
  String get propagationDirect => 'Sow directly in the container';

  @override
  String get propagationSeed => 'From seed';

  @override
  String get propagationDivision => 'By dividing a clump';

  @override
  String get propagationCutting => 'From cuttings';

  @override
  String propagationNursery(int min, int max) {
    return 'Transplant after $min–$max days in a nursery tray';
  }

  @override
  String get plantSectionCare => 'Care notes';

  @override
  String get plantSectionPets => 'Pets';

  @override
  String get petToxic => 'Toxic to pets';

  @override
  String get petNonToxic => 'Listed as non-toxic to pets';

  @override
  String get petNotAssessed => 'Not assessed';

  @override
  String get petScopeNote =>
      'Pet data is from the ASPCA and does not cover children. If a person or pet eats a plant, contact a doctor or vet.';

  @override
  String get plantSectionSources => 'Sources';

  @override
  String get plantSourcesNote =>
      'Facts are summarised from these publications.';

  @override
  String get plantAddToGarden => 'Add to a garden';

  @override
  String get plantNotFound => 'This plant is no longer in the catalogue.';

  @override
  String get recTitle => 'Plant ideas';

  @override
  String recSubtitle(String garden, String month) {
    return 'For $garden in $month';
  }

  @override
  String get recDisclaimer =>
      'Ranked from your garden profile and sourced plant data. A starting point, not a promise of success.';

  @override
  String get recCompleteProfile =>
      'Add your sun hours and city to sharpen these ideas.';

  @override
  String get recGroupGoodNow => 'Good choices now';

  @override
  String get recGroupLater => 'Good fit, sow later';

  @override
  String get recGroupNotSuited => 'Not a good fit here';

  @override
  String get recSunMatches => 'Light suits your space';

  @override
  String get recSunNeedsMore => 'Needs 6+ hours of sun; your space gets 3–6';

  @override
  String get recSunTooShady => 'Your space gets under 3 hours of sun';

  @override
  String get recSunPrefersIndirect =>
      'Prefers bright indirect light to strong sun';

  @override
  String get recSunGardenUnknown => 'Add your sun hours to check light';

  @override
  String get recSunSpeciesUnknown => 'Light needs not documented';

  @override
  String get recSowNow => 'Sow now';

  @override
  String recSowSoon(String month) {
    return 'Sow from $month';
  }

  @override
  String recSowLater(String month) {
    return 'Next sowing: $month';
  }

  @override
  String get recNoRegion => 'No sourced sowing calendar for your city yet';

  @override
  String get recNoSeasonData => 'No sowing data for your region';

  @override
  String recContainerFits(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count of your containers are big enough',
      one: '1 of your containers is big enough',
    );
    return '$_temp0';
  }

  @override
  String get recContainerTooSmall =>
      'None of your containers is big enough yet';

  @override
  String get recNoContainers => 'Add containers in the designer to check size';

  @override
  String get recContainerUnknown => 'Container size not documented';

  @override
  String get recGoalMatch => 'Matches your goals';

  @override
  String get caveatContainerProxy => 'Container size from a similar crop';

  @override
  String get caveatRegionFallback => 'Uses broader regional sowing data';

  @override
  String get caveatPetToxic => 'Toxic to pets';

  @override
  String get caveatIncomplete => 'Some details not documented';

  @override
  String get recShortlistAdd => 'Save to shortlist';

  @override
  String get recShortlistRemove => 'Remove from shortlist';

  @override
  String get recShortlistOnly => 'Shortlist';

  @override
  String get recShortlistEmpty =>
      'Nothing shortlisted yet. Tap the bookmark on any idea to save it.';

  @override
  String plantingAddTitle(String plant) {
    return 'Add $plant';
  }

  @override
  String plantingEditTitle(String plant) {
    return 'Edit $plant';
  }

  @override
  String get plantingGarden => 'Garden';

  @override
  String get plantingContainer => 'Container';

  @override
  String get plantingNotPlaced => 'Not placed yet';

  @override
  String get plantingQuantity => 'Number of plants';

  @override
  String get plantingPlantedOn => 'Planted on';

  @override
  String get plantingStartedFrom => 'Started from';

  @override
  String get startSeed => 'Seed';

  @override
  String get startSeedling => 'Seedling';

  @override
  String get startCutting => 'Cutting';

  @override
  String get startPlant => 'Grown plant';

  @override
  String get plantingNotes => 'Notes (optional)';

  @override
  String get plantingSave => 'Add planting';

  @override
  String get plantingUpdate => 'Save changes';

  @override
  String plantingAdded(String plant, String garden) {
    return '$plant added to $garden';
  }

  @override
  String get plantingNoGardens =>
      'Create a garden first, then add plants to it.';

  @override
  String plantingIssueLowVolume(String actual, String required) {
    return 'This container holds about $actual; this plant needs at least $required.';
  }

  @override
  String plantingIssueShallow(String actual, String required) {
    return 'This container is $actual deep; this plant needs at least $required.';
  }

  @override
  String plantingIssueCrowded(int capacity) {
    return 'Rough guide: about $capacity of these plants fit this container (scaled from the source\'s per-container figure).';
  }

  @override
  String plantingIssueShared(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count other plantings already use this container.',
      one: '1 other planting already uses this container.',
    );
    return '$_temp0';
  }

  @override
  String get plantingIssueNoDepth =>
      'Set this container\'s soil depth in the designer to check its size.';

  @override
  String get quantityDecrease => 'Fewer';

  @override
  String get quantityIncrease => 'More';

  @override
  String get myPlantsTitle => 'My plants';

  @override
  String get myPlantsEmpty => 'No plants yet. Find ideas that suit this space.';

  @override
  String plantingSummary(int count, String date) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plants',
      one: '1 plant',
    );
    return '$_temp0 · since $date';
  }

  @override
  String get plantingContainerMissing =>
      'Its container was removed from the layout';

  @override
  String get plantingRemove => 'Remove planting';

  @override
  String plantingRemoveTitle(String plant) {
    return 'Remove $plant?';
  }

  @override
  String get plantingRemoveBody =>
      'This removes the planting from this garden.';

  @override
  String get plantingRemoved => 'Planting removed';

  @override
  String get plantingUnknownSpecies => 'Unknown plant';

  @override
  String get digestTitle => 'Your garden today';

  @override
  String digestBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count care tasks are due. Check the soil before you water.',
      one: '1 care task is due. Check the soil before you water.',
    );
    return '$_temp0';
  }

  @override
  String get taskCheckSoil => 'Check the soil';

  @override
  String get taskInspectPests => 'Look for pests';

  @override
  String get taskFeed => 'Feed';

  @override
  String get taskTransplant => 'Transplant seedlings';

  @override
  String get taskHarvest => 'Harvest may start';

  @override
  String get taskPrune => 'Prune';

  @override
  String get guideCheckSoil =>
      'Push a finger 2–3 cm into the soil, or about a third of the way down the pot. Water only if it feels dry, then water slowly until it drains from the bottom. Early morning is best; water the base, not the leaves.';

  @override
  String get guideCheckSoilDry =>
      'This plant should dry out between waterings (succulents completely). Check the soil and water only when it is dry; overwatering is the main risk.';

  @override
  String get guideCheckSoilMoist =>
      'Don\'t let this plant\'s soil dry out. Check it and water if it is getting dry.';

  @override
  String get guideInspectPests =>
      'Look under leaves and on new growth for aphids, mites and whitefly; aphids gather on the upwind side. Wash pests off with a strong jet of water early in the day. Avoid broad-spectrum sprays: they can make mites worse.';

  @override
  String get guideFeed =>
      'Feed every 2–4 weeks while the plant is growing, onto moist soil, at the amount on the product label. Feed less if plants turn tall and spindly or leaf edges look burnt.';

  @override
  String get guideTransplant =>
      'Seedlings raised in trays are moved to their final container about 25–30 days after sowing; most vegetables are ready at 2–3 true leaves.';

  @override
  String get guideHarvest =>
      'By the sourced timeline this crop may be ready to start harvesting. Timing varies with variety and season and is counted from sowing, so plants started as seedlings may be ready sooner.';

  @override
  String get guidePrune =>
      'In Tamil Nadu, jasmine (Jasminum sambac) is cut back to about 50 cm in the last week of November.';

  @override
  String guideSources(String publishers) {
    return 'Sources: $publishers';
  }

  @override
  String get todayOverdue => 'Overdue';

  @override
  String get todayDueToday => 'Today';

  @override
  String get todayUpcoming => 'Coming up';

  @override
  String get todayDoneToday => 'Done today';

  @override
  String get todayAllDone => 'All done for today';

  @override
  String get todayAllDoneBody =>
      'Nothing else is due today. Upcoming tasks are below.';

  @override
  String todayTasksDue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tasks due today',
      one: '1 task due today',
      zero: 'No tasks due today',
    );
    return '$_temp0';
  }

  @override
  String get taskMarkAllDone => 'Mark all done';

  @override
  String get taskDone => 'Mark done';

  @override
  String get taskSkip => 'Skip';

  @override
  String get taskMoveTomorrow => 'Move to tomorrow';

  @override
  String get taskPickDate => 'Choose another date';

  @override
  String get taskHowTo => 'How to';

  @override
  String get taskActions => 'Task options';

  @override
  String taskDueOn(String date) {
    return 'Due $date';
  }

  @override
  String get skipReasonTitle => 'Why skip it?';

  @override
  String get skipRained => 'It rained';

  @override
  String get skipSoilMoist => 'Soil is still moist';

  @override
  String get skipNotNeeded => 'Not needed';

  @override
  String get skipOther => 'Another reason';

  @override
  String get taskCompleted => 'Marked done';

  @override
  String get taskSkipped => 'Skipped';

  @override
  String taskMoved(String date) {
    return 'Moved to $date';
  }

  @override
  String get carePlan => 'Care plan';

  @override
  String carePlanTitle(String plant) {
    return 'Care plan: $plant';
  }

  @override
  String carePlanAfterDone(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Every $days days after the last one is done',
      one: 'Every day after the last one is done',
    );
    return '$_temp0';
  }

  @override
  String carePlanEvery(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Every $days days',
      one: 'Every day',
    );
    return '$_temp0';
  }

  @override
  String get carePlanWeekly => 'Every week';

  @override
  String carePlanOnce(String date) {
    return 'Once, on $date';
  }

  @override
  String carePlanYearly(String date) {
    return 'Every year on $date';
  }

  @override
  String get carePlanNote =>
      'Defaults come from the sources in each task\'s guide. Adjust them to your plants and weather; the soil check always comes first.';

  @override
  String get carePlanEmpty =>
      'The care plan appears a moment after the plant is added.';

  @override
  String get intervalShorter => 'Shorter interval';

  @override
  String get intervalLonger => 'Longer interval';

  @override
  String get calendarTitle => 'Care calendar';

  @override
  String get calendarNote =>
      'Shows scheduled tasks. Repeating checks appear on their next due date.';

  @override
  String get calendarNoTasks => 'Nothing scheduled on this day.';

  @override
  String get calendarPrevMonth => 'Previous month';

  @override
  String get calendarNextMonth => 'Next month';

  @override
  String calendarTasksOn(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tasks',
      one: '1 task',
    );
    return '$_temp0';
  }

  @override
  String get settingsReminders => 'Reminders';

  @override
  String get reminderDaily => 'Daily care digest';

  @override
  String reminderDailySubtitle(String time) {
    return 'One notification at $time on days with tasks';
  }

  @override
  String get reminderTime => 'Reminder time';

  @override
  String get reminderPermissionDenied =>
      'Notifications are turned off for this app. You can allow them in the system settings.';

  @override
  String get reminderNote =>
      'Reminders can arrive a few minutes late. The Today screen is always up to date.';

  @override
  String get journalTitle => 'Journal';

  @override
  String get journalAddEntry => 'New entry';

  @override
  String get journalNewTitle => 'New journal entry';

  @override
  String get journalFilterAll => 'All';

  @override
  String get journalWholeGarden => 'Whole garden';

  @override
  String get milestoneGerminated => 'Germinated';

  @override
  String get milestoneTransplanted => 'Transplanted';

  @override
  String get milestoneFlowering => 'Flowering';

  @override
  String get milestoneFirstFruit => 'First fruit';

  @override
  String get milestoneHarvest => 'Harvest';

  @override
  String get milestoneOther => 'Other';

  @override
  String get journalGarden => 'Garden';

  @override
  String get journalPlant => 'Plant';

  @override
  String get journalDate => 'Date';

  @override
  String get journalMilestone => 'Milestone (optional)';

  @override
  String get journalNote => 'Note';

  @override
  String get journalNoteHint => 'What did you notice?';

  @override
  String get journalPhotos => 'Photos';

  @override
  String get journalAddPhoto => 'Add photo';

  @override
  String get journalRemovePhoto => 'Remove photo';

  @override
  String journalPhotoLimit(int max) {
    return 'Up to $max photos per entry';
  }

  @override
  String get journalHarvestAmount => 'Harvest amount';

  @override
  String get unitGrams => 'Grams';

  @override
  String get unitPieces => 'Pieces';

  @override
  String get unitBunches => 'Bunches';

  @override
  String journalHarvestGrams(String amount) {
    return '$amount g';
  }

  @override
  String journalHarvestPieces(String amount) {
    return '$amount pieces';
  }

  @override
  String journalHarvestBunches(String amount) {
    return '$amount bunches';
  }

  @override
  String get journalSave => 'Save entry';

  @override
  String get journalSaved => 'Entry saved';

  @override
  String get journalEmptyError => 'Add a note, a milestone or a photo.';

  @override
  String get journalQuantityError =>
      'Enter an amount above zero and choose a unit.';

  @override
  String journalCareDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count care tasks done',
      one: '1 care task done',
    );
    return '$_temp0';
  }

  @override
  String get journalDeleteTitle => 'Delete this entry?';

  @override
  String get journalDeleteBody =>
      'Its photos will be deleted from this device too.';

  @override
  String get journalDeleted => 'Entry deleted';

  @override
  String get journalNoMatches => 'Nothing here for this filter yet.';

  @override
  String get journalAddForPlant => 'Add journal entry';

  @override
  String get statsTitle => 'Your progress';

  @override
  String get statTasks => 'Care tasks done';

  @override
  String get statStreak => 'Day streak';

  @override
  String get statEntries => 'Journal entries';

  @override
  String get statPhotos => 'Photos';

  @override
  String get statHarvested => 'Harvested';

  @override
  String get compareAction => 'Compare photos';

  @override
  String get compareTitle => 'Compare photos';

  @override
  String get compareHint => 'Choose two photos to see them side by side.';

  @override
  String get compareNeedTwo => 'Add at least two photos to compare progress.';

  @override
  String get compareAgain => 'Choose other photos';

  @override
  String get compareSelected => 'Selected';

  @override
  String todayHeadlineSoil(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plants would like a soil check',
      one: '1 plant would like a soil check',
    );
    return '$_temp0';
  }

  @override
  String todayHeadlineTasks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count things to do today',
      one: '1 thing to do today',
    );
    return '$_temp0';
  }

  @override
  String get todayHeadlineDone => 'All done for today';

  @override
  String get todayWaterTip =>
      'Check in the morning: it is the best time to water · Royal Horticultural Society';

  @override
  String get todayDrawTitle => 'Let\'s draw your terrace';

  @override
  String get todayDrawBody =>
      'Measure the floor once. We\'ll suggest plants that fit your pots, your sun and your city\'s season, and remind you to check the soil.';

  @override
  String get todayDrawStart => 'Start with my terrace';

  @override
  String get todayDrawExplore => 'Look at plants first';

  @override
  String get todayNoLayoutTitle => 'Draw your terrace to see it here';

  @override
  String get todayNoLayoutBody =>
      'Add your pots and grow bags to scale. Your plants and their checks will appear on the plan.';

  @override
  String get todayDesignLayout => 'Design your layout';

  @override
  String get todayEditLayout => 'Edit layout';

  @override
  String get todayGardenDetails => 'Garden details';

  @override
  String get todaySwitchGarden => 'Switch garden';

  @override
  String get todayAllGardens => 'All gardens';

  @override
  String todayPlanLabel(String garden) {
    return 'Plan of $garden';
  }

  @override
  String get planDue => 'check due';

  @override
  String get planDone => 'done today';

  @override
  String get planEmpty => 'empty';

  @override
  String get checkedToday => 'checked today';

  @override
  String get checkedYesterday => 'checked yesterday';

  @override
  String checkedDaysAgo(int days) {
    return 'checked $days days ago';
  }

  @override
  String get checkedNever => 'first check';

  @override
  String dueSince(String date) {
    return 'due since $date';
  }

  @override
  String soilSheetLabel(String container) {
    return 'Soil check · $container';
  }

  @override
  String get soilDry => 'It was dry, I watered';

  @override
  String get soilMoist => 'Still moist, skip today';

  @override
  String get soilMorning =>
      'Morning is the best time to water · Royal Horticultural Society';

  @override
  String get soilDiagramLabel =>
      'Cross-section of a pot: a finger pushed 2 to 3 centimetres into the soil, where the top layer is drier';

  @override
  String get soilDryOnTop => 'Dry on top?';

  @override
  String get soilFeelBelow => 'Feel below it';

  @override
  String get seasonsTitle => 'Seasons';

  @override
  String seasonsSubtitle(String city, String region) {
    return '$city · $region calendar';
  }

  @override
  String get seasonsSowNow => 'sow now';

  @override
  String get seasonsNothingNow =>
      'Nothing in the catalogue has a sowing window this month for your region.';

  @override
  String get seasonsYourPlants => 'Your plants and saved';

  @override
  String get seasonsWindowLegend => 'sowing window';

  @override
  String get seasonsNoCalendar => 'No sowing calendar in our sources';

  @override
  String get seasonsNoRegion =>
      'Your city has no sourced sowing calendar yet, so seasons can\'t be shown. North India, South India, Telangana, Tamil Nadu and Kerala are covered.';

  @override
  String get seasonsNoGarden =>
      'Add a garden with your city to see what to sow each month.';

  @override
  String get seasonsFootnote =>
      'Windows come from sourced regional tables. Exact dates depend on variety and weather.';

  @override
  String get seasonsEmptyPlants =>
      'Plants you add or save will appear here with their sowing months.';

  @override
  String get settingsData => 'Your data';

  @override
  String get exportData => 'Export my data';

  @override
  String get exportDataSubtitle =>
      'A ZIP file with your gardens, plants, care history, journal and photos';

  @override
  String get exportPreparing => 'Preparing your export…';

  @override
  String get exportFailed =>
      'The export could not be created. Please try again.';

  @override
  String get exportSubject => 'Terrace Garden data export';

  @override
  String get deleteAllData => 'Delete all data';

  @override
  String get deleteAllDataSubtitle =>
      'Gardens, plants, care history, journal and photos on this device';

  @override
  String get deleteAllTitle => 'Delete everything?';

  @override
  String get deleteAllBody =>
      'This permanently removes every garden, plant, care task, journal entry and photo stored by this app, and resets your settings. It can\'t be undone.';

  @override
  String get deleteAllConfirm => 'Delete everything';

  @override
  String get deleteAllFailed =>
      'Some data could not be deleted. Please try again.';

  @override
  String get plantSoilCheckDue => 'Soil check due';

  @override
  String journeyDay(int day) {
    return 'Day $day';
  }

  @override
  String journeyStartsOn(String date) {
    return 'Starts $date';
  }

  @override
  String get journeySown => 'Sown';

  @override
  String get journeyPlanted => 'Planted';

  @override
  String get journeyTransplant => 'Transplant';

  @override
  String get journeyHarvest => 'Harvest may start';

  @override
  String get journeyVaries => 'Varieties and weather differ.';

  @override
  String get journeyUndocumented =>
      'Our sources don\'t document the next steps for this plant yet.';

  @override
  String journeyLabel(String plant, String steps) {
    return '$plant journey: $steps';
  }

  @override
  String get careRhythm => 'Care rhythm';

  @override
  String get rhythmToday => 'Today';

  @override
  String get rhythmTomorrow => 'Tomorrow';

  @override
  String rhythmInDays(int count) {
    return 'In $count days';
  }

  @override
  String factSoil(String volume) {
    return '$volume+ of soil';
  }

  @override
  String plantArtLabel(String plant) {
    return 'Illustration of $plant';
  }

  @override
  String plantSourcesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sources',
      one: '1 source',
    );
    return '$_temp0';
  }

  @override
  String get plantingWhichContainer => 'Which container?';

  @override
  String plantingNeedsBoth(String plant, String volume, String depth) {
    return '$plant needs at least $volume and $depth of soil.';
  }

  @override
  String plantingNeedsVolume(String plant, String volume) {
    return '$plant needs at least $volume of soil.';
  }

  @override
  String plantingNeedsDepth(String plant, String depth) {
    return '$plant needs soil at least $depth deep.';
  }

  @override
  String plantingNeedsUnknown(String plant) {
    return 'Our sources don\'t give a container size for $plant, so we can\'t check the fit.';
  }

  @override
  String plantingPlanLabel(String garden) {
    return 'Choose a container on the plan of $garden';
  }

  @override
  String plantingSaveIn(String container) {
    return 'Plant in $container';
  }

  @override
  String get fitFits => 'fits';

  @override
  String get fitTooSmall => 'too small';

  @override
  String get fitTooShallow => 'too shallow';

  @override
  String get fitFull => 'full';

  @override
  String get fitUnknown => 'not checked';

  @override
  String fitHas(String plant) {
    return 'has $plant';
  }

  @override
  String get recBestMatch => 'Best match';

  @override
  String get recSowNowFilter => 'All ideas';

  @override
  String recSowIn(String months) {
    return 'Sow in $months';
  }

  @override
  String recReadyIn(int min, int max) {
    return 'Ready in $min–$max days';
  }
}
