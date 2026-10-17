import 'package:drift/drift.dart';
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/storage/photo_storage.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/features/garden/domain/garden_photo.dart';

final class DriftGardenPhotoRepository implements GardenPhotoRepository {
  DriftGardenPhotoRepository(
    this._db,
    this._storage,
    this._clock,
    this._ids,
    this._logger,
  );

  final AppDatabase _db;
  final PhotoStorage _storage;
  final Clock _clock;
  final IdGenerator _ids;
  final AppLogger _logger;

  @override
  Stream<List<GardenPhoto>> watchForGarden(String gardenId) => _queryForGarden(
    gardenId,
  ).watch().map((rows) => rows.map(_toDomain).toList());

  @override
  Future<List<GardenPhoto>> listForGarden(String gardenId) async =>
      (await _queryForGarden(gardenId).get()).map(_toDomain).toList();

  @override
  Future<Result<GardenPhoto>> add(String gardenId, String sourcePath) =>
      _guard('add photo', () async {
        final id = _ids.newId();
        final now = _clock.now().toUtc();
        final stored = await _storage.importImage(
          sourcePath,
          folder: gardenPhotoFolder(gardenId),
          id: id,
        );
        try {
          await _db
              .into(_db.gardenPhotos)
              .insert(
                GardenPhotosCompanion.insert(
                  id: id,
                  gardenId: gardenId,
                  relativePath: stored.relativePath,
                  thumbnailPath: stored.thumbnailPath,
                  width: stored.width,
                  height: stored.height,
                  takenAt: now,
                  createdAt: now,
                ),
              );
        } on Object {
          // The row failed (e.g. the garden was deleted); drop the files.
          await _storage.deleteFiles([
            stored.relativePath,
            stored.thumbnailPath,
          ]);
          rethrow;
        }
        return _read(id);
      });

  @override
  Future<Result<GardenPhoto>> replace(String photoId, String sourcePath) =>
      _guard('replace photo', () async {
        final old = await _read(photoId);
        // A new file name avoids stale image caches showing the old picture.
        final newId = _ids.newId();
        final stored = await _storage.importImage(
          sourcePath,
          folder: gardenPhotoFolder(old.gardenId),
          id: newId,
        );
        await (_db.update(
          _db.gardenPhotos,
        )..where((p) => p.id.equals(photoId))).write(
          GardenPhotosCompanion(
            relativePath: Value(stored.relativePath),
            thumbnailPath: Value(stored.thumbnailPath),
            width: Value(stored.width),
            height: Value(stored.height),
            takenAt: Value(_clock.now().toUtc()),
          ),
        );
        await _storage.deleteFiles([old.relativePath, old.thumbnailPath]);
        return _read(photoId);
      });

  @override
  Future<Result<void>> updateCaption(String photoId, String? caption) =>
      _guard('update caption', () async {
        final trimmed = caption?.trim();
        final updated =
            await (_db.update(
              _db.gardenPhotos,
            )..where((p) => p.id.equals(photoId))).write(
              GardenPhotosCompanion(
                caption: Value(
                  (trimmed == null || trimmed.isEmpty) ? null : trimmed,
                ),
              ),
            );
        if (updated == 0) throw const NotFoundFailure();
      });

  @override
  Future<Result<void>> delete(String photoId) =>
      _guard('delete photo', () async {
        final photo = await _read(photoId);
        await _db.transaction(() async {
          await (_db.update(_db.gardens)
                ..where((g) => g.coverPhotoId.equals(photoId)))
              .write(const GardensCompanion(coverPhotoId: Value(null)));
          await (_db.delete(
            _db.gardenPhotos,
          )..where((p) => p.id.equals(photoId))).go();
        });
        await _storage.deleteFiles([photo.relativePath, photo.thumbnailPath]);
      });

  SimpleSelectStatement<$GardenPhotosTable, GardenPhotoRow> _queryForGarden(
    String gardenId,
  ) => _db.select(_db.gardenPhotos)
    ..where((p) => p.gardenId.equals(gardenId))
    ..orderBy([(p) => OrderingTerm.desc(p.createdAt)]);

  Future<GardenPhoto> _read(String id) async {
    final row = await (_db.select(
      _db.gardenPhotos,
    )..where((p) => p.id.equals(id))).getSingleOrNull();
    if (row == null) throw const NotFoundFailure();
    return _toDomain(row);
  }

  Future<Result<T>> _guard<T>(String action, Future<T> Function() body) async {
    try {
      return Ok(await body());
    } on AppFailure catch (failure) {
      return Err(failure);
    } on Object catch (error, stackTrace) {
      _logger.error('Failed to $action', error: error, stackTrace: stackTrace);
      return Err(StorageFailure(error));
    }
  }

  static GardenPhoto _toDomain(GardenPhotoRow r) => GardenPhoto(
    id: r.id,
    gardenId: r.gardenId,
    relativePath: r.relativePath,
    thumbnailPath: r.thumbnailPath,
    width: r.width,
    height: r.height,
    takenAt: r.takenAt,
    createdAt: r.createdAt,
    caption: r.caption,
  );
}
