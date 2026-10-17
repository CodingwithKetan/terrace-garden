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
      'Garden setup is coming in the next update. You\'ll describe your space, add photos and arrange pots and grow bags to scale.';

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
  String settingsVersion(String version) {
    return 'Version $version';
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
