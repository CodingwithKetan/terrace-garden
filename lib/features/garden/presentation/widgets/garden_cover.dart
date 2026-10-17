import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terrace_garden/app/theme/app_imagery.dart';
import 'package:terrace_garden/core/widgets/stored_photo_image.dart';
import 'package:terrace_garden/features/garden/data/garden_providers.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';

/// The garden's cover: the user's chosen photo, otherwise a bundled terrace
/// photo so the garden never looks empty.
class GardenCover extends ConsumerWidget {
  const GardenCover({required this.garden, this.thumbnail = false, super.key});

  final Garden garden;

  /// Use the small thumbnail file (lists) instead of the full photo.
  final bool thumbnail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coverId = garden.coverPhotoId;
    final photos = ref.watch(gardenPhotosProvider(garden.id)).value ?? const [];
    final cover = coverId == null
        ? null
        : photos.where((p) => p.id == coverId).firstOrNull;

    if (cover == null) {
      return Image.asset(
        AppPhotos.gardenTerrace,
        fit: BoxFit.cover,
        cacheWidth: thumbnail ? 240 : null,
        excludeFromSemantics: true,
      );
    }
    return StoredPhotoImage(
      relativePath: thumbnail ? cover.thumbnailPath : cover.relativePath,
      cacheWidth: thumbnail ? 240 : null,
    );
  }
}
