import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/app/theme/care_colors.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/care/data/care_providers.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/care/presentation/care_labels.dart';
import 'package:terrace_garden/features/plant_catalog/plant_catalog.dart';
import 'package:terrace_garden/features/plantings/plantings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// CARE-02. A month of scheduled care: a count on each day with tasks, and
/// the selected day's list. Completion-based checks only exist one at a
/// time, so they show on their next due date.
class CareCalendarScreen extends ConsumerStatefulWidget {
  const CareCalendarScreen({super.key});

  @override
  ConsumerState<CareCalendarScreen> createState() => _CareCalendarScreenState();
}

class _CareCalendarScreenState extends ConsumerState<CareCalendarScreen> {
  late LocalDate _month;
  late LocalDate _selected;

  @override
  void initState() {
    super.initState();
    final today = LocalDate.fromDateTime(ref.read(clockProvider).now());
    _month = LocalDate(today.year, today.month, 1);
    _selected = today;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final today = LocalDate.fromDateTime(ref.watch(clockProvider).now());
    final pending = ref.watch(pendingTasksProvider).value ?? const [];
    final done = ref.watch(doneTasksProvider).value ?? const [];
    final plantings = ref.watch(allPlantingsProvider).value ?? const [];
    final catalogue = ref.watch(plantCatalogueProvider).value;

    // Overdue tasks count on today, as on the Today screen.
    final byDay = <LocalDate, List<CareTask>>{};
    for (final t in pending) {
      final day = t.dueOn.isBefore(today) ? today : t.dueOn;
      (byDay[day] ??= []).add(t);
    }
    for (final t in done) {
      if (t.completedOn case final on?) (byDay[on] ??= []).add(t);
    }

    String plantName(String plantingId) {
      final speciesId = plantings
          .where((p) => p.id == plantingId)
          .firstOrNull
          ?.speciesId;
      return catalogue?.byId(speciesId ?? '')?.commonName ??
          l10n.plantingUnknownSpecies;
    }

    final dayTasks = byDay[_selected] ?? const <CareTask>[];
    final width = MediaQuery.sizeOf(context).width;
    // Narrow side padding on phones keeps each day cell at least 48 dp wide.
    final gutter = width < AppBreakpoints.medium
        ? AppSpacing.sm
        : AppSpacing.contentInsetFor(width);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.calendarTitle)),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          gutter,
          AppSpacing.md,
          gutter,
          MediaQuery.paddingOf(context).bottom + AppSpacing.xl,
        ),
        children: [
          Row(
            children: [
              IconButton(
                tooltip: l10n.calendarPrevMonth,
                icon: const Icon(Icons.chevron_left),
                onPressed: () => setState(
                  () => _month = LocalDate(_month.year, _month.month - 1, 1),
                ),
              ),
              Expanded(
                child: Text(
                  DateFormat.yMMMM(locale).format(_month.toLocalDateTime()),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              IconButton(
                tooltip: l10n.calendarNextMonth,
                icon: const Icon(Icons.chevron_right),
                onPressed: () => setState(
                  () => _month = LocalDate(_month.year, _month.month + 1, 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _MonthGrid(
            month: _month,
            today: today,
            selected: _selected,
            counts: {
              for (final e in byDay.entries) e.key: e.value.length,
            },
            onSelect: (d) => setState(() => _selected = d),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.calendarNote, style: theme.textTheme.bodySmall),
          const SizedBox(height: AppSpacing.lg),
          Semantics(
            header: true,
            child: Text(
              DateFormat.yMMMMEEEEd(
                locale,
              ).format(_selected.toLocalDateTime()),
              style: theme.textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (dayTasks.isEmpty)
            Text(l10n.calendarNoTasks, style: theme.textTheme.bodyMedium)
          else
            for (final t in dayTasks)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  t.isPending ? t.type.icon : Icons.check_circle,
                  color: t.isPending
                      ? t.type.color(context.careColors)
                      : theme.colorScheme.onSurfaceVariant,
                ),
                title: Text(
                  '${t.type.label(l10n)} · ${plantName(t.plantingId)}',
                  style: t.isPending
                      ? null
                      : const TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                ),
              ),
        ],
      ),
    );
  }
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.month,
    required this.today,
    required this.selected,
    required this.counts,
    required this.onSelect,
  });

  final LocalDate month;
  final LocalDate today;
  final LocalDate selected;
  final Map<LocalDate, int> counts;
  final ValueChanged<LocalDate> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final daysInMonth = LocalDate(
      month.year,
      month.month + 1,
      1,
    ).addDays(-1).day;
    // Monday-first grid; leading blanks before the 1st.
    final lead = month.toLocalDateTime().weekday - 1;
    final weekdayNames = [
      for (var i = 0; i < 7; i++)
        DateFormat.E(locale).format(DateTime(2026, 10, 19 + i)),
    ];

    return Column(
      children: [
        Row(
          children: [
            for (final name in weekdayNames)
              Expanded(
                child: ExcludeSemantics(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelSmall,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (var i = 0; i < lead; i++) const SizedBox.shrink(),
            for (var d = 1; d <= daysInMonth; d++)
              _DayCell(
                date: LocalDate(month.year, month.month, d),
                isToday: LocalDate(month.year, month.month, d) == today,
                isSelected: LocalDate(month.year, month.month, d) == selected,
                count: counts[LocalDate(month.year, month.month, d)] ?? 0,
                countLabel: l10n.calendarTasksOn,
                onTap: onSelect,
                colors: colors,
              ),
          ],
        ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.date,
    required this.isToday,
    required this.isSelected,
    required this.count,
    required this.countLabel,
    required this.onTap,
    required this.colors,
  });

  final LocalDate date;
  final bool isToday;
  final bool isSelected;
  final int count;
  final String Function(int) countLabel;
  final ValueChanged<LocalDate> onTap;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final label = DateFormat.MMMMd(
      Localizations.localeOf(context).toLanguageTag(),
    ).format(date.toLocalDateTime());
    return Semantics(
      button: true,
      selected: isSelected,
      label: count == 0 ? label : '$label, ${countLabel(count)}',
      excludeSemantics: true,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => onTap(date),
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? colors.primary : null,
            border: isToday && !isSelected
                ? Border.all(color: colors.primary, width: 2)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${date.day}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isSelected ? colors.onPrimary : null,
                ),
              ),
              if (count > 0)
                Text(
                  '$count',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isSelected ? colors.onPrimary : colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
