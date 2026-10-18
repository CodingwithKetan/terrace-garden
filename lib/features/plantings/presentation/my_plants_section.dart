import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/app/theme/care_colors.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/units/measurement_formatter.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/core/widgets/app_button.dart';
import 'package:terrace_garden/core/widgets/app_card.dart';
import 'package:terrace_garden/core/widgets/dialogs.dart';
import 'package:terrace_garden/core/widgets/error_state.dart';
import 'package:terrace_garden/core/widgets/section_header.dart';
import 'package:terrace_garden/features/care/care.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/garden_designer.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plant_catalog/plant_catalog.dart';
import 'package:terrace_garden/features/plantings/data/planting_providers.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';
import 'package:terrace_garden/features/plantings/domain/planting_fit.dart';
import 'package:terrace_garden/features/plantings/presentation/planting_labels.dart';
import 'package:terrace_garden/features/plantings/presentation/planting_sheet.dart';
import 'package:terrace_garden/features/settings/settings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// Entry to ranked ideas for a garden (REC-01).
class PlantIdeasCard extends StatelessWidget {
  const PlantIdeasCard({required this.gardenId, super.key});

  final String gardenId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Material(
      color: colors.secondaryContainer,
      borderRadius: AppRadii.mdAll,
      child: InkWell(
        borderRadius: AppRadii.mdAll,
        onTap: () => context.push(AppRoutes.gardenIdeas(gardenId)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Icon(
                Icons.auto_awesome_outlined,
                color: colors.onSecondaryContainer,
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.recTitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colors.onSecondaryContainer,
                      ),
                    ),
                    Text(
                      l10n.plantsIdeasSubtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colors.onSecondaryContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// PLT-03. The garden's plantings with their container and fit warnings.
class MyPlantsSection extends ConsumerWidget {
  const MyPlantsSection({required this.gardenId, super.key});

  final String gardenId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final plantings = ref.watch(gardenPlantingsProvider(gardenId)).value;
    final catalogue = ref.watch(plantCatalogueProvider).value;
    final elements =
        ref.watch(layoutElementsProvider(gardenId)).value ?? const [];
    if (plantings == null || catalogue == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(title: l10n.myPlantsTitle),
          if (plantings.isEmpty)
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.myPlantsEmpty, style: theme.textTheme.bodyMedium),
                  const SizedBox(height: AppSpacing.md),
                  AppButton.secondary(
                    label: l10n.recTitle,
                    icon: Icons.auto_awesome_outlined,
                    onPressed: () =>
                        context.push(AppRoutes.gardenIdeas(gardenId)),
                  ),
                ],
              ),
            )
          else
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  for (final p in plantings)
                    _PlantingTile(
                      planting: p,
                      species: catalogue.byId(p.speciesId),
                      elements: elements,
                      plantings: plantings,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _PlantingTile extends ConsumerWidget {
  const _PlantingTile({
    required this.planting,
    required this.species,
    required this.elements,
    required this.plantings,
  });

  final Planting planting;
  final PlantSpecies? species;
  final List<LayoutElement> elements;
  final List<Planting> plantings;

  Future<void> _remove(BuildContext context, WidgetRef ref, String name) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.plantingRemoveTitle(name),
      message: l10n.plantingRemoveBody,
      confirmLabel: l10n.actionDelete,
      destructive: true,
    );
    if (!confirmed) return;
    final result = await ref
        .read(plantingRepositoryProvider)
        .delete(planting.id);
    messenger.showSnackBar(
      SnackBar(
        content: Text(switch (result) {
          Ok() => l10n.plantingRemoved,
          Err(:final failure) => ErrorState.messageFor(l10n, failure),
        }),
      ),
    );
  }

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
    final s = species;
    final name = s?.commonName ?? l10n.plantingUnknownSpecies;
    final containers = layoutContainers(elements);
    final container = containers
        .where((c) => c.id == planting.elementId)
        .firstOrNull;
    final date = DateFormat.yMMMd(
      Localizations.localeOf(context).toLanguageTag(),
    ).format(planting.plantedOn.toLocalDateTime());
    final placement = planting.elementId == null
        ? l10n.plantingNotPlaced
        : container == null
        ? l10n.plantingContainerMissing
        : containerName(l10n, container, containers);
    final issues = (s == null || container == null)
        ? const <PlantingIssue>[]
        : PlantingFit.check(
            species: s,
            container: container,
            quantity: planting.quantity,
            othersInContainer: plantings
                .where(
                  (p) => p.elementId == container.id && p.id != planting.id,
                )
                .toList(),
          ).where((i) => i.kind != PlantingIssueKind.shared).toList();

    return ListTile(
      leading: Icon(s?.category.icon ?? Icons.help_outline),
      title: Text(name, style: theme.textTheme.titleMedium),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.plantingSummary(planting.quantity, date)),
          Text(placement),
          for (final issue in issues)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xxs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: context.careColors.warning,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(child: Text(issue.message(l10n, format))),
                ],
              ),
            ),
        ],
      ),
      onTap: s == null
          ? null
          : () => context.push(
              AppRoutes.plantDetail(s.id, gardenId: planting.gardenId),
            ),
      trailing: PopupMenuButton<void>(
        tooltip: l10n.moreActions,
        itemBuilder: (_) => [
          PopupMenuItem(
            onTap: () => context.push(
              AppRoutes.journalNew(
                gardenId: planting.gardenId,
                plantingId: planting.id,
              ),
            ),
            child: Text(l10n.journalAddForPlant),
          ),
          PopupMenuItem(
            onTap: () => showCarePlanSheet(
              context,
              plantingId: planting.id,
              plantName: name,
            ),
            child: Text(l10n.carePlan),
          ),
          if (s != null)
            PopupMenuItem(
              onTap: () =>
                  showPlantingSheet(context, species: s, existing: planting),
              child: Text(l10n.actionEdit),
            ),
          PopupMenuItem(
            onTap: () => _remove(context, ref, name),
            child: Text(l10n.plantingRemove),
          ),
        ],
      ),
    );
  }
}
