import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/app/theme/app_imagery.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/app/theme/glass_theme.dart';
import 'package:terrace_garden/core/units/measurement_formatter.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/core/widgets/async_state_view.dart';
import 'package:terrace_garden/core/widgets/glass_panel.dart';
import 'package:terrace_garden/core/widgets/immersive_empty_state.dart';
import 'package:terrace_garden/core/widgets/photo_backdrop.dart';
import 'package:terrace_garden/features/garden/data/garden_providers.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';
import 'package:terrace_garden/features/garden/presentation/garden_labels.dart';
import 'package:terrace_garden/features/garden/presentation/widgets/garden_cover.dart';
import 'package:terrace_garden/features/settings/application/settings_controller.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// GDN-01. The user's gardens, or an invitation to create the first one.
class GardenHomeScreen extends ConsumerWidget {
  const GardenHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final gardens = ref.watch(gardensProvider);

    return Scaffold(
      body: AsyncStateView(
        value: gardens,
        onRetry: () => ref.invalidate(gardensProvider),
        data: (list) => list.isEmpty
            ? ImmersiveEmptyState(
                screenTitle: l10n.navGarden,
                image: const AssetImage(AppPhotos.gardenTerrace),
                icon: Icons.yard_outlined,
                title: l10n.gardenEmptyTitle,
                body: l10n.gardenEmptyBody,
                actionLabel: l10n.gardenCreateAction,
                onAction: () => context.push(AppRoutes.gardenNew),
              )
            : _GardenList(gardens: list),
      ),
    );
  }
}

class _GardenList extends ConsumerWidget {
  const _GardenList({required this.gardens});

  final List<Garden> gardens;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final insets = MediaQuery.paddingOf(context);
    final gutter = AppSpacing.gutterFor(MediaQuery.sizeOf(context).width);

    return PhotoBackdrop(
      image: const AssetImage(AppPhotos.gardenTerrace),
      child: ListView(
        padding: EdgeInsets.fromLTRB(
          gutter,
          insets.top + AppSpacing.lg,
          gutter,
          insets.bottom + AppSpacing.xl,
        ),
        children: [
          Semantics(
            header: true,
            child: Text(
              l10n.gardensTitle,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: context.glass.onPhoto,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          for (final garden in gardens) ...[
            _GardenCard(garden: garden),
            const SizedBox(height: AppSpacing.md),
          ],
          GlassPanel(
            padding: EdgeInsets.zero,
            child: ListTile(
              minTileHeight: 64,
              leading: const Icon(Icons.add),
              title: Text(l10n.gardenNew, style: theme.textTheme.titleMedium),
              onTap: () => context.push(AppRoutes.gardenNew),
            ),
          ),
        ],
      ),
    );
  }
}

class _GardenCard extends ConsumerWidget {
  const _GardenCard({required this.garden});

  final Garden garden;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final units =
        ref.watch(settingsControllerProvider).value?.unitSystem ??
        UnitSystem.metric;
    final format = MeasurementFormatter(
      units,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    final details = [
      garden.spaceType.label(l10n),
      if (garden.hasDimensions)
        l10n.gardenSizeValue(
          format.length(garden.length!),
          format.length(garden.width!),
        ),
      ?garden.cityName,
    ].join(' · ');

    return GlassPanel(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: () => context.go(AppRoutes.gardenDetail(garden.id)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: AppRadii.mdAll,
                child: SizedBox.square(
                  dimension: 72,
                  child: GardenCover(garden: garden, thumbnail: true),
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(garden.name, style: theme.textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(details, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
