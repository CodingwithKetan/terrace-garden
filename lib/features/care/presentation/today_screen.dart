import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/app/theme/care_colors.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/core/units/measurement_formatter.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/core/widgets/dialogs.dart';
import 'package:terrace_garden/core/widgets/error_state.dart';
import 'package:terrace_garden/features/care/application/care_controllers.dart';
import 'package:terrace_garden/features/care/data/care_providers.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/care/presentation/care_labels.dart';
import 'package:terrace_garden/features/care/presentation/care_sheets.dart';
import 'package:terrace_garden/features/care/presentation/soil_check_sheet.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';
import 'package:terrace_garden/features/garden/garden.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/garden_designer.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plant_catalog/plant_catalog.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';
import 'package:terrace_garden/features/plantings/plantings.dart';
import 'package:terrace_garden/features/settings/settings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// HOME-01, Living Terrace: the day's job as a headline, the user's own
/// terrace drawn from above with pins on plants that need a check, and the
/// tasks grouped by kind. Watering is always a soil check first.
class TodayScreen extends ConsumerStatefulWidget {
  const TodayScreen({super.key});

  @override
  ConsumerState<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends ConsumerState<TodayScreen> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    // A new day may have started while the app was in the background.
    _lifecycle = AppLifecycleListener(
      onResume: () {
        ref.invalidate(agendaProvider);
        unawaited(ref.read(careSyncProvider).reconcile());
      },
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final now = ref.watch(clockProvider).now();
    final today = LocalDate.fromDateTime(now);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final garden = ref.watch(currentGardenProvider);
    final gardens = ref.watch(gardensProvider).value ?? const <Garden>[];
    final catalogue = ref.watch(plantCatalogueProvider).value;
    final allTasks = ref.watch(agendaProvider).value ?? const <CareTask>[];
    final allPlantings = ref.watch(allPlantingsProvider).value ?? const [];
    final done = ref.watch(doneTasksProvider).value ?? const <CareTask>[];
    final elements = garden == null
        ? const <LayoutElement>[]
        : ref.watch(layoutElementsProvider(garden.id)).value ??
              const <LayoutElement>[];

    final tasks = [
      for (final t in allTasks)
        if (t.gardenId == garden?.id) t,
    ];
    final plantings = [
      for (final p in allPlantings)
        if (p.gardenId == garden?.id) p,
    ];
    final data = _TodayData(
      today: today,
      tasks: tasks,
      plantings: plantings,
      elements: elements,
      done: done,
      catalogue: catalogue,
      l10n: l10n,
    );

    final dueNow = tasks.where((t) => t.isPending && !t.dueOn.isAfter(today));
    final soilDue = dueNow.where((t) => t.type == CareTaskType.checkSoil);
    final headline = soilDue.isNotEmpty
        ? l10n.todayHeadlineSoil(soilDue.length)
        : dueNow.isNotEmpty
        ? l10n.todayHeadlineTasks(dueNow.length)
        : plantings.isNotEmpty
        ? l10n.todayHeadlineDone
        : l10n.todayEmptyTitle;
    final gutter = AppSpacing.contentInsetFor(MediaQuery.sizeOf(context).width);

    final children = <Widget>[
      _Header(garden: garden, gardens: gardens),
      const SizedBox(height: AppSpacing.sm),
      Text(
        [
          DateFormat.MMMMEEEEd(locale).format(now),
          ?garden?.cityName,
        ].join(' · '),
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      const SizedBox(height: AppSpacing.xs),
      Semantics(
        header: true,
        child: Text(headline, style: theme.textTheme.headlineMedium),
      ),
      if (soilDue.isNotEmpty) ...[
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.todayWaterTip,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
      const SizedBox(height: AppSpacing.lg),
      if (garden == null)
        const _DrawTerraceCard()
      else if (!garden.hasDimensions || elements.isEmpty)
        _NoLayoutCard(garden: garden)
      else
        _PlanSection(garden: garden, data: data),
      ..._taskSections(data),
    ];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            gutter,
            AppSpacing.sm,
            gutter,
            AppSpacing.xxl,
          ),
          children: children,
        ),
      ),
    );
  }

  List<Widget> _taskSections(_TodayData d) {
    final l10n = d.l10n;
    final due = [
      for (final t in d.tasks)
        if (t.isPending && !t.dueOn.isAfter(d.today)) t,
    ];
    final finished = [
      for (final t in d.tasks)
        if (!t.isPending) t,
    ];
    final upcoming = [
      for (final t in d.tasks)
        if (t.isPending && t.dueOn.isAfter(d.today)) t,
    ];
    return [
      for (final type in CareTaskType.values)
        if (due.where((t) => t.type == type).toList() case final group
            when group.isNotEmpty)
          _TaskGroup(type: type, tasks: group, data: d),
      if (finished.isNotEmpty)
        _SimpleSection(
          title: l10n.todayDoneToday,
          children: [
            for (final t in finished) _TaskRow(task: t, data: d, compact: true),
          ],
        ),
      if (upcoming.isNotEmpty)
        _SimpleSection(
          title: l10n.todayUpcoming,
          children: [
            for (final t in upcoming)
              _TaskRow(task: t, data: d, compact: true, showType: true),
          ],
        ),
    ];
  }
}

/// Everything rows and the plan need to describe a task or container.
class _TodayData {
  _TodayData({
    required this.today,
    required this.tasks,
    required this.plantings,
    required this.elements,
    required this.done,
    required this.catalogue,
    required this.l10n,
  });

  final LocalDate today;
  final List<CareTask> tasks;
  final List<Planting> plantings;
  final List<LayoutElement> elements;
  final List<CareTask> done;
  final PlantCatalogue? catalogue;
  final AppLocalizations l10n;

  late final Map<String, Planting> _plantingById = {
    for (final p in plantings) p.id: p,
  };
  late final List<LayoutElement> containers = layoutContainers(elements);

  Planting? planting(String id) => _plantingById[id];

  PlantSpecies? species(String plantingId) =>
      catalogue?.byId(planting(plantingId)?.speciesId ?? '');

  String plantName(String plantingId) =>
      species(plantingId)?.commonName ?? l10n.plantingUnknownSpecies;

  LayoutElement? container(String plantingId) {
    final id = planting(plantingId)?.elementId;
    return containers.where((c) => c.id == id).firstOrNull;
  }

  String containerLabel(String plantingId) {
    final c = container(plantingId);
    return c == null
        ? l10n.plantingNotPlaced
        : containerName(l10n, c, containers);
  }

  /// "checked yesterday" for a planting's last finished task of [type].
  String lastChecked(String plantingId, CareTaskType type) {
    final last = [
      for (final t in done)
        if (t.plantingId == plantingId && t.type == type) ?t.completedOn,
    ]..sort();
    if (last.isEmpty) return l10n.checkedNever;
    final days = last.last.daysUntil(today);
    return switch (days) {
      <= 0 => l10n.checkedToday,
      1 => l10n.checkedYesterday,
      _ => l10n.checkedDaysAgo(days),
    };
  }
}

// ---------------------------------------------------------------------------
// Header and garden switching
// ---------------------------------------------------------------------------

class _Header extends ConsumerWidget {
  const _Header({required this.garden, required this.gardens});

  final Garden? garden;
  final List<Garden> gardens;

  Future<void> _switch(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    await showAppBottomSheet<void>(
      context,
      title: l10n.todaySwitchGarden,
      builder: (sheet) => Column(
        children: [
          for (final g in gardens)
            ListTile(
              leading: Icon(
                g.id == garden?.id
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
              ),
              title: Text(g.name),
              subtitle: g.cityName == null ? null : Text(g.cityName!),
              onTap: () {
                ref.read(selectedGardenIdProvider.notifier).selected = g.id;
                Navigator.of(sheet).pop();
              },
            ),
          ListTile(
            leading: const Icon(Icons.list),
            title: Text(l10n.todayAllGardens),
            onTap: () {
              Navigator.of(sheet).pop();
              unawaited(context.push(AppRoutes.gardens));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final g = garden;
    return Row(
      children: [
        if (g != null)
          Flexible(
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.onSurface,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              ),
              onPressed: () => context.push(AppRoutes.gardenDetail(g.id)),
              child: Text(
                g.name,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium,
              ),
            ),
          ),
        if (gardens.length > 1)
          IconButton(
            tooltip: l10n.todaySwitchGarden,
            icon: const Icon(Icons.expand_more),
            onPressed: () => _switch(context, ref),
          ),
        const Spacer(),
        IconButton(
          tooltip: l10n.calendarTitle,
          icon: const Icon(Icons.calendar_month_outlined),
          onPressed: () => context.push(AppRoutes.careCalendar),
        ),
        IconButton(
          tooltip: l10n.settingsTooltip,
          icon: const Icon(Icons.settings_outlined),
          onPressed: () => context.push(AppRoutes.settings),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// The terrace
// ---------------------------------------------------------------------------

class _PlanSection extends ConsumerWidget {
  const _PlanSection({required this.garden, required this.data});

  final Garden garden;
  final _TodayData data;

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
    final dark = theme.brightness == Brightness.dark;

    final items = <PlanItem>[];
    for (final e in data.elements) {
      if (!e.kind.isContainer) {
        items.add(PlanItem(element: e));
        continue;
      }
      final here = [
        for (final p in data.plantings)
          if (p.elementId == e.id) p,
      ];
      final ids = {for (final p in here) p.id};
      final pending = data.tasks.where(
        (t) =>
            ids.contains(t.plantingId) &&
            t.isPending &&
            !t.dueOn.isAfter(data.today),
      );
      final finishedToday = data.tasks.any(
        (t) => ids.contains(t.plantingId) && !t.isPending,
      );
      final badge = pending.isNotEmpty
          ? PlanBadge.due
          : finishedToday
          ? PlanBadge.done
          : PlanBadge.none;
      final names = [
        for (final p in here)
          data.catalogue?.byId(p.speciesId)?.commonName ??
              l10n.plantingUnknownSpecies,
      ];
      final name = containerName(l10n, e, data.containers);
      final tag = names.isEmpty
          ? name
          : names.length == 1
          ? names.first
          : '${names.first} +${names.length - 1}';
      final status = switch (badge) {
        PlanBadge.due => l10n.planDue,
        PlanBadge.done => l10n.planDone,
        PlanBadge.none => names.isEmpty ? l10n.planEmpty : null,
      };
      items.add(
        PlanItem(
          element: e,
          plants: [
            for (final p in here)
              PlantArtSpec.of(
                p.speciesId,
                category: data.catalogue?.byId(p.speciesId)?.category,
              ),
          ],
          tag: tag,
          badge: badge,
          semanticLabel: [
            if (names.isNotEmpty) names.join(', '),
            name,
            ?status,
          ].join(', '),
        ),
      );
    }

    Future<void> onTap(PlanItem item) async {
      final here = [
        for (final p in data.plantings)
          if (p.elementId == item.element.id) p,
      ];
      final soil = data.tasks
          .where(
            (t) =>
                t.type == CareTaskType.checkSoil &&
                t.isPending &&
                !t.dueOn.isAfter(data.today) &&
                here.any((p) => p.id == t.plantingId),
          )
          .firstOrNull;
      if (soil != null) {
        await _runSoilCheck(context, ref, soil, data);
      } else if (here.isNotEmpty) {
        await context.push(
          AppRoutes.plantDetail(here.first.speciesId, gardenId: garden.id),
        );
      } else {
        await context.push(AppRoutes.gardenIdeas(garden.id));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withValues(alpha: .16),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          // The box follows the terrace's proportions, kept between a
          // nearly square and a long, narrow balcony.
          child: AspectRatio(
            aspectRatio: (garden.length!.cm / garden.width!.cm).clamp(.9, 3),
            child: TerracePlan(
              lengthCm: garden.length!.cm,
              widthCm: garden.width!.cm,
              items: items,
              dusk: dark,
              semanticLabel: l10n.todayPlanLabel(garden.name),
              onTapItem: onTap,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.gardenSizeValue(
                  format.length(garden.length!),
                  format.length(garden.width!),
                ),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            TextButton(
              onPressed: () => context.push(AppRoutes.gardenDesign(garden.id)),
              child: Text(l10n.todayEditLayout),
            ),
          ],
        ),
      ],
    );
  }
}

class _DrawTerraceCard extends StatelessWidget {
  const _DrawTerraceCard();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return _Paper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 168, child: _SketchIllustration()),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.todayDrawTitle, style: theme.textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.xs),
          Text(l10n.todayDrawBody, style: theme.textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.onSurface,
              foregroundColor: theme.colorScheme.surface,
            ),
            onPressed: () => context.push(AppRoutes.gardenNew),
            child: Text(l10n.todayDrawStart),
          ),
          TextButton(
            onPressed: () => context.go(AppRoutes.plants),
            child: Text(l10n.todayDrawExplore),
          ),
        ],
      ),
    );
  }
}

class _NoLayoutCard extends StatelessWidget {
  const _NoLayoutCard({required this.garden});

  final Garden garden;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return _Paper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 120, child: _SketchIllustration()),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.todayNoLayoutTitle, style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.xs),
          Text(l10n.todayNoLayoutBody, style: theme.textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.md),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: FilledButton.icon(
              icon: const Icon(Icons.dashboard_customize_outlined),
              label: Text(l10n.todayDesignLayout),
              onPressed: () => context.push(AppRoutes.gardenDesign(garden.id)),
            ),
          ),
        ],
      ),
    );
  }
}

/// A terrace outline being measured, with dotted places for pots.
class _SketchIllustration extends StatelessWidget {
  const _SketchIllustration();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ExcludeSemantics(
      child: CustomPaint(
        painter: _SketchPainter(
          ink: colors.onSurface,
          accent: colors.secondary,
          dashes: colors.outline,
          floor: colors.surfaceContainer,
        ),
      ),
    );
  }
}

class _SketchPainter extends CustomPainter {
  const _SketchPainter({
    required this.ink,
    required this.accent,
    required this.dashes,
    required this.floor,
  });

  final Color ink;
  final Color accent;
  final Color dashes;
  final Color floor;

  @override
  void paint(Canvas canvas, Size size) {
    final r = Rect.fromLTWH(
      size.width * .12,
      size.height * .18,
      size.width * .76,
      size.height * .7,
    );
    canvas.drawRect(r, Paint()..color = floor);
    final line = Paint()
      ..color = ink
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(
      Path()
        ..moveTo(r.left, r.bottom)
        ..lineTo(r.left, r.top)
        ..lineTo(r.right, r.top)
        ..lineTo(r.right, r.center.dy),
      line,
    );
    final dotted = Paint()
      ..color = ink
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    for (var y = r.center.dy + 10; y < r.bottom; y += 11) {
      canvas.drawCircle(Offset(r.right, y), 1.4, dotted);
    }
    for (var x = r.left; x < r.right; x += 11) {
      canvas.drawCircle(Offset(x, r.bottom), 1.4, dotted);
    }
    final dim = Paint()
      ..color = accent
      ..strokeWidth = 1.6;
    final y = r.top - size.height * .08;
    canvas
      ..drawLine(Offset(r.left, y), Offset(r.right, y), dim)
      ..drawLine(Offset(r.left, y - 6), Offset(r.left, y + 6), dim)
      ..drawLine(Offset(r.right, y - 6), Offset(r.right, y + 6), dim);
    final dash = Paint()
      ..color = dashes
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    void dashed(Path p) {
      for (final m in p.computeMetrics()) {
        for (var d = 0.0; d < m.length; d += 9) {
          canvas.drawPath(m.extractPath(d, d + 4), dash);
        }
      }
    }

    dashed(
      Path()..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            r.left + r.width * .1,
            r.top + r.height * .14,
            r.width * .28,
            r.height * .3,
          ),
          const Radius.circular(8),
        ),
      ),
    );
    dashed(
      Path()..addOval(
        Rect.fromCircle(
          center: Offset(r.left + r.width * .62, r.top + r.height * .3),
          radius: r.height * .16,
        ),
      ),
    );
    dashed(
      Path()..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            r.left + r.width * .3,
            r.top + r.height * .62,
            r.width * .48,
            r.height * .22,
          ),
          const Radius.circular(6),
        ),
      ),
    );
  }

  @override
  bool shouldRepaint(_SketchPainter oldDelegate) =>
      oldDelegate.ink != ink || oldDelegate.floor != floor;
}

class _Paper extends StatelessWidget {
  const _Paper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.lg),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(24),
    ),
    child: child,
  );
}

// ---------------------------------------------------------------------------
// Tasks
// ---------------------------------------------------------------------------

/// Runs the soil-check sheet for [task] and records the answer.
Future<void> _runSoilCheck(
  BuildContext context,
  WidgetRef ref,
  CareTask task,
  _TodayData data,
) async {
  final l10n = context.l10n;
  final messenger = ScaffoldMessenger.of(context);
  final answer = await showSoilCheckSheet(
    context,
    plantName: data.plantName(task.plantingId),
    containerName: data.containerLabel(task.plantingId),
    species: data.species(task.plantingId),
    growBag: data.container(task.plantingId)?.kind == ElementKind.growBag,
  );
  if (answer == null) return;
  final care = ref.read(careRepositoryProvider);
  final result = switch (answer) {
    SoilCheckAnswer.watered => await care.complete(task.id, on: data.today),
    SoilCheckAnswer.stillMoist => await care.skip(
      task.id,
      on: data.today,
      reason: SkipReason.soilStillMoist,
    ),
  };
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(switch (result) {
          Ok() =>
            answer == SoilCheckAnswer.watered
                ? l10n.taskCompleted
                : l10n.taskSkipped,
          Err(:final failure) => ErrorState.messageFor(l10n, failure),
        }),
      ),
    );
}

class _TaskGroup extends ConsumerWidget {
  const _TaskGroup({
    required this.type,
    required this.tasks,
    required this.data,
  });

  final CareTaskType type;
  final List<CareTask> tasks;
  final _TodayData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    Future<void> markAll() async {
      final messenger = ScaffoldMessenger.of(context);
      final care = ref.read(careRepositoryProvider);
      for (final t in tasks) {
        await care.complete(t.id, on: data.today);
      }
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(l10n.taskCompleted)));
    }

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(type.icon, size: 18, color: type.color(context.careColors)),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Semantics(
                        header: true,
                        child: Text(
                          type.label(l10n),
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                    ),
                    Text(
                      '  ·  ${tasks.length}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (tasks.length > 1)
                TextButton(
                  onPressed: markAll,
                  child: Text(l10n.taskMarkAllDone),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _Paper(
            child: Column(
              children: [
                for (final (i, t) in tasks.indexed) ...[
                  if (i > 0)
                    Divider(height: 1, color: theme.colorScheme.outlineVariant),
                  _TaskRow(task: t, data: data),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SimpleSection extends StatelessWidget {
  const _SimpleSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: Text(title, style: theme.textTheme.titleSmall),
          ),
          const SizedBox(height: AppSpacing.sm),
          _Paper(child: Column(children: children)),
        ],
      ),
    );
  }
}

enum _TaskAction { howTo, skip, tomorrow, pickDate }

class _TaskRow extends ConsumerWidget {
  const _TaskRow({
    required this.task,
    required this.data,
    this.compact = false,
    this.showType = false,
  });

  final CareTask task;
  final _TodayData data;
  final bool compact;
  final bool showType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final care = ref.read(careRepositoryProvider);
    final species = data.species(task.plantingId);
    final color = task.type.color(context.careColors);
    String dateLabel(LocalDate d) =>
        DateFormat.MMMEd(locale).format(d.toLocalDateTime());

    Future<void> report(Result<void> result, String message) async {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(switch (result) {
              Ok() => message,
              Err(:final failure) => ErrorState.messageFor(l10n, failure),
            }),
          ),
        );
    }

    Future<void> complete() async {
      if (task.type == CareTaskType.checkSoil) {
        await _runSoilCheck(context, ref, task, data);
      } else {
        await report(
          await care.complete(task.id, on: data.today),
          l10n.taskCompleted,
        );
      }
    }

    Future<void> onAction(_TaskAction action) async {
      switch (action) {
        case _TaskAction.howTo:
          await showTaskGuide(
            context,
            type: task.type,
            species: species,
            sources: data.catalogue?.sources ?? const {},
          );
        case _TaskAction.skip:
          final reason = await showSkipReasonSheet(context);
          if (reason == null) return;
          await report(
            await care.skip(task.id, on: data.today, reason: reason),
            l10n.taskSkipped,
          );
        case _TaskAction.tomorrow:
          final to = data.today.addDays(1);
          await report(
            await care.reschedule(task.id, to),
            l10n.taskMoved(dateLabel(to)),
          );
        case _TaskAction.pickDate:
          final picked = await showDatePicker(
            context: context,
            initialDate: data.today.addDays(1).toLocalDateTime(),
            firstDate: data.today.toLocalDateTime(),
            lastDate: data.today.addDays(60).toLocalDateTime(),
          );
          if (picked == null) return;
          final to = LocalDate.fromDateTime(picked);
          await report(
            await care.reschedule(task.id, to),
            l10n.taskMoved(dateLabel(to)),
          );
      }
    }

    final dueNow = task.isPending && !task.dueOn.isAfter(data.today);
    final details = [
      if (showType) task.type.label(l10n),
      data.containerLabel(task.plantingId),
      if (task.isPending && task.dueOn.isBefore(data.today))
        l10n.dueSince(dateLabel(task.dueOn))
      else if (task.isPending && task.dueOn.isAfter(data.today))
        l10n.taskDueOn(dateLabel(task.dueOn))
      else if (task.isPending)
        data.lastChecked(task.plantingId, task.type),
      if (task.skipReason case final reason?) reason.label(l10n),
    ].join(' · ');
    final art = compact ? 36.0 : 46.0;

    return InkWell(
      onTap: dueNow ? complete : null,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: compact ? AppSpacing.xxs : AppSpacing.sm,
        ),
        child: Row(
          children: [
            ExcludeSemantics(
              child: Container(
                width: art,
                height: art,
                padding: const EdgeInsets.all(AppSpacing.xxs),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHigh,
                  shape: BoxShape.circle,
                ),
                child: PlantTopArt(
                  spec: PlantArtSpec.of(
                    species?.id ?? '',
                    category: species?.category,
                  ),
                  size: art - AppSpacing.xs,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.plantName(task.plantingId),
                    style:
                        (compact
                                ? theme.textTheme.titleSmall
                                : theme.textTheme.titleMedium)
                            ?.copyWith(
                              fontFamily:
                                  theme.textTheme.headlineSmall?.fontFamily,
                              fontWeight: FontWeight.w400,
                              decoration: task.isPending
                                  ? null
                                  : TextDecoration.lineThrough,
                            ),
                  ),
                  Text(details, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            if (task.isPending)
              IconButton(
                tooltip: l10n.taskDone,
                onPressed: complete,
                icon: Icon(Icons.radio_button_unchecked, color: color),
              )
            else
              Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Icon(
                  task.status == TaskStatus.done
                      ? Icons.check_circle
                      : Icons.redo_rounded,
                  color: task.status == TaskStatus.done
                      ? context.careColors.success
                      : colors.onSurfaceVariant,
                  semanticLabel: task.status == TaskStatus.done
                      ? l10n.taskCompleted
                      : l10n.taskSkipped,
                ),
              ),
            PopupMenuButton<_TaskAction>(
              tooltip: l10n.taskActions,
              onSelected: onAction,
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: _TaskAction.howTo,
                  child: Text(l10n.taskHowTo),
                ),
                if (task.isPending) ...[
                  PopupMenuItem(
                    value: _TaskAction.skip,
                    child: Text(l10n.taskSkip),
                  ),
                  PopupMenuItem(
                    value: _TaskAction.tomorrow,
                    child: Text(l10n.taskMoveTomorrow),
                  ),
                  PopupMenuItem(
                    value: _TaskAction.pickDate,
                    child: Text(l10n.taskPickDate),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
