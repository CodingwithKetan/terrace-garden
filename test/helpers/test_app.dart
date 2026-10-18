import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/app/app.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/database/database_provider.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/storage/photo_picker.dart';
import 'package:terrace_garden/core/storage/photo_storage.dart';
import 'package:terrace_garden/core/storage/storage_providers.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/features/care/data/care_providers.dart';
import 'package:terrace_garden/features/settings/application/settings_controller.dart';
import 'package:terrace_garden/features/settings/domain/app_settings.dart';

import 'fake_notification_scheduler.dart';
import 'fake_settings_repository.dart';
import 'test_images.dart';

/// Picker that returns preset paths (or a failure) without platform UI.
class FakePhotoPicker implements PhotoPicker {
  Result<List<String>> next = const Ok([]);

  @override
  Future<Result<List<String>>> pick(
    PhotoSource source, {
    bool multiple = false,
  }) async => next;

  @override
  Future<List<String>> retrieveLost() async => const [];
}

/// Everything an app-level widget test needs, with fakes at the edges:
/// in-memory database, temp photo folder, fake picker and settings.
class TestApp {
  TestApp({
    AppSettings settings = const AppSettings(onboardingCompleted: true),
    this.now,
    this.surface,
  }) : settings = FakeSettingsRepository(settings),
       database = AppDatabase(
         DatabaseConnection(
           NativeDatabase.memory(),
           closeStreamsSynchronously: true,
         ),
       ),
       photoRoot = Directory.systemTemp.createTempSync('app_test'),
       picker = FakePhotoPicker(),
       compressor = CopyingImageCompressor();

  final FakeSettingsRepository settings;
  final AppDatabase database;
  final Directory photoRoot;
  final FakePhotoPicker picker;
  final CopyingImageCompressor compressor;
  final FakeNotificationScheduler notifications = FakeNotificationScheduler();

  /// When set, the app clock is fixed at this time (e.g. for season checks).
  final DateTime? now;

  /// When set, the test window is this size in logical pixels (e.g. a
  /// portrait phone) instead of the 800 × 600 default.
  final Size? surface;

  List<Override> get overrides => [
    settingsRepositoryProvider.overrideWithValue(settings),
    appDatabaseProvider.overrideWithValue(database),
    photoRootProvider.overrideWith((ref) async => photoRoot),
    photoStorageProvider.overrideWithValue(
      FileSystemPhotoStorage(() async => photoRoot, compressor),
    ),
    photoPickerProvider.overrideWithValue(picker),
    notificationSchedulerProvider.overrideWithValue(notifications),
    if (now != null) clockProvider.overrideWithValue(FixedClock(now!)),
  ];

  Future<void> pump(WidgetTester tester) async {
    if (surface case final size?) {
      tester.view
        ..physicalSize = size
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
    }
    addTearDown(() async {
      // Unmount first so stream subscriptions end before the database
      // closes; otherwise a failing test can hang instead of failing.
      await tester.pumpWidget(const SizedBox());
      await dispose();
    });
    await tester.pumpWidget(
      ProviderScope(overrides: overrides, child: const TerraceGardenApp()),
    );
    await tester.pumpAndSettle();
  }

  /// Pushes [location] (e.g. the gardens list, which is reached from
  /// Today rather than a tab) and settles.
  Future<void> open(WidgetTester tester, String location) async {
    final container = ProviderScope.containerOf(
      tester.element(find.byType(TerraceGardenApp)),
    );
    unawaited(container.read(appRouterProvider).push<void>(location));
    await tester.pumpAndSettle();
  }

  Future<void> dispose() async {
    await database.close();
    if (photoRoot.existsSync()) photoRoot.deleteSync(recursive: true);
  }
}
