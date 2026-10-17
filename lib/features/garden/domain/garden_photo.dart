import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:terrace_garden/core/errors/result.dart';

part 'garden_photo.freezed.dart';

/// A photo of a garden, stored in app storage (data-model.md §3). Photos
/// document the space; they are never used to derive measurements.
@freezed
abstract class GardenPhoto with _$GardenPhoto {
  const factory GardenPhoto({
    required String id,
    required String gardenId,
    required String relativePath,
    required String thumbnailPath,
    required int width,
    required int height,
    required DateTime takenAt,
    required DateTime createdAt,
    String? caption,
  }) = _GardenPhoto;
}

abstract interface class GardenPhotoRepository {
  /// Newest first.
  Stream<List<GardenPhoto>> watchForGarden(String gardenId);

  Future<List<GardenPhoto>> listForGarden(String gardenId);

  /// Imports the image at [sourcePath] and stores it for [gardenId].
  Future<Result<GardenPhoto>> add(String gardenId, String sourcePath);

  /// Swaps the image of an existing photo, keeping its caption.
  Future<Result<GardenPhoto>> replace(String photoId, String sourcePath);

  Future<Result<void>> updateCaption(String photoId, String? caption);

  /// Deletes the photo and its files; clears it as cover if needed.
  Future<Result<void>> delete(String photoId);
}

/// Storage folder holding every file that belongs to a garden.
String gardenPhotoFolder(String gardenId) => 'photos/$gardenId';
