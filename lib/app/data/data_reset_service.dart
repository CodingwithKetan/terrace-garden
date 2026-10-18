import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/database/database_provider.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/storage/photo_storage.dart';
import 'package:terrace_garden/core/storage/storage_providers.dart';
import 'package:terrace_garden/features/care/data/care_providers.dart';
import 'package:terrace_garden/features/care/domain/care_repository.dart';
import 'package:terrace_garden/features/care/domain/notification_scheduler.dart';
import 'package:terrace_garden/features/settings/application/settings_controller.dart';

part 'data_reset_service.g.dart';

/// "Delete all data" (P6-03): spans every feature, so it lives at the app
/// composition root.
final class DataResetService {
  DataResetService({
    required this._db,
    required this._care,
    required this._scheduler,
    required this._storage,
    required this._resetSettings,
    required this._logger,
  });

  final AppDatabase _db;
  final CareRepository _care;
  final NotificationScheduler _scheduler;
  final PhotoStorage _storage;
  final Future<Result<void>> Function() _resetSettings;
  final AppLogger _logger;

  /// Cancels scheduled notifications, deletes every row (gardens cascade to
  /// photos, layouts, plantings, care and journal), removes photo files and
  /// resets settings. Continues past individual failures and reports one.
  Future<Result<void>> deleteEverything() async {
    Object? firstError;
    Future<void> step(String what, Future<void> Function() body) async {
      try {
        await body();
      } on Object catch (error, stackTrace) {
        firstError ??= error;
        _logger.error(
          'Delete all data: $what failed',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }

    await step('cancel notifications', () async {
      for (final digest in await _care.scheduledDigests()) {
        await _scheduler.cancel(digest.id);
      }
    });
    await step('delete rows', () async {
      await _db.transaction(() async {
        await _db.delete(_db.gardens).go();
        await _db.delete(_db.scheduledNotifications).go();
      });
    });
    await step('delete photos', () => _storage.deleteFolder('photos'));
    await step('reset settings', () async {
      if (await _resetSettings() case Err(:final failure)) throw failure;
    });
    return firstError == null
        ? const Ok(null)
        : Err(StorageFailure(firstError));
  }
}

@riverpod
DataResetService dataResetService(Ref ref) => DataResetService(
  db: ref.watch(appDatabaseProvider),
  care: ref.watch(careRepositoryProvider),
  scheduler: ref.watch(notificationSchedulerProvider),
  storage: ref.watch(photoStorageProvider),
  resetSettings: () => ref.read(settingsControllerProvider.notifier).reset(),
  logger: ref.watch(appLoggerProvider),
);
