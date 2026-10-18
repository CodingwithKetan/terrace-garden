import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/settings/data/shared_preferences_settings_repository.dart';
import 'package:terrace_garden/features/settings/domain/app_settings.dart';
import 'package:terrace_garden/features/settings/domain/settings_repository.dart';

part 'settings_controller.g.dart';

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) =>
    SharedPreferencesSettingsRepository(
      ref.watch(sharedPreferencesProvider),
      ref.watch(appLoggerProvider),
    );

/// App-wide settings state. Updates are optimistic: the UI changes at once and
/// rolls back if saving fails.
@Riverpod(keepAlive: true)
class SettingsController extends _$SettingsController {
  @override
  Future<AppSettings> build() => ref.watch(settingsRepositoryProvider).load();

  Future<Result<void>> setThemePreference(ThemePreference preference) =>
      _update(
        (settings) => settings.copyWith(themePreference: preference),
        (repository) => repository.saveThemePreference(preference),
      );

  Future<Result<void>> setUnitSystem(UnitSystem unitSystem) => _update(
    (settings) => settings.copyWith(unitSystem: unitSystem),
    (repository) => repository.saveUnitSystem(unitSystem),
  );

  Future<Result<void>> setLanguage(AppLanguage language) => _update(
    (settings) => settings.copyWith(language: language),
    (repository) => repository.saveLanguage(language),
  );

  /// Marks onboarding as finished (or skipped) so it is not shown again.
  Future<Result<void>> completeOnboarding() => _update(
    (settings) => settings.copyWith(onboardingCompleted: true),
    (repository) => repository.saveOnboardingCompleted(completed: true),
  );

  Future<Result<void>> setReminder({
    required bool enabled,
    required int minutes,
  }) => _update(
    (settings) =>
        settings.copyWith(reminderEnabled: enabled, reminderMinutes: minutes),
    (repository) => repository.saveReminder(enabled: enabled, minutes: minutes),
  );

  /// Clears stored settings and returns to first-launch defaults.
  Future<Result<void>> reset() async {
    final result = await ref.read(settingsRepositoryProvider).clear();
    if (result case Ok()) state = const AsyncData(AppSettings.defaults);
    return result;
  }

  Future<Result<void>> _update(
    AppSettings Function(AppSettings) change,
    Future<Result<void>> Function(SettingsRepository) save,
  ) async {
    final previous = await future;
    state = AsyncData(change(previous));
    final result = await save(ref.read(settingsRepositoryProvider));
    if (result case Err()) state = AsyncData(previous);
    return result;
  }
}
