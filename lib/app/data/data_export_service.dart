import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:drift/drift.dart' show DataClass, Table, TableInfo;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/database/database_provider.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/storage/storage_providers.dart';
import 'package:terrace_garden/core/time/clock.dart';

part 'data_export_service.g.dart';

/// Hands a file to the platform share sheet; replaced by a fake in tests.
abstract interface class FileSharer {
  Future<void> shareFile(File file, {required String subject});
}

final class SharePlusFileSharer implements FileSharer {
  const SharePlusFileSharer();

  @override
  Future<void> shareFile(File file, {required String subject}) async {
    await SharePlus.instance.share(
      ShareParams(files: [XFile(file.path)], subject: subject),
    );
  }
}

/// "Export my data" (P6-03): a ZIP with `data.json` (every user table) and
/// the photo files, so nothing the user created is locked in the app.
final class DataExportService {
  DataExportService({
    required this._db,
    required this._photoRoot,
    required this._tempDir,
    required this._clock,
    required this._logger,
  });

  static const format = 'terrace-garden-export';
  static const formatVersion = 1;

  final AppDatabase _db;
  final Future<Directory> Function() _photoRoot;
  final Future<Directory> Function() _tempDir;
  final Clock _clock;
  final AppLogger _logger;

  /// The export as JSON-ready data. Scheduled-notification bookkeeping is
  /// device-specific and left out.
  Future<Map<String, Object?>> snapshot() async {
    Future<List<Map<String, Object?>>> rows<T extends DataClass>(
      TableInfo<Table, T> table,
    ) async => [
      for (final row in await _db.select(table).get()) row.toJson(),
    ];

    return {
      'format': format,
      'formatVersion': formatVersion,
      'schemaVersion': _db.schemaVersion,
      'exportedAt': _clock.now().toUtc().toIso8601String(),
      'tables': {
        'gardens': await rows(_db.gardens),
        'gardenPhotos': await rows(_db.gardenPhotos),
        'layoutElements': await rows(_db.layoutElements),
        'plantings': await rows(_db.plantings),
        'shortlistEntries': await rows(_db.shortlistEntries),
        'careRules': await rows(_db.careRules),
        'careTasks': await rows(_db.careTasks),
        'journalEntries': await rows(_db.journalEntries),
        'journalPhotos': await rows(_db.journalPhotos),
      },
    };
  }

  /// Writes the ZIP to the temporary directory and returns it.
  Future<Result<File>> buildArchive() async {
    try {
      final stamp = _clock
          .now()
          .toIso8601String()
          .substring(0, 19)
          .replaceAll(':', '-');
      final zipPath = p.join((await _tempDir()).path, '$format-$stamp.zip');
      final json = const JsonEncoder.withIndent(
        '  ',
      ).convert(await snapshot());
      final encoder = ZipFileEncoder()
        ..create(zipPath)
        ..addArchiveFile(ArchiveFile.string('data.json', json));
      final photos = Directory(p.join((await _photoRoot()).path, 'photos'));
      if (photos.existsSync()) {
        for (final file in photos.listSync(recursive: true).whereType<File>()) {
          final relative = p
              .relative(file.path, from: (await _photoRoot()).path)
              .replaceAll(r'\', '/');
          await encoder.addFile(file, relative);
        }
      }
      await encoder.close();
      return Ok(File(zipPath));
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Failed to build data export',
        error: error,
        stackTrace: stackTrace,
      );
      return Err(StorageFailure(error));
    }
  }
}

@Riverpod(keepAlive: true)
FileSharer fileSharer(Ref ref) => const SharePlusFileSharer();

@riverpod
DataExportService dataExportService(Ref ref) => DataExportService(
  db: ref.watch(appDatabaseProvider),
  photoRoot: () => ref.read(photoRootProvider.future),
  tempDir: getTemporaryDirectory,
  clock: ref.watch(clockProvider),
  logger: ref.watch(appLoggerProvider),
);
