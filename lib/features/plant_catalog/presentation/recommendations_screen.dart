import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/widgets/app_card.dart';
import 'package:terrace_garden/core/widgets/async_state_view.dart';
import 'package:terrace_garden/core/widgets/error_state.dart';
import 'package:terrace_garden/core/widgets/section_header.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden/garden.dart';
import 'package:terrace_garden/features/plant_catalog/application/recommendation_providers.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plant_catalog/domain/recommendation_engine.dart';
import 'package:terrace_garden/features/plant_catalog/presentation/art/plant_art.dart';
import 'package:terrace_garden/features/plant_catalog/presentation/plant_labels.dart';
import 'package:terrace_garden/features/plantings/plantings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// REC-01 and REC-03, Living Terrace: ranked plant ideas for one garden as
/// a seed-shop shelf. The best match is featured with every reason behind
/// it; the rest sit in a grid with the season and container reasons.
class RecommendationsScreen extends ConsumerStatefulWidget {
  const RecommendationsScreen({required this.gardenId, super.key});

  final String gardenId;

  @override
  ConsumerState<RecommendationsScreen> createState() =>
      _RecommendationsScreenState();
}

class _RecommendationsScreenState extends ConsumerState<RecommendationsScreen> {
  bool _shortlistOnly = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final recommendations = ref.watch(
      gardenRecommendationsProvider(widget.gardenId),
    );
    return Scaffold(
      appBar: AppBar(title: Text(l10n.recTitle)),
      body: AsyncStateView(
        value: recommendations,
        onRetry: () =>
            ref.invalidate(gardenRecommendationsProvider(widget.gardenId)),
        data: (list) => list == null
            ? const ErrorState(failure: NotFoundFailure())
            : _buildList(context, list),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Recommendation> all) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final garden = ref.watch(gardenProvider(widget.gardenId)).value;
    final shortlist =
        ref.watch(shortlistProvider(widget.gardenId)).value ?? const {};
    final insets = MediaQuery.paddingOf(context);
    final width = MediaQuery.sizeOf(context).width;
    final gutter = AppSpacing.contentInsetFor(width);
    final month = ref.watch(clockProvider).now().month;
    final list = _shortlistOnly
        ? all.where((r) => shortlist.contains(r.species.id)).toList()
        : all;
    final profileIncomplete =
        garden != null &&
        (garden.sun == SunExposure.unknown || garden.region == null);

    final children = <Widget>[
      if (garden != null)
        Text(
          l10n.recSubtitle(garden.name, monthLong(context, month)),
          style: theme.textTheme.headlineMedium,
        ),
      const SizedBox(height: AppSpacing.xs),
      Text(
        l10n.recDisclaimer,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      if (profileIncomplete) ...[
        const SizedBox(height: AppSpacing.md),
        AppCard(
          onTap: () => context.push(AppRoutes.gardenEdit(widget.gardenId)),
          child: Row(
            children: [
              Icon(Icons.tune, color: theme.colorScheme.primary),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: Text(l10n.recCompleteProfile)),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ],
      const SizedBox(height: AppSpacing.md),
      Wrap(
        spacing: AppSpacing.sm,
        children: [
          ChoiceChip(
            label: Text(l10n.recSowNowFilter),
            selected: !_shortlistOnly,
            onSelected: (_) => setState(() => _shortlistOnly = false),
          ),
          FilterChip(
            avatar: const Icon(Icons.bookmark_outline, size: 18),
            showCheckmark: false,
            label: Text(l10n.recShortlistOnly),
            selected: _shortlistOnly,
            onSelected: (v) => setState(() => _shortlistOnly = v),
          ),
        ],
      ),
      if (_shortlistOnly && list.isEmpty)
        Padding(
          padding: const EdgeInsets.only(top: AppSpacing.lg),
          child: Text(
            l10n.recShortlistEmpty,
            style: theme.textTheme.bodyLarge,
          ),
        ),
      for (final group in RecommendationGroup.values)
        if (list.where((r) => r.group == group).toList() case final items
            when items.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          SectionHeader(
            title: switch (group) {
              RecommendationGroup.goodNow => l10n.recGroupGoodNow,
              RecommendationGroup.later => l10n.recGroupLater,
              RecommendationGroup.notSuited => l10n.recGroupNotSuited,
            },
          ),
          if (group == RecommendationGroup.goodNow) ...[
            RecommendationCard(
              recommendation: items.first,
              gardenId: widget.gardenId,
              shortlisted: shortlist.contains(items.first.species.id),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          _Grid(
            columns: width >= AppBreakpoints.medium ? 3 : 2,
            children: [
              for (final r
                  in group == RecommendationGroup.goodNow
                      ? items.skip(1)
                      : items)
                _IdeaTile(
                  recommendation: r,
                  gardenId: widget.gardenId,
                  shortlisted: shortlist.contains(r.species.id),
                ),
            ],
          ),
        ],
    ];

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppBreakpoints.readableMaxWidth,
        ),
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            gutter,
            AppSpacing.md,
            gutter,
            insets.bottom + AppSpacing.xxl,
          ),
          children: children,
        ),
      ),
    );
  }
}

/// Rows of equal-width tiles.
class _Grid extends StatelessWidget {
  const _Grid({required this.columns, required this.children});

  final int columns;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (var i = 0; i < children.length; i += columns)
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          // Tiles in a row share the tallest one's height.
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var j = i; j < i + columns; j++) ...[
                  if (j > i) const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: j < children.length
                        ? children[j]
                        : const SizedBox.shrink(),
                  ),
                ],
              ],
            ),
          ),
        ),
    ],
  );
}

/// The plant in its pot on a soft ground, as on a seed packet.
class _Packet extends StatelessWidget {
  const _Packet({required this.species, required this.artSize, this.height});

  final PlantSpecies species;
  final double artSize;

  /// Null to fill the height the parent gives.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [colors.surfaceContainerLow, colors.surfaceContainerHigh],
        ),
      ),
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: PlantSideArt(
        spec: PlantArtSpec.of(species.id, category: species.category),
        size: artSize,
      ),
    );
  }
}

class _ShortlistButton extends ConsumerWidget {
  const _ShortlistButton({
    required this.speciesId,
    required this.gardenId,
    required this.shortlisted,
  });

  final String speciesId;
  final String gardenId;
  final bool shortlisted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return IconButton(
      tooltip: shortlisted ? l10n.recShortlistRemove : l10n.recShortlistAdd,
      isSelected: shortlisted,
      icon: const Icon(Icons.bookmark_outline),
      selectedIcon: const Icon(Icons.bookmark),
      onPressed: () => ref
          .read(shortlistRepositoryProvider)
          .setShortlisted(gardenId, speciesId, shortlisted: !shortlisted),
    );
  }
}

/// The featured best match: the drawing beside every reason and caveat.
class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    required this.recommendation,
    required this.gardenId,
    required this.shortlisted,
    super.key,
  });

  final Recommendation recommendation;
  final String gardenId;
  final bool shortlisted;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final r = recommendation;
    final s = r.species;
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.recBestMatch.toUpperCase(),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                  letterSpacing: 1.1,
                ),
              ),
            ),
            _ShortlistButton(
              speciesId: s.id,
              gardenId: gardenId,
              shortlisted: shortlisted,
            ),
          ],
        ),
        Text(s.name(l10n), style: theme.textTheme.headlineSmall),
        Text(
          [...s.localNames, s.category.label(l10n)].join(' · '),
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final reason in r.reasons(context))
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  reason.fit.icon,
                  size: 18,
                  color: reason.fit.color(context),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(reason.text, style: theme.textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        if (r.caveats.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: [
              for (final c in r.caveats)
                Chip(
                  visualDensity: VisualDensity.compact,
                  avatar: Icon(c.icon, size: 16),
                  label: Text(c.label(l10n)),
                ),
            ],
          ),
        ],
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TextButton.icon(
            icon: const Icon(Icons.add),
            label: Text(l10n.plantAddToGarden),
            onPressed: () =>
                showPlantingSheet(context, species: s, gardenId: gardenId),
          ),
        ),
      ],
    );

    return AppCard(
      padding: EdgeInsets.zero,
      onTap: () =>
          context.push(AppRoutes.plantDetail(s.id, gardenId: gardenId)),
      semanticLabel: s.name(l10n),
      child: LayoutBuilder(
        builder: (context, box) {
          const pad = EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.xs,
            AppSpacing.xs,
            AppSpacing.sm,
          );
          // Side by side when there is room; the drawing on top otherwise.
          if (box.maxWidth < 340) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Packet(species: s, height: 150, artSize: 140),
                Padding(padding: pad, child: details),
              ],
            );
          }
          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: box.maxWidth * .36,
                  child: _Packet(species: s, artSize: box.maxWidth * .36),
                ),
                Expanded(
                  child: Padding(padding: pad, child: details),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// A shelf tile: drawing, name, when to sow and whether a container fits.
class _IdeaTile extends StatelessWidget {
  const _IdeaTile({
    required this.recommendation,
    required this.gardenId,
    required this.shortlisted,
  });

  final Recommendation recommendation;
  final String gardenId;
  final bool shortlisted;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final r = recommendation;
    final s = r.species;
    final reasons = r.reasons(context);
    final season = reasons[1];
    final container = reasons[2];

    return AppCard(
      padding: EdgeInsets.zero,
      onTap: () =>
          context.push(AppRoutes.plantDetail(s.id, gardenId: gardenId)),
      semanticLabel: s.name(l10n),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              _Packet(species: s, height: 120, artSize: 112),
              PositionedDirectional(
                top: 0,
                end: 0,
                child: _ShortlistButton(
                  speciesId: s.id,
                  gardenId: gardenId,
                  shortlisted: shortlisted,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.name(l10n),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontFamily: theme.textTheme.headlineSmall?.fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  season.text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  container.text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: container.fit.color(context),
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
