import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/widgets/error_state.dart';
import 'package:terrace_garden/core/widgets/section_header.dart';
import 'package:terrace_garden/features/care/data/care_providers.dart';
import 'package:terrace_garden/features/settings/application/settings_controller.dart';
import 'package:terrace_garden/features/settings/domain/app_settings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// CARE-05. The daily digest switch and time. Permission is asked only when
/// the user turns reminders on (ADR-008).
class ReminderSettingsSection extends ConsumerWidget {
  const ReminderSettingsSection({required this.settings, super.key});

  final AppSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final controller = ref.read(settingsControllerProvider.notifier);
    final time = TimeOfDay(
      hour: settings.reminderMinutes ~/ 60,
      minute: settings.reminderMinutes % 60,
    );

    Future<void> save({required bool enabled, required int minutes}) async {
      final messenger = ScaffoldMessenger.of(context);
      final result = await controller.setReminder(
        enabled: enabled,
        minutes: minutes,
      );
      if (result case Err(:final failure)) {
        messenger.showSnackBar(
          SnackBar(content: Text(ErrorState.messageFor(l10n, failure))),
        );
      }
    }

    Future<void> toggle({required bool on}) async {
      if (on) {
        final messenger = ScaffoldMessenger.of(context);
        final allowed = await ref
            .read(notificationSchedulerProvider)
            .requestPermission();
        if (!allowed) {
          messenger.showSnackBar(
            SnackBar(content: Text(l10n.reminderPermissionDenied)),
          );
          return;
        }
      }
      await save(enabled: on, minutes: settings.reminderMinutes);
    }

    Future<void> pickTime() async {
      final picked = await showTimePicker(context: context, initialTime: time);
      if (picked == null) return;
      await save(
        enabled: settings.reminderEnabled,
        minutes: picked.hour * 60 + picked.minute,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(title: l10n.settingsReminders),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.notifications_outlined),
          title: Text(l10n.reminderDaily),
          subtitle: Text(l10n.reminderDailySubtitle(time.format(context))),
          value: settings.reminderEnabled,
          onChanged: (on) => toggle(on: on),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          enabled: settings.reminderEnabled,
          leading: const Icon(Icons.schedule_outlined),
          title: Text(l10n.reminderTime),
          trailing: Text(time.format(context)),
          onTap: pickTime,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(l10n.reminderNote, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
