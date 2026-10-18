import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/storage/photo_storage.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/garden/application/garden_service.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_repository.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/journal/data/drift_journal_repository.dart';
import 'package:terrace_garden/features/journal/domain/journal_entry.dart';
import 'package:terrace_garden/features/plantings/data/drift_planting_repository.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';

import '../../../helpers/test_images.dart';

void main() {
  late Directory root;
  late AppDatabase db;
  late CopyingImageCompressor compressor;
  late FileSystemPhotoStorage storage;
  late DriftGardenRepository gardens;
  late DriftJournalRepository journal;
  late String gardenId;
  late String plantingId;
  late String sourcePath;
  final today = LocalDate(2026, 10, 18);

  setUp(() async {
    root = await Directory.systemTemp.createTemp('journal_test');
    db = AppDatabase(NativeDatabase.memory());
    compressor = CopyingImageCompressor();
    storage = FileSystemPhotoStorage(() async => root, compressor);
    final clock = FixedClock(DateTime(2026, 10, 18, 9));
    const logger = DeveloperLogger();
    gardens = DriftGardenRepository(
      db,
      clock,
      SequentialIdGenerator('g'),
      logger,
    );
    journal = DriftJournalRepository(
      db,
      storage,
      clock,
      SequentialIdGenerator('j'),
      logger,
    );
    gardenId = (await gardens.create(
      const GardenDraft(name: 'Roof'),
    )).valueOrNull!.id;
    plantingId =
        (await DriftPlantingRepository(
              db,
              clock,
              SequentialIdGenerator('p'),
              logger,
            ).create(
              PlantingDraft(
                gardenId: gardenId,
                speciesId: 'tomato',
                plantedOn: today,
              ),
            ))
            .valueOrNull!
            .id;
    sourcePath = (await writeTestPng(p.join(root.path, 'src', 'a.png'))).path;
  });

  tearDown(() async {
    await db.close();
    if (root.existsSync()) root.deleteSync(recursive: true);
  });

  test('saves a harvest entry with photos, newest first', () async {
    final older = await journal.create(
      JournalDraft(
        gardenId: gardenId,
        date: today.addDays(-3),
        note: 'First flowers',
        milestone: Milestone.flowering,
      ),
    );
    expect(older, isA<Ok<JournalEntry>>());

    final entry = (await journal.create(
      JournalDraft(
        gardenId: gardenId,
        plantingId: plantingId,
        date: today,
        note: '  Picked the first tomatoes  ',
        milestone: Milestone.harvest,
        harvestQuantity: 250,
        harvestUnit: HarvestUnit.grams,
      ),
      photoSourcePaths: [sourcePath, sourcePath],
    )).valueOrNull!;
    expect(entry.note, 'Picked the first tomatoes');
    expect(entry.harvestQuantity, 250);
    expect(entry.photos, hasLength(2));
    expect(
      File(p.join(root.path, entry.photos.first.relativePath)).existsSync(),
      isTrue,
    );

    final all = await journal.watchAll().first;
    expect(all.map((e) => e.milestone), [
      Milestone.harvest,
      Milestone.flowering,
    ]);
    expect(all.first.photos, hasLength(2));
  });

  test('rejects empty, future and inconsistent harvest entries', () async {
    Future<String> fieldOf(JournalDraft d) async =>
        (((await journal.create(d)) as Err).failure as ValidationFailure).field;

    expect(
      await fieldOf(JournalDraft(gardenId: gardenId, date: today)),
      'empty',
    );
    expect(
      await fieldOf(
        JournalDraft(gardenId: gardenId, date: today.addDays(1), note: 'x'),
      ),
      'date',
    );
    expect(
      await fieldOf(
        JournalDraft(
          gardenId: gardenId,
          date: today,
          milestone: Milestone.flowering,
          harvestQuantity: 2,
          harvestUnit: HarvestUnit.pieces,
        ),
      ),
      'quantity',
    );
    expect(await journal.watchAll().first, isEmpty);
  });

  test('a photo-only entry is allowed', () async {
    final result = await journal.create(
      JournalDraft(gardenId: gardenId, date: today),
      photoSourcePaths: [sourcePath],
    );
    expect(result, isA<Ok<JournalEntry>>());
  });

  test('a failed photo import writes nothing', () async {
    compressor.fail = true;
    final result = await journal.create(
      JournalDraft(gardenId: gardenId, date: today, note: 'x'),
      photoSourcePaths: [sourcePath],
    );
    expect((result as Err).failure, isA<StorageFailure>());
    expect(await journal.watchAll().first, isEmpty);
  });

  test('delete removes the entry and its files', () async {
    final entry = (await journal.create(
      JournalDraft(gardenId: gardenId, date: today, note: 'x'),
      photoSourcePaths: [sourcePath],
    )).valueOrNull!;
    final file = File(p.join(root.path, entry.photos.single.relativePath));
    expect(file.existsSync(), isTrue);
    await journal.delete(entry.id);
    expect(await journal.watchAll().first, isEmpty);
    expect(file.existsSync(), isFalse);
    expect(
      ((await journal.delete(entry.id)) as Err).failure,
      isA<NotFoundFailure>(),
    );
  });

  test('removing a planting keeps its entries but unlinks them', () async {
    await journal.create(
      JournalDraft(
        gardenId: gardenId,
        plantingId: plantingId,
        date: today,
        note: 'x',
      ),
    );
    await (db.delete(db.plantings)..where((p) => p.id.equals(plantingId))).go();
    final entry = (await journal.watchAll().first).single;
    expect(entry.plantingId, isNull);
  });

  test('deleting the garden removes entries and their photo files', () async {
    final entry = (await journal.create(
      JournalDraft(gardenId: gardenId, date: today, note: 'x'),
      photoSourcePaths: [sourcePath],
    )).valueOrNull!;
    final file = File(p.join(root.path, entry.photos.single.relativePath));
    await GardenService(
      gardens,
      storage,
      const DeveloperLogger(),
    ).deleteGarden(gardenId);
    expect(await journal.watchAll().first, isEmpty);
    expect(file.existsSync(), isFalse);
  });
}
