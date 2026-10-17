import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() => database = AppDatabase(NativeDatabase.memory()));
  tearDown(() => database.close());

  test('opens an in-memory database on the host', () async {
    final row = await database
        .customSelect('SELECT sqlite_version() AS version')
        .getSingle();
    expect(row.read<String>('version'), isNotNull);
  });

  test('enables foreign key enforcement on open', () async {
    final row = await database.customSelect('PRAGMA foreign_keys').getSingle();
    expect(row.data.values.single, 1);
  });

  test('starts at schema version 1', () {
    expect(database.schemaVersion, 1);
  });
}
