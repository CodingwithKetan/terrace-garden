import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/features/journal/domain/journal_entry.dart';

abstract interface class JournalRepository {
  /// Every entry, newest first.
  Stream<List<JournalEntry>> watchAll();

  Future<JournalEntry?> find(String id);

  /// Saves the entry and imports [photoSourcePaths] (compressed, EXIF
  /// stripped) into app storage.
  Future<Result<JournalEntry>> create(
    JournalDraft draft, {
    List<String> photoSourcePaths = const [],
  });

  /// Deletes the entry and its photo files.
  Future<Result<void>> delete(String id);
}
