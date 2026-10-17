import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/storage/storage_providers.dart';
import 'package:terrace_garden/core/widgets/dialogs.dart';
import 'package:terrace_garden/core/widgets/error_state.dart';
import 'package:terrace_garden/core/widgets/stored_photo_image.dart';
import 'package:terrace_garden/features/garden/data/garden_providers.dart';
import 'package:terrace_garden/features/garden/domain/garden_photo.dart';
import 'package:terrace_garden/features/garden/presentation/photo_actions.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// GDN-05. One photo, zoomable, with caption, cover, replace and delete.
class PhotoViewerScreen extends ConsumerWidget {
  const PhotoViewerScreen({
    required this.gardenId,
    required this.photoId,
    super.key,
  });

  final String gardenId;
  final String photoId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photos = ref.watch(gardenPhotosProvider(gardenId)).value;
    final photo = photos?.where((p) => p.id == photoId).firstOrNull;
    final garden = ref.watch(gardenProvider(gardenId)).value;

    return Theme(
      data: ThemeData.dark(useMaterial3: true).copyWith(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          foregroundColor: Colors.white,
          title: Text(photo?.caption ?? ''),
        ),
        extendBodyBehindAppBar: true,
        body: photos == null
            ? const Center(child: CircularProgressIndicator())
            : photo == null
            ? const ErrorState(failure: NotFoundFailure())
            : InteractiveViewer(
                maxScale: 5,
                child: Center(
                  child: StoredPhotoImage(
                    relativePath: photo.relativePath,
                    fit: BoxFit.contain,
                    semanticLabel: photo.caption ?? context.l10n.gardenPhotos,
                  ),
                ),
              ),
        bottomNavigationBar: photo == null
            ? null
            : _Actions(
                photo: photo,
                isCover: garden?.coverPhotoId == photo.id,
              ),
      ),
    );
  }
}

class _Actions extends ConsumerWidget {
  const _Actions({required this.photo, required this.isCover});

  final GardenPhoto photo;
  final bool isCover;

  void _report(BuildContext context, Result<void> result, String? success) {
    final l10n = context.l10n;
    final message = switch (result) {
      Err(:final failure) => ErrorState.messageFor(l10n, failure),
      Ok() => success,
    };
    if (message != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _editCaption(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final controller = TextEditingController(text: photo.caption);
    final caption = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.photoCaption),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 120,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(hintText: l10n.photoCaptionHint),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.actionCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: Text(l10n.actionSave),
          ),
        ],
      ),
    );
    controller.dispose();
    if (caption == null || !context.mounted) return;
    final result = await ref
        .read(gardenPhotoRepositoryProvider)
        .updateCaption(photo.id, caption);
    if (context.mounted) _report(context, result, null);
  }

  Future<void> _setCover(BuildContext context, WidgetRef ref) async {
    final result = await ref
        .read(gardenRepositoryProvider)
        .setCoverPhoto(photo.gardenId, photo.id);
    if (context.mounted) {
      _report(context, result, context.l10n.photoCoverUpdated);
    }
  }

  Future<void> _replace(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final source = await showPhotoSourceSheet(context);
    if (source == null || !context.mounted) return;
    final picked = await ref.read(photoPickerProvider).pick(source);
    if (!context.mounted) return;
    switch (picked) {
      case Err(failure: PermissionFailure()):
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.photoPermission)));
      case Err(:final failure):
        _report(context, Err(failure), null);
      case Ok(value: [final path, ...]):
        final result = await ref
            .read(gardenPhotoRepositoryProvider)
            .replace(photo.id, path);
        if (context.mounted) _report(context, result, null);
      case Ok():
        break;
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final router = GoRouter.of(context);
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.photoDelete,
      message: l10n.photoDeleteBody,
      confirmLabel: l10n.actionDelete,
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
    final result = await ref
        .read(gardenPhotoRepositoryProvider)
        .delete(photo.id);
    if (!context.mounted) return;
    if (result.isOk) {
      router.pop();
    } else {
      _report(context, result, null);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final actions = [
      (
        Icons.edit_note_outlined,
        l10n.photoCaption,
        () => _editCaption(context, ref),
      ),
      (
        isCover ? Icons.star : Icons.star_outline,
        isCover ? l10n.photoIsCover : l10n.photoSetCover,
        isCover ? null : () => _setCover(context, ref),
      ),
      (Icons.swap_horiz, l10n.photoReplace, () => _replace(context, ref)),
      (Icons.delete_outline, l10n.photoDelete, () => _delete(context, ref)),
    ];

    return ColoredBox(
      color: Colors.black54,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Row(
            children: [
              for (final (icon, label, onPressed) in actions)
                Expanded(
                  child: TextButton(
                    onPressed: onPressed,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Colors.white70,
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          label,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
