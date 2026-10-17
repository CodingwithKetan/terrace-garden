import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:terrace_garden/core/database/app_database.steps.dart';
import 'package:terrace_garden/features/garden/data/garden_tables.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';

part 'app_database.g.dart';

/// The single local database for all domain data (ADR-005).
///
/// It is the composition point for feature tables, so it imports each
/// feature's `data` tables. Each schema change bumps [schemaVersion], adds a
/// step to [migration], and is snapshotted with
/// `dart run drift_dev make-migrations` (schemas in `drift_schemas/`,
/// generated tests in `test/drift/`).
@DriftDatabase(tables: [Gardens, GardenPhotos])
class AppDatabase extends _$AppDatabase {
  /// Use [AppDatabase.open] in the app; tests pass an in-memory executor.
  AppDatabase(super.e);

  factory AppDatabase.open() =>
      AppDatabase(driftDatabase(name: 'terrace_garden'));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        await m.createTable(schema.gardens);
        await m.createTable(schema.gardenPhotos);
      },
    ),
    beforeOpen: (details) async {
      // SQLite leaves foreign keys off by default; cascades rely on them.
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
