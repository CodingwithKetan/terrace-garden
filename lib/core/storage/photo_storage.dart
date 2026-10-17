import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;

/// A photo copied into app storage: paths are relative to the storage root so
/// they survive app-container moves (iOS) and backups (ADR-007).
class StoredPhoto {
  const StoredPhoto({
    required this.relativePath,
    required this.thumbnailPath,
    required this.width,
    required this.height,
  });

  final String relativePath;
  final String thumbnailPath;
  final int width;
  final int height;
}

/// Re-encodes images. Wraps the native compressor so storage logic can be
/// tested on the host with a fake.
abstract interface class ImageCompressor {
  /// Writes a JPEG of [source] to [target], scaled so its shorter side is at
  /// most [maxShortSide] (never upscaled), with EXIF (including GPS) removed.
  Future<void> compress(
    String source,
    String target, {
    required int maxShortSide,
    required int quality,
  });
}

final class NativeImageCompressor implements ImageCompressor {
  const NativeImageCompressor();

  @override
  Future<void> compress(
    String source,
    String target, {
    required int maxShortSide,
    required int quality,
  }) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      source,
      target,
      minWidth: maxShortSide,
      minHeight: maxShortSide,
      quality: quality,
      // keepExif defaults to false: location metadata can reveal the
      // user's home, so it is never kept.
    );
    if (result == null) {
      throw FileSystemException('Image could not be compressed', source);
    }
  }
}

abstract interface class PhotoStorage {
  /// Copies [sourcePath] into `folder/`, creating a compressed photo and a
  /// thumbnail named after [id].
  Future<StoredPhoto> importImage(
    String sourcePath, {
    required String folder,
    required String id,
  });

  /// The file for a stored relative path (it may no longer exist).
  Future<File> resolve(String relativePath);

  Future<void> deleteFiles(Iterable<String> relativePaths);

  /// Removes a whole folder, e.g. all photos of a deleted garden.
  Future<void> deleteFolder(String folder);
}

final class FileSystemPhotoStorage implements PhotoStorage {
  FileSystemPhotoStorage(
    this._root, [
    this._compressor = const NativeImageCompressor(),
  ]);

  final Future<Directory> Function() _root;
  final ImageCompressor _compressor;

  /// Shorter side of stored photos; about 2048 px on the long side for 4:3.
  static const photoShortSide = 1536;
  static const thumbnailShortSide = 400;

  @override
  Future<StoredPhoto> importImage(
    String sourcePath, {
    required String folder,
    required String id,
  }) async {
    final root = await _root();
    final photoRel = p.posix.join(folder, '$id.jpg');
    final thumbRel = p.posix.join(folder, 'thumbs', '$id.jpg');
    final photoFile = File(p.join(root.path, photoRel));
    final thumbFile = File(p.join(root.path, thumbRel));
    await thumbFile.parent.create(recursive: true);

    try {
      await _compressor.compress(
        sourcePath,
        photoFile.path,
        maxShortSide: photoShortSide,
        quality: 80,
      );
      await _compressor.compress(
        photoFile.path,
        thumbFile.path,
        maxShortSide: thumbnailShortSide,
        quality: 75,
      );
      final (width, height) = await _dimensions(photoFile);
      return StoredPhoto(
        relativePath: photoRel,
        thumbnailPath: thumbRel,
        width: width,
        height: height,
      );
    } on Object {
      // Never leave half-imported files behind.
      await _deleteIfExists(photoFile);
      await _deleteIfExists(thumbFile);
      rethrow;
    }
  }

  @override
  Future<File> resolve(String relativePath) async =>
      File(p.join((await _root()).path, relativePath));

  @override
  Future<void> deleteFiles(Iterable<String> relativePaths) async {
    for (final path in relativePaths) {
      await _deleteIfExists(await resolve(path));
    }
  }

  @override
  Future<void> deleteFolder(String folder) async {
    final dir = Directory(p.join((await _root()).path, folder));
    if (dir.existsSync()) await dir.delete(recursive: true);
  }

  static Future<void> _deleteIfExists(File file) async {
    if (file.existsSync()) await file.delete();
  }

  /// Reads the image header only (no full decode).
  static Future<(int, int)> _dimensions(File file) async {
    final buffer = await ui.ImmutableBuffer.fromUint8List(
      Uint8List.fromList(await file.readAsBytes()),
    );
    final descriptor = await ui.ImageDescriptor.encoded(buffer);
    final size = (descriptor.width, descriptor.height);
    descriptor.dispose();
    buffer.dispose();
    return size;
  }
}
