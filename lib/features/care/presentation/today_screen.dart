import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/app/theme/app_imagery.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/app/theme/care_colors.dart';
import 'package:terrace_garden/app/theme/glass_theme.dart';
import 'package:terrace_garden/core/widgets/glass_icon_button.dart';
import 'package:terrace_garden/core/widgets/glass_panel.dart';
import 'package:terrace_garden/core/widgets/photo_backdrop.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// HOME-01. Today's care agenda arrives in Phase 5; until then the screen
/// greets the user and shows one sourced, always-true care tip.
class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final now = ref.watch(clockProvider).now();
    final locale = Localizations.localeOf(context).toLanguageTag();

    return Scaffold(
      body: PhotoBackdrop(
        image: const AssetImage(AppPhotos.todayTerrace),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final gutter = AppSpacing.gutterFor(constraints.maxWidth);
            final insets = MediaQuery.paddingOf(context);
            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppBreakpoints.readableMaxWidth,
                ),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    gutter,
                    insets.top + AppSpacing.md,
                    gutter,
                    insets.bottom + AppSpacing.xl,
                  ),
                  children: [
                    _Header(
                      date: DateFormat.MMMMEEEEd(locale).format(now),
                      greeting: switch (now.hour) {
                        < 12 => l10n.greetingMorning,
                        < 17 => l10n.greetingAfternoon,
                        _ => l10n.greetingEvening,
                      },
                      subtitle: l10n.todayEmptyTitle,
                      onSettings: () => context.push(AppRoutes.settings),
                    ),
                    // Let the photo breathe before the content cards.
                    SizedBox(height: constraints.maxHeight * 0.22),
                    _TodayCareCard(
                      heading: l10n.todayCareHeading,
                      title: l10n.todayNoTasks,
                      body: l10n.todayEmptyBody,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _TipCard(
                      title: l10n.tipWateringTitle,
                      body: l10n.tipWateringBody,
                      source: l10n.tipWateringSource,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.date,
    required this.greeting,
    required this.subtitle,
    required this.onSettings,
  });

  final String date;
  final String greeting;
  final String subtitle;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final onPhoto = context.glass.onPhoto;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date.toUpperCase(),
                style: text.labelMedium?.copyWith(
                  color: onPhoto,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Semantics(
                header: true,
                child: Text(
                  greeting,
                  style: text.displaySmall?.copyWith(color: onPhoto),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                style: text.bodyLarge?.copyWith(color: onPhoto),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        GlassIconButton(
          icon: Icons.settings_outlined,
          tooltip: context.l10n.settingsTooltip,
          onPressed: onSettings,
        ),
      ],
    );
  }
}

class _TodayCareCard extends StatelessWidget {
  const _TodayCareCard({
    required this.heading,
    required this.title,
    required this.body,
  });

  final String heading;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading.toUpperCase(),
            style: theme.textTheme.labelMedium?.copyWith(
              color: colors.onSurface,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Icon(
                    Icons.eco_outlined,
                    color: colors.onPrimaryContainer,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.xs),
                    Text(body, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard({
    required this.title,
    required this.body,
    required this.source,
  });

  final String title;
  final String body;
  final String source;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final water = context.careColors.water;

    return GlassPanel(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: water.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Icon(Icons.water_drop_outlined, color: water),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(body, style: theme.textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  source,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
