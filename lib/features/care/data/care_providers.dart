import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/core/database/database_provider.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/care/data/drift_care_repository.dart';
import 'package:terrace_garden/features/care/data/local_notification_scheduler.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/care/domain/care_repository.dart';
import 'package:terrace_garden/features/care/domain/notification_scheduler.dart';

part 'care_providers.g.dart';

@Riverpod(keepAlive: true)
CareRepository careRepository(Ref ref) => DriftCareRepository(
  ref.watch(appDatabaseProvider),
  ref.watch(idGeneratorProvider),
  ref.watch(appLoggerProvider),
);

@Riverpod(keepAlive: true)
NotificationScheduler notificationScheduler(Ref ref) =>
    LocalNotificationScheduler(ref.watch(appLoggerProvider));

/// Days of upcoming tasks shown on Today.
const agendaDays = 7;

/// Today's agenda: overdue, today and the next [agendaDays] days, plus tasks
/// finished today.
@riverpod
Stream<List<CareTask>> agenda(Ref ref) {
  final today = LocalDate.fromDateTime(ref.watch(clockProvider).now());
  return ref
      .watch(careRepositoryProvider)
      .watchAgenda(until: today.addDays(agendaDays), doneOn: today);
}

@riverpod
Stream<List<CareTask>> pendingTasks(Ref ref) =>
    ref.watch(careRepositoryProvider).watchPending();

@riverpod
Stream<List<CareRule>> plantingRules(Ref ref, String plantingId) =>
    ref.watch(careRepositoryProvider).watchRules(plantingId);
