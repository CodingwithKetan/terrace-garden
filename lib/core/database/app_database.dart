import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// The single local database for all domain data (ADR-005).
///
/// Feature tables are added phase by phase. Each schema change bumps
/// [schemaVersion] and adds a step-by-step migration; schema snapshots live in
/// `drift_schemas/` and are verified by tests (`dart run drift_dev
/// make-migrations`).
@DriftDatabase()
class AppDatabase extends _$AppDatabase {
  /// Use [AppDatabase.open] in the app; tests pass an in-memory executor.
  AppDatabase(super.e);

  factory AppDatabase.open() =>
      AppDatabase(driftDatabase(name: 'terrace_garden'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      // SQLite leaves foreign keys off by default; cascades rely on them.
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
