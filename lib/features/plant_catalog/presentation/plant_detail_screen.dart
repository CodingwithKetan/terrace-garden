import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/app/theme/care_colors.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/core/units/measurement_formatter.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/core/widgets/app_button.dart';
import 'package:terrace_garden/core/widgets/app_card.dart';
import 'package:terrace_garden/core/widgets/async_state_view.dart';
import 'package:terrace_garden/core/widgets/empty_state.dart';
import 'package:terrace_garden/core/widgets/section_header.dart';
import 'package:terrace_garden/core/widgets/status_chip.dart';
import 'package:terrace_garden/features/care/care.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/garden/garden.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/garden_designer.dart';
import 'package:terrace_garden/features/plant_catalog/data/catalogue_providers.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plant_catalog/presentation/art/plant_art.dart';
import 'package:terrace_garden/features/plant_catalog/presentation/plant_labels.dart';
import 'package:terrace_garden/features/plantings/domain/plant_journey.dart';
import 'package:terrace_garden/features/plantings/plantings.dart';
import 'package:terrace_garden/features/settings/settings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// PLT-02. Everything the catalogue knows about one plant, each fact with
/// its source, and "Not documented" where no verified source exists. When
/// the user grows it, the page opens with its sourced journey and care
/// rhythm (Living Terrace).
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
    final size = MediaQuery.sizeOf(context);
    final gutter = AppSpacing.contentInsetFor(size.width);
    final units =
        ref.watch(settingsControllerProvider).value?.unitSystem ??
        UnitSystem.metric;
    final format = MeasurementFormatter(
      units,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    final today = LocalDate.fromDateTime(ref.watch(clockProvider).now());
    final s = species;
    final c = s.container;

    // The user's own plant of this species, in the garden they came from.
    final garden = gardenId ?? ref.watch(currentGardenProvider)?.id;
    final planting = garden == null
        ? null
        : (ref.watch(gardenPlantingsProvider(garden)).value ?? const [])
              .where((p) => p.speciesId == s.id)
              .firstOrNull;
    final elements = garden == null
        ? const <LayoutElement>[]
        : ref.watch(layoutElementsProvider(garden)).value ??
              const <LayoutElement>[];
    final containers = layoutContainers(elements);
    final container = containers
        .where((e) => e.id == planting?.elementId)
        .firstOrNull;
    final pending = ref.watch(pendingTasksProvider).value ?? const <CareTask>[];
    final tasks = [
      for (final t in pending)
        if (planting != null && t.plantingId == planting.id) t,
    ];
    final soilDue = tasks.any(
      (t) => t.type == CareTaskType.checkSoil && !t.dueOn.isAfter(today),
    );
    final cited = _refs(s.citedSources.toList());
    final publishers = cited.map((r) => r.publisher).toSet().join(', ');

    final subtitle = [
      ...s.localNames,
      if (container != null)
        containerName(l10n, container, containers)
      else ...[
        s.category.label(l10n),
        s.lifecycle.label(l10n),
      ],
    ].join(' · ');

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: (size.height * .42).clamp(220, 340),
          backgroundColor: theme.colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          leading: const Padding(
            padding: EdgeInsets.all(AppSpacing.xs),
            child: _RoundBackButton(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: _Hero(
              species: s,
              pot: container?.kind == ElementKind.growBag
                  ? PotStyle.growBag
                  : PotStyle.terracotta,
              badge: soilDue ? l10n.plantSoilCheckDue : null,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            gutter,
            AppSpacing.md,
            gutter,
            insets.bottom + AppSpacing.xxl,
          ),
          sliver: SliverList.list(
            children: [
              Semantics(
                header: true,
                child: Text(s.name(l10n), style: theme.textTheme.displaySmall),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                s.scientificName,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(subtitle, style: theme.textTheme.bodyMedium),
              if (planting != null) ...[
                const SizedBox(height: AppSpacing.lg),
                _JourneyCard(
                  species: s,
                  journey: PlantJourney.of(
                    planting: planting,
                    species: s,
                    today: today,
                  ),
                  sources: sources,
                ),
                if (tasks.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Semantics(
                    header: true,
                    child: Text(
                      l10n.careRhythm,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _Rhythm(tasks: tasks, today: today),
                ],
              ],
              const SizedBox(height: AppSpacing.lg),
              _QuickFacts(species: s, format: format),
              if (cited.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: l10n.plantSourcesCount(cited.length),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: ' · $publishers',
                      ),
                    ],
                  ),
                  style: theme.textTheme.bodySmall,
                ),
              ],
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
              _SourcesSection(sources: cited),
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

class _RoundBackButton extends StatelessWidget {
  const _RoundBackButton();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        shape: BoxShape.circle,
      ),
      child: BackButton(color: colors.onSurface),
    );
  }
}

/// The plant drawn large in its pot on a soft limestone ground.
class _Hero extends StatelessWidget {
  const _Hero({required this.species, required this.pot, this.badge});

  final PlantSpecies species;
  final PotStyle pot;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [colors.surfaceContainerHigh, colors.surface],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xl),
                child: LayoutBuilder(
                  builder: (context, box) => Center(
                    child: PlantSideArt(
                      spec: PlantArtSpec.of(
                        species.id,
                        category: species.category,
                      ),
                      size: box.biggest.shortestSide,
                      pot: pot,
                      semanticLabel: context.l10n.plantArtLabel(
                        species.name(context.l10n),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (badge case final text?)
              PositionedDirectional(
                start: AppSpacing.lg,
                bottom: AppSpacing.md,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerLowest,
                    borderRadius: AppRadii.fullAll,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.water_drop,
                          size: 14,
                          color: context.careColors.water,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(text, style: theme.textTheme.labelLarge),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// "Day 30": the planting date, then only the steps the sources document,
/// on a line with today's position.
class _JourneyCard extends StatelessWidget {
  const _JourneyCard({
    required this.species,
    required this.journey,
    required this.sources,
  });

  final PlantSpecies species;
  final PlantJourney journey;
  final Map<String, SourceRef> sources;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    String date(LocalDate d) =>
        DateFormat.MMMd(locale).format(d.toLocalDateTime());
    String when(JourneyMilestone m) =>
        m.isRange ? '${date(m.from)} – ${date(m.to)}' : date(m.from);
    String label(MilestoneKind k) => switch (k) {
      MilestoneKind.sown => l10n.journeySown,
      MilestoneKind.planted => l10n.journeyPlanted,
      MilestoneKind.transplant => l10n.journeyTransplant,
      MilestoneKind.harvest => l10n.journeyHarvest,
    };
    final day = journey.day;
    final first = journey.milestones.first;
    final last = journey.milestones.length - 1;
    final publishers = {
      for (final id in journey.sources) ?sources[id]?.publisher,
    };

    return Semantics(
      container: true,
      label: l10n.journeyLabel(
        species.name(l10n),
        [
          for (final m in journey.milestones) '${label(m.kind)} ${when(m)}',
        ].join(', '),
      ),
      child: ExcludeSemantics(
        child: AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      day == null
                          ? l10n.journeyStartsOn(date(first.from))
                          : l10n.journeyDay(day),
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  Text(
                    '${label(first.kind)} ${date(first.from)}',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              if (journey.hasSourcedSteps) ...[
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  height: 24,
                  child: CustomPaint(
                    painter: _JourneyPainter(
                      journey: journey,
                      line: theme.colorScheme.outlineVariant,
                      done: theme.colorScheme.primary,
                      harvest: context.careColors.fertilise,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final (i, m) in journey.milestones.indexed)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: i == 0
                              ? CrossAxisAlignment.start
                              : i == last
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.center,
                          children: [
                            Text(
                              label(m.kind),
                              textAlign: i == last
                                  ? TextAlign.end
                                  : TextAlign.start,
                              style: theme.textTheme.labelLarge,
                            ),
                            Text(when(m), style: theme.textTheme.bodySmall),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  '${publishers.join(' · ')}. ${l10n.journeyVaries}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ] else ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.journeyUndocumented,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _JourneyPainter extends CustomPainter {
  const _JourneyPainter({
    required this.journey,
    required this.line,
    required this.done,
    required this.harvest,
  });

  final PlantJourney journey;
  final Color line;
  final Color done;
  final Color harvest;

  static const _inset = 8.0;

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height / 2;
    final span = size.width - 2 * _inset;
    final total = journey.start.daysUntil(journey.end);
    double x(LocalDate d) => total <= 0
        ? size.width - _inset
        : _inset + span * journey.start.daysUntil(d) / total;
    final now = _inset + span * journey.progress;
    final track = Paint()
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas
      ..drawLine(
        Offset(_inset, y),
        Offset(size.width - _inset, y),
        track..color = line,
      )
      ..drawLine(Offset(_inset, y), Offset(now, y), track..color = done);
    for (final m in journey.milestones) {
      if (m.kind == MilestoneKind.harvest) {
        // The harvest window as a striped band.
        final band = Paint()
          ..color = harvest
          ..strokeWidth = 8;
        final end = x(m.to);
        for (var px = x(m.from); px < end; px += 7) {
          canvas.drawLine(
            Offset(px, y),
            Offset(px + 4 > end ? end : px + 4, y),
            band,
          );
        }
      } else if (m.isRange) {
        canvas.drawLine(
          Offset(x(m.from), y),
          Offset(x(m.to), y),
          Paint()
            ..color = done.withValues(alpha: .45)
            ..strokeWidth = 9
            ..strokeCap = StrokeCap.round,
        );
      } else {
        canvas.drawCircle(Offset(x(m.from), y), 7, Paint()..color = done);
      }
    }
    // Today.
    canvas
      ..drawLine(
        Offset(now, 0),
        Offset(now, size.height),
        Paint()
          ..color = done
          ..strokeWidth = 3,
      )
      ..drawCircle(Offset(now, y), 5, Paint()..color = done);
  }

  @override
  bool shouldRepaint(_JourneyPainter oldDelegate) =>
      oldDelegate.journey != journey || oldDelegate.line != line;
}

/// The next pending task of each kind for this plant.
class _Rhythm extends StatelessWidget {
  const _Rhythm({required this.tasks, required this.today});

  final List<CareTask> tasks;
  final LocalDate today;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    String date(LocalDate d) =>
        DateFormat.MMMd(locale).format(d.toLocalDateTime());
    final next = <CareTaskType, CareTask>{};
    for (final t in [...tasks]..sort((a, b) => a.dueOn.compareTo(b.dueOn))) {
      next.putIfAbsent(t.type, () => t);
    }
    String when(LocalDate d) => switch (today.daysUntil(d)) {
      < 0 => l10n.dueSince(date(d)),
      0 => l10n.rhythmToday,
      1 => l10n.rhythmTomorrow,
      final n when n < 7 => l10n.rhythmInDays(n),
      _ => date(d),
    };
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final t in next.values)
          Container(
            constraints: const BoxConstraints(minWidth: 104),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLowest,
              borderRadius: AppRadii.mdAll,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  t.type.icon,
                  size: 16,
                  color: t.type.color(context.careColors),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(t.type.label(l10n), style: theme.textTheme.titleSmall),
                Text(when(t.dueOn), style: theme.textTheme.bodySmall),
              ],
            ),
          ),
      ],
    );
  }
}

/// Sun, soil and pet facts as chips, only where the catalogue has them.
class _QuickFacts extends StatelessWidget {
  const _QuickFacts({required this.species, required this.format});

  final PlantSpecies species;
  final MeasurementFormatter format;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final s = species;
    // Pills that wrap long sourced phrases instead of clipping them.
    Widget chip(String label, IconData icon, {bool warn = false}) {
      final fg = warn ? colors.onErrorContainer : colors.onSurface;
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: warn ? colors.errorContainer : colors.surfaceContainerHigh,
          borderRadius: AppRadii.mdAll,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: fg),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(color: fg),
              ),
            ),
          ],
        ),
      );
    }

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (s.sun?.label(l10n) case final sun?)
          chip(sun, Icons.wb_sunny_outlined),
        if (s.container.minVolumeL case final litres?)
          chip(
            l10n.factSoil(format.volume(Volume.litres(litres))),
            Icons.inventory_2_outlined,
          ),
        if (s.petSafety.status == PetSafetyStatus.toxic)
          chip(l10n.petToxic, Icons.pets_outlined, warn: true),
        StatusChip(
          label: s.dataStatus.label(l10n),
          icon: s.dataStatus.icon,
          color: s.dataStatus.color(context.careColors),
        ),
      ],
    );
  }
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
