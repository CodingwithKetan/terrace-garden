import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// Working product name shown in the app bar and task switcher.
  ///
  /// In en, this message translates to:
  /// **'Terrace Garden'**
  String get appTitle;

  /// No description provided for @navToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get navToday;

  /// No description provided for @navGarden.
  ///
  /// In en, this message translates to:
  /// **'Garden'**
  String get navGarden;

  /// No description provided for @navPlants.
  ///
  /// In en, this message translates to:
  /// **'Plants'**
  String get navPlants;

  /// No description provided for @navJournal.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get navJournal;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTooltip;

  /// No description provided for @todayEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your garden day starts here'**
  String get todayEmptyTitle;

  /// No description provided for @todayEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Once you\'ve set up a garden and added plants, your care tasks for today will appear here, with a reminder to check the soil before you water.'**
  String get todayEmptyBody;

  /// No description provided for @gardenEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan your terrace or balcony'**
  String get gardenEmptyTitle;

  /// No description provided for @gardenEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Describe your space, add photos and keep everything about your terrace in one place.'**
  String get gardenEmptyBody;

  /// No description provided for @plantsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Plants that suit your space'**
  String get plantsEmptyTitle;

  /// No description provided for @plantsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'A catalogue of container plants for Indian terraces is on its way, with sources for every recommendation.'**
  String get plantsEmptyBody;

  /// No description provided for @journalEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Watch your garden grow'**
  String get journalEmptyTitle;

  /// No description provided for @journalEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Progress photos, notes and harvests will collect here once your garden is growing.'**
  String get journalEmptyBody;

  /// No description provided for @comingSoonLabel.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoonLabel;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetingEvening;

  /// No description provided for @todayCareHeading.
  ///
  /// In en, this message translates to:
  /// **'Today\'s care'**
  String get todayCareHeading;

  /// No description provided for @todayNoTasks.
  ///
  /// In en, this message translates to:
  /// **'No care tasks yet'**
  String get todayNoTasks;

  /// No description provided for @tipWateringTitle.
  ///
  /// In en, this message translates to:
  /// **'Before you water'**
  String get tipWateringTitle;

  /// No description provided for @tipWateringBody.
  ///
  /// In en, this message translates to:
  /// **'Push a finger about 2–3 cm into the soil. Water only if it feels dry, then water slowly until it drains from the bottom of the pot.'**
  String get tipWateringBody;

  /// Provenance for the watering tip (gardening-references S5, S6).
  ///
  /// In en, this message translates to:
  /// **'Source: Royal Horticultural Society'**
  String get tipWateringSource;

  /// No description provided for @onbWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Grow a garden that suits your terrace'**
  String get onbWelcomeTitle;

  /// No description provided for @onbBenefitPlan.
  ///
  /// In en, this message translates to:
  /// **'Plan your real space with pots and grow bags to scale'**
  String get onbBenefitPlan;

  /// No description provided for @onbBenefitSeason.
  ///
  /// In en, this message translates to:
  /// **'Plant ideas for your city and season'**
  String get onbBenefitSeason;

  /// No description provided for @onbBenefitCare.
  ///
  /// In en, this message translates to:
  /// **'Care reminders that ask you to check the soil first'**
  String get onbBenefitCare;

  /// No description provided for @onbStart.
  ///
  /// In en, this message translates to:
  /// **'Set up my garden'**
  String get onbStart;

  /// No description provided for @onbExplore.
  ///
  /// In en, this message translates to:
  /// **'I\'ll explore first'**
  String get onbExplore;

  /// No description provided for @onbStepOf.
  ///
  /// In en, this message translates to:
  /// **'Step {step} of {total}'**
  String onbStepOf(int step, int total);

  /// No description provided for @onbSpaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your space'**
  String get onbSpaceTitle;

  /// No description provided for @onbLightTitle.
  ///
  /// In en, this message translates to:
  /// **'Light and location'**
  String get onbLightTitle;

  /// No description provided for @onbOptionalHint.
  ///
  /// In en, this message translates to:
  /// **'Everything here is optional. Choose \"Not sure\" if you don\'t know.'**
  String get onbOptionalHint;

  /// No description provided for @onbGoalsTitle.
  ///
  /// In en, this message translates to:
  /// **'What would you like to grow?'**
  String get onbGoalsTitle;

  /// No description provided for @onbReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Ready to create your garden'**
  String get onbReadyTitle;

  /// No description provided for @onbReadyBody.
  ///
  /// In en, this message translates to:
  /// **'You can add photos, measurements and plants at any time.'**
  String get onbReadyBody;

  /// No description provided for @onbCreateGarden.
  ///
  /// In en, this message translates to:
  /// **'Create my garden'**
  String get onbCreateGarden;

  /// No description provided for @actionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get actionContinue;

  /// No description provided for @actionSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get actionSkip;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// No description provided for @actionEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get actionEdit;

  /// No description provided for @actionAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get actionAdd;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @notSure.
  ///
  /// In en, this message translates to:
  /// **'Not sure'**
  String get notSure;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @notSetAdd.
  ///
  /// In en, this message translates to:
  /// **'Not set · Add'**
  String get notSetAdd;

  /// No description provided for @fieldGardenName.
  ///
  /// In en, this message translates to:
  /// **'Garden name'**
  String get fieldGardenName;

  /// No description provided for @defaultGardenName.
  ///
  /// In en, this message translates to:
  /// **'My terrace'**
  String get defaultGardenName;

  /// No description provided for @fieldSpaceType.
  ///
  /// In en, this message translates to:
  /// **'Type of space'**
  String get fieldSpaceType;

  /// No description provided for @spaceTerrace.
  ///
  /// In en, this message translates to:
  /// **'Terrace'**
  String get spaceTerrace;

  /// No description provided for @spaceBalcony.
  ///
  /// In en, this message translates to:
  /// **'Balcony'**
  String get spaceBalcony;

  /// No description provided for @spaceRooftop.
  ///
  /// In en, this message translates to:
  /// **'Rooftop'**
  String get spaceRooftop;

  /// No description provided for @spaceWindowsill.
  ///
  /// In en, this message translates to:
  /// **'Windowsill'**
  String get spaceWindowsill;

  /// No description provided for @spaceCourtyard.
  ///
  /// In en, this message translates to:
  /// **'Courtyard'**
  String get spaceCourtyard;

  /// No description provided for @spaceOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get spaceOther;

  /// No description provided for @fieldDimensions.
  ///
  /// In en, this message translates to:
  /// **'Size (optional)'**
  String get fieldDimensions;

  /// No description provided for @fieldDimensionsHelp.
  ///
  /// In en, this message translates to:
  /// **'Measure the usable floor area. You can add this later.'**
  String get fieldDimensionsHelp;

  /// No description provided for @fieldLength.
  ///
  /// In en, this message translates to:
  /// **'Length'**
  String get fieldLength;

  /// No description provided for @fieldWidth.
  ///
  /// In en, this message translates to:
  /// **'Width'**
  String get fieldWidth;

  /// No description provided for @unitMetresShort.
  ///
  /// In en, this message translates to:
  /// **'m'**
  String get unitMetresShort;

  /// No description provided for @unitFeetShort.
  ///
  /// In en, this message translates to:
  /// **'ft'**
  String get unitFeetShort;

  /// No description provided for @fieldCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get fieldCity;

  /// No description provided for @cityChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose your city'**
  String get cityChoose;

  /// No description provided for @citySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search city or state'**
  String get citySearchHint;

  /// No description provided for @cityNoResults.
  ///
  /// In en, this message translates to:
  /// **'No matching city. You can leave this blank.'**
  String get cityNoResults;

  /// No description provided for @cityClear.
  ///
  /// In en, this message translates to:
  /// **'No city'**
  String get cityClear;

  /// No description provided for @cityNoRegion.
  ///
  /// In en, this message translates to:
  /// **'Sowing calendars for this city aren\'t available yet. Everything else works normally.'**
  String get cityNoRegion;

  /// No description provided for @fieldSun.
  ///
  /// In en, this message translates to:
  /// **'Direct sun per day'**
  String get fieldSun;

  /// No description provided for @sunLessThan3.
  ///
  /// In en, this message translates to:
  /// **'Under 3 hours'**
  String get sunLessThan3;

  /// No description provided for @sun3To6.
  ///
  /// In en, this message translates to:
  /// **'3–6 hours'**
  String get sun3To6;

  /// No description provided for @sunMoreThan6.
  ///
  /// In en, this message translates to:
  /// **'6+ hours'**
  String get sunMoreThan6;

  /// No description provided for @fieldFacing.
  ///
  /// In en, this message translates to:
  /// **'Which way does it face?'**
  String get fieldFacing;

  /// No description provided for @facingNorth.
  ///
  /// In en, this message translates to:
  /// **'North'**
  String get facingNorth;

  /// No description provided for @facingNorthEast.
  ///
  /// In en, this message translates to:
  /// **'North-east'**
  String get facingNorthEast;

  /// No description provided for @facingEast.
  ///
  /// In en, this message translates to:
  /// **'East'**
  String get facingEast;

  /// No description provided for @facingSouthEast.
  ///
  /// In en, this message translates to:
  /// **'South-east'**
  String get facingSouthEast;

  /// No description provided for @facingSouth.
  ///
  /// In en, this message translates to:
  /// **'South'**
  String get facingSouth;

  /// No description provided for @facingSouthWest.
  ///
  /// In en, this message translates to:
  /// **'South-west'**
  String get facingSouthWest;

  /// No description provided for @facingWest.
  ///
  /// In en, this message translates to:
  /// **'West'**
  String get facingWest;

  /// No description provided for @facingNorthWest.
  ///
  /// In en, this message translates to:
  /// **'North-west'**
  String get facingNorthWest;

  /// No description provided for @fieldWind.
  ///
  /// In en, this message translates to:
  /// **'Wind'**
  String get fieldWind;

  /// No description provided for @windSheltered.
  ///
  /// In en, this message translates to:
  /// **'Sheltered'**
  String get windSheltered;

  /// No description provided for @windModerate.
  ///
  /// In en, this message translates to:
  /// **'Some wind'**
  String get windModerate;

  /// No description provided for @windExposed.
  ///
  /// In en, this message translates to:
  /// **'Very windy'**
  String get windExposed;

  /// No description provided for @fieldWater.
  ///
  /// In en, this message translates to:
  /// **'Water source'**
  String get fieldWater;

  /// No description provided for @waterTapNearby.
  ///
  /// In en, this message translates to:
  /// **'Tap nearby'**
  String get waterTapNearby;

  /// No description provided for @waterCarried.
  ///
  /// In en, this message translates to:
  /// **'Carried in buckets'**
  String get waterCarried;

  /// No description provided for @fieldGoals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get fieldGoals;

  /// No description provided for @goalVegetables.
  ///
  /// In en, this message translates to:
  /// **'Vegetables'**
  String get goalVegetables;

  /// No description provided for @goalHerbs.
  ///
  /// In en, this message translates to:
  /// **'Herbs'**
  String get goalHerbs;

  /// No description provided for @goalFlowers.
  ///
  /// In en, this message translates to:
  /// **'Flowers'**
  String get goalFlowers;

  /// No description provided for @goalOrnamental.
  ///
  /// In en, this message translates to:
  /// **'Ornamental plants'**
  String get goalOrnamental;

  /// No description provided for @goalFruit.
  ///
  /// In en, this message translates to:
  /// **'Fruit'**
  String get goalFruit;

  /// No description provided for @fieldStyle.
  ///
  /// In en, this message translates to:
  /// **'Garden style (optional)'**
  String get fieldStyle;

  /// No description provided for @styleModernMinimalist.
  ///
  /// In en, this message translates to:
  /// **'Modern minimalist'**
  String get styleModernMinimalist;

  /// No description provided for @styleTropical.
  ///
  /// In en, this message translates to:
  /// **'Tropical'**
  String get styleTropical;

  /// No description provided for @styleEdibleKitchen.
  ///
  /// In en, this message translates to:
  /// **'Edible kitchen garden'**
  String get styleEdibleKitchen;

  /// No description provided for @styleIndianTerraceVegetable.
  ///
  /// In en, this message translates to:
  /// **'Indian terrace vegetable garden'**
  String get styleIndianTerraceVegetable;

  /// No description provided for @styleHerbGarden.
  ///
  /// In en, this message translates to:
  /// **'Herb garden'**
  String get styleHerbGarden;

  /// No description provided for @styleFlowerGarden.
  ///
  /// In en, this message translates to:
  /// **'Flower garden'**
  String get styleFlowerGarden;

  /// No description provided for @styleLowMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Low-maintenance'**
  String get styleLowMaintenance;

  /// No description provided for @styleVerticalSpaceSaving.
  ///
  /// In en, this message translates to:
  /// **'Vertical and space-saving'**
  String get styleVerticalSpaceSaving;

  /// No description provided for @fieldExperience.
  ///
  /// In en, this message translates to:
  /// **'Gardening experience'**
  String get fieldExperience;

  /// No description provided for @experienceBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get experienceBeginner;

  /// No description provided for @experienceIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Some experience'**
  String get experienceIntermediate;

  /// No description provided for @experienceExperienced.
  ///
  /// In en, this message translates to:
  /// **'Experienced'**
  String get experienceExperienced;

  /// No description provided for @fieldWeeklyTime.
  ///
  /// In en, this message translates to:
  /// **'Time per week'**
  String get fieldWeeklyTime;

  /// No description provided for @weeklyUnderOneHour.
  ///
  /// In en, this message translates to:
  /// **'Under 1 hour'**
  String get weeklyUnderOneHour;

  /// No description provided for @weeklyOneToThree.
  ///
  /// In en, this message translates to:
  /// **'1–3 hours'**
  String get weeklyOneToThree;

  /// No description provided for @weeklyMoreThanThree.
  ///
  /// In en, this message translates to:
  /// **'More than 3 hours'**
  String get weeklyMoreThanThree;

  /// No description provided for @fieldBudget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get fieldBudget;

  /// No description provided for @budgetLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get budgetLow;

  /// No description provided for @budgetMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get budgetMedium;

  /// No description provided for @budgetHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get budgetHigh;

  /// No description provided for @fieldNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get fieldNotes;

  /// No description provided for @fieldNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Anything worth remembering about this space'**
  String get fieldNotesHint;

  /// No description provided for @errNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Give your garden a name'**
  String get errNameRequired;

  /// No description provided for @errNameTooLong.
  ///
  /// In en, this message translates to:
  /// **'Use 60 characters or fewer'**
  String get errNameTooLong;

  /// No description provided for @errDimension.
  ///
  /// In en, this message translates to:
  /// **'Enter a size above 0 and up to 200 m (656 ft)'**
  String get errDimension;

  /// No description provided for @regionNorthIndia.
  ///
  /// In en, this message translates to:
  /// **'North India'**
  String get regionNorthIndia;

  /// No description provided for @regionSouthIndia.
  ///
  /// In en, this message translates to:
  /// **'South India'**
  String get regionSouthIndia;

  /// No description provided for @regionTelangana.
  ///
  /// In en, this message translates to:
  /// **'Telangana'**
  String get regionTelangana;

  /// No description provided for @regionTamilNadu.
  ///
  /// In en, this message translates to:
  /// **'Tamil Nadu'**
  String get regionTamilNadu;

  /// No description provided for @regionKerala.
  ///
  /// In en, this message translates to:
  /// **'Kerala'**
  String get regionKerala;

  /// No description provided for @gardensTitle.
  ///
  /// In en, this message translates to:
  /// **'Your gardens'**
  String get gardensTitle;

  /// No description provided for @gardenCreateAction.
  ///
  /// In en, this message translates to:
  /// **'Create your garden'**
  String get gardenCreateAction;

  /// No description provided for @gardenNew.
  ///
  /// In en, this message translates to:
  /// **'New garden'**
  String get gardenNew;

  /// No description provided for @gardenEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit garden'**
  String get gardenEditTitle;

  /// No description provided for @gardenSectionSpace.
  ///
  /// In en, this message translates to:
  /// **'Your space'**
  String get gardenSectionSpace;

  /// No description provided for @gardenSectionLight.
  ///
  /// In en, this message translates to:
  /// **'Light and weather'**
  String get gardenSectionLight;

  /// No description provided for @gardenSectionGoals.
  ///
  /// In en, this message translates to:
  /// **'Goals and style'**
  String get gardenSectionGoals;

  /// No description provided for @gardenSize.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get gardenSize;

  /// No description provided for @gardenArea.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get gardenArea;

  /// No description provided for @gardenSizeValue.
  ///
  /// In en, this message translates to:
  /// **'{length} × {width}'**
  String gardenSizeValue(String length, String width);

  /// No description provided for @gardenLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get gardenLocation;

  /// No description provided for @gardenRegion.
  ///
  /// In en, this message translates to:
  /// **'Growing region'**
  String get gardenRegion;

  /// No description provided for @gardenPhotos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get gardenPhotos;

  /// No description provided for @gardenPhotosEmpty.
  ///
  /// In en, this message translates to:
  /// **'Add photos of your space from a few angles. Photos are for your records; measurements always come from what you enter.'**
  String get gardenPhotosEmpty;

  /// No description provided for @gardenDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete garden'**
  String get gardenDelete;

  /// No description provided for @gardenDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete {name}?'**
  String gardenDeleteTitle(String name);

  /// No description provided for @gardenDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'This removes the garden, its photos and everything recorded for it. This can\'t be undone.'**
  String get gardenDeleteBody;

  /// No description provided for @gardenDeleted.
  ///
  /// In en, this message translates to:
  /// **'Garden deleted'**
  String get gardenDeleted;

  /// No description provided for @gardenSaved.
  ///
  /// In en, this message translates to:
  /// **'Garden saved'**
  String get gardenSaved;

  /// No description provided for @unsavedTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get unsavedTitle;

  /// No description provided for @unsavedBody.
  ///
  /// In en, this message translates to:
  /// **'Your changes to this garden haven\'t been saved.'**
  String get unsavedBody;

  /// No description provided for @unsavedDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get unsavedDiscard;

  /// No description provided for @moreActions.
  ///
  /// In en, this message translates to:
  /// **'More actions'**
  String get moreActions;

  /// No description provided for @photosTitle.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photosTitle;

  /// No description provided for @photoAdd.
  ///
  /// In en, this message translates to:
  /// **'Add photo'**
  String get photoAdd;

  /// No description provided for @photoTake.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get photoTake;

  /// No description provided for @photoChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get photoChoose;

  /// No description provided for @photoCaption.
  ///
  /// In en, this message translates to:
  /// **'Caption'**
  String get photoCaption;

  /// No description provided for @photoCaptionHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. View from the north corner'**
  String get photoCaptionHint;

  /// No description provided for @photoSetCover.
  ///
  /// In en, this message translates to:
  /// **'Use as cover'**
  String get photoSetCover;

  /// No description provided for @photoIsCover.
  ///
  /// In en, this message translates to:
  /// **'Cover photo'**
  String get photoIsCover;

  /// No description provided for @photoReplace.
  ///
  /// In en, this message translates to:
  /// **'Replace photo'**
  String get photoReplace;

  /// No description provided for @photoDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete photo'**
  String get photoDelete;

  /// No description provided for @photoDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'This photo will be removed from your garden.'**
  String get photoDeleteBody;

  /// No description provided for @photoCoverUpdated.
  ///
  /// In en, this message translates to:
  /// **'Cover photo updated'**
  String get photoCoverUpdated;

  /// No description provided for @photoMissing.
  ///
  /// In en, this message translates to:
  /// **'This photo is no longer on your device'**
  String get photoMissing;

  /// No description provided for @photoPermission.
  ///
  /// In en, this message translates to:
  /// **'Allow camera or photo access for Terrace Garden in your phone\'s settings, or choose a photo from your gallery instead.'**
  String get photoPermission;

  /// No description provided for @photoAdding.
  ///
  /// In en, this message translates to:
  /// **'Adding photo…'**
  String get photoAdding;

  /// No description provided for @photoCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No photos} =1{1 photo} other{{count} photos}}'**
  String photoCount(int count);

  /// No description provided for @checklistTitle.
  ///
  /// In en, this message translates to:
  /// **'Terrace care checklist'**
  String get checklistTitle;

  /// No description provided for @checklistSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Weight, drainage, waterproofing, monsoon and heat'**
  String get checklistSubtitle;

  /// No description provided for @checklistIntro.
  ///
  /// In en, this message translates to:
  /// **'Practical points for terraces and balconies. This is general guidance, not a structural assessment of your building.'**
  String get checklistIntro;

  /// No description provided for @checkLoadTitle.
  ///
  /// In en, this message translates to:
  /// **'Check the roof can take the weight'**
  String get checkLoadTitle;

  /// No description provided for @checkLoadBody.
  ///
  /// In en, this message translates to:
  /// **'Under the Indian loading code, a flat roof you can walk on is designed for about 150 kg per square metre of people and objects. Wet soil, pots and stored water add up quickly. Ask a structural engineer before adding raised beds, large planters or water tanks.'**
  String get checkLoadBody;

  /// No description provided for @checkLoadSources.
  ///
  /// In en, this message translates to:
  /// **'Sources: IS 875 (Part 2), Bureau of Indian Standards; ICAR Indian Horticulture'**
  String get checkLoadSources;

  /// No description provided for @checkWallsTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep heavy containers over walls'**
  String get checkWallsTitle;

  /// No description provided for @checkWallsBody.
  ///
  /// In en, this message translates to:
  /// **'Place grow bags and heavy pots where there is a wall underneath, not in the middle of an open span.'**
  String get checkWallsBody;

  /// No description provided for @checkWallsSources.
  ///
  /// In en, this message translates to:
  /// **'Source: Kerala Agricultural University'**
  String get checkWallsSources;

  /// No description provided for @checkDrainTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep water draining'**
  String get checkDrainTitle;

  /// No description provided for @checkDrainBody.
  ///
  /// In en, this message translates to:
  /// **'Every container needs drainage holes. Raise pots on bricks or pot feet so water runs away, empty saucers after watering, and keep the roof outlets clear.'**
  String get checkDrainBody;

  /// No description provided for @checkDrainSources.
  ///
  /// In en, this message translates to:
  /// **'Sources: University of Maryland Extension; Kerala Agricultural University'**
  String get checkDrainSources;

  /// No description provided for @checkWaterproofTitle.
  ///
  /// In en, this message translates to:
  /// **'Protect the waterproofing'**
  String get checkWaterproofTitle;

  /// No description provided for @checkWaterproofBody.
  ///
  /// In en, this message translates to:
  /// **'Make sure the roof is waterproofed with a root- and rot-resistant layer before planting. After each crop, shift bags and bricks slightly so no patch of roof stays permanently wet.'**
  String get checkWaterproofBody;

  /// No description provided for @checkWaterproofSources.
  ///
  /// In en, this message translates to:
  /// **'Sources: ICAR Indian Horticulture; Kerala Agricultural University'**
  String get checkWaterproofSources;

  /// No description provided for @checkMonsoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Prepare for the monsoon'**
  String get checkMonsoonTitle;

  /// No description provided for @checkMonsoonBody.
  ///
  /// In en, this message translates to:
  /// **'Overwatering is the most common cause of container plant loss. In very wet spells, move pots under cover, remove saucers, and check the soil before watering even after rain.'**
  String get checkMonsoonBody;

  /// No description provided for @checkMonsoonSources.
  ///
  /// In en, this message translates to:
  /// **'Sources: Royal Horticultural Society'**
  String get checkMonsoonSources;

  /// No description provided for @checkHeatTitle.
  ///
  /// In en, this message translates to:
  /// **'Protect plants from summer heat'**
  String get checkHeatTitle;

  /// No description provided for @checkHeatBody.
  ///
  /// In en, this message translates to:
  /// **'Small, dark and metal pots heat up and dry out fast, and south- and west-facing spots dry quickest. Group pots together, mulch the soil, and water early in the morning.'**
  String get checkHeatBody;

  /// No description provided for @checkHeatSources.
  ///
  /// In en, this message translates to:
  /// **'Sources: Royal Horticultural Society; University of Maryland Extension'**
  String get checkHeatSources;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @settingsUnits.
  ///
  /// In en, this message translates to:
  /// **'Measurement units'**
  String get settingsUnits;

  /// No description provided for @unitsMetric.
  ///
  /// In en, this message translates to:
  /// **'Metric (cm, m)'**
  String get unitsMetric;

  /// No description provided for @unitsImperial.
  ///
  /// In en, this message translates to:
  /// **'Imperial (in, ft)'**
  String get unitsImperial;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsLicences.
  ///
  /// In en, this message translates to:
  /// **'Open-source licences'**
  String get settingsLicences;

  /// No description provided for @settingsLicencesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fonts and software used in this app'**
  String get settingsLicencesSubtitle;

  /// No description provided for @imageCreditsTitle.
  ///
  /// In en, this message translates to:
  /// **'Image credits'**
  String get imageCreditsTitle;

  /// No description provided for @imageCreditsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Photographers and licences for the photos in this app'**
  String get imageCreditsSubtitle;

  /// No description provided for @imageCreditsBy.
  ///
  /// In en, this message translates to:
  /// **'Photo by {author}'**
  String imageCreditsBy(String author);

  /// No description provided for @errorGenericTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorGenericTitle;

  /// No description provided for @errorGenericBody.
  ///
  /// In en, this message translates to:
  /// **'Please try again. If it keeps happening, restart the app.'**
  String get errorGenericBody;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find that item. It may have been deleted.'**
  String get errorNotFound;

  /// No description provided for @errorStorage.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t save or read your data on this device.'**
  String get errorStorage;

  /// No description provided for @errorPermission.
  ///
  /// In en, this message translates to:
  /// **'Permission is needed to continue.'**
  String get errorPermission;

  /// No description provided for @actionRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get actionRetry;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get actionConfirm;

  /// No description provided for @actionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// No description provided for @actionOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get actionOpenSettings;

  /// No description provided for @loadingLabel.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loadingLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
