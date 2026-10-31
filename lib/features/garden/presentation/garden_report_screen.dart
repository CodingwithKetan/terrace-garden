import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:terrace_garden/app/data/data_export_service.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/core/units/measurement_formatter.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/core/widgets/async_state_view.dart';
import 'package:terrace_garden/features/care/care.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/garden/data/garden_providers.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/garden_designer.dart';
import 'package:terrace_garden/features/journal/domain/journal_entry.dart';
import 'package:terrace_garden/features/journal/domain/journal_stats.dart';
import 'package:terrace_garden/features/journal/journal.dart';
import 'package:terrace_garden/features/plant_catalog/plant_catalog.dart';
import 'package:terrace_garden/features/plantings/plantings.dart';
import 'package:terrace_garden/features/settings/settings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// GDN-REPORT (Plus, ADR-028). One page about a garden: its plan, plants,
/// recent care and harvests, shared as an image so any language prints
/// as it shows on screen.
class GardenReportScreen extends ConsumerStatefulWidget {
  const GardenReportScreen({required this.gardenId, super.key});

  final String gardenId;

  @override
  ConsumerState<GardenReportScreen> createState() => _GardenReportScreenState();
}

class _GardenReportScreenState extends ConsumerState<GardenReportScreen> {
  final GlobalKey _page = GlobalKey();
  bool _sharing = false;

  Future<void> _share(Garden garden) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final sharer = ref.read(fileSharerProvider);
    setState(() => _sharing = true);
    try {
      final boundary =
          _page.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 2.5);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/garden-report-${garden.id}.png');
      await file.writeAsBytes(bytes!.buffer.asUint8List(), flush: true);
      await sharer.shareFile(
        file,
        subject: l10n.reportShareSubject(garden.name),
      );
    } on Object {
      messenger.showSnackBar(SnackBar(content: Text(l10n.reportShareFailed)));
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final garden = ref.watch(gardenProvider(widget.gardenId));
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.reportTitle),
        actions: [
          if (garden.value case final g?)
            IconButton(
              tooltip: l10n.reportShare,
              icon: const Icon(Icons.ios_share_outlined),
              onPressed: _sharing ? null : () => _share(g),
            ),
        ],
      ),
      body: AsyncStateView(
        value: garden,
        onRetry: () => ref.invalidate(gardenProvider(widget.gardenId)),
        data: (g) => g == null
            ? const SizedBox.shrink()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: RepaintBoundary(
                      key: _page,
                      child: _ReportPage(garden: g),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class _ReportPage extends ConsumerWidget {
  const _ReportPage({required this.garden});

  final Garden garden;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final now = ref.watch(clockProvider).now();
    final today = LocalDate.fromDateTime(now);
    final units =
        ref.watch(settingsControllerProvider).value?.unitSystem ??
        UnitSystem.metric;
    final format = MeasurementFormatter(units, locale: locale);
    final catalogue = ref.watch(plantCatalogueProvider).value;
    final plantings =
        ref.watch(gardenPlantingsProvider(garden.id)).value ?? const [];
    final elements =
        ref.watch(layoutElementsProvider(garden.id)).value ??
        const <LayoutElement>[];
    final containers = layoutContainers(elements);
    final ids = {for (final p in plantings) p.id};
    final since = today.addDays(-30);
    final care = <CareTaskType, int>{};
    for (final t in ref.watch(doneTasksProvider).value ?? const <CareTask>[]) {
      final on = t.completedOn;
      if (t.status != TaskStatus.done || on == null) continue;
      if (!ids.contains(t.plantingId) || on.isBefore(since)) continue;
      care[t.type] = (care[t.type] ?? 0) + 1;
    }
    final entries = [
      for (final e
          in ref.watch(journalEntriesProvider).value ?? const <JournalEntry>[])
        if (e.gardenId == garden.id) e,
    ];
    final stats = JournalStats.of(
      entries: entries,
      doneTasks: const [],
      today: today,
    );
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
    ];
    String plantName(String speciesId) =>
        catalogue?.byId(speciesId)?.name(l10n) ?? l10n.plantingUnknownSpecies;

    Widget section(String title, List<Widget> children) => Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.xs),
          ...children,
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(garden.name, style: theme.textTheme.headlineMedium),
          Text(
            [
              DateFormat.yMMMMd(locale).format(now),
              ?garden.cityName,
              if (garden.hasDimensions)
                l10n.gardenSizeValue(
                  format.length(garden.length!),
                  format.length(garden.width!),
                ),
            ].join(' · '),
            style: theme.textTheme.bodyMedium,
          ),
          if (garden.hasDimensions && elements.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            AspectRatio(
              aspectRatio: (garden.length!.cm / garden.width!.cm).clamp(
                .9,
                3.0,
              ),
              child: TerracePlan(
                lengthCm: garden.length!.cm,
                widthCm: garden.width!.cm,
                items: [
                  for (final e in elements)
                    PlanItem(
                      element: e,
                      plants: [
                        for (final p in plantings)
                          if (p.elementId == e.id)
                            PlantArtSpec.of(
                              p.speciesId,
                              category: catalogue?.byId(p.speciesId)?.category,
                            ),
                      ],
                      tag: [
                        for (final p in plantings)
                          if (p.elementId == e.id)
                            catalogue?.byId(p.speciesId)?.shortName(l10n) ??
                                l10n.plantingUnknownSpecies,
                      ].firstOrNull,
                    ),
                ],
              ),
            ),
          ],
          section(l10n.reportPlants, [
            if (plantings.isEmpty)
              Text(l10n.reportNoPlants, style: theme.textTheme.bodyMedium),
            for (final p in plantings)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
                child: Text(
                  [
                    plantName(p.speciesId),
                    if (containers.where((c) => c.id == p.elementId).firstOrNull
                        case final c?)
                      containerName(l10n, c, containers),
                    if (p.plantedOn.daysUntil(today) >= 0)
                      l10n.journeyDay(p.plantedOn.daysUntil(today) + 1),
                  ].join(' · '),
                  style: theme.textTheme.bodyMedium,
                ),
              ),
          ]),
          section(l10n.reportCare, [
            if (care.isEmpty)
              Text(l10n.reportCareNone, style: theme.textTheme.bodyMedium)
            else
              Text(
                [
                  for (final MapEntry(key: type, value: count) in care.entries)
                    '${type.label(l10n)} · $count',
                ].join('\n'),
                style: theme.textTheme.bodyMedium,
              ),
          ]),
          section(l10n.reportHarvests, [
            Text(
              harvest.isEmpty ? l10n.reportHarvestsNone : harvest.join(' · '),
              style: theme.textTheme.bodyMedium,
            ),
          ]),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.reportFooter, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
