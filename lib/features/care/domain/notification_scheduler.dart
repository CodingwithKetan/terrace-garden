import 'package:terrace_garden/features/care/domain/notification_planner.dart';

/// The platform's notification schedule, behind an interface so planning
/// stays testable and the plugin can be swapped (ADR-008).
abstract interface class NotificationScheduler {
  Future<void> initialize();

  /// Asks for permission where the platform needs it (Android 13+, iOS).
  /// Returns whether notifications are allowed.
  Future<bool> requestPermission();

  Future<void> scheduleDigest(
    PlannedDigest digest, {
    required String title,
    required String body,
  });

  Future<void> cancel(int id);
}
