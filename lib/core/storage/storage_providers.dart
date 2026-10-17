import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:terrace_garden/core/storage/photo_picker.dart';
import 'package:terrace_garden/core/storage/photo_storage.dart';

part 'storage_providers.g.dart';

/// Root directory for stored photos (the app documents directory).
@Riverpod(keepAlive: true)
Future<Directory> photoRoot(Ref ref) => getApplicationDocumentsDirectory();

@Riverpod(keepAlive: true)
PhotoStorage photoStorage(Ref ref) =>
    FileSystemPhotoStorage(() => ref.read(photoRootProvider.future));

@Riverpod(keepAlive: true)
PhotoPicker photoPicker(Ref ref) => ImagePickerPhotoPicker();
