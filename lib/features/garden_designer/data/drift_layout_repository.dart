import 'package:drift/drift.dart';
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_repository.dart';

final class DriftLayoutRepository implements LayoutRepository {
  DriftLayoutRepository(this._db, this._logger);

  final AppDatabase _db;
  final AppLogger _logger;

  @override
  Future<List<LayoutElement>> loadElements(String gardenId) async =>
      (await _query(gardenId).get()).map(_toDomain).toList();

  @override
  Stream<List<LayoutElement>> watchElements(String gardenId) => _query(
    gardenId,
  ).watch().map((rows) => rows.map(_toDomain).toList());

  SimpleSelectStatement<$LayoutElementsTable, LayoutElementRow> _query(
    String gardenId,
  ) => _db.select(_db.layoutElements)
    ..where((e) => e.gardenId.equals(gardenId))
    ..orderBy([(e) => OrderingTerm.asc(e.zIndex)]);

  @override
  Future<Result<void>> saveElements(
    String gardenId,
    List<LayoutElement> elements,
  ) async {
    try {
      await _db.transaction(() async {
        await (_db.delete(
          _db.layoutElements,
        )..where((e) => e.gardenId.equals(gardenId))).go();
        await _db.batch((batch) {
          batch.insertAll(_db.layoutElements, [
            for (final (i, e) in elements.indexed)
              LayoutElementsCompanion.insert(
                id: e.id,
                gardenId: gardenId,
                kind: e.kind,
                centerX: e.center.x,
                centerY: e.center.y,
                width: e.width,
                height: e.height,
                rotationDeg: Value(e.rotationDeg),
                depthCm: Value(e.depthCm),
                label: Value(e.label),
                zIndex: i,
              ),
          ]);
        });
      });
      return const Ok(null);
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Failed to save layout',
        error: error,
        stackTrace: stackTrace,
      );
      return Err(StorageFailure(error));
    }
  }

  static LayoutElement _toDomain(LayoutElementRow r) => LayoutElement(
    id: r.id,
    kind: r.kind,
    center: Vec2(r.centerX, r.centerY),
    width: r.width,
    height: r.height,
    rotationDeg: r.rotationDeg,
    depthCm: r.depthCm,
    label: r.label,
  );
}
