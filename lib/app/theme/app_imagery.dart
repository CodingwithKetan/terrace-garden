/// Bundled photography. Every file is listed with its licence in
/// assets/images/ATTRIBUTION.md and credited in the app via [photoCredits].
abstract final class AppPhotos {
  static const _dir = 'assets/images/photos';

  static const todayTerrace = '$_dir/today_terrace.jpg';
  static const gardenTerrace = '$_dir/garden_terrace.jpg';
  static const plantsTerrace = '$_dir/plants_terrace.jpg';
  static const journalTerrace = '$_dir/journal_terrace.jpg';
}

/// Credit for a bundled photo, shown on the image credits screen.
class PhotoCredit {
  const PhotoCredit({
    required this.asset,
    required this.title,
    required this.author,
    required this.licence,
    required this.source,
  });

  final String asset;
  final String title;
  final String author;
  final String licence;
  final String source;
}

const _rooftopAuthor = 'Suresh Khole';
const _rooftopLicence = 'CC BY-SA 4.0 (cropped)';
const _commons = 'https://commons.wikimedia.org/wiki/File:';

/// Keep in sync with assets/images/ATTRIBUTION.md.
const photoCredits = [
  PhotoCredit(
    asset: AppPhotos.todayTerrace,
    title: 'Roof Top Garden 12',
    author: _rooftopAuthor,
    licence: _rooftopLicence,
    source: '${_commons}Roof_Top_Garden_12.jpg',
  ),
  PhotoCredit(
    asset: AppPhotos.gardenTerrace,
    title: 'Roof Top Garden 14',
    author: _rooftopAuthor,
    licence: _rooftopLicence,
    source: '${_commons}Roof_Top_Garden_14.jpg',
  ),
  PhotoCredit(
    asset: AppPhotos.plantsTerrace,
    title: 'Roof Top Garden 04',
    author: _rooftopAuthor,
    licence: _rooftopLicence,
    source: '${_commons}Roof_Top_Garden_04.jpg',
  ),
  PhotoCredit(
    asset: AppPhotos.journalTerrace,
    title: 'Roof Top Garden 15',
    author: _rooftopAuthor,
    licence: _rooftopLicence,
    source: '${_commons}Roof_Top_Garden_15.jpg',
  ),
];
