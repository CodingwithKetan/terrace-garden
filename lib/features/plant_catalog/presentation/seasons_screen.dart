import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';
import 'package:terrace_garden/features/garden/garden.dart';
import 'package:terrace_garden/features/plant_catalog/data/catalogue_providers.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plant_catalog/presentation/art/plant_art.dart';
import 'package:terrace_garden/features/plant_catalog/presentation/plant_labels.dart';
import 'package:terrace_garden/features/plantings/plantings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// Seasons tab (Living Terrace): what to sow this month in the current
/// garden's region, and a sowing almanac for the user's plants and
/// shortlist. Only sourced windows are shown; a species without one says so.
class SeasonsScreen extends ConsumerWidget {
  const SeasonsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final garden = ref.watch(currentGardenProvider);
    final catalogue = ref.watch(plantCatalogueProvider).value;
    final month = ref.watch(clockProvider).now().month;
    final width = MediaQuery.sizeOf(context).width;
    final gutter = AppSpacing.contentInsetFor(width);
    final region = garden?.region;

    final children = <Widget>[
      Semantics(
        header: true,
        child: Text(l10n.seasonsTitle, style: theme.textTheme.headlineLarge),
      ),
      if (garden != null && region != null)
        Padding(
          padding: const EdgeInsets.only(top: AppSpacing.xxs),
          child: Text(
            l10n.seasonsSubtitle(
              garden.cityName ?? garden.name,
              region.label(l10n),
            ),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      const SizedBox(height: AppSpacing.lg),
    ];

    if (garden == null || region == null || catalogue == null) {
      children.add(
        _Card(
          child: Text(
            garden == null ? l10n.seasonsNoGarden : l10n.seasonsNoRegion,
            style: theme.textTheme.bodyLarge,
          ),
        ),
      );
    } else {
      final sowNow = [
        for (final s in catalogue.search())
          if (s.sowingFor(region)?.window.months.contains(month) ?? false) s,
      ];
      final plantings =
          ref.watch(gardenPlantingsProvider(garden.id)).value ?? const [];
      final saved =
          ref.watch(shortlistProvider(garden.id)).value ?? const <String>{};
      final mine = <PlantSpecies>[
        for (final id in {...plantings.map((p) => p.speciesId), ...saved})
          ?catalogue.byId(id),
      ];

      children
        ..add(
          _NowCard(
            month: monthLong(context, month),
            species: sowNow,
          ),
        )
        ..add(const SizedBox(height: AppSpacing.xl))
        ..add(
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.seasonsYourPlants.toUpperCase(),
                  style: theme.textTheme.labelMedium?.copyWith(
                    letterSpacing: 1.2,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Container(
                width: 12,
                height: 8,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(l10n.seasonsWindowLegend, style: theme.textTheme.bodySmall),
            ],
          ),
        )
        ..add(const SizedBox(height: AppSpacing.sm))
        ..add(
          _Card(
            child: mine.isEmpty
                ? Text(
                    l10n.seasonsEmptyPlants,
                    style: theme.textTheme.bodyMedium,
                  )
                : _Almanac(species: mine, region: region, month: month),
          ),
        )
        ..add(const SizedBox(height: AppSpacing.md))
        ..add(
          Text(
            l10n.seasonsFootnote,
            style: theme.textTheme.bodySmall,
          ),
        );
    }

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            gutter,
            AppSpacing.lg,
            gutter,
            AppSpacing.xxl,
          ),
          children: children,
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.lg),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(22),
    ),
    child: child,
  );
}

/// The dark "this month" card with what can be sown now.
class _NowCard extends StatelessWidget {
  const _NowCard({required this.month, required this.species});

  final String month;
  final List<PlantSpecies> species;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    // Inverse colours so the card reads the same in both themes.
    final fg = colors.onInverseSurface;
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: colors.inverseSurface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: Text(
                  month,
                  style: theme.textTheme.headlineMedium?.copyWith(color: fg),
                ),
              ),
              Text(
                l10n.seasonsSowNow,
                style: theme.textTheme.bodySmall?.copyWith(color: fg),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (species.isEmpty)
            Text(
              l10n.seasonsNothingNow,
              style: theme.textTheme.bodyMedium?.copyWith(color: fg),
            )
          else
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final s in species)
                  ActionChip(
                    label: Text(s.commonName),
                    labelStyle: theme.textTheme.labelLarge?.copyWith(
                      color: fg,
                    ),
                    backgroundColor: Color.alphaBlend(
                      fg.withValues(alpha: .12),
                      colors.inverseSurface,
                    ),
                    side: BorderSide.none,
                    onPressed: () => context.push(AppRoutes.plantDetail(s.id)),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class _Almanac extends StatelessWidget {
  const _Almanac({
    required this.species,
    required this.region,
    required this.month,
  });

  final List<PlantSpecies> species;
  final GrowingRegion region;
  final int month;

  static const _nameWidth = 112.0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final months = [for (var m = 1; m <= 12; m++) monthShort(context, m)];

    Widget monthRow() => Row(
      children: [
        const SizedBox(width: _nameWidth),
        for (var m = 1; m <= 12; m++)
          Expanded(
            child: ExcludeSemantics(
              child: Text(
                months[m - 1].characters.first,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: m == month ? FontWeight.w700 : null,
                  color: m == month ? colors.tertiary : colors.onSurfaceVariant,
                ),
              ),
            ),
          ),
      ],
    );

    return Column(
      children: [
        monthRow(),
        const SizedBox(height: AppSpacing.sm),
        for (final s in species) ...[
          _AlmanacRow(
            species: s,
            sowing: s.sowingFor(region),
            month: month,
            nameWidth: _nameWidth,
            monthNames: months,
            noCalendar: l10n.seasonsNoCalendar,
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _AlmanacRow extends StatelessWidget {
  const _AlmanacRow({
    required this.species,
    required this.sowing,
    required this.month,
    required this.nameWidth,
    required this.monthNames,
    required this.noCalendar,
  });

  final PlantSpecies species;
  final RegionalSowing? sowing;
  final int month;
  final double nameWidth;
  final List<String> monthNames;
  final String noCalendar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final window = sowing?.window.months;
    final summary = window == null
        ? noCalendar
        : ([...window]..sort()).map((m) => monthNames[m - 1]).join(', ');

    return Semantics(
      container: true,
      label: '${species.commonName}: $summary',
      child: ExcludeSemantics(
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => context.push(AppRoutes.plantDetail(species.id)),
          child: SizedBox(
            height: 32,
            child: Row(
              children: [
                SizedBox(
                  width: nameWidth,
                  child: Row(
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerHigh,
                          shape: BoxShape.circle,
                        ),
                        child: PlantSideArt(
                          spec: PlantArtSpec.of(
                            species.id,
                            category: species.category,
                          ),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          species.commonName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontFamily:
                                theme.textTheme.headlineSmall?.fontFamily,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (window == null)
                  Expanded(
                    child: Text(
                      noCalendar,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                else
                  for (var m = 1; m <= 12; m++)
                    Expanded(
                      child: Container(
                        height: 16,
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color: window.contains(m)
                              ? colors.primary
                              : m == month
                              ? colors.tertiaryContainer
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
