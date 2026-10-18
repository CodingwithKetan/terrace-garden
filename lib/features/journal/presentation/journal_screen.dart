import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/app/theme/app_imagery.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/app/theme/glass_theme.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/core/widgets/dialogs.dart';
import 'package:terrace_garden/core/widgets/error_state.dart';
import 'package:terrace_garden/core/widgets/glass_icon_button.dart';
import 'package:terrace_garden/core/widgets/glass_panel.dart';
import 'package:terrace_garden/core/widgets/immersive_empty_state.dart';
import 'package:terrace_garden/core/widgets/photo_backdrop.dart';
import 'package:terrace_garden/core/widgets/stored_photo_image.dart';
import 'package:terrace_garden/features/care/care.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';
import 'package:terrace_garden/features/garden/garden.dart';
import 'package:terrace_garden/features/journal/data/journal_providers.dart';
import 'package:terrace_garden/features/journal/domain/journal_entry.dart';
import 'package:terrace_garden/features/journal/domain/journal_stats.dart';
import 'package:terrace_garden/features/journal/domain/timeline.dart';
import 'package:terrace_garden/features/journal/presentation/journal_labels.dart';
import 'package:terrace_garden/features/plant_catalog/plant_catalog.dart';
import 'package:terrace_garden/features/plantings/plantings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// JRN-01. Entries and completed care, day by day, filterable by garden
/// and plant.
class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  String? _gardenId;
  String? _plantingId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final gardens = ref.watch(gardensProvider).value ?? const <Garden>[];
    final entries = ref.watch(journalEntriesProvider).value ?? const [];
    final done = ref.watch(doneTasksProvider).value ?? const [];
    final plantings = ref.watch(allPlantingsProvider).value ?? const [];
    final catalogue = ref.watch(plantCatalogueProvider).value;
    final insets = MediaQuery.paddingOf(context);
    final gutter = AppSpacing.gutterFor(MediaQuery.sizeOf(context).width);

    void newEntry() => context.push(
      AppRoutes.journalNew(gardenId: _gardenId, plantingId: _plantingId),
    );

    if (gardens.isEmpty || (entries.isEmpty && done.isEmpty)) {
      return Scaffold(
        body: ImmersiveEmptyState(
          screenTitle: l10n.navJournal,
          image: const AssetImage(AppPhotos.journalTerrace),
          icon: Icons.photo_library_outlined,
          title: l10n.journalEmptyTitle,
          body: l10n.journalEmptyBody,
          actionLabel: gardens.isEmpty ? null : l10n.journalAddEntry,
          onAction: gardens.isEmpty ? null : newEntry,
        ),
      );
    }

    String plantName(String? plantingId) {
      final speciesId = plantings
          .where((p) => p.id == plantingId)
          .firstOrNull
          ?.speciesId;
      return catalogue?.byId(speciesId ?? '')?.commonName ??
          l10n.plantingUnknownSpecies;
    }

    final gardenPlantings = plantings
        .where((p) => _gardenId == null || p.gardenId == _gardenId)
        .toList();
    final days = buildTimeline(
      entries: entries,
      doneTasks: done,
      filter: TimelineFilter(gardenId: _gardenId, plantingId: _plantingId),
    );
    final locale = Localizations.localeOf(context).toLanguageTag();

    return Scaffold(
      body: PhotoBackdrop(
        image: const AssetImage(AppPhotos.journalTerrace),
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppBreakpoints.readableMaxWidth,
            ),
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                gutter,
                insets.top + AppSpacing.lg,
                gutter,
                insets.bottom + AppSpacing.xl,
              ),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Semantics(
                        header: true,
                        child: Text(
                          l10n.journalTitle,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: context.glass.onPhoto,
                          ),
                        ),
                      ),
                    ),
                    GlassIconButton(
                      icon: Icons.add,
                      tooltip: l10n.journalAddEntry,
                      onPressed: newEntry,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                if (gardens.length > 1)
                  _ChipRow(
                    children: [
                      _FilterChip(
                        label: l10n.journalFilterAll,
                        selected: _gardenId == null,
                        onTap: () => setState(() {
                          _gardenId = null;
                          _plantingId = null;
                        }),
                      ),
                      for (final g in gardens)
                        _FilterChip(
                          label: g.name,
                          selected: _gardenId == g.id,
                          onTap: () => setState(() {
                            _gardenId = g.id;
                            _plantingId = null;
                          }),
                        ),
                    ],
                  ),
                if (gardenPlantings.isNotEmpty)
                  _ChipRow(
                    children: [
                      _FilterChip(
                        label: l10n.journalFilterAll,
                        selected: _plantingId == null,
                        onTap: () => setState(() => _plantingId = null),
                      ),
                      for (final p in gardenPlantings)
                        _FilterChip(
                          label: plantName(p.id),
                          selected: _plantingId == p.id,
                          onTap: () => setState(() => _plantingId = p.id),
                        ),
                    ],
                  ),
                _StatsPanel(
                  stats: JournalStats.of(
                    entries: [
                      for (final d in days) ...d.entries,
                    ],
                    doneTasks: [
                      for (final d in days) ...d.doneTasks,
                    ],
                    today: LocalDate.fromDateTime(
                      ref.watch(clockProvider).now(),
                    ),
                  ),
                  onCompare: () => context.push(
                    AppRoutes.journalCompare(
                      gardenId: _gardenId,
                      plantingId: _plantingId,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                if (days.isEmpty)
                  GlassPanel(child: Text(l10n.journalNoMatches)),
                for (final day in days) ...[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppSpacing.md,
                      bottom: AppSpacing.sm,
                    ),
                    // A glass pill keeps small text readable over any part
                    // of the photo (found by the contrast guideline test).
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: GlassPanel(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        borderRadius: AppRadii.fullAll,
                        child: Semantics(
                          header: true,
                          child: Text(
                            DateFormat.yMMMMEEEEd(
                              locale,
                            ).format(day.date.toLocalDateTime()),
                            style: theme.textTheme.titleSmall,
                          ),
                        ),
                      ),
                    ),
                  ),
                  for (final entry in day.entries)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: _EntryCard(
                        entry: entry,
                        plantName: entry.plantingId == null
                            ? null
                            : plantName(entry.plantingId),
                      ),
                    ),
                  if (day.doneTasks.isNotEmpty)
                    GlassPanel(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.journalCareDone(day.doneTasks.length),
                            style: theme.textTheme.titleSmall,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          for (final t in day.doneTasks)
                            Text(
                              '${t.type.label(l10n)} · '
                              '${plantName(t.plantingId)}',
                              style: theme.textTheme.bodyMedium,
                            ),
                        ],
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChipRow extends StatelessWidget {
  const _ChipRow({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: children),
    ),
  );
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
    child: FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
    ),
  );
}

class _EntryCard extends ConsumerWidget {
  const _EntryCard({required this.entry, required this.plantName});

  final JournalEntry entry;
  final String? plantName;

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.journalDeleteTitle,
      message: l10n.journalDeleteBody,
      confirmLabel: l10n.actionDelete,
      destructive: true,
    );
    if (!confirmed) return;
    final result = await ref.read(journalRepositoryProvider).delete(entry.id);
    messenger.showSnackBar(
      SnackBar(
        content: Text(switch (result) {
          Ok() => l10n.journalDeleted,
          Err(:final failure) => ErrorState.messageFor(l10n, failure),
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final milestone = entry.milestone;
    final harvest = harvestText(context, entry);
    final heading = [
      ?milestone?.label(l10n),
      ?plantName,
      ?harvest,
    ].join(' · ');

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (milestone != null) ...[
                Icon(milestone.icon, size: 20),
                const SizedBox(width: AppSpacing.sm),
              ],
              Expanded(
                child: Text(
                  heading.isEmpty ? l10n.journalNote : heading,
                  style: theme.textTheme.titleSmall,
                ),
              ),
              PopupMenuButton<void>(
                tooltip: l10n.moreActions,
                itemBuilder: (_) => [
                  PopupMenuItem(
                    onTap: () => _delete(context, ref),
                    child: Text(l10n.actionDelete),
                  ),
                ],
              ),
            ],
          ),
          if (entry.note != null)
            Text(entry.note!, style: theme.textTheme.bodyLarge),
          if (entry.photos.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: 96,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: entry.photos.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, i) => ClipRRect(
                  borderRadius: AppRadii.mdAll,
                  child: SizedBox.square(
                    dimension: 96,
                    child: StoredPhotoImage(
                      relativePath: entry.photos[i].thumbnailPath,
                      cacheWidth: 288,
                      semanticLabel: entry.note ?? l10n.journalPhotos,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatsPanel extends StatelessWidget {
  const _StatsPanel({required this.stats, required this.onCompare});

  final JournalStats stats;
  final VoidCallback onCompare;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final number = NumberFormat.decimalPattern(locale);
    final harvest = [
      for (final MapEntry(key: unit, value: total) in stats.harvests.entries)
        switch (unit) {
          HarvestUnit.grams => l10n.journalHarvestGrams(number.format(total)),
          HarvestUnit.pieces => l10n.journalHarvestPieces(number.format(total)),
          HarvestUnit.bunches => l10n.journalHarvestBunches(
            number.format(total),
          ),
        },
    ].join(' · ');

    Widget stat(String label, String value) => SizedBox(
      width: 132,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: theme.textTheme.titleLarge),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(l10n.statsTitle, style: theme.textTheme.titleSmall),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.sm,
            children: [
              stat(l10n.statTasks, number.format(stats.tasksDone)),
              stat(l10n.statStreak, number.format(stats.streakDays)),
              stat(l10n.statEntries, number.format(stats.entries)),
              stat(l10n.statPhotos, number.format(stats.photos)),
            ],
          ),
          if (harvest.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${l10n.statHarvested}: $harvest',
              style: theme.textTheme.bodyMedium,
            ),
          ],
          if (stats.photos >= 2)
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton.icon(
                icon: const Icon(Icons.compare_outlined),
                label: Text(l10n.compareAction),
                onPressed: onCompare,
              ),
            ),
        ],
      ),
    );
  }
}
