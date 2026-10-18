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
    this.onboardingCompleted = false,
    this.reminderEnabled = false,
    this.reminderMinutes = defaultReminderMinutes,
  });

  /// Defaults for a first launch. Metric suits the India-first audience.
  static const defaults = AppSettings();

  /// 07:00. Early morning is the best time to water (gardening-references
  /// §4c, S6), so the daily digest arrives then by default.
  static const int defaultReminderMinutes = 7 * 60;

  final ThemePreference themePreference;
  final UnitSystem unitSystem;

  /// True once the user finished or skipped onboarding ("explore first").
  final bool onboardingCompleted;

  /// Daily care digest notification (off until the user turns it on and
  /// grants permission).
  final bool reminderEnabled;

  /// Digest time as minutes after local midnight.
  final int reminderMinutes;

  AppSettings copyWith({
    ThemePreference? themePreference,
    UnitSystem? unitSystem,
    bool? onboardingCompleted,
    bool? reminderEnabled,
    int? reminderMinutes,
  }) => AppSettings(
    themePreference: themePreference ?? this.themePreference,
    unitSystem: unitSystem ?? this.unitSystem,
    onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    reminderEnabled: reminderEnabled ?? this.reminderEnabled,
    reminderMinutes: reminderMinutes ?? this.reminderMinutes,
  );

  @override
  bool operator ==(Object other) =>
      other is AppSettings &&
      other.themePreference == themePreference &&
      other.unitSystem == unitSystem &&
      other.onboardingCompleted == onboardingCompleted &&
      other.reminderEnabled == reminderEnabled &&
      other.reminderMinutes == reminderMinutes;

  @override
  int get hashCode => Object.hash(
    themePreference,
    unitSystem,
    onboardingCompleted,
    reminderEnabled,
    reminderMinutes,
  );
}
