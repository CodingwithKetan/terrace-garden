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
  String get plantsEmptyTitle => 'Plants that suit your space';

  @override
  String get plantsEmptyBody =>
      'A catalogue of container plants for Indian terraces is on its way, with sources for every recommendation.';

  @override
  String get journalEmptyTitle => 'Watch your garden grow';

  @override
  String get journalEmptyBody =>
      'Progress photos, notes and harvests will collect here once your garden is growing.';

  @override
  String get comingSoonLabel => 'Coming soon';

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
}
