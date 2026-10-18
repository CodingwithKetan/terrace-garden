import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/features/care/application/care_sync.dart';
import 'package:terrace_garden/features/care/data/care_providers.dart';
import 'package:terrace_garden/features/garden/garden.dart';
import 'package:terrace_garden/features/plant_catalog/plant_catalog.dart';
import 'package:terrace_garden/features/plantings/plantings.dart';
import 'package:terrace_garden/features/settings/settings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

part 'care_controllers.g.dart';

@Riverpod(keepAlive: true)
CareSync careSync(Ref ref) => CareSync(
  care: ref.watch(careRepositoryProvider),
  plantings: ref.watch(plantingRepositoryProvider),
  gardens: ref.watch(gardenRepositoryProvider),
  catalogue: ref.watch(catalogueRepositoryProvider),
  clock: ref.watch(clockProvider),
  logger: ref.watch(appLoggerProvider),
);

@Riverpod(keepAlive: true)
NotificationSync notificationSync(Ref ref) => NotificationSync(
  care: ref.watch(careRepositoryProvider),
  scheduler: ref.watch(notificationSchedulerProvider),
  clock: ref.watch(clockProvider),
  logger: ref.watch(appLoggerProvider),
);

/// Watched by the app root: reconciles care plans whenever plantings change,
/// and mirrors pending tasks into digest notifications whenever tasks or
/// reminder settings change.
@Riverpod(keepAlive: true)
void careAutomation(Ref ref) {
  final sync = ref.watch(careSyncProvider);
  ref.listen(allPlantingsProvider, (_, next) {
    if (next.hasValue) unawaited(sync.reconcile());
  }, fireImmediately: true);

  void planNotifications() {
    final tasks = ref.read(pendingTasksProvider).value;
    final settings = ref.read(settingsControllerProvider).value;
    if (tasks == null || settings == null) return;
    // Notifications are built outside any widget: use the chosen language,
    // or the phone's when it is supported, else English.
    final l10n = lookupAppLocalizations(
      appLocaleFor(
        settings.language.code,
        WidgetsBinding.instance.platformDispatcher.locale,
      ),
    );
    unawaited(
      ref
          .read(notificationSyncProvider)
          .sync(
            tasks: tasks,
            enabled: settings.reminderEnabled,
            minutesOfDay: settings.reminderMinutes,
            title: l10n.digestTitle,
            body: l10n.digestBody,
          ),
    );
  }

  ref
    ..listen(pendingTasksProvider, (_, _) => planNotifications())
    ..listen(settingsControllerProvider, (_, _) => planNotifications());
}
