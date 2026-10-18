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

  /// No description provided for @designOpen.
  ///
  /// In en, this message translates to:
  /// **'Design your layout'**
  String get designOpen;

  /// No description provided for @designOpenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Arrange pots, grow bags and beds to scale'**
  String get designOpenSubtitle;

  /// No description provided for @layoutObjectCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 object in your layout} other{{count} objects in your layout}}'**
  String layoutObjectCount(int count);

  /// No description provided for @designerTitle.
  ///
  /// In en, this message translates to:
  /// **'Layout'**
  String get designerTitle;

  /// No description provided for @designerAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get designerAdd;

  /// No description provided for @designerUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get designerUndo;

  /// No description provided for @designerRedo.
  ///
  /// In en, this message translates to:
  /// **'Redo'**
  String get designerRedo;

  /// No description provided for @designerObjects.
  ///
  /// In en, this message translates to:
  /// **'Objects'**
  String get designerObjects;

  /// No description provided for @designerSummary.
  ///
  /// In en, this message translates to:
  /// **'Space summary'**
  String get designerSummary;

  /// No description provided for @designerSnap.
  ///
  /// In en, this message translates to:
  /// **'Snap'**
  String get designerSnap;

  /// No description provided for @designerFit.
  ///
  /// In en, this message translates to:
  /// **'Fit to screen'**
  String get designerFit;

  /// No description provided for @designerSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get designerSaved;

  /// No description provided for @designerSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get designerSaving;

  /// No description provided for @designerNotSaved.
  ///
  /// In en, this message translates to:
  /// **'Not saved yet'**
  String get designerNotSaved;

  /// No description provided for @designerSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save. Your changes are kept and will be saved again.'**
  String get designerSaveFailed;

  /// No description provided for @designerEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Tap Add to place pots, grow bags, beds and more.'**
  String get designerEmptyHint;

  /// No description provided for @designerNeedsSizeTitle.
  ///
  /// In en, this message translates to:
  /// **'Add your garden\'s size'**
  String get designerNeedsSizeTitle;

  /// No description provided for @designerNeedsSizeBody.
  ///
  /// In en, this message translates to:
  /// **'The layout uses real measurements, so it needs the length and width of the usable floor.'**
  String get designerNeedsSizeBody;

  /// No description provided for @designerStart.
  ///
  /// In en, this message translates to:
  /// **'Start designing'**
  String get designerStart;

  /// No description provided for @designerProblems.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 problem} other{{count} problems}}'**
  String designerProblems(int count);

  /// No description provided for @designerCanvasLabel.
  ///
  /// In en, this message translates to:
  /// **'Garden layout, {count, plural, =0{no objects} =1{1 object} other{{count} objects}}. Use the Objects list to review and edit them.'**
  String designerCanvasLabel(int count);

  /// No description provided for @issueOutOfBounds.
  ///
  /// In en, this message translates to:
  /// **'Outside the garden'**
  String get issueOutOfBounds;

  /// No description provided for @issueOverlap.
  ///
  /// In en, this message translates to:
  /// **'Overlaps another object'**
  String get issueOverlap;

  /// No description provided for @issueOnPath.
  ///
  /// In en, this message translates to:
  /// **'Standing on a path'**
  String get issueOnPath;

  /// No description provided for @paletteContainers.
  ///
  /// In en, this message translates to:
  /// **'Containers'**
  String get paletteContainers;

  /// No description provided for @paletteStructures.
  ///
  /// In en, this message translates to:
  /// **'Structures'**
  String get paletteStructures;

  /// No description provided for @paletteOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get paletteOther;

  /// No description provided for @kindRoundPot.
  ///
  /// In en, this message translates to:
  /// **'Round pot'**
  String get kindRoundPot;

  /// No description provided for @kindRectPlanter.
  ///
  /// In en, this message translates to:
  /// **'Planter box'**
  String get kindRectPlanter;

  /// No description provided for @kindGrowBag.
  ///
  /// In en, this message translates to:
  /// **'Grow bag'**
  String get kindGrowBag;

  /// No description provided for @kindRaisedBed.
  ///
  /// In en, this message translates to:
  /// **'Raised bed'**
  String get kindRaisedBed;

  /// No description provided for @kindVerticalPlanter.
  ///
  /// In en, this message translates to:
  /// **'Vertical planter'**
  String get kindVerticalPlanter;

  /// No description provided for @kindWall.
  ///
  /// In en, this message translates to:
  /// **'Wall'**
  String get kindWall;

  /// No description provided for @kindRailing.
  ///
  /// In en, this message translates to:
  /// **'Railing'**
  String get kindRailing;

  /// No description provided for @kindPath.
  ///
  /// In en, this message translates to:
  /// **'Path'**
  String get kindPath;

  /// No description provided for @kindWaterPoint.
  ///
  /// In en, this message translates to:
  /// **'Water tap'**
  String get kindWaterPoint;

  /// No description provided for @inspectorTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit object'**
  String get inspectorTitle;

  /// No description provided for @fieldDiameter.
  ///
  /// In en, this message translates to:
  /// **'Diameter'**
  String get fieldDiameter;

  /// No description provided for @fieldDepth.
  ///
  /// In en, this message translates to:
  /// **'Soil depth'**
  String get fieldDepth;

  /// No description provided for @fieldRotation.
  ///
  /// In en, this message translates to:
  /// **'Rotation'**
  String get fieldRotation;

  /// No description provided for @fieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Label (optional)'**
  String get fieldLabel;

  /// No description provided for @fieldLabelHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Tomatoes'**
  String get fieldLabelHint;

  /// No description provided for @degreesValue.
  ///
  /// In en, this message translates to:
  /// **'{degrees}°'**
  String degreesValue(int degrees);

  /// No description provided for @actionRotate.
  ///
  /// In en, this message translates to:
  /// **'Rotate 90°'**
  String get actionRotate;

  /// No description provided for @actionDuplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get actionDuplicate;

  /// No description provided for @actionDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get actionDone;

  /// No description provided for @unitCmShort.
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get unitCmShort;

  /// No description provided for @unitInShort.
  ///
  /// In en, this message translates to:
  /// **'in'**
  String get unitInShort;

  /// No description provided for @objectsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No objects yet'**
  String get objectsEmpty;

  /// No description provided for @summaryGardenArea.
  ///
  /// In en, this message translates to:
  /// **'Garden area'**
  String get summaryGardenArea;

  /// No description provided for @summaryContainerArea.
  ///
  /// In en, this message translates to:
  /// **'Covered by containers'**
  String get summaryContainerArea;

  /// No description provided for @summaryContainerShare.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of the floor'**
  String summaryContainerShare(int percent);

  /// No description provided for @summaryWalkway.
  ///
  /// In en, this message translates to:
  /// **'Paths'**
  String get summaryWalkway;

  /// No description provided for @summarySoil.
  ///
  /// In en, this message translates to:
  /// **'Soil needed'**
  String get summarySoil;

  /// No description provided for @summaryCounts.
  ///
  /// In en, this message translates to:
  /// **'Objects'**
  String get summaryCounts;

  /// No description provided for @summaryNote.
  ///
  /// In en, this message translates to:
  /// **'Soil is each container\'s footprint × the soil depth you entered. Fill grow bags to about three quarters (Kerala Agricultural University) and check the weight guidance in the terrace checklist.'**
  String get summaryNote;

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

  /// No description provided for @plantsTitle.
  ///
  /// In en, this message translates to:
  /// **'Plants'**
  String get plantsTitle;

  /// No description provided for @plantsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search, e.g. bhindi or tulsi'**
  String get plantsSearchHint;

  /// No description provided for @plantsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get plantsFilterAll;

  /// No description provided for @categoryVegetable.
  ///
  /// In en, this message translates to:
  /// **'Vegetables'**
  String get categoryVegetable;

  /// No description provided for @categoryLeafyGreen.
  ///
  /// In en, this message translates to:
  /// **'Leafy greens'**
  String get categoryLeafyGreen;

  /// No description provided for @categoryHerb.
  ///
  /// In en, this message translates to:
  /// **'Herbs'**
  String get categoryHerb;

  /// No description provided for @categoryClimber.
  ///
  /// In en, this message translates to:
  /// **'Climbers'**
  String get categoryClimber;

  /// No description provided for @categoryFlower.
  ///
  /// In en, this message translates to:
  /// **'Flowers'**
  String get categoryFlower;

  /// No description provided for @categoryOrnamental.
  ///
  /// In en, this message translates to:
  /// **'Ornamentals'**
  String get categoryOrnamental;

  /// No description provided for @plantsNoResults.
  ///
  /// In en, this message translates to:
  /// **'No plants match your search'**
  String get plantsNoResults;

  /// No description provided for @plantsNoResultsBody.
  ///
  /// In en, this message translates to:
  /// **'Try a common name, a local name or a different category.'**
  String get plantsNoResultsBody;

  /// No description provided for @plantsCatalogueNote.
  ///
  /// In en, this message translates to:
  /// **'Every fact is linked to its source. Anything not documented is shown as such, never guessed.'**
  String get plantsCatalogueNote;

  /// No description provided for @plantsIdeasFor.
  ///
  /// In en, this message translates to:
  /// **'Ideas for {garden}'**
  String plantsIdeasFor(String garden);

  /// No description provided for @plantsIdeasSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ranked for your space, season and containers'**
  String get plantsIdeasSubtitle;

  /// No description provided for @lifecycleAnnual.
  ///
  /// In en, this message translates to:
  /// **'Annual'**
  String get lifecycleAnnual;

  /// No description provided for @lifecyclePerennial.
  ///
  /// In en, this message translates to:
  /// **'Perennial'**
  String get lifecyclePerennial;

  /// No description provided for @dataStatusVerified.
  ///
  /// In en, this message translates to:
  /// **'Well sourced'**
  String get dataStatusVerified;

  /// No description provided for @dataStatusPartial.
  ///
  /// In en, this message translates to:
  /// **'Partly documented'**
  String get dataStatusPartial;

  /// No description provided for @dataStatusUnverified.
  ///
  /// In en, this message translates to:
  /// **'Few sourced facts'**
  String get dataStatusUnverified;

  /// No description provided for @notDocumented.
  ///
  /// In en, this message translates to:
  /// **'Not documented'**
  String get notDocumented;

  /// No description provided for @plantSectionSun.
  ///
  /// In en, this message translates to:
  /// **'Sunlight'**
  String get plantSectionSun;

  /// No description provided for @sunFull.
  ///
  /// In en, this message translates to:
  /// **'Full sun'**
  String get sunFull;

  /// No description provided for @sunFullHours.
  ///
  /// In en, this message translates to:
  /// **'Full sun, at least {hours} hours a day'**
  String sunFullHours(int hours);

  /// No description provided for @sunPartial.
  ///
  /// In en, this message translates to:
  /// **'Tolerates partial shade'**
  String get sunPartial;

  /// No description provided for @sunPartialHours.
  ///
  /// In en, this message translates to:
  /// **'Sun or partial shade, at least {hours} hours of direct sun'**
  String sunPartialHours(int hours);

  /// No description provided for @sunIndirect.
  ///
  /// In en, this message translates to:
  /// **'Bright indirect light'**
  String get sunIndirect;

  /// No description provided for @plantSectionContainer.
  ///
  /// In en, this message translates to:
  /// **'Container'**
  String get plantSectionContainer;

  /// No description provided for @containerMinSoil.
  ///
  /// In en, this message translates to:
  /// **'Minimum soil'**
  String get containerMinSoil;

  /// No description provided for @containerRecommendedSoil.
  ///
  /// In en, this message translates to:
  /// **'Recommended soil'**
  String get containerRecommendedSoil;

  /// No description provided for @containerMinDepth.
  ///
  /// In en, this message translates to:
  /// **'Minimum depth'**
  String get containerMinDepth;

  /// No description provided for @containerRecommendedDepth.
  ///
  /// In en, this message translates to:
  /// **'Recommended depth'**
  String get containerRecommendedDepth;

  /// No description provided for @containerPlantsPer.
  ///
  /// In en, this message translates to:
  /// **'Plants per minimum container'**
  String get containerPlantsPer;

  /// No description provided for @evidenceVerified.
  ///
  /// In en, this message translates to:
  /// **'Sourced'**
  String get evidenceVerified;

  /// No description provided for @evidenceProxy.
  ///
  /// In en, this message translates to:
  /// **'Based on a similar crop'**
  String get evidenceProxy;

  /// No description provided for @evidenceUnverified.
  ///
  /// In en, this message translates to:
  /// **'Size not documented'**
  String get evidenceUnverified;

  /// No description provided for @plantSectionHarvest.
  ///
  /// In en, this message translates to:
  /// **'Time to first harvest'**
  String get plantSectionHarvest;

  /// No description provided for @harvestDays.
  ///
  /// In en, this message translates to:
  /// **'{min}–{max} days'**
  String harvestDays(int min, int max);

  /// No description provided for @harvestDaysSingle.
  ///
  /// In en, this message translates to:
  /// **'About {days} days'**
  String harvestDaysSingle(int days);

  /// No description provided for @plantSectionSowing.
  ///
  /// In en, this message translates to:
  /// **'Sowing or planting months'**
  String get plantSectionSowing;

  /// No description provided for @sowingYearRound.
  ///
  /// In en, this message translates to:
  /// **'All year'**
  String get sowingYearRound;

  /// No description provided for @sowingFallback.
  ///
  /// In en, this message translates to:
  /// **'No {state} table for this plant; showing {region} months.'**
  String sowingFallback(String state, String region);

  /// No description provided for @sowingNone.
  ///
  /// In en, this message translates to:
  /// **'No sourced sowing calendar for this plant.'**
  String get sowingNone;

  /// No description provided for @plantSectionPropagation.
  ///
  /// In en, this message translates to:
  /// **'How to start'**
  String get plantSectionPropagation;

  /// No description provided for @propagationTransplant.
  ///
  /// In en, this message translates to:
  /// **'Raise seedlings, then transplant'**
  String get propagationTransplant;

  /// No description provided for @propagationDirect.
  ///
  /// In en, this message translates to:
  /// **'Sow directly in the container'**
  String get propagationDirect;

  /// No description provided for @propagationSeed.
  ///
  /// In en, this message translates to:
  /// **'From seed'**
  String get propagationSeed;

  /// No description provided for @propagationDivision.
  ///
  /// In en, this message translates to:
  /// **'By dividing a clump'**
  String get propagationDivision;

  /// No description provided for @propagationCutting.
  ///
  /// In en, this message translates to:
  /// **'From cuttings'**
  String get propagationCutting;

  /// No description provided for @propagationNursery.
  ///
  /// In en, this message translates to:
  /// **'Transplant after {min}–{max} days in a nursery tray'**
  String propagationNursery(int min, int max);

  /// No description provided for @plantSectionCare.
  ///
  /// In en, this message translates to:
  /// **'Care notes'**
  String get plantSectionCare;

  /// No description provided for @plantSectionPets.
  ///
  /// In en, this message translates to:
  /// **'Pets'**
  String get plantSectionPets;

  /// No description provided for @petToxic.
  ///
  /// In en, this message translates to:
  /// **'Toxic to pets'**
  String get petToxic;

  /// No description provided for @petNonToxic.
  ///
  /// In en, this message translates to:
  /// **'Listed as non-toxic to pets'**
  String get petNonToxic;

  /// No description provided for @petNotAssessed.
  ///
  /// In en, this message translates to:
  /// **'Not assessed'**
  String get petNotAssessed;

  /// No description provided for @petScopeNote.
  ///
  /// In en, this message translates to:
  /// **'Pet data is from the ASPCA and does not cover children. If a person or pet eats a plant, contact a doctor or vet.'**
  String get petScopeNote;

  /// No description provided for @plantSectionSources.
  ///
  /// In en, this message translates to:
  /// **'Sources'**
  String get plantSectionSources;

  /// No description provided for @plantSourcesNote.
  ///
  /// In en, this message translates to:
  /// **'Facts are summarised from these publications.'**
  String get plantSourcesNote;

  /// No description provided for @plantAddToGarden.
  ///
  /// In en, this message translates to:
  /// **'Add to a garden'**
  String get plantAddToGarden;

  /// No description provided for @plantNotFound.
  ///
  /// In en, this message translates to:
  /// **'This plant is no longer in the catalogue.'**
  String get plantNotFound;

  /// No description provided for @recTitle.
  ///
  /// In en, this message translates to:
  /// **'Plant ideas'**
  String get recTitle;

  /// No description provided for @recSubtitle.
  ///
  /// In en, this message translates to:
  /// **'For {garden} in {month}'**
  String recSubtitle(String garden, String month);

  /// No description provided for @recDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Ranked from your garden profile and sourced plant data. A starting point, not a promise of success.'**
  String get recDisclaimer;

  /// No description provided for @recCompleteProfile.
  ///
  /// In en, this message translates to:
  /// **'Add your sun hours and city to sharpen these ideas.'**
  String get recCompleteProfile;

  /// No description provided for @recGroupGoodNow.
  ///
  /// In en, this message translates to:
  /// **'Good choices now'**
  String get recGroupGoodNow;

  /// No description provided for @recGroupLater.
  ///
  /// In en, this message translates to:
  /// **'Good fit, sow later'**
  String get recGroupLater;

  /// No description provided for @recGroupNotSuited.
  ///
  /// In en, this message translates to:
  /// **'Not a good fit here'**
  String get recGroupNotSuited;

  /// No description provided for @recSunMatches.
  ///
  /// In en, this message translates to:
  /// **'Light suits your space'**
  String get recSunMatches;

  /// No description provided for @recSunNeedsMore.
  ///
  /// In en, this message translates to:
  /// **'Needs 6+ hours of sun; your space gets 3–6'**
  String get recSunNeedsMore;

  /// No description provided for @recSunTooShady.
  ///
  /// In en, this message translates to:
  /// **'Your space gets under 3 hours of sun'**
  String get recSunTooShady;

  /// No description provided for @recSunPrefersIndirect.
  ///
  /// In en, this message translates to:
  /// **'Prefers bright indirect light to strong sun'**
  String get recSunPrefersIndirect;

  /// No description provided for @recSunGardenUnknown.
  ///
  /// In en, this message translates to:
  /// **'Add your sun hours to check light'**
  String get recSunGardenUnknown;

  /// No description provided for @recSunSpeciesUnknown.
  ///
  /// In en, this message translates to:
  /// **'Light needs not documented'**
  String get recSunSpeciesUnknown;

  /// No description provided for @recSowNow.
  ///
  /// In en, this message translates to:
  /// **'Sow now'**
  String get recSowNow;

  /// No description provided for @recSowSoon.
  ///
  /// In en, this message translates to:
  /// **'Sow from {month}'**
  String recSowSoon(String month);

  /// No description provided for @recSowLater.
  ///
  /// In en, this message translates to:
  /// **'Next sowing: {month}'**
  String recSowLater(String month);

  /// No description provided for @recNoRegion.
  ///
  /// In en, this message translates to:
  /// **'No sourced sowing calendar for your city yet'**
  String get recNoRegion;

  /// No description provided for @recNoSeasonData.
  ///
  /// In en, this message translates to:
  /// **'No sowing data for your region'**
  String get recNoSeasonData;

  /// No description provided for @recContainerFits.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 of your containers is big enough} other{{count} of your containers are big enough}}'**
  String recContainerFits(int count);

  /// No description provided for @recContainerTooSmall.
  ///
  /// In en, this message translates to:
  /// **'None of your containers is big enough yet'**
  String get recContainerTooSmall;

  /// No description provided for @recNoContainers.
  ///
  /// In en, this message translates to:
  /// **'Add containers in the designer to check size'**
  String get recNoContainers;

  /// No description provided for @recContainerUnknown.
  ///
  /// In en, this message translates to:
  /// **'Container size not documented'**
  String get recContainerUnknown;

  /// No description provided for @recGoalMatch.
  ///
  /// In en, this message translates to:
  /// **'Matches your goals'**
  String get recGoalMatch;

  /// No description provided for @caveatContainerProxy.
  ///
  /// In en, this message translates to:
  /// **'Container size from a similar crop'**
  String get caveatContainerProxy;

  /// No description provided for @caveatRegionFallback.
  ///
  /// In en, this message translates to:
  /// **'Uses broader regional sowing data'**
  String get caveatRegionFallback;

  /// No description provided for @caveatPetToxic.
  ///
  /// In en, this message translates to:
  /// **'Toxic to pets'**
  String get caveatPetToxic;

  /// No description provided for @caveatIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Some details not documented'**
  String get caveatIncomplete;

  /// No description provided for @recShortlistAdd.
  ///
  /// In en, this message translates to:
  /// **'Save to shortlist'**
  String get recShortlistAdd;

  /// No description provided for @recShortlistRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove from shortlist'**
  String get recShortlistRemove;

  /// No description provided for @recShortlistOnly.
  ///
  /// In en, this message translates to:
  /// **'Shortlist'**
  String get recShortlistOnly;

  /// No description provided for @recShortlistEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing shortlisted yet. Tap the bookmark on any idea to save it.'**
  String get recShortlistEmpty;

  /// No description provided for @plantingAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add {plant}'**
  String plantingAddTitle(String plant);

  /// No description provided for @plantingEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit {plant}'**
  String plantingEditTitle(String plant);

  /// No description provided for @plantingGarden.
  ///
  /// In en, this message translates to:
  /// **'Garden'**
  String get plantingGarden;

  /// No description provided for @plantingContainer.
  ///
  /// In en, this message translates to:
  /// **'Container'**
  String get plantingContainer;

  /// No description provided for @plantingNotPlaced.
  ///
  /// In en, this message translates to:
  /// **'Not placed yet'**
  String get plantingNotPlaced;

  /// No description provided for @plantingQuantity.
  ///
  /// In en, this message translates to:
  /// **'Number of plants'**
  String get plantingQuantity;

  /// No description provided for @plantingPlantedOn.
  ///
  /// In en, this message translates to:
  /// **'Planted on'**
  String get plantingPlantedOn;

  /// No description provided for @plantingStartedFrom.
  ///
  /// In en, this message translates to:
  /// **'Started from'**
  String get plantingStartedFrom;

  /// No description provided for @startSeed.
  ///
  /// In en, this message translates to:
  /// **'Seed'**
  String get startSeed;

  /// No description provided for @startSeedling.
  ///
  /// In en, this message translates to:
  /// **'Seedling'**
  String get startSeedling;

  /// No description provided for @startCutting.
  ///
  /// In en, this message translates to:
  /// **'Cutting'**
  String get startCutting;

  /// No description provided for @startPlant.
  ///
  /// In en, this message translates to:
  /// **'Grown plant'**
  String get startPlant;

  /// No description provided for @plantingNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get plantingNotes;

  /// No description provided for @plantingSave.
  ///
  /// In en, this message translates to:
  /// **'Add planting'**
  String get plantingSave;

  /// No description provided for @plantingUpdate.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get plantingUpdate;

  /// No description provided for @plantingAdded.
  ///
  /// In en, this message translates to:
  /// **'{plant} added to {garden}'**
  String plantingAdded(String plant, String garden);

  /// No description provided for @plantingNoGardens.
  ///
  /// In en, this message translates to:
  /// **'Create a garden first, then add plants to it.'**
  String get plantingNoGardens;

  /// No description provided for @plantingIssueLowVolume.
  ///
  /// In en, this message translates to:
  /// **'This container holds about {actual}; this plant needs at least {required}.'**
  String plantingIssueLowVolume(String actual, String required);

  /// No description provided for @plantingIssueShallow.
  ///
  /// In en, this message translates to:
  /// **'This container is {actual} deep; this plant needs at least {required}.'**
  String plantingIssueShallow(String actual, String required);

  /// No description provided for @plantingIssueCrowded.
  ///
  /// In en, this message translates to:
  /// **'Rough guide: about {capacity} of these plants fit this container (scaled from the source\'s per-container figure).'**
  String plantingIssueCrowded(int capacity);

  /// No description provided for @plantingIssueShared.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 other planting already uses this container.} other{{count} other plantings already use this container.}}'**
  String plantingIssueShared(int count);

  /// No description provided for @plantingIssueNoDepth.
  ///
  /// In en, this message translates to:
  /// **'Set this container\'s soil depth in the designer to check its size.'**
  String get plantingIssueNoDepth;

  /// No description provided for @quantityDecrease.
  ///
  /// In en, this message translates to:
  /// **'Fewer'**
  String get quantityDecrease;

  /// No description provided for @quantityIncrease.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get quantityIncrease;

  /// No description provided for @myPlantsTitle.
  ///
  /// In en, this message translates to:
  /// **'My plants'**
  String get myPlantsTitle;

  /// No description provided for @myPlantsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No plants yet. Find ideas that suit this space.'**
  String get myPlantsEmpty;

  /// No description provided for @plantingSummary.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 plant} other{{count} plants}} · since {date}'**
  String plantingSummary(int count, String date);

  /// No description provided for @plantingContainerMissing.
  ///
  /// In en, this message translates to:
  /// **'Its container was removed from the layout'**
  String get plantingContainerMissing;

  /// No description provided for @plantingRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove planting'**
  String get plantingRemove;

  /// No description provided for @plantingRemoveTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove {plant}?'**
  String plantingRemoveTitle(String plant);

  /// No description provided for @plantingRemoveBody.
  ///
  /// In en, this message translates to:
  /// **'This removes the planting from this garden.'**
  String get plantingRemoveBody;

  /// No description provided for @plantingRemoved.
  ///
  /// In en, this message translates to:
  /// **'Planting removed'**
  String get plantingRemoved;

  /// No description provided for @plantingUnknownSpecies.
  ///
  /// In en, this message translates to:
  /// **'Unknown plant'**
  String get plantingUnknownSpecies;

  /// No description provided for @digestTitle.
  ///
  /// In en, this message translates to:
  /// **'Your garden today'**
  String get digestTitle;

  /// No description provided for @digestBody.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 care task is due. Check the soil before you water.} other{{count} care tasks are due. Check the soil before you water.}}'**
  String digestBody(int count);

  /// No description provided for @taskCheckSoil.
  ///
  /// In en, this message translates to:
  /// **'Check the soil'**
  String get taskCheckSoil;

  /// No description provided for @taskInspectPests.
  ///
  /// In en, this message translates to:
  /// **'Look for pests'**
  String get taskInspectPests;

  /// No description provided for @taskFeed.
  ///
  /// In en, this message translates to:
  /// **'Feed'**
  String get taskFeed;

  /// No description provided for @taskTransplant.
  ///
  /// In en, this message translates to:
  /// **'Transplant seedlings'**
  String get taskTransplant;

  /// No description provided for @taskHarvest.
  ///
  /// In en, this message translates to:
  /// **'Harvest may start'**
  String get taskHarvest;

  /// No description provided for @taskPrune.
  ///
  /// In en, this message translates to:
  /// **'Prune'**
  String get taskPrune;

  /// No description provided for @guideCheckSoil.
  ///
  /// In en, this message translates to:
  /// **'Push a finger 2–3 cm into the soil, or about a third of the way down the pot. Water only if it feels dry, then water slowly until it drains from the bottom. Early morning is best; water the base, not the leaves.'**
  String get guideCheckSoil;

  /// No description provided for @guideCheckSoilDry.
  ///
  /// In en, this message translates to:
  /// **'This plant should dry out between waterings (succulents completely). Check the soil and water only when it is dry; overwatering is the main risk.'**
  String get guideCheckSoilDry;

  /// No description provided for @guideCheckSoilMoist.
  ///
  /// In en, this message translates to:
  /// **'Don\'t let this plant\'s soil dry out. Check it and water if it is getting dry.'**
  String get guideCheckSoilMoist;

  /// No description provided for @guideInspectPests.
  ///
  /// In en, this message translates to:
  /// **'Look under leaves and on new growth for aphids, mites and whitefly; aphids gather on the upwind side. Wash pests off with a strong jet of water early in the day. Avoid broad-spectrum sprays: they can make mites worse.'**
  String get guideInspectPests;

  /// No description provided for @guideFeed.
  ///
  /// In en, this message translates to:
  /// **'Feed every 2–4 weeks while the plant is growing, onto moist soil, at the amount on the product label. Feed less if plants turn tall and spindly or leaf edges look burnt.'**
  String get guideFeed;

  /// No description provided for @guideTransplant.
  ///
  /// In en, this message translates to:
  /// **'Seedlings raised in trays are moved to their final container about 25–30 days after sowing; most vegetables are ready at 2–3 true leaves.'**
  String get guideTransplant;

  /// No description provided for @guideHarvest.
  ///
  /// In en, this message translates to:
  /// **'By the sourced timeline this crop may be ready to start harvesting. Timing varies with variety and season and is counted from sowing, so plants started as seedlings may be ready sooner.'**
  String get guideHarvest;

  /// No description provided for @guidePrune.
  ///
  /// In en, this message translates to:
  /// **'In Tamil Nadu, jasmine (Jasminum sambac) is cut back to about 50 cm in the last week of November.'**
  String get guidePrune;

  /// No description provided for @guideSources.
  ///
  /// In en, this message translates to:
  /// **'Sources: {publishers}'**
  String guideSources(String publishers);

  /// No description provided for @todayOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get todayOverdue;

  /// No description provided for @todayDueToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayDueToday;

  /// No description provided for @todayUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Coming up'**
  String get todayUpcoming;

  /// No description provided for @todayDoneToday.
  ///
  /// In en, this message translates to:
  /// **'Done today'**
  String get todayDoneToday;

  /// No description provided for @todayAllDone.
  ///
  /// In en, this message translates to:
  /// **'All done for today'**
  String get todayAllDone;

  /// No description provided for @todayAllDoneBody.
  ///
  /// In en, this message translates to:
  /// **'Nothing else is due today. Upcoming tasks are below.'**
  String get todayAllDoneBody;

  /// No description provided for @todayTasksDue.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No tasks due today} =1{1 task due today} other{{count} tasks due today}}'**
  String todayTasksDue(int count);

  /// No description provided for @taskMarkAllDone.
  ///
  /// In en, this message translates to:
  /// **'Mark all done'**
  String get taskMarkAllDone;

  /// No description provided for @taskDone.
  ///
  /// In en, this message translates to:
  /// **'Mark done'**
  String get taskDone;

  /// No description provided for @taskSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get taskSkip;

  /// No description provided for @taskMoveTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Move to tomorrow'**
  String get taskMoveTomorrow;

  /// No description provided for @taskPickDate.
  ///
  /// In en, this message translates to:
  /// **'Choose another date'**
  String get taskPickDate;

  /// No description provided for @taskHowTo.
  ///
  /// In en, this message translates to:
  /// **'How to'**
  String get taskHowTo;

  /// No description provided for @taskActions.
  ///
  /// In en, this message translates to:
  /// **'Task options'**
  String get taskActions;

  /// No description provided for @taskDueOn.
  ///
  /// In en, this message translates to:
  /// **'Due {date}'**
  String taskDueOn(String date);

  /// No description provided for @skipReasonTitle.
  ///
  /// In en, this message translates to:
  /// **'Why skip it?'**
  String get skipReasonTitle;

  /// No description provided for @skipRained.
  ///
  /// In en, this message translates to:
  /// **'It rained'**
  String get skipRained;

  /// No description provided for @skipSoilMoist.
  ///
  /// In en, this message translates to:
  /// **'Soil is still moist'**
  String get skipSoilMoist;

  /// No description provided for @skipNotNeeded.
  ///
  /// In en, this message translates to:
  /// **'Not needed'**
  String get skipNotNeeded;

  /// No description provided for @skipOther.
  ///
  /// In en, this message translates to:
  /// **'Another reason'**
  String get skipOther;

  /// No description provided for @taskCompleted.
  ///
  /// In en, this message translates to:
  /// **'Marked done'**
  String get taskCompleted;

  /// No description provided for @taskSkipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get taskSkipped;

  /// No description provided for @taskMoved.
  ///
  /// In en, this message translates to:
  /// **'Moved to {date}'**
  String taskMoved(String date);

  /// No description provided for @carePlan.
  ///
  /// In en, this message translates to:
  /// **'Care plan'**
  String get carePlan;

  /// No description provided for @carePlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Care plan: {plant}'**
  String carePlanTitle(String plant);

  /// No description provided for @carePlanAfterDone.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{Every day after the last one is done} other{Every {days} days after the last one is done}}'**
  String carePlanAfterDone(int days);

  /// No description provided for @carePlanEvery.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{Every day} other{Every {days} days}}'**
  String carePlanEvery(int days);

  /// No description provided for @carePlanWeekly.
  ///
  /// In en, this message translates to:
  /// **'Every week'**
  String get carePlanWeekly;

  /// No description provided for @carePlanOnce.
  ///
  /// In en, this message translates to:
  /// **'Once, on {date}'**
  String carePlanOnce(String date);

  /// No description provided for @carePlanYearly.
  ///
  /// In en, this message translates to:
  /// **'Every year on {date}'**
  String carePlanYearly(String date);

  /// No description provided for @carePlanNote.
  ///
  /// In en, this message translates to:
  /// **'Defaults come from the sources in each task\'s guide. Adjust them to your plants and weather; the soil check always comes first.'**
  String get carePlanNote;

  /// No description provided for @carePlanEmpty.
  ///
  /// In en, this message translates to:
  /// **'The care plan appears a moment after the plant is added.'**
  String get carePlanEmpty;

  /// No description provided for @intervalShorter.
  ///
  /// In en, this message translates to:
  /// **'Shorter interval'**
  String get intervalShorter;

  /// No description provided for @intervalLonger.
  ///
  /// In en, this message translates to:
  /// **'Longer interval'**
  String get intervalLonger;

  /// No description provided for @settingsReminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get settingsReminders;

  /// No description provided for @reminderDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily care digest'**
  String get reminderDaily;

  /// No description provided for @reminderDailySubtitle.
  ///
  /// In en, this message translates to:
  /// **'One notification at {time} on days with tasks'**
  String reminderDailySubtitle(String time);

  /// No description provided for @reminderTime.
  ///
  /// In en, this message translates to:
  /// **'Reminder time'**
  String get reminderTime;

  /// No description provided for @reminderPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Notifications are turned off for this app. You can allow them in the system settings.'**
  String get reminderPermissionDenied;

  /// No description provided for @reminderNote.
  ///
  /// In en, this message translates to:
  /// **'Reminders can arrive a few minutes late. The Today screen is always up to date.'**
  String get reminderNote;
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
