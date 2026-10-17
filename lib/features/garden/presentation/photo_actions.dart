import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/storage/photo_picker.dart';
import 'package:terrace_garden/core/storage/storage_providers.dart';
import 'package:terrace_garden/core/widgets/dialogs.dart';
import 'package:terrace_garden/core/widgets/error_state.dart';
import 'package:terrace_garden/features/garden/data/garden_providers.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// Asks camera or gallery. Resolves to null if dismissed.
Future<PhotoSource?> showPhotoSourceSheet(BuildContext context) {
  final l10n = context.l10n;
  return showAppBottomSheet<PhotoSource>(
    context,
    title: l10n.photoAdd,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.photo_camera_outlined),
          title: Text(l10n.photoTake),
          onTap: () => Navigator.of(context).pop(PhotoSource.camera),
        ),
        ListTile(
          leading: const Icon(Icons.photo_library_outlined),
          title: Text(l10n.photoChoose),
          onTap: () => Navigator.of(context).pop(PhotoSource.gallery),
        ),
      ],
    ),
  );
}

/// Full "add photos" flow: choose a source, pick, import, report errors.
Future<void> addGardenPhotos(
  BuildContext context,
  WidgetRef ref,
  String gardenId,
) async {
  final l10n = context.l10n;
  final messenger = ScaffoldMessenger.of(context);
  final source = await showPhotoSourceSheet(context);
  if (source == null) return;

  final picked = await ref
      .read(photoPickerProvider)
      .pick(source, multiple: source == PhotoSource.gallery);
  switch (picked) {
    case Err(failure: PermissionFailure()):
      messenger.showSnackBar(SnackBar(content: Text(l10n.photoPermission)));
    case Err(:final failure):
      messenger.showSnackBar(
        SnackBar(content: Text(ErrorState.messageFor(l10n, failure))),
      );
    case Ok(value: final paths) when paths.isNotEmpty:
      messenger.showSnackBar(SnackBar(content: Text(l10n.photoAdding)));
      final repository = ref.read(gardenPhotoRepositoryProvider);
      for (final path in paths) {
        final result = await repository.add(gardenId, path);
        if (result case Err(:final failure)) {
          messenger
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(ErrorState.messageFor(l10n, failure))),
            );
          return;
        }
      }
      messenger.hideCurrentSnackBar();
    case Ok():
      // The user cancelled the picker.
      break;
  }
}
