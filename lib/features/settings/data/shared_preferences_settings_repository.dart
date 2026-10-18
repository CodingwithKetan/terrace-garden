import 'package:shared_preferences/shared_preferences.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/settings/domain/app_settings.dart';
import 'package:terrace_garden/features/settings/domain/settings_repository.dart';

/// Stores settings as enum names in SharedPreferences (ADR-005).
final class SharedPreferencesSettingsRepository implements SettingsRepository {
  SharedPreferencesSettingsRepository(this._prefs, this._logger);

  static const themeKey = 'settings.themePreference';
  static const unitsKey = 'settings.unitSystem';
  static const onboardingKey = 'settings.onboardingCompleted';
  static const reminderEnabledKey = 'settings.reminderEnabled';
  static const reminderMinutesKey = 'settings.reminderMinutes';

  final SharedPreferencesAsync _prefs;
  final AppLogger _logger;

  @override
  Future<AppSettings> load() async {
    try {
      final theme = await _prefs.getString(themeKey);
      final units = await _prefs.getString(unitsKey);
      final onboarded = await _prefs.getBool(onboardingKey);
      final reminder = await _prefs.getBool(reminderEnabledKey);
      final minutes = await _prefs.getInt(reminderMinutesKey);
      return AppSettings(
        themePreference: _byName(
          ThemePreference.values,
          theme,
          AppSettings.defaults.themePreference,
        ),
        unitSystem: _byName(
          UnitSystem.values,
          units,
          AppSettings.defaults.unitSystem,
        ),
        onboardingCompleted: onboarded ?? false,
        reminderEnabled: reminder ?? false,
        reminderMinutes: (minutes != null && minutes >= 0 && minutes < 24 * 60)
            ? minutes
            : AppSettings.defaultReminderMinutes,
      );
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Failed to read settings; using defaults',
        error: error,
        stackTrace: stackTrace,
      );
      return AppSettings.defaults;
    }
  }

  @override
  Future<Result<void>> saveThemePreference(ThemePreference preference) =>
      _write(themeKey, preference.name);

  @override
  Future<Result<void>> saveUnitSystem(UnitSystem unitSystem) =>
      _write(unitsKey, unitSystem.name);

  @override
  Future<Result<void>> saveOnboardingCompleted({
    required bool completed,
  }) async {
    try {
      await _prefs.setBool(onboardingKey, completed);
      return const Ok(null);
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Failed to save onboarding state',
        error: error,
        stackTrace: stackTrace,
      );
      return Err(StorageFailure(error));
    }
  }

  @override
  Future<Result<void>> saveReminder({
    required bool enabled,
    required int minutes,
  }) async {
    try {
      await _prefs.setBool(reminderEnabledKey, enabled);
      await _prefs.setInt(reminderMinutesKey, minutes);
      return const Ok(null);
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Failed to save reminder settings',
        error: error,
        stackTrace: stackTrace,
      );
      return Err(StorageFailure(error));
    }
  }

  Future<Result<void>> _write(String key, String value) async {
    try {
      await _prefs.setString(key, value);
      return const Ok(null);
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Failed to save setting $key',
        error: error,
        stackTrace: stackTrace,
      );
      return Err(StorageFailure(error));
    }
  }

  // Unknown names (e.g. from a future app version) fall back to the default.
  static T _byName<T extends Enum>(List<T> values, String? name, T fallback) =>
      values.where((value) => value.name == name).firstOrNull ?? fallback;
}
