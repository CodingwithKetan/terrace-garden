import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/app/theme/app_imagery.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/app/theme/care_colors.dart';
import 'package:terrace_garden/app/theme/glass_theme.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/core/widgets/error_state.dart';
import 'package:terrace_garden/core/widgets/glass_icon_button.dart';
import 'package:terrace_garden/core/widgets/glass_panel.dart';
import 'package:terrace_garden/core/widgets/photo_backdrop.dart';
import 'package:terrace_garden/features/care/application/care_controllers.dart';
import 'package:terrace_garden/features/care/data/care_providers.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/care/presentation/care_labels.dart';
import 'package:terrace_garden/features/care/presentation/care_sheets.dart';
import 'package:terrace_garden/features/garden/garden.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plant_catalog/plant_catalog.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';
import 'package:terrace_garden/features/plantings/plantings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// HOME-01 (P5-05). The day's care: overdue, today, done today and the week
/// ahead. Watering is always a soil check first.
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
    final now = ref.watch(clockProvider).now();
    final locale = Localizations.localeOf(context).toLanguageTag();
    final today = LocalDate.fromDateTime(now);
    final tasks = ref.watch(agendaProvider).value ?? const <CareTask>[];
    final plantings = ref.watch(allPlantingsProvider).value ?? const [];
    final dueToday = tasks
        .where((t) => t.isPending && !t.dueOn.isAfter(today))
        .length;

    return Scaffold(
      body: PhotoBackdrop(
        image: const AssetImage(AppPhotos.todayTerrace),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final gutter = AppSpacing.gutterFor(constraints.maxWidth);
            final insets = MediaQuery.paddingOf(context);
            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppBreakpoints.readableMaxWidth,
                ),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    gutter,
                    insets.top + AppSpacing.md,
                    gutter,
                    insets.bottom + AppSpacing.xl,
                  ),
                  children: [
                    _Header(
                      date: DateFormat.MMMMEEEEd(locale).format(now),
                      greeting: switch (now.hour) {
                        < 12 => l10n.greetingMorning,
                        < 17 => l10n.greetingAfternoon,
                        _ => l10n.greetingEvening,
                      },
                      subtitle: plantings.isEmpty
                          ? l10n.todayEmptyTitle
                          : l10n.todayTasksDue(dueToday),
                      onSettings: () => context.push(AppRoutes.settings),
                    ),
                    // Let the photo breathe before the content cards.
                    SizedBox(
                      height: tasks.isEmpty
                          ? constraints.maxHeight * 0.22
                          : AppSpacing.xxl,
                    ),
                    if (plantings.isEmpty)
                      _EmptyCareCard(
                        heading: l10n.todayCareHeading,
                        title: l10n.todayNoTasks,
                        body: l10n.todayEmptyBody,
                      )
                    else
                      _Agenda(tasks: tasks, plantings: plantings, today: today),
                    const SizedBox(height: AppSpacing.md),
                    _TipCard(
                      title: l10n.tipWateringTitle,
                      body: l10n.tipWateringBody,
                      source: l10n.tipWateringSource,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Everything a task row needs to describe itself.
class _TaskContext {
  const _TaskContext({
    required this.plantName,
    required this.species,
    required this.gardenName,
  });

  final String plantName;
  final PlantSpecies? species;

  /// Only shown when the user has more than one garden.
  final String? gardenName;
}

class _Agenda extends ConsumerWidget {
  const _Agenda({
    required this.tasks,
    required this.plantings,
    required this.today,
  });

  final List<CareTask> tasks;
  final List<Planting> plantings;
  final LocalDate today;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final catalogue = ref.watch(plantCatalogueProvider).value;
    final gardens = ref.watch(gardensProvider).value ?? const [];
    final plantingById = {for (final p in plantings) p.id: p};
    final gardenNames = {for (final g in gardens) g.id: g.name};

    _TaskContext contextFor(CareTask t) {
      final species = catalogue?.byId(
        plantingById[t.plantingId]?.speciesId ?? '',
      );
      return _TaskContext(
        plantName: species?.commonName ?? l10n.plantingUnknownSpecies,
        species: species,
        gardenName: gardens.length > 1 ? gardenNames[t.gardenId] : null,
      );
    }

    final overdue = tasks.where((t) => t.isOverdue(today)).toList();
    final dueToday = tasks
        .where((t) => t.isPending && t.dueOn == today)
        .toList();
    final done = tasks.where((t) => !t.isPending).toList();
    final upcoming = tasks
        .where((t) => t.isPending && t.dueOn.isAfter(today))
        .toList();

    Widget tile(CareTask t, {bool showDate = false, bool showType = false}) =>
        _TaskTile(
          task: t,
          info: contextFor(t),
          today: today,
          showDate: showDate,
          showType: showType,
          sources: catalogue?.sources ?? const {},
        );

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.todayCareHeading.toUpperCase(),
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              letterSpacing: 1.2,
            ),
          ),
          if (overdue.isEmpty && dueToday.isEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: context.careColors.success,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.todayAllDone,
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        l10n.todayAllDoneBody,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          if (overdue.isNotEmpty) ...[
            _SectionLabel(l10n.todayOverdue),
            for (final t in overdue) tile(t, showDate: true, showType: true),
          ],
          if (dueToday.isNotEmpty) ...[
            _SectionLabel(l10n.todayDueToday),
            for (final type in CareTaskType.values)
              if (dueToday.where((t) => t.type == type).toList()
                  case final group when group.isNotEmpty)
                _TypeGroup(
                  type: type,
                  tasks: group,
                  today: today,
                  children: [for (final t in group) tile(t)],
                ),
          ],
          if (done.isNotEmpty) ...[
            _SectionLabel(l10n.todayDoneToday),
            for (final t in done) tile(t, showType: true),
          ],
          if (upcoming.isNotEmpty) ...[
            _SectionLabel(l10n.todayUpcoming),
            for (final t in upcoming) tile(t, showDate: true, showType: true),
          ],
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: AppSpacing.lg, bottom: AppSpacing.xs),
    child: Semantics(
      header: true,
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    ),
  );
}

/// Today's tasks of one type, with "Mark all done" for two or more.
class _TypeGroup extends ConsumerWidget {
  const _TypeGroup({
    required this.type,
    required this.tasks,
    required this.today,
    required this.children,
  });

  final CareTaskType type;
  final List<CareTask> tasks;
  final LocalDate today;
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final color = type.color(context.careColors);

    Future<void> markAll() async {
      final messenger = ScaffoldMessenger.of(context);
      final care = ref.read(careRepositoryProvider);
      for (final t in tasks) {
        await care.complete(t.id, on: today);
      }
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(l10n.taskCompleted)));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(type.icon, size: 20, color: color),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(type.label(l10n), style: theme.textTheme.titleSmall),
            ),
            if (tasks.length > 1)
              TextButton(onPressed: markAll, child: Text(l10n.taskMarkAllDone)),
          ],
        ),
        ...children,
      ],
    );
  }
}

enum _TaskAction { howTo, skip, tomorrow, pickDate }

class _TaskTile extends ConsumerWidget {
  const _TaskTile({
    required this.task,
    required this.info,
    required this.today,
    required this.showDate,
    required this.showType,
    required this.sources,
  });

  final CareTask task;
  final _TaskContext info;
  final LocalDate today;
  final bool showDate;
  final bool showType;
  final Map<String, SourceRef> sources;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final color = task.type.color(context.careColors);
    final care = ref.read(careRepositoryProvider);
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

    Future<void> onAction(_TaskAction action) async {
      switch (action) {
        case _TaskAction.howTo:
          await showTaskGuide(
            context,
            type: task.type,
            species: info.species,
            sources: sources,
          );
        case _TaskAction.skip:
          final reason = await showSkipReasonSheet(context);
          if (reason == null) return;
          await report(
            await care.skip(task.id, on: today, reason: reason),
            l10n.taskSkipped,
          );
        case _TaskAction.tomorrow:
          final to = today.addDays(1);
          await report(
            await care.reschedule(task.id, to),
            l10n.taskMoved(dateLabel(to)),
          );
        case _TaskAction.pickDate:
          final picked = await showDatePicker(
            context: context,
            initialDate: today.addDays(1).toLocalDateTime(),
            firstDate: today.toLocalDateTime(),
            lastDate: today.addDays(60).toLocalDateTime(),
          );
          if (picked == null) return;
          final to = LocalDate.fromDateTime(picked);
          await report(
            await care.reschedule(task.id, to),
            l10n.taskMoved(dateLabel(to)),
          );
      }
    }

    final title = showType
        ? '${task.type.label(l10n)} · ${info.plantName}'
        : info.plantName;
    final details = [
      ?info.gardenName,
      if (showDate && task.isPending) l10n.taskDueOn(dateLabel(task.dueOn)),
      if (task.skipReason case final reason?) reason.label(l10n),
    ].join(' · ');

    return Row(
      children: [
        if (task.isPending)
          IconButton(
            tooltip: l10n.taskDone,
            icon: Icon(Icons.radio_button_unchecked, color: color),
            onPressed: () async => report(
              await care.complete(task.id, on: today),
              l10n.taskCompleted,
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Icon(
              task.status == TaskStatus.done
                  ? Icons.check_circle
                  : Icons.redo_rounded,
              color: theme.colorScheme.onSurfaceVariant,
              semanticLabel: task.status == TaskStatus.done
                  ? l10n.taskCompleted
                  : l10n.taskSkipped,
            ),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  decoration: task.isPending
                      ? null
                      : TextDecoration.lineThrough,
                ),
              ),
              if (details.isNotEmpty)
                Text(details, style: theme.textTheme.bodySmall),
            ],
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
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.date,
    required this.greeting,
    required this.subtitle,
    required this.onSettings,
  });

  final String date;
  final String greeting;
  final String subtitle;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final onPhoto = context.glass.onPhoto;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date.toUpperCase(),
                style: text.labelMedium?.copyWith(
                  color: onPhoto,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Semantics(
                header: true,
                child: Text(
                  greeting,
                  style: text.displaySmall?.copyWith(color: onPhoto),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                style: text.bodyLarge?.copyWith(color: onPhoto),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        GlassIconButton(
          icon: Icons.settings_outlined,
          tooltip: context.l10n.settingsTooltip,
          onPressed: onSettings,
        ),
      ],
    );
  }
}

class _EmptyCareCard extends StatelessWidget {
  const _EmptyCareCard({
    required this.heading,
    required this.title,
    required this.body,
  });

  final String heading;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading.toUpperCase(),
            style: theme.textTheme.labelMedium?.copyWith(
              color: colors.onSurface,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Icon(
                    Icons.eco_outlined,
                    color: colors.onPrimaryContainer,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.xs),
                    Text(body, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard({
    required this.title,
    required this.body,
    required this.source,
  });

  final String title;
  final String body;
  final String source;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final water = context.careColors.water;

    return GlassPanel(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: water.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Icon(Icons.water_drop_outlined, color: water),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(body, style: theme.textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  source,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurface,
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
