import 'package:meta/meta.dart';
import 'package:terrace_garden/core/units/measurements.dart';

/// Theme choice, kept independent of Flutter's `ThemeMode` so the domain layer
/// stays pure Dart.
enum ThemePreference { system, light, dark }

/// User-level preferences stored on the device.
@immutable
final class AppSettings {
  const AppSettings({
    this.themePreference = ThemePreference.system,
    this.unitSystem = UnitSystem.metric,
  });

  /// Defaults for a first launch. Metric suits the India-first audience.
  static const defaults = AppSettings();

  final ThemePreference themePreference;
  final UnitSystem unitSystem;

  AppSettings copyWith({
    ThemePreference? themePreference,
    UnitSystem? unitSystem,
  }) => AppSettings(
    themePreference: themePreference ?? this.themePreference,
    unitSystem: unitSystem ?? this.unitSystem,
  );

  @override
  bool operator ==(Object other) =>
      other is AppSettings &&
      other.themePreference == themePreference &&
      other.unitSystem == unitSystem;

  @override
  int get hashCode => Object.hash(themePreference, unitSystem);
}
