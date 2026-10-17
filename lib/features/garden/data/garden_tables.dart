import 'package:drift/drift.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';

/// Enum columns store the enum's `name`. Renaming an enum value therefore
/// needs a data migration; adding values is safe.
@DataClassName('GardenRow')
class Gardens extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 60)();
  TextColumn get spaceType => textEnum<SpaceType>()();
  TextColumn get cityName => text().nullable()();
  TextColumn get region => textEnum<GrowingRegion>().nullable()();
  RealColumn get lengthCm => real().nullable()();
  RealColumn get widthCm => real().nullable()();
  TextColumn get sun => textEnum<SunExposure>()();
  TextColumn get facing => textEnum<Facing>()();
  TextColumn get wind => textEnum<WindExposure>()();
  TextColumn get water => textEnum<WaterAccess>()();

  /// Comma-separated `GardenGoal` names (a small, closed set).
  TextColumn get goals => text().withDefault(const Constant(''))();
  TextColumn get style => textEnum<GardenStyle>().nullable()();
  TextColumn get experience => textEnum<ExperienceLevel>().nullable()();
  TextColumn get weeklyTime => textEnum<WeeklyTime>()();
  TextColumn get budget => textEnum<BudgetBand>()();
  TextColumn get coverPhotoId => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Photo metadata; image files live on disk (ADR-007). Rows are deleted with
/// their garden; files are removed by the application layer afterwards.
@DataClassName('GardenPhotoRow')
class GardenPhotos extends Table {
  TextColumn get id => text()();
  TextColumn get gardenId =>
      text().references(Gardens, #id, onDelete: KeyAction.cascade)();

  /// Paths relative to the app documents directory.
  TextColumn get relativePath => text()();
  TextColumn get thumbnailPath => text()();
  TextColumn get caption => text().nullable()();
  IntColumn get width => integer()();
  IntColumn get height => integer()();
  DateTimeColumn get takenAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
