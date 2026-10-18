import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/features/care/domain/notification_planner.dart';
import 'package:terrace_garden/features/care/domain/notification_scheduler.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// `flutter_local_notifications` adapter. Inexact scheduling only: no exact
/// alarm permission is declared (ADR-008), so a digest may arrive a few
/// minutes late on Android.
final class LocalNotificationScheduler implements NotificationScheduler {
  LocalNotificationScheduler(this._logger);

  static const _channelId = 'care_digest';

  final AppLogger _logger;
  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    tz_data.initializeTimeZones();
    try {
      final zone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(zone.identifier));
    } on Object catch (error, stackTrace) {
      // Fall back to UTC wall-clock times rather than not scheduling at all.
      _logger.error(
        'Could not read the device time zone',
        error: error,
        stackTrace: stackTrace,
      );
    }
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
    );
    _initialized = true;
  }

  @override
  Future<bool> requestPermission() async {
    await initialize();
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android != null) {
      return await android.requestNotificationsPermission() ?? false;
    }
    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (ios != null) {
      return await ios.requestPermissions(alert: true, sound: true) ?? false;
    }
    return false;
  }

  @override
  Future<void> scheduleDigest(
    PlannedDigest digest, {
    required String title,
    required String body,
  }) async {
    await initialize();
    final at = digest.fireAt;
    await _plugin.zonedSchedule(
      id: digest.id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime(
        tz.local,
        at.year,
        at.month,
        at.day,
        at.hour,
        at.minute,
      ),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          'Daily care digest',
          channelDescription: "Today's garden tasks, once a day",
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  @override
  Future<void> cancel(int id) async {
    await initialize();
    await _plugin.cancel(id: id);
  }
}
