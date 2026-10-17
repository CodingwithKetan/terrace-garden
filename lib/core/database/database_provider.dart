import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:terrace_garden/core/database/app_database.dart';

part 'database_provider.g.dart';

/// The app's database, opened lazily on first use and closed with the
/// provider scope. Tests override it with an in-memory database.
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final database = AppDatabase.open();
  ref.onDispose(database.close);
  return database;
}
