import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/storage/photo_storage.dart';
import 'package:terrace_garden/features/garden/domain/garden_photo.dart';
import 'package:terrace_garden/features/garden/domain/garden_repository.dart';

/// Operations that span gardens and their files.
class GardenService {
  GardenService(this._gardens, this._storage, this._logger);

  final GardenRepository _gardens;
  final PhotoStorage _storage;
  final AppLogger _logger;

  /// Deletes the garden (rows cascade) and then its photo folder. A failure
  /// to remove files is logged but does not undo the deletion.
  Future<Result<void>> deleteGarden(String gardenId) async {
    final result = await _gardens.delete(gardenId);
    if (result case Ok()) {
      try {
        await _storage.deleteFolder(
          gardenPhotoFolder(gardenId),
        );
      } on Object catch (error, stackTrace) {
        _logger.error(
          'Garden deleted but its photo folder could not be removed',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }
    return result;
  }
}
