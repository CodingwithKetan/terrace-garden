import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/app/app.dart';
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/database/database_provider.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/storage/photo_picker.dart';
import 'package:terrace_garden/core/storage/photo_storage.dart';
import 'package:terrace_garden/core/storage/storage_providers.dart';
import 'package:terrace_garden/features/settings/application/settings_controller.dart';
import 'package:terrace_garden/features/settings/domain/app_settings.dart';

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
  TestApp({AppSettings settings = const AppSettings(onboardingCompleted: true)})
    : settings = FakeSettingsRepository(settings),
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

  List<Override> get overrides => [
    settingsRepositoryProvider.overrideWithValue(settings),
    appDatabaseProvider.overrideWithValue(database),
    photoRootProvider.overrideWith((ref) async => photoRoot),
    photoStorageProvider.overrideWithValue(
      FileSystemPhotoStorage(() async => photoRoot, compressor),
    ),
    photoPickerProvider.overrideWithValue(picker),
  ];

  Future<void> pump(WidgetTester tester) async {
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

  Future<void> dispose() async {
    await database.close();
    if (photoRoot.existsSync()) photoRoot.deleteSync(recursive: true);
  }
}
