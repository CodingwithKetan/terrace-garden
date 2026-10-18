import 'package:drift/drift.dart';
import 'package:terrace_garden/features/garden/data/garden_tables.dart';
import 'package:terrace_garden/features/journal/domain/journal_entry.dart';
import 'package:terrace_garden/features/plantings/data/planting_tables.dart';

/// Journal entries are deleted with their garden. Removing a planting keeps
/// its entries (history) and clears the link.
@DataClassName('JournalEntryRow')
class JournalEntries extends Table {
  TextColumn get id => text()();
  TextColumn get gardenId =>
      text().references(Gardens, #id, onDelete: KeyAction.cascade)();
  TextColumn get plantingId => text().nullable().references(
    Plantings,
    #id,
    onDelete: KeyAction.setNull,
  )();

  /// `yyyy-MM-dd`.
  TextColumn get date => text()();
  TextColumn get note => text().nullable()();
  TextColumn get milestone => textEnum<Milestone>().nullable()();
  RealColumn get harvestQuantity => real().nullable()();
  TextColumn get harvestUnit => textEnum<HarvestUnit>().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Photo metadata for journal entries; files live on disk (ADR-007).
@DataClassName('JournalPhotoRow')
class JournalPhotos extends Table {
  TextColumn get id => text()();
  TextColumn get entryId =>
      text().references(JournalEntries, #id, onDelete: KeyAction.cascade)();
  TextColumn get relativePath => text()();
  TextColumn get thumbnailPath => text()();
  IntColumn get position => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
