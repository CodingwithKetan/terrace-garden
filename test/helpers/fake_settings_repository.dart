import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/settings/domain/app_settings.dart';
import 'package:terrace_garden/features/settings/domain/settings_repository.dart';

/// In-memory settings store. Set [failSaves] to simulate storage errors.
class FakeSettingsRepository implements SettingsRepository {
  FakeSettingsRepository([this.stored = AppSettings.defaults]);

  AppSettings stored;
  bool failSaves = false;

  @override
  Future<AppSettings> load() async => stored;

  @override
  Future<Result<void>> saveThemePreference(ThemePreference preference) async {
    if (failSaves) return const Err(StorageFailure());
    stored = stored.copyWith(themePreference: preference);
    return const Ok(null);
  }

  @override
  Future<Result<void>> saveUnitSystem(UnitSystem unitSystem) async {
    if (failSaves) return const Err(StorageFailure());
    stored = stored.copyWith(unitSystem: unitSystem);
    return const Ok(null);
  }
}
