import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';

enum PhotoSource { camera, gallery }

/// Picks photos from the camera or gallery. Wraps image_picker so screens can
/// be tested with a fake and permission errors become [PermissionFailure].
abstract interface class PhotoPicker {
  /// Returns the picked file paths: empty if the user cancelled.
  Future<Result<List<String>>> pick(PhotoSource source, {bool multiple});

  /// Android can destroy the app while the camera is open; this returns any
  /// photo taken before that happened (call on screen start).
  Future<List<String>> retrieveLost();
}

final class ImagePickerPhotoPicker implements PhotoPicker {
  ImagePickerPhotoPicker([ImagePicker? picker])
    : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  // Pre-shrink very large camera images; storage compresses again later.
  static const _maxSide = 3000.0;

  @override
  Future<Result<List<String>>> pick(
    PhotoSource source, {
    bool multiple = false,
  }) async {
    try {
      if (source == PhotoSource.gallery && multiple) {
        final files = await _picker.pickMultiImage(
          maxWidth: _maxSide,
          maxHeight: _maxSide,
          requestFullMetadata: false,
        );
        return Ok(files.map((f) => f.path).toList());
      }
      final file = await _picker.pickImage(
        source: source == PhotoSource.camera
            ? ImageSource.camera
            : ImageSource.gallery,
        maxWidth: _maxSide,
        maxHeight: _maxSide,
        requestFullMetadata: false,
      );
      return Ok([?file?.path]);
    } on PlatformException catch (error) {
      if (error.code.contains('access_denied')) {
        // image_picker cannot tell a one-off denial from a permanent one, so
        // the UI always offers "Open settings".
        return Err(PermissionFailure(permanentlyDenied: true, cause: error));
      }
      return Err(UnexpectedFailure(error));
    }
  }

  @override
  Future<List<String>> retrieveLost() async {
    final response = await _picker.retrieveLostData();
    if (response.isEmpty) return const [];
    return [for (final file in response.files ?? const <XFile>[]) file.path];
  }
}
