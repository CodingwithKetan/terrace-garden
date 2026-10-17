import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/settings/application/settings_controller.dart';
import 'package:terrace_garden/features/settings/domain/app_settings.dart';

import '../../../helpers/fake_settings_repository.dart';

void main() {
  late FakeSettingsRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = FakeSettingsRepository(
      const AppSettings(unitSystem: UnitSystem.imperial),
    );
    container = ProviderContainer.test(
      overrides: [settingsRepositoryProvider.overrideWithValue(repository)],
    );
  });

  test('loads stored settings', () async {
    final settings = await container.read(settingsControllerProvider.future);
    expect(settings.unitSystem, UnitSystem.imperial);
  });

  test('updates state and persists a new theme preference', () async {
    await container.read(settingsControllerProvider.future);
    final result = await container
        .read(settingsControllerProvider.notifier)
        .setThemePreference(ThemePreference.dark);

    expect(result.isOk, isTrue);
    expect(
      container.read(settingsControllerProvider).value?.themePreference,
      ThemePreference.dark,
    );
    expect(repository.stored.themePreference, ThemePreference.dark);
  });

  test('rolls back the optimistic update when saving fails', () async {
    await container.read(settingsControllerProvider.future);
    repository.failSaves = true;

    final result = await container
        .read(settingsControllerProvider.notifier)
        .setUnitSystem(UnitSystem.metric);

    expect(result.failureOrNull, isA<StorageFailure>());
    expect(
      container.read(settingsControllerProvider).value?.unitSystem,
      UnitSystem.imperial,
    );
  });
}
