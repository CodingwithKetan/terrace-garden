import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terrace_garden/app/theme/app_imagery.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/app/theme/care_colors.dart';
import 'package:terrace_garden/core/units/measurement_formatter.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/core/widgets/app_button.dart';
import 'package:terrace_garden/core/widgets/app_card.dart';
import 'package:terrace_garden/core/widgets/async_state_view.dart';
import 'package:terrace_garden/core/widgets/empty_state.dart';
import 'package:terrace_garden/core/widgets/section_header.dart';
import 'package:terrace_garden/core/widgets/status_chip.dart';
import 'package:terrace_garden/features/garden/presentation/garden_labels.dart';
import 'package:terrace_garden/features/plant_catalog/data/catalogue_providers.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plant_catalog/presentation/plant_labels.dart';
import 'package:terrace_garden/features/plantings/presentation/planting_sheet.dart';
import 'package:terrace_garden/features/settings/application/settings_controller.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// PLT-02. Everything the catalogue knows about one plant, each fact with
/// its source, and "Not documented" where no verified source exists.
class PlantDetailScreen extends ConsumerWidget {
  const PlantDetailScreen({required this.speciesId, this.gardenId, super.key});

  final String speciesId;

  /// The garden the user came from, preselected when adding.
  final String? gardenId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogue = ref.watch(plantCatalogueProvider);
    return Scaffold(
      body: AsyncStateView(
        value: catalogue,
        onRetry: () => ref.invalidate(plantCatalogueProvider),
        data: (catalogue) {
          final species = catalogue.byId(speciesId);
          if (species == null) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackButton(),
                  Expanded(
                    child: EmptyState(
                      icon: Icons.search_off_outlined,
                      title: context.l10n.plantNotFound,
                      body: '',
                    ),
                  ),
                ],
              ),
            );
          }
          return _Detail(
            species: species,
            sources: catalogue.sources,
            gardenId: gardenId,
          );
        },
      ),
    );
  }
}

class _Detail extends ConsumerWidget {
  const _Detail({
    required this.species,
    required this.sources,
    required this.gardenId,
  });

  final PlantSpecies species;
  final Map<String, SourceRef> sources;
  final String? gardenId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final insets = MediaQuery.paddingOf(context);
    final gutter = AppSpacing.gutterFor(MediaQuery.sizeOf(context).width);
    final units =
        ref.watch(settingsControllerProvider).value?.unitSystem ??
        UnitSystem.metric;
    final format = MeasurementFormatter(
      units,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    final s = species;
    final c = s.container;
    final subtitle = [
      ...s.localNames,
      s.category.label(l10n),
      s.lifecycle.label(l10n),
    ].join(' · ');

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 220,
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsetsDirectional.only(
              start: 56,
              bottom: 14,
              end: AppSpacing.lg,
            ),
            title: Text(
              s.commonName,
              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  AppPhotos.plantsTerrace,
                  fit: BoxFit.cover,
                  excludeFromSemantics: true,
                  cacheWidth: 1080,
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x99000000), Color(0xCC000000)],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            gutter,
            AppSpacing.lg,
            gutter,
            insets.bottom + AppSpacing.xxl,
          ),
          sliver: SliverList.list(
            children: [
              Text(
                s.scientificName,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(subtitle, style: theme.textTheme.bodyMedium),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  StatusChip(
                    label: s.dataStatus.label(l10n),
                    icon: s.dataStatus.icon,
                    color: s.dataStatus.color(context.careColors),
                  ),
                  if (s.petSafety.status == PetSafetyStatus.toxic)
                    StatusChip(
                      label: l10n.petToxic,
                      icon: Icons.pets_outlined,
                      color: theme.colorScheme.error,
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: l10n.plantAddToGarden,
                icon: Icons.add,
                onPressed: () =>
                    showPlantingSheet(context, species: s, gardenId: gardenId),
              ),
              _FactSection(
                title: l10n.plantSectionSun,
                icon: Icons.wb_sunny_outlined,
                sources: _refs(s.sun?.sources),
                children: [_Value(s.sun?.label(l10n))],
              ),
              _FactSection(
                title: l10n.plantSectionContainer,
                icon: Icons.inventory_2_outlined,
                sources: _refs(c.sources),
                children: [
                  if (c.hasSize) ...[
                    _Pair(
                      l10n.containerMinSoil,
                      c.minVolumeL == null
                          ? null
                          : format.volume(Volume.litres(c.minVolumeL!)),
                    ),
                    if (c.recommendedVolumeL != null)
                      _Pair(
                        l10n.containerRecommendedSoil,
                        format.volume(Volume.litres(c.recommendedVolumeL!)),
                      ),
                    _Pair(
                      l10n.containerMinDepth,
                      c.minDepthCm == null
                          ? null
                          : format.length(Length.cm(c.minDepthCm!)),
                    ),
                    if (c.recommendedDepthCm != null)
                      _Pair(
                        l10n.containerRecommendedDepth,
                        format.length(Length.cm(c.recommendedDepthCm!)),
                      ),
                    if (c.plantsPerContainer != null)
                      _Pair(l10n.containerPlantsPer, '${c.plantsPerContainer}'),
                  ],
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.xs),
                    child: StatusChip(
                      label: c.status.label(l10n),
                      icon: switch (c.status) {
                        EvidenceStatus.verified => Icons.verified_outlined,
                        EvidenceStatus.proxy => Icons.compare_arrows,
                        EvidenceStatus.unverified => Icons.help_outline,
                      },
                      color: c.status == EvidenceStatus.verified
                          ? context.careColors.success
                          : context.careColors.warning,
                    ),
                  ),
                  if (c.note != null) _Note(c.note!),
                ],
              ),
              _FactSection(
                title: l10n.plantSectionHarvest,
                icon: Icons.agriculture_outlined,
                sources: _refs(s.daysToHarvest?.sources),
                children: [
                  _Value(switch (s.daysToHarvest) {
                    null => null,
                    final h when h.minDays == h.maxDays =>
                      l10n.harvestDaysSingle(h.minDays),
                    final h => l10n.harvestDays(h.minDays, h.maxDays),
                  }),
                  if (s.daysToHarvest?.note case final note?) _Note(note),
                ],
              ),
              _FactSection(
                title: l10n.plantSectionSowing,
                icon: Icons.calendar_month_outlined,
                sources: _refs([for (final w in s.sowing) w.source]),
                children: [
                  if (s.sowing.isEmpty)
                    _Value(null, notDocumented: l10n.sowingNone)
                  else
                    for (final w in s.sowing) _SowingRow(window: w),
                ],
              ),
              _FactSection(
                title: l10n.plantSectionPropagation,
                icon: Icons.spa_outlined,
                sources: _refs(s.propagation?.sources),
                children: [
                  _Value(s.propagation?.method.label(l10n)),
                  if (s.propagation case Propagation(
                    nurseryDaysMin: final int min,
                    nurseryDaysMax: final int max,
                  ))
                    _Note(l10n.propagationNursery(min, max)),
                ],
              ),
              if (s.careNotes.isNotEmpty)
                _FactSection(
                  title: l10n.plantSectionCare,
                  icon: Icons.tips_and_updates_outlined,
                  sources: _refs([for (final n in s.careNotes) ...n.sources]),
                  children: [
                    for (final n in s.careNotes)
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: Text(
                          '• ${n.text}',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                  ],
                ),
              _FactSection(
                title: l10n.plantSectionPets,
                icon: Icons.pets_outlined,
                sources: _refs(s.petSafety.sources),
                children: [
                  Row(
                    children: [
                      Icon(
                        s.petSafety.status.icon,
                        size: 20,
                        color: s.petSafety.status == PetSafetyStatus.toxic
                            ? theme.colorScheme.error
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          s.petSafety.status.label(l10n),
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  if (s.petSafety.note case final note?) _Note(note),
                  _Note(l10n.petScopeNote),
                ],
              ),
              _SourcesSection(sources: _refs(s.citedSources.toList())),
            ],
          ),
        ),
      ],
    );
  }

  List<SourceRef> _refs(List<String>? ids) => [
    for (final id in {...?ids}) ?sources[id],
  ];
}

class _FactSection extends StatelessWidget {
  const _FactSection({
    required this.title,
    required this.icon,
    required this.sources,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<SourceRef> sources;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xl),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Semantics(
                    header: true,
                    child: Text(title, style: theme.textTheme.titleMedium),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ...children,
            if (sources.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                sources.map((s) => s.publisher).toSet().join(' · '),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A single value, or "Not documented" when null.
class _Value extends StatelessWidget {
  const _Value(this.value, {this.notDocumented});

  final String? value;
  final String? notDocumented;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final missing = value == null;
    return Text(
      value ?? notDocumented ?? context.l10n.notDocumented,
      style: missing
          ? theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            )
          : theme.textTheme.bodyLarge,
    );
  }
}

class _Pair extends StatelessWidget {
  const _Pair(this.label, this.value);

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(label, style: theme.textTheme.bodyMedium)),
          const SizedBox(width: AppSpacing.md),
          Flexible(child: _Value(value)),
        ],
      ),
    );
  }
}

class _Note extends StatelessWidget {
  const _Note(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// A region's sowing months as a 12-month strip with a readable summary.
class _SowingRow extends StatelessWidget {
  const _SowingRow({required this.window});

  final SowingWindow window;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final months = window.yearRound
        ? l10n.sowingYearRound
        : ([
            ...window.months,
          ]..sort()).map((m) => monthShort(context, m)).join(', ');
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Semantics(
        container: true,
        label: '${window.region.label(l10n)}: $months',
        child: ExcludeSemantics(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                window.region.label(l10n),
                style: theme.textTheme.labelLarge,
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  for (var m = 1; m <= 12; m++)
                    Expanded(
                      child: Container(
                        height: 24,
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: window.months.contains(m)
                              ? colors.primary
                              : colors.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          monthShort(context, m).characters.first,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: window.months.contains(m)
                                ? colors.onPrimary
                                : colors.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(months, style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _SourcesSection extends StatelessWidget {
  const _SourcesSection({required this.sources});

  final List<SourceRef> sources;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    if (sources.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(title: l10n.plantSectionSources),
          Text(l10n.plantSourcesNote, style: theme.textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.sm),
          for (final s in sources)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.title, style: theme.textTheme.titleSmall),
                  Text(s.publisher, style: theme.textTheme.bodyMedium),
                  SelectableText(
                    s.url,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
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
