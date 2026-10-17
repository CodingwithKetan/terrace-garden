import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/storage/photo_storage.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/features/garden/application/garden_service.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_photo_repository.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_repository.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';

import '../../../helpers/test_images.dart';

void main() {
  late Directory root;
  late AppDatabase db;
  late CopyingImageCompressor compressor;
  late FileSystemPhotoStorage storage;
  late DriftGardenRepository gardens;
  late DriftGardenPhotoRepository photos;
  late String gardenId;
  late String sourcePath;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('photos_test');
    db = AppDatabase(NativeDatabase.memory());
    compressor = CopyingImageCompressor();
    storage = FileSystemPhotoStorage(() async => root, compressor);
    final clock = FixedClock(DateTime.utc(2026, 10, 18));
    final ids = SequentialIdGenerator();
    gardens = DriftGardenRepository(db, clock, ids, const DeveloperLogger());
    photos = DriftGardenPhotoRepository(
      db,
      storage,
      clock,
      ids,
      const DeveloperLogger(),
    );
    gardenId = (await gardens.create(
      const GardenDraft(name: 'Roof'),
    )).valueOrNull!.id;
  });

  tearDown(() async {
    await db.close();
    if (root.existsSync()) await root.delete(recursive: true);
  });

  bool exists(String relative) =>
      File(p.join(root.path, relative)).existsSync();

  testWidgets('imports a photo with thumbnail, size and relative paths', (
    tester,
  ) async {
    await tester.runAsync(() async {
      sourcePath = (await writeTestPng(p.join(root.path, 'in.png'))).path;
      final photo = (await photos.add(gardenId, sourcePath)).valueOrNull!;

      expect(photo.relativePath, 'photos/$gardenId/${photo.id}.jpg');
      expect(photo.thumbnailPath, 'photos/$gardenId/thumbs/${photo.id}.jpg');
      expect(p.isRelative(photo.relativePath), isTrue);
      expect((photo.width, photo.height), (4, 3));
      expect(exists(photo.relativePath) && exists(photo.thumbnailPath), isTrue);
      expect(await photos.listForGarden(gardenId), [photo]);
    });
  });

  testWidgets('leaves no files behind when compression fails', (tester) async {
    await tester.runAsync(() async {
      sourcePath = (await writeTestPng(p.join(root.path, 'in.png'))).path;
      compressor.fail = true;

      final result = await photos.add(gardenId, sourcePath);
      expect(result.failureOrNull, isA<StorageFailure>());
      expect(
        Directory(p.join(root.path, 'photos')).existsSync() &&
            Directory(
              p.join(root.path, 'photos', gardenId),
            ).listSync(recursive: true).whereType<File>().isNotEmpty,
        isFalse,
      );
      expect(await photos.listForGarden(gardenId), isEmpty);
    });
  });

  testWidgets('removes imported files if the garden no longer exists', (
    tester,
  ) async {
    await tester.runAsync(() async {
      sourcePath = (await writeTestPng(p.join(root.path, 'in.png'))).path;
      final result = await photos.add('missing-garden', sourcePath);
      expect(result.isOk, isFalse);
      final folder = Directory(p.join(root.path, 'photos', 'missing-garden'));
      final leftovers = folder.existsSync()
          ? folder.listSync(recursive: true).whereType<File>()
          : const <File>[];
      expect(leftovers, isEmpty);
    });
  });

  testWidgets('replace swaps files and keeps the caption', (tester) async {
    await tester.runAsync(() async {
      sourcePath = (await writeTestPng(p.join(root.path, 'in.png'))).path;
      final original = (await photos.add(gardenId, sourcePath)).valueOrNull!;
      await photos.updateCaption(original.id, '  North view ');

      final second = await writeTestPng(
        p.join(root.path, 'in2.png'),
        width: 6,
        height: 2,
      );
      final replaced = (await photos.replace(
        original.id,
        second.path,
      )).valueOrNull!;

      expect(replaced.id, original.id);
      expect(replaced.caption, 'North view');
      expect((replaced.width, replaced.height), (6, 2));
      expect(replaced.relativePath, isNot(original.relativePath));
      expect(exists(original.relativePath), isFalse);
      expect(exists(replaced.relativePath), isTrue);
    });
  });

  testWidgets('delete removes files and clears the garden cover', (
    tester,
  ) async {
    await tester.runAsync(() async {
      sourcePath = (await writeTestPng(p.join(root.path, 'in.png'))).path;
      final photo = (await photos.add(gardenId, sourcePath)).valueOrNull!;
      await gardens.setCoverPhoto(gardenId, photo.id);

      expect((await photos.delete(photo.id)).isOk, isTrue);
      expect(exists(photo.relativePath), isFalse);
      expect(exists(photo.thumbnailPath), isFalse);
      final garden = await gardens.watch(gardenId).first;
      expect(garden!.coverPhotoId, isNull);
    });
  });

  testWidgets('deleting a garden removes its rows and photo folder', (
    tester,
  ) async {
    await tester.runAsync(() async {
      sourcePath = (await writeTestPng(p.join(root.path, 'in.png'))).path;
      await photos.add(gardenId, sourcePath);
      final service = GardenService(gardens, storage, const DeveloperLogger());

      expect((await service.deleteGarden(gardenId)).isOk, isTrue);
      expect(await photos.listForGarden(gardenId), isEmpty);
      expect(
        Directory(p.join(root.path, 'photos', gardenId)).existsSync(),
        isFalse,
      );
    });
  });

  test('caption updates on a missing photo fail with NotFound', () async {
    expect(
      (await photos.updateCaption('nope', 'x')).failureOrNull,
      isA<NotFoundFailure>(),
    );
  });
}
