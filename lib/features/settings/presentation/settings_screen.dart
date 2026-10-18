import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:terrace_garden/app/data/data_reset_service.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/core/widgets/async_state_view.dart';
import 'package:terrace_garden/core/widgets/dialogs.dart';
import 'package:terrace_garden/core/widgets/error_state.dart';
import 'package:terrace_garden/core/widgets/section_header.dart';
import 'package:terrace_garden/features/care/care.dart';
import 'package:terrace_garden/features/settings/application/settings_controller.dart';
import 'package:terrace_garden/features/settings/domain/app_settings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// SET-01. Theme, units and the daily care reminder; data export arrives
/// in Phase 6.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: AsyncStateView(
        value: settings,
        onRetry: () => ref.invalidate(settingsControllerProvider),
        data: (settings) => _SettingsList(settings: settings),
      ),
    );
  }
}

class _SettingsList extends ConsumerWidget {
  const _SettingsList({required this.settings});

  final AppSettings settings;

  Future<void> _apply(
    BuildContext context,
    Future<Result<void>> Function() update,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    final result = await update();
    if (result case Err(:final failure)) {
      messenger.showSnackBar(
        SnackBar(content: Text(ErrorState.messageFor(l10n, failure))),
      );
    }
  }

  Future<void> _deleteEverything(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.deleteAllTitle,
      message: l10n.deleteAllBody,
      confirmLabel: l10n.deleteAllConfirm,
      destructive: true,
    );
    if (!confirmed) return;
    final result = await ref.read(dataResetServiceProvider).deleteEverything();
    if (result case Err()) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.deleteAllFailed)));
      return;
    }
    router.go(AppRoutes.onboarding);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final controller = ref.read(settingsControllerProvider.notifier);
    final gutter = AppSpacing.gutterFor(MediaQuery.sizeOf(context).width);

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppBreakpoints.readableMaxWidth,
        ),
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            gutter,
            AppSpacing.lg,
            gutter,
            AppSpacing.xxl,
          ),
          children: [
            SectionHeader(title: l10n.settingsAppearance),
            Text(l10n.settingsTheme, style: theme.textTheme.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            SegmentedButton<ThemePreference>(
              showSelectedIcon: false,
              segments: [
                ButtonSegment(
                  value: ThemePreference.system,
                  label: Text(l10n.themeSystem),
                  icon: const Icon(Icons.brightness_auto_outlined),
                ),
                ButtonSegment(
                  value: ThemePreference.light,
                  label: Text(l10n.themeLight),
                  icon: const Icon(Icons.light_mode_outlined),
                ),
                ButtonSegment(
                  value: ThemePreference.dark,
                  label: Text(l10n.themeDark),
                  icon: const Icon(Icons.dark_mode_outlined),
                ),
              ],
              selected: {settings.themePreference},
              onSelectionChanged: (selection) => _apply(
                context,
                () => controller.setThemePreference(selection.single),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(l10n.settingsUnits, style: theme.textTheme.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            SegmentedButton<UnitSystem>(
              showSelectedIcon: false,
              segments: [
                ButtonSegment(
                  value: UnitSystem.metric,
                  label: Text(l10n.unitsMetric),
                ),
                ButtonSegment(
                  value: UnitSystem.imperial,
                  label: Text(l10n.unitsImperial),
                ),
              ],
              selected: {settings.unitSystem},
              onSelectionChanged: (selection) => _apply(
                context,
                () => controller.setUnitSystem(selection.single),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            ReminderSettingsSection(settings: settings),
            const SizedBox(height: AppSpacing.xxl),
            SectionHeader(title: l10n.settingsData),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.delete_forever_outlined,
                color: theme.colorScheme.error,
              ),
              title: Text(l10n.deleteAllData),
              subtitle: Text(l10n.deleteAllDataSubtitle),
              onTap: () => _deleteEverything(context, ref),
            ),
            const SizedBox(height: AppSpacing.xxl),
            SectionHeader(title: l10n.settingsAbout),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.photo_outlined),
              title: Text(l10n.imageCreditsTitle),
              subtitle: Text(l10n.imageCreditsSubtitle),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => context.push(AppRoutes.imageCredits),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.description_outlined),
              title: Text(l10n.settingsLicences),
              subtitle: Text(l10n.settingsLicencesSubtitle),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => showLicensePage(
                context: context,
                applicationName: l10n.appTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
