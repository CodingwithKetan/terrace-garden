import 'package:terrace_garden/features/care/domain/notification_planner.dart';
import 'package:terrace_garden/features/care/domain/notification_scheduler.dart';

/// Records what the app asks the platform to schedule.
class FakeNotificationScheduler implements NotificationScheduler {
  final scheduled = <int, ({PlannedDigest digest, String body})>{};
  bool permissionGranted = true;
  int permissionRequests = 0;

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> requestPermission() async {
    permissionRequests++;
    return permissionGranted;
  }

  @override
  Future<void> scheduleDigest(
    PlannedDigest digest, {
    required String title,
    required String body,
  }) async => scheduled[digest.id] = (digest: digest, body: body);

  @override
  Future<void> cancel(int id) async => scheduled.remove(id);
}
