import 'package:drift/drift.dart';
import 'package:terrace_garden/features/garden/data/garden_tables.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';

/// Plantings are deleted with their garden. `elementId` is deliberately not
/// a foreign key: saving a layout replaces its element rows, which
/// would otherwise cascade into plantings.
@DataClassName('PlantingRow')
class Plantings extends Table {
  TextColumn get id => text()();
  TextColumn get gardenId =>
      text().references(Gardens, #id, onDelete: KeyAction.cascade)();
  TextColumn get speciesId => text()();
  TextColumn get elementId => text().nullable()();
  IntColumn get quantity => integer()();

  /// `yyyy-MM-dd` (a calendar date, not an instant).
  TextColumn get plantedOn => text()();
  TextColumn get startedFrom => textEnum<PlantingStart>()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ShortlistRow')
class ShortlistEntries extends Table {
  TextColumn get gardenId =>
      text().references(Gardens, #id, onDelete: KeyAction.cascade)();
  TextColumn get speciesId => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {gardenId, speciesId};
}
