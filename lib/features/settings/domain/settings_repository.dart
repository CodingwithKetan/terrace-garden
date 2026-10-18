import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/settings/domain/app_settings.dart';

abstract interface class SettingsRepository {
  /// Returns stored settings, falling back to defaults for missing or
  /// unreadable values (settings must never block app start).
  Future<AppSettings> load();

  Future<Result<void>> saveThemePreference(ThemePreference preference);

  Future<Result<void>> saveUnitSystem(UnitSystem unitSystem);

  Future<Result<void>> saveOnboardingCompleted({required bool completed});

  Future<Result<void>> saveReminder({
    required bool enabled,
    required int minutes,
  });
}
