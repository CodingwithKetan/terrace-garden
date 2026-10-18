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
import 'package:terrace_garden/features/plant_catalog/domain/recommendation_engine.dart';
import 'package:terrace_garden/features/plant_catalog/presentation/plant_labels.dart';
import 'package:terrace_garden/features/plantings/plantings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// REC-01 and REC-03. Ranked plant ideas for one garden with the reasons
/// behind each, and a per-garden shortlist.
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
    final gutter = AppSpacing.contentInsetFor(
      MediaQuery.sizeOf(context).width,
    );
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
          style: theme.textTheme.titleMedium,
        ),
      const SizedBox(height: AppSpacing.xs),
      Text(l10n.recDisclaimer, style: theme.textTheme.bodyMedium),
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
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: FilterChip(
          avatar: const Icon(Icons.bookmark_outline, size: 18),
          showCheckmark: false,
          label: Text(l10n.recShortlistOnly),
          selected: _shortlistOnly,
          onSelected: (v) => setState(() => _shortlistOnly = v),
        ),
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
          for (final r in items)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: RecommendationCard(
                recommendation: r,
                gardenId: widget.gardenId,
                shortlisted: shortlist.contains(r.species.id),
              ),
            ),
        ],
    ];

    return ListView(
      padding: EdgeInsets.fromLTRB(
        gutter,
        AppSpacing.md,
        gutter,
        insets.bottom + AppSpacing.xxl,
      ),
      children: children,
    );
  }
}

class RecommendationCard extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final r = recommendation;
    final s = r.species;

    return AppCard(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.xs,
        AppSpacing.md,
      ),
      onTap: () =>
          context.push(AppRoutes.plantDetail(s.id, gardenId: gardenId)),
      semanticLabel: s.commonName,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(s.category.icon, color: theme.colorScheme.primary),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.commonName, style: theme.textTheme.titleMedium),
                    Text(
                      [...s.localNames, s.category.label(l10n)].join(' · '),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: shortlisted
                    ? l10n.recShortlistRemove
                    : l10n.recShortlistAdd,
                isSelected: shortlisted,
                icon: const Icon(Icons.bookmark_outline),
                selectedIcon: const Icon(Icons.bookmark),
                onPressed: () => ref
                    .read(shortlistRepositoryProvider)
                    .setShortlisted(gardenId, s.id, shortlisted: !shortlisted),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final reason in r.reasons(context))
            Padding(
              padding: const EdgeInsets.only(
                bottom: AppSpacing.xs,
                right: AppSpacing.md,
              ),
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
                    child: Text(
                      reason.text,
                      style: theme.textTheme.bodyMedium,
                    ),
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
      ),
    );
  }
}
