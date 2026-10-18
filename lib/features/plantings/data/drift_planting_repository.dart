import 'package:drift/drift.dart';
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';
import 'package:terrace_garden/features/plantings/domain/planting_repository.dart';

final class DriftPlantingRepository implements PlantingRepository {
  DriftPlantingRepository(this._db, this._clock, this._ids, this._logger);

  final AppDatabase _db;
  final Clock _clock;
  final IdGenerator _ids;
  final AppLogger _logger;

  LocalDate get _today => LocalDate.fromDateTime(_clock.now());

  @override
  Stream<List<Planting>> watchForGarden(String gardenId) {
    final query = _db.select(_db.plantings)
      ..where((p) => p.gardenId.equals(gardenId))
      ..orderBy([(p) => OrderingTerm.asc(p.createdAt)]);
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  @override
  Stream<List<Planting>> watchAll() {
    final query = _db.select(_db.plantings)
      ..orderBy([(p) => OrderingTerm.asc(p.createdAt)]);
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  @override
  Future<Planting?> find(String id) async {
    final row = await (_db.select(
      _db.plantings,
    )..where((p) => p.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  @override
  Future<Result<Planting>> create(PlantingDraft draft) async {
    final errors = draft.validate(today: _today);
    if (errors.isNotEmpty) return Err(ValidationFailure(errors.first));
    final id = _ids.newId();
    final now = _clock.now().toUtc();
    return _guard('create planting', () async {
      await _db
          .into(_db.plantings)
          .insert(_toCompanion(id, draft, createdAt: now, updatedAt: now));
      return (await find(id))!;
    });
  }

  @override
  Future<Result<Planting>> update(String id, PlantingDraft draft) async {
    final errors = draft.validate(today: _today);
    if (errors.isNotEmpty) return Err(ValidationFailure(errors.first));
    return _guard('update planting', () async {
      final existing = await find(id);
      if (existing == null) throw const NotFoundFailure();
      await _db
          .update(_db.plantings)
          .replace(
            _toCompanion(
              id,
              draft,
              createdAt: existing.createdAt,
              updatedAt: _clock.now().toUtc(),
            ),
          );
      return (await find(id))!;
    });
  }

  @override
  Future<Result<void>> delete(String id) => _guard('delete planting', () async {
    final deleted = await (_db.delete(
      _db.plantings,
    )..where((p) => p.id.equals(id))).go();
    if (deleted == 0) throw const NotFoundFailure();
  });

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

  static PlantingsCompanion _toCompanion(
    String id,
    PlantingDraft d, {
    required DateTime createdAt,
    required DateTime updatedAt,
  }) => PlantingsCompanion.insert(
    id: id,
    gardenId: d.gardenId,
    speciesId: d.speciesId,
    elementId: Value(d.elementId),
    quantity: d.quantity,
    plantedOn: d.plantedOn.toIso8601(),
    startedFrom: d.startedFrom,
    notes: Value(d.notes),
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  static Planting _toDomain(PlantingRow r) => Planting(
    id: r.id,
    gardenId: r.gardenId,
    speciesId: r.speciesId,
    elementId: r.elementId,
    quantity: r.quantity,
    plantedOn: LocalDate.parse(r.plantedOn),
    startedFrom: r.startedFrom,
    notes: r.notes,
    createdAt: r.createdAt,
    updatedAt: r.updatedAt,
  );
}

final class DriftShortlistRepository implements ShortlistRepository {
  DriftShortlistRepository(this._db, this._clock, this._logger);

  final AppDatabase _db;
  final Clock _clock;
  final AppLogger _logger;

  @override
  Stream<Set<String>> watch(String gardenId) {
    final query = _db.select(_db.shortlistEntries)
      ..where((s) => s.gardenId.equals(gardenId));
    return query.watch().map((rows) => {for (final r in rows) r.speciesId});
  }

  @override
  Future<Result<void>> setShortlisted(
    String gardenId,
    String speciesId, {
    required bool shortlisted,
  }) async {
    try {
      if (shortlisted) {
        await _db
            .into(_db.shortlistEntries)
            .insertOnConflictUpdate(
              ShortlistEntriesCompanion.insert(
                gardenId: gardenId,
                speciesId: speciesId,
                createdAt: _clock.now().toUtc(),
              ),
            );
      } else {
        await (_db.delete(_db.shortlistEntries)..where(
              (s) =>
                  s.gardenId.equals(gardenId) & s.speciesId.equals(speciesId),
            ))
            .go();
      }
      return const Ok(null);
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Failed to update shortlist',
        error: error,
        stackTrace: stackTrace,
      );
      return Err(StorageFailure(error));
    }
  }
}
