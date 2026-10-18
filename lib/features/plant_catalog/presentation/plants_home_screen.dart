import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/app/theme/app_imagery.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/app/theme/glass_theme.dart';
import 'package:terrace_garden/core/widgets/async_state_view.dart';
import 'package:terrace_garden/core/widgets/glass_panel.dart';
import 'package:terrace_garden/core/widgets/photo_backdrop.dart';
import 'package:terrace_garden/features/garden/data/garden_providers.dart';
import 'package:terrace_garden/features/plant_catalog/data/catalogue_providers.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plant_catalog/presentation/plant_labels.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// PLT-01. The sourced catalogue: search by any name, filter by category,
/// and jump to ranked ideas for each garden.
class PlantsHomeScreen extends ConsumerStatefulWidget {
  const PlantsHomeScreen({super.key});

  @override
  ConsumerState<PlantsHomeScreen> createState() => _PlantsHomeScreenState();
}

class _PlantsHomeScreenState extends ConsumerState<PlantsHomeScreen> {
  String _query = '';
  PlantCategory? _category;

  @override
  Widget build(BuildContext context) {
    final catalogue = ref.watch(plantCatalogueProvider);
    return Scaffold(
      body: PhotoBackdrop(
        image: const AssetImage(AppPhotos.plantsTerrace),
        child: AsyncStateView(
          value: catalogue,
          onRetry: () => ref.invalidate(plantCatalogueProvider),
          data: (catalogue) => _buildList(context, catalogue),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, PlantCatalogue catalogue) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final insets = MediaQuery.paddingOf(context);
    final gutter = AppSpacing.gutterFor(MediaQuery.sizeOf(context).width);
    final gardens = ref.watch(gardensProvider).value ?? const [];
    final results = catalogue.search(query: _query, category: _category);

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            gutter,
            insets.top + AppSpacing.lg,
            gutter,
            0,
          ),
          sliver: SliverList.list(
            children: [
              Semantics(
                header: true,
                child: Text(
                  l10n.plantsTitle,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: context.glass.onPhoto,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              for (final garden in gardens.take(3)) ...[
                GlassPanel(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    minTileHeight: 64,
                    leading: const Icon(Icons.auto_awesome_outlined),
                    title: Text(
                      l10n.plantsIdeasFor(garden.name),
                      style: theme.textTheme.titleMedium,
                    ),
                    subtitle: Text(l10n.plantsIdeasSubtitle),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => context.push(AppRoutes.gardenIdeas(garden.id)),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              GlassPanel(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: TextField(
                  key: const Key('plantSearch'),
                  onChanged: (v) => setState(() => _query = v),
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: l10n.plantsSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    border: InputBorder.none,
                    filled: false,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: gutter),
              children: [
                _CategoryChip(
                  label: l10n.plantsFilterAll,
                  selected: _category == null,
                  onSelected: () => setState(() => _category = null),
                ),
                for (final c in PlantCategory.values)
                  _CategoryChip(
                    label: c.label(l10n),
                    icon: c.icon,
                    selected: _category == c,
                    onSelected: () => setState(
                      () => _category = _category == c ? null : c,
                    ),
                  ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            gutter,
            AppSpacing.md,
            gutter,
            insets.bottom + AppSpacing.xl,
          ),
          sliver: results.isEmpty
              ? SliverToBoxAdapter(
                  child: GlassPanel(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.plantsNoResults,
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(l10n.plantsNoResultsBody),
                      ],
                    ),
                  ),
                )
              : SliverList.separated(
                  itemCount: results.length + 1,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) => index == results.length
                      ? Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.md),
                          child: GlassPanel(
                            child: Text(
                              l10n.plantsCatalogueNote,
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        )
                      : PlantTile(species: results[index]),
                ),
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    this.icon,
  });

  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
      child: FilterChip(
        label: Text(label),
        avatar: icon == null ? null : Icon(icon, size: 18),
        showCheckmark: icon == null,
        selected: selected,
        onSelected: (_) => onSelected(),
      ),
    );
  }
}

/// A catalogue row: category, names and how well documented it is.
class PlantTile extends StatelessWidget {
  const PlantTile({required this.species, this.gardenId, super.key});

  final PlantSpecies species;
  final String? gardenId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final names = [...species.localNames, species.scientificName].join(' · ');
    return GlassPanel(
      padding: EdgeInsets.zero,
      child: ListTile(
        minTileHeight: 64,
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          foregroundColor: theme.colorScheme.onPrimaryContainer,
          child: Icon(species.category.icon),
        ),
        title: Text(species.commonName, style: theme.textTheme.titleMedium),
        subtitle: Text(names, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: Tooltip(
          message: species.dataStatus.label(l10n),
          child: Icon(
            species.dataStatus.icon,
            semanticLabel: species.dataStatus.label(l10n),
          ),
        ),
        onTap: () => context.push(
          AppRoutes.plantDetail(species.id, gardenId: gardenId),
        ),
      ),
    );
  }
}
