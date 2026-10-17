import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/widgets/async_state_view.dart';
import 'package:terrace_garden/core/widgets/empty_state.dart';
import 'package:terrace_garden/core/widgets/stored_photo_image.dart';
import 'package:terrace_garden/features/garden/data/garden_providers.dart';
import 'package:terrace_garden/features/garden/presentation/photo_actions.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// GDN-04. All photos of one garden.
class PhotoGalleryScreen extends ConsumerWidget {
  const PhotoGalleryScreen({required this.gardenId, super.key});

  final String gardenId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final photos = ref.watch(gardenPhotosProvider(gardenId));
    final insets = MediaQuery.paddingOf(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.photosTitle)),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: insets.bottom),
        child: FloatingActionButton.extended(
          onPressed: () => addGardenPhotos(context, ref, gardenId),
          icon: const Icon(Icons.add_a_photo_outlined),
          label: Text(l10n.photoAdd),
        ),
      ),
      body: AsyncStateView(
        value: photos,
        onRetry: () => ref.invalidate(gardenPhotosProvider(gardenId)),
        data: (photos) => photos.isEmpty
            ? EmptyState(
                icon: Icons.photo_library_outlined,
                title: l10n.photosTitle,
                body: l10n.gardenPhotosEmpty,
              )
            : GridView.builder(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.sm,
                  AppSpacing.sm,
                  AppSpacing.sm,
                  insets.bottom + 96,
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 180,
                  mainAxisSpacing: AppSpacing.xs,
                  crossAxisSpacing: AppSpacing.xs,
                ),
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  final photo = photos[index];
                  return ClipRRect(
                    borderRadius: AppRadii.smAll,
                    child: InkWell(
                      onTap: () => context.push(
                        AppRoutes.gardenPhoto(gardenId, photo.id),
                      ),
                      child: StoredPhotoImage(
                        relativePath: photo.thumbnailPath,
                        cacheWidth: 360,
                        semanticLabel: photo.caption ?? l10n.gardenPhotos,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
