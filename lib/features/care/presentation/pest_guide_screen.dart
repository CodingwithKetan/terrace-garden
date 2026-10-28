import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/features/plant_catalog/plant_catalog.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// CARE-PEST. Common container pests: what to look for and gentle first
/// steps, each from the sources in gardening-references §6. Free on every
/// plan. No synthetic pesticide doses, ever (product rules).
class PestGuideScreen extends ConsumerWidget {
  const PestGuideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final gutter = AppSpacing.contentInsetFor(MediaQuery.sizeOf(context).width);
    final sources =
        ref.watch(plantCatalogueProvider).value?.sources ?? const {};
    String cite(List<String> ids) => l10n.pestSourcesLine(
      {for (final id in ids) ?sources[id]?.publisher}.join(' · '),
    );

    final pests = [
      (
        l10n.pestAphidsName,
        l10n.pestAphidsSigns,
        l10n.pestAphidsActions,
        const ['S32'],
      ),
      (
        l10n.pestMitesName,
        l10n.pestMitesSigns,
        l10n.pestMitesActions,
        const ['S33'],
      ),
      (
        l10n.pestWhiteflyName,
        l10n.pestWhiteflySigns,
        l10n.pestWhiteflyActions,
        const ['S34'],
      ),
      (
        l10n.pestMealybugName,
        l10n.pestMealybugSigns,
        l10n.pestMealybugActions,
        const ['S35'],
      ),
      (
        l10n.pestBorerName,
        l10n.pestBorerSigns,
        l10n.pestBorerActions,
        const ['S27'],
      ),
      (
        l10n.pestLeafMinerName,
        l10n.pestLeafMinerSigns,
        l10n.pestLeafMinerActions,
        const ['S12'],
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.pestGuideTitle)),
      body: Align(
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
              AppSpacing.xxl,
            ),
            children: [
              Text(l10n.pestGuideIntro, style: theme.textTheme.bodyLarge),
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xs),
                child: Text(
                  cite(const ['S1', 'S32']),
                  style: theme.textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              for (final (name, signs, actions, ids) in pests)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _PestCard(
                    name: name,
                    signs: signs,
                    actions: actions,
                    source: cite(ids),
                  ),
                ),
              const SizedBox(height: AppSpacing.md),
              _Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Semantics(
                      header: true,
                      child: Text(
                        l10n.pestSprayTitle,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    for (final rule in [
                      l10n.pestSprayHeat,
                      l10n.pestSprayTest,
                      l10n.pestSprayCover,
                      l10n.pestSprayNeem,
                    ])
                      _Bullet(text: rule),
                    Text(
                      cite(const ['S32', 'S33', 'S34', 'S37', 'S38']),
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      l10n.pestNeemRecipeTitle,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.pestNeemRecipe,
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(cite(const ['S12']), style: theme.textTheme.bodySmall),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      l10n.pestChemicals,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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

class _PestCard extends StatelessWidget {
  const _PestCard({
    required this.name,
    required this.signs,
    required this.actions,
    required this.source,
  });

  final String name;
  final String signs;
  final String actions;
  final String source;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(22),
      ),
      child: ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        title: Text(
          name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontFamily: theme.textTheme.headlineSmall?.fontFamily,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Text(signs, maxLines: 1, overflow: TextOverflow.ellipsis),
        childrenPadding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.pestLookFor, style: theme.textTheme.titleSmall),
          Text(signs, style: theme.textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.pestWhatToDo, style: theme.textTheme.titleSmall),
          Text(actions, style: theme.textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(source, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 18,
            color: theme.colorScheme.tertiary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(text, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
