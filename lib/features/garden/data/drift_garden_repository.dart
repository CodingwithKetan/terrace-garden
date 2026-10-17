import 'package:drift/drift.dart';
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden/domain/garden_repository.dart';

final class DriftGardenRepository implements GardenRepository {
  DriftGardenRepository(this._db, this._clock, this._ids, this._logger);

  final AppDatabase _db;
  final Clock _clock;
  final IdGenerator _ids;
  final AppLogger _logger;

  @override
  Stream<List<Garden>> watchAll() {
    final query = _db.select(_db.gardens)
      ..orderBy([(g) => OrderingTerm.asc(g.createdAt)]);
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  @override
  Stream<Garden?> watch(String id) {
    final query = _db.select(_db.gardens)..where((g) => g.id.equals(id));
    return query.watchSingleOrNull().map(
      (row) => row == null ? null : _toDomain(row),
    );
  }

  @override
  Future<Garden?> find(String id) async {
    final row = await (_db.select(
      _db.gardens,
    )..where((g) => g.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  @override
  Future<Result<Garden>> create(GardenDraft draft) async {
    final errors = draft.validate();
    if (errors.isNotEmpty) return Err(ValidationFailure(errors.first.name));
    final now = _clock.now().toUtc();
    final id = _ids.newId();
    return _guard('create garden', () async {
      await _db.into(_db.gardens).insert(_toCompanion(id, draft, now, now));
      return _readById(id);
    });
  }

  @override
  Future<Result<Garden>> update(String id, GardenDraft draft) async {
    final errors = draft.validate();
    if (errors.isNotEmpty) return Err(ValidationFailure(errors.first.name));
    return _guard('update garden', () async {
      final existing = await (_db.select(
        _db.gardens,
      )..where((g) => g.id.equals(id))).getSingleOrNull();
      if (existing == null) throw const NotFoundFailure();
      final companion = _toCompanion(
        id,
        draft,
        existing.createdAt,
        _clock.now().toUtc(),
      ).copyWith(coverPhotoId: Value(existing.coverPhotoId));
      await _db.update(_db.gardens).replace(companion);
      return _readById(id);
    });
  }

  @override
  Future<Result<void>> setCoverPhoto(String gardenId, String? photoId) =>
      _guard('set cover photo', () async {
        final updated =
            await (_db.update(
              _db.gardens,
            )..where((g) => g.id.equals(gardenId))).write(
              GardensCompanion(
                coverPhotoId: Value(photoId),
                updatedAt: Value(_clock.now().toUtc()),
              ),
            );
        if (updated == 0) throw const NotFoundFailure();
      });

  @override
  Future<Result<void>> delete(String id) => _guard('delete garden', () async {
    final deleted = await (_db.delete(
      _db.gardens,
    )..where((g) => g.id.equals(id))).go();
    if (deleted == 0) throw const NotFoundFailure();
  });

  Future<Garden> _readById(String id) async {
    final row = await (_db.select(
      _db.gardens,
    )..where((g) => g.id.equals(id))).getSingle();
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

  static GardensCompanion _toCompanion(
    String id,
    GardenDraft d,
    DateTime createdAt,
    DateTime updatedAt,
  ) => GardensCompanion.insert(
    id: id,
    name: d.name.trim(),
    spaceType: d.spaceType,
    cityName: Value(d.cityName),
    region: Value(d.region),
    lengthCm: Value(d.length?.cm),
    widthCm: Value(d.width?.cm),
    sun: d.sun,
    facing: d.facing,
    wind: d.wind,
    water: d.water,
    goals: Value(d.goals.map((g) => g.name).join(',')),
    style: Value(d.style),
    experience: Value(d.experience),
    weeklyTime: d.weeklyTime,
    budget: d.budget,
    notes: Value(_blankToNull(d.notes)),
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  static Garden _toDomain(GardenRow r) => Garden(
    id: r.id,
    name: r.name,
    spaceType: r.spaceType,
    cityName: r.cityName,
    region: r.region,
    length: r.lengthCm == null ? null : Length.cm(r.lengthCm!),
    width: r.widthCm == null ? null : Length.cm(r.widthCm!),
    sun: r.sun,
    facing: r.facing,
    wind: r.wind,
    water: r.water,
    goals: _parseGoals(r.goals),
    style: r.style,
    experience: r.experience,
    weeklyTime: r.weeklyTime,
    budget: r.budget,
    coverPhotoId: r.coverPhotoId,
    notes: r.notes,
    createdAt: r.createdAt,
    updatedAt: r.updatedAt,
  );

  // Unknown names (e.g. written by a newer app version) are skipped.
  static Set<GardenGoal> _parseGoals(String raw) => {
    for (final name in raw.split(','))
      ...GardenGoal.values.where((g) => g.name == name),
  };

  static String? _blankToNull(String? value) =>
      (value == null || value.trim().isEmpty) ? null : value.trim();
}
