import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';

abstract interface class PlantingRepository {
  /// A garden's plantings, oldest first.
  Stream<List<Planting>> watchForGarden(String gardenId);

  /// Every planting in every garden, oldest first.
  Stream<List<Planting>> watchAll();

  /// Every planting, as a one-off read.
  Future<List<Planting>> all();

  Future<Planting?> find(String id);

  Future<Result<Planting>> create(PlantingDraft draft);

  Future<Result<Planting>> update(String id, PlantingDraft draft);

  Future<Result<void>> delete(String id);
}

/// Species the user saved from recommendations, per garden (REC-03).
abstract interface class ShortlistRepository {
  Stream<Set<String>> watch(String gardenId);

  Future<Result<void>> setShortlisted(
    String gardenId,
    String speciesId, {
    required bool shortlisted,
  });
}
