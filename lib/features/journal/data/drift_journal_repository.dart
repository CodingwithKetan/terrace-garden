import 'package:drift/drift.dart';
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/storage/photo_storage.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/journal/domain/journal_entry.dart';
import 'package:terrace_garden/features/journal/domain/journal_repository.dart';

/// Journal photos live inside the garden's photo folder, so deleting a garden
/// removes them with the rest of its files.
String journalPhotoFolder(String gardenId, String entryId) =>
    'photos/$gardenId/journal/$entryId';

final class DriftJournalRepository implements JournalRepository {
  DriftJournalRepository(
    this._db,
    this._storage,
    this._clock,
    this._ids,
    this._logger,
  );

  /// More photos than this per entry are ignored (keeps storage bounded).
  static const maxPhotos = 6;

  final AppDatabase _db;
  final PhotoStorage _storage;
  final Clock _clock;
  final IdGenerator _ids;
  final AppLogger _logger;

  @override
  Stream<List<JournalEntry>> watchAll() {
    final query =
        _db.select(_db.journalEntries).join([
          leftOuterJoin(
            _db.journalPhotos,
            _db.journalPhotos.entryId.equalsExp(_db.journalEntries.id),
          ),
        ])..orderBy([
          OrderingTerm.desc(_db.journalEntries.date),
          OrderingTerm.desc(_db.journalEntries.createdAt),
          OrderingTerm.asc(_db.journalPhotos.position),
        ]);
    return query.watch().map(_group);
  }

  @override
  Future<JournalEntry?> find(String id) async {
    final query =
        _db.select(_db.journalEntries).join([
            leftOuterJoin(
              _db.journalPhotos,
              _db.journalPhotos.entryId.equalsExp(_db.journalEntries.id),
            ),
          ])
          ..where(_db.journalEntries.id.equals(id))
          ..orderBy([OrderingTerm.asc(_db.journalPhotos.position)]);
    return _group(await query.get()).firstOrNull;
  }

  List<JournalEntry> _group(List<TypedResult> rows) {
    final entries = <String, JournalEntryRow>{};
    final photos = <String, List<JournalPhoto>>{};
    for (final row in rows) {
      final entry = row.readTable(_db.journalEntries);
      entries.putIfAbsent(entry.id, () => entry);
      final photo = row.readTableOrNull(_db.journalPhotos);
      if (photo != null) {
        (photos[entry.id] ??= []).add(
          JournalPhoto(
            id: photo.id,
            relativePath: photo.relativePath,
            thumbnailPath: photo.thumbnailPath,
          ),
        );
      }
    }
    return [
      for (final e in entries.values)
        JournalEntry(
          id: e.id,
          gardenId: e.gardenId,
          plantingId: e.plantingId,
          date: LocalDate.parse(e.date),
          note: e.note,
          milestone: e.milestone,
          harvestQuantity: e.harvestQuantity,
          harvestUnit: e.harvestUnit,
          photos: photos[e.id] ?? const [],
          createdAt: e.createdAt,
        ),
    ];
  }

  @override
  Future<Result<JournalEntry>> create(
    JournalDraft draft, {
    List<String> photoSourcePaths = const [],
  }) async {
    final sources = photoSourcePaths.take(maxPhotos).toList();
    final errors = draft.validate(
      today: LocalDate.fromDateTime(_clock.now()),
      photoCount: sources.length,
    );
    if (errors.isNotEmpty) return Err(ValidationFailure(errors.first));
    final id = _ids.newId();
    final folder = journalPhotoFolder(draft.gardenId, id);
    try {
      // Import files first; if any fails, nothing is written to the DB.
      final stored = <(String, StoredPhoto)>[];
      for (final source in sources) {
        final photoId = _ids.newId();
        stored.add((
          photoId,
          await _storage.importImage(source, folder: folder, id: photoId),
        ));
      }
      final note = draft.note?.trim();
      await _db.transaction(() async {
        await _db
            .into(_db.journalEntries)
            .insert(
              JournalEntriesCompanion.insert(
                id: id,
                gardenId: draft.gardenId,
                plantingId: Value(draft.plantingId),
                date: draft.date.toIso8601(),
                note: Value((note?.isEmpty ?? true) ? null : note),
                milestone: Value(draft.milestone),
                harvestQuantity: Value(draft.harvestQuantity),
                harvestUnit: Value(draft.harvestUnit),
                createdAt: _clock.now().toUtc(),
              ),
            );
        for (final (i, (photoId, photo)) in stored.indexed) {
          await _db
              .into(_db.journalPhotos)
              .insert(
                JournalPhotosCompanion.insert(
                  id: photoId,
                  entryId: id,
                  relativePath: photo.relativePath,
                  thumbnailPath: photo.thumbnailPath,
                  position: i,
                ),
              );
        }
      });
      return Ok((await find(id))!);
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Failed to save journal entry',
        error: error,
        stackTrace: stackTrace,
      );
      await _deleteFolderQuietly(folder);
      return Err(StorageFailure(error));
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      final entry = await (_db.select(
        _db.journalEntries,
      )..where((e) => e.id.equals(id))).getSingleOrNull();
      if (entry == null) return const Err(NotFoundFailure());
      await (_db.delete(
        _db.journalEntries,
      )..where((e) => e.id.equals(id))).go();
      await _deleteFolderQuietly(journalPhotoFolder(entry.gardenId, id));
      return const Ok(null);
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Failed to delete journal entry',
        error: error,
        stackTrace: stackTrace,
      );
      return Err(StorageFailure(error));
    }
  }

  Future<void> _deleteFolderQuietly(String folder) async {
    try {
      await _storage.deleteFolder(folder);
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Could not remove journal photos at $folder',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
