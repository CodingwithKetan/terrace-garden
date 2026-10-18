import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:terrace_garden/app/data/data_export_service.dart';
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_repository.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/plantings/data/drift_planting_repository.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';

void main() {
  late Directory root;
  late Directory temp;
  late AppDatabase db;
  late DataExportService export;
  final clock = FixedClock(DateTime(2026, 10, 18, 9, 30));

  setUp(() async {
    root = await Directory.systemTemp.createTemp('export_root');
    temp = await Directory.systemTemp.createTemp('export_tmp');
    db = AppDatabase(NativeDatabase.memory());
    export = DataExportService(
      db: db,
      photoRoot: () async => root,
      tempDir: () async => temp,
      clock: clock,
      logger: const DeveloperLogger(),
    );
    const logger = DeveloperLogger();
    final gardenId = (await DriftGardenRepository(
      db,
      clock,
      SequentialIdGenerator('g'),
      logger,
    ).create(const GardenDraft(name: 'Roof'))).valueOrNull!.id;
    await DriftPlantingRepository(
      db,
      clock,
      SequentialIdGenerator('p'),
      logger,
    ).create(
      PlantingDraft(
        gardenId: gardenId,
        speciesId: 'tomato',
        plantedOn: LocalDate(2026, 10, 1),
      ),
    );
    final photo = File(p.join(root.path, 'photos', gardenId, 'a.jpg'));
    await photo.parent.create(recursive: true);
    await photo.writeAsBytes([1, 2, 3]);
  });

  tearDown(() async {
    await db.close();
    for (final d in [root, temp]) {
      if (d.existsSync()) d.deleteSync(recursive: true);
    }
  });

  test('snapshot holds every user table with readable values', () async {
    final data = await export.snapshot();
    expect(data['format'], DataExportService.format);
    expect(data['schemaVersion'], db.schemaVersion);
    final tables = data['tables']! as Map<String, Object?>;
    expect(tables.keys, containsAll(['gardens', 'plantings', 'careTasks']));
    final garden = (tables['gardens']! as List).single as Map<String, Object?>;
    expect(garden['name'], 'Roof');
    expect(garden['spaceType'], 'terrace');
    final planting =
        (tables['plantings']! as List).single as Map<String, Object?>;
    expect(planting['plantedOn'], '2026-10-01');
  });

  test('the ZIP contains data.json and the photo files', () async {
    final file = (await export.buildArchive()).valueOrNull!;
    expect(p.basename(file.path), contains('2026-10-18T09-30-00'));
    final archive = ZipDecoder().decodeBytes(file.readAsBytesSync());
    final names = archive.files.map((f) => f.name).toList();
    expect(names, contains('data.json'));
    expect(
      names.any((n) => n.startsWith('photos/') && n.endsWith('a.jpg')),
      isTrue,
    );
    final json =
        jsonDecode(utf8.decode(archive.findFile('data.json')!.content))
            as Map<String, Object?>;
    expect(json['formatVersion'], 1);
  });

  test('a failure is reported, not thrown', () async {
    // A file where the temp directory should be: the ZIP can't be created.
    final blocker = File(p.join(temp.path, 'blocked'))..writeAsStringSync('x');
    final broken = DataExportService(
      db: db,
      photoRoot: () async => root,
      tempDir: () async => Directory(blocker.path),
      clock: clock,
      logger: const DeveloperLogger(),
    );
    expect(await broken.buildArchive(), isA<Err<File>>());
  });
}
