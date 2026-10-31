import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/units/measurement_formatter.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/core/widgets/dialogs.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden/garden.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/domain/sun_areas.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plant_catalog/domain/recommendation_engine.dart';
import 'package:terrace_garden/features/plant_catalog/plant_catalog.dart';
import 'package:terrace_garden/features/plantings/data/planting_providers.dart';
import 'package:terrace_garden/features/plantings/presentation/planting_labels.dart';
import 'package:terrace_garden/features/plantings/presentation/planting_sheet.dart';
import 'package:terrace_garden/features/settings/settings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// "What to grow here" for one container on the plan: catalogue plants
/// ranked by this container's size, the sun the user marked where it stands
/// and the season, each with its reasons. Choosing one opens the add-plant
/// sheet with this container already chosen.
///
/// [layout] is the designer's current document, which may be newer than
/// what is saved.
Future<void> showGrowHereSheet(
  BuildContext context, {
  required String gardenId,
  required LayoutDocument layout,
  required LayoutElement container,
}) async {
  final species = await showAppBottomSheet<PlantSpecies>(
    context,
    title: context.l10n.growHereTitle,
    builder: (context) => _GrowHereBody(
      gardenId: gardenId,
      layout: layout,
      container: container,
    ),
  );
  if (species == null || !context.mounted) return;
  await showPlantingSheet(
    context,
    species: species,
    gardenId: gardenId,
    elementId: container.id,
  );
}

class _GrowHereBody extends ConsumerWidget {
  const _GrowHereBody({
    required this.gardenId,
    required this.layout,
    required this.container,
  });

  final String gardenId;
  final LayoutDocument layout;
  final LayoutElement container;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final garden = ref.watch(gardenProvider(gardenId)).value;
    final catalogue = ref.watch(plantCatalogueProvider).value;
    final plantings =
        ref.watch(gardenPlantingsProvider(gardenId)).value ?? const [];
    final units =
        ref.watch(settingsControllerProvider).value?.unitSystem ??
        UnitSystem.metric;
    final format = MeasurementFormatter(
      units,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    if (garden == null || catalogue == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final spotSun = sunFor(layout, container);
    final litres = container.soilLitres;
    final ranked = RecommendationEngine.rankForSpot(
      garden: garden,
      species: catalogue.species,
      container: litres == null
          ? null
          : ContainerSpace(
              id: container.id,
              soilLitres: litres,
              depthCm: container.depthCm!,
              widthCm: container.narrowestSide,
            ),
      spotSun: spotSun,
      month: ref.watch(clockProvider).now().month,
    );
    List<SpotRecommendation> inGroup(RecommendationGroup g) =>
        ranked.where((r) => r.recommendation.group == g).toList();
    final growing = [
      for (final p in plantings)
        if (p.elementId == container.id)
          catalogue.byId(p.speciesId)?.name(l10n) ??
              l10n.plantingUnknownSpecies,
    ];

    final summary = [
      containerName(l10n, container, layoutContainers(layout.elements)),
      _size(container, format),
      if (litres != null) format.volume(Volume.litres(litres)),
      if (container.depthCm case final depth?)
        l10n.spotDepth(format.length(Length.cm(depth))),
    ].join(' · ');
    final sunText = switch ((spotSun, garden.sun)) {
      (final sun?, _) => l10n.sunHere(sun.label(l10n)),
      (null, SunExposure.unknown) => l10n.spotSunUnknown,
      (null, final sun) => l10n.spotSunUnmarked(sun.label(l10n)),
    };

    Widget section(String title, List<SpotRecommendation> items) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: AppSpacing.lg,
            bottom: AppSpacing.sm,
          ),
          child: Text(title, style: theme.textTheme.titleMedium),
        ),
        for (final r in items) _SpotTile(spot: r, format: format),
      ],
    );

    final now = inGroup(RecommendationGroup.goodNow);
    final later = inGroup(RecommendationGroup.later);
    final notSuited = inGroup(RecommendationGroup.notSuited);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(summary, style: theme.textTheme.bodyLarge),
        const SizedBox(height: AppSpacing.xs),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              spotSun == null ? Icons.help_outline : Icons.wb_sunny_outlined,
              size: 18,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: Text(sunText, style: theme.textTheme.bodyMedium)),
          ],
        ),
        if (growing.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.spotGrowing(growing.join(', ')),
            style: theme.textTheme.bodyMedium,
          ),
        ],
        if (now.isNotEmpty) section(l10n.growHereNow, now),
        if (later.isNotEmpty) section(l10n.growHereLater, later),
        if (notSuited.isNotEmpty)
          Theme(
            // No divider lines around the expansion tile.
            data: theme.copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              title: Text(
                l10n.growHereNot(notSuited.length),
                style: theme.textTheme.titleMedium,
              ),
              children: [
                for (final r in notSuited) _SpotTile(spot: r, format: format),
              ],
            ),
          ),
      ],
    );
  }

  static String _size(LayoutElement e, MeasurementFormatter format) {
    final w = format.length(Length.cm(e.width));
    if (e.kind.round) return 'Ø $w';
    return '$w × ${format.length(Length.cm(e.height))}';
  }
}

class _SpotTile extends StatelessWidget {
  const _SpotTile({required this.spot, required this.format});

  final SpotRecommendation spot;
  final MeasurementFormatter format;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final s = spot.species;
    final r = spot.recommendation;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Material(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: AppRadii.mdAll,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => Navigator.of(context).pop(s),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlantTopArt(
                  spec: PlantArtSpec.of(s.id, category: s.category),
                  size: 52,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.name(l10n), style: theme.textTheme.titleSmall),
                      if (s.localNames.isNotEmpty)
                        Text(
                          s.localNames.join(' · '),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      const SizedBox(height: AppSpacing.xs),
                      for (final line in _reasons(context, r, s))
                        Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.xxs),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                line.fit.icon,
                                size: 16,
                                color: line.fit.color(context),
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Expanded(
                                child: Text(
                                  line.text,
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (r.caveats.contains(Caveat.petToxic))
                        Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.xxs),
                          child: Row(
                            children: [
                              Icon(
                                Caveat.petToxic.icon,
                                size: 16,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Expanded(
                                child: Text(
                                  Caveat.petToxic.label(l10n),
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                FilledButton.tonal(
                  onPressed: () => Navigator.of(context).pop(s),
                  child: Text(l10n.growHereAction),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// The checks in words about this spot: sun, size, then season.
  List<ReasonLine> _reasons(
    BuildContext context,
    Recommendation r,
    PlantSpecies s,
  ) {
    final l10n = context.l10n;
    final need = s.container;
    return [
      ReasonLine(
        switch (r.sun.reason) {
          SunReason.matches => l10n.spotSunMatches,
          SunReason.needsMoreSun => l10n.spotSunNeedsMore,
          SunReason.tooShady => l10n.spotSunTooShady,
          SunReason.prefersIndirect => l10n.spotSunPrefersIndirect,
          SunReason.gardenUnknown => l10n.spotSunNotKnown,
          SunReason.speciesUnknown => l10n.recSunSpeciesUnknown,
        },
        r.sun.fit,
        Icons.wb_sunny_outlined,
      ),
      ReasonLine(
        switch (r.container.reason) {
          ContainerReason.fits => l10n.spotFits,
          ContainerReason.tooSmall => l10n.spotTooSmall(
            [
              if (need.minVolumeL case final v?)
                l10n.spotAtLeast(format.volume(Volume.litres(v))),
              if (need.minDepthCm case final d?)
                l10n.spotDepth(format.length(Length.cm(d))),
              if (need.minWidthCm case final w?)
                l10n.spotWide(format.length(Length.cm(w))),
            ].join(', '),
          ),
          ContainerReason.noContainers => l10n.spotNoSize,
          ContainerReason.speciesUnknown => l10n.recContainerUnknown,
        },
        r.container.fit,
        Icons.inventory_2_outlined,
      ),
      ReasonLine(
        switch (r.season.reason) {
          SeasonReason.sowNow => l10n.recSowNow,
          SeasonReason.sowSoon => l10n.recSowSoon(
            monthLong(context, r.season.nextMonth!),
          ),
          SeasonReason.later => l10n.recSowLater(
            monthLong(context, r.season.nextMonth!),
          ),
          SeasonReason.noRegion => l10n.recNoRegion,
          SeasonReason.noData => l10n.recNoSeasonData,
        },
        r.season.fit,
        Icons.calendar_month_outlined,
      ),
    ];
  }
}
