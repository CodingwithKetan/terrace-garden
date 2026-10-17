import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/settings/data/shared_preferences_settings_repository.dart';
import 'package:terrace_garden/features/settings/domain/app_settings.dart';

void main() {
  late SharedPreferencesAsync prefs;
  late SharedPreferencesSettingsRepository repository;

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    prefs = SharedPreferencesAsync();
    repository = SharedPreferencesSettingsRepository(
      prefs,
      const DeveloperLogger(),
    );
  });

  test('returns defaults on first launch', () async {
    expect(await repository.load(), AppSettings.defaults);
  });

  test('persists theme and unit choices', () async {
    expect(
      (await repository.saveThemePreference(ThemePreference.dark)).isOk,
      isTrue,
    );
    expect((await repository.saveUnitSystem(UnitSystem.imperial)).isOk, isTrue);

    final reloaded = SharedPreferencesSettingsRepository(
      prefs,
      const DeveloperLogger(),
    );
    expect(
      await reloaded.load(),
      const AppSettings(
        themePreference: ThemePreference.dark,
        unitSystem: UnitSystem.imperial,
      ),
    );
  });

  test('falls back to defaults for unknown stored values', () async {
    await prefs.setString(
      SharedPreferencesSettingsRepository.themeKey,
      'sepia',
    );
    await prefs.setString(SharedPreferencesSettingsRepository.unitsKey, '');
    expect(await repository.load(), AppSettings.defaults);
  });
}
