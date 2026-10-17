import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';

abstract interface class GardenRepository {
  /// All gardens, oldest first; emits again whenever gardens change.
  Stream<List<Garden>> watchAll();

  /// A single garden, or null once it has been deleted.
  Stream<Garden?> watch(String id);

  /// A one-off read of a garden (null if it does not exist).
  Future<Garden?> find(String id);

  /// Validates and stores a new garden. Fails with `ValidationFailure` when
  /// the draft is invalid.
  Future<Result<Garden>> create(GardenDraft draft);

  /// Replaces the editable fields of an existing garden.
  Future<Result<Garden>> update(String id, GardenDraft draft);

  Future<Result<void>> setCoverPhoto(String gardenId, String? photoId);

  /// Deletes the garden and everything that belongs to it.
  Future<Result<void>> delete(String id);
}
