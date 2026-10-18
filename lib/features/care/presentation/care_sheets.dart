import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/app/theme/care_colors.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/core/widgets/dialogs.dart';
import 'package:terrace_garden/features/care/data/care_providers.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/care/domain/care_planner.dart';
import 'package:terrace_garden/features/care/domain/recurrence.dart';
import 'package:terrace_garden/features/care/presentation/care_labels.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// Source IDs behind a task's guide, using species data where it applies.
List<String> guideSources(CareTaskType type, PlantSpecies? species) =>
    switch (type) {
      CareTaskType.checkSoil when species?.watering != null =>
        species!.watering!.sources,
      CareTaskType.harvest => species?.daysToHarvest?.sources ?? const [],
      CareTaskType.transplant => [
        ...?species?.propagation?.sources,
        'S1',
      ],
      _ => CarePlanner.sourcesFor[type] ?? const [],
    };

/// How to do a task, with its sources (CARE-03).
Future<void> showTaskGuide(
  BuildContext context, {
  required CareTaskType type,
  required PlantSpecies? species,
  required Map<String, SourceRef> sources,
}) {
  final l10n = context.l10n;
  final publishers = {
    for (final id in guideSources(type, species))
      if (sources[id] case final ref?) ref.publisher,
  };
  return showAppBottomSheet<void>(
    context,
    title: species == null
        ? type.label(l10n)
        : '${type.label(l10n)} · ${species.commonName}',
    builder: (context) {
      final theme = Theme.of(context);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type.guide(l10n, species: species),
            style: theme.textTheme.bodyLarge,
          ),
          if (publishers.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.guideSources(publishers.join(' · ')),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      );
    },
  );
}

Future<SkipReason?> showSkipReasonSheet(BuildContext context) {
  final l10n = context.l10n;
  return showAppBottomSheet<SkipReason>(
    context,
    title: l10n.skipReasonTitle,
    builder: (context) => Column(
      children: [
        for (final reason in SkipReason.values)
          ListTile(
            leading: Icon(reason.icon),
            title: Text(reason.label(l10n)),
            onTap: () => Navigator.of(context).pop(reason),
          ),
      ],
    ),
  );
}

/// CARE-04. A planting's care rules: switch each on or off and adjust the
/// interval of repeating checks.
Future<void> showCarePlanSheet(
  BuildContext context, {
  required String plantingId,
  required String plantName,
}) => showAppBottomSheet<void>(
  context,
  title: context.l10n.carePlanTitle(plantName),
  builder: (context) => _CarePlan(plantingId: plantingId),
);

class _CarePlan extends ConsumerWidget {
  const _CarePlan({required this.plantingId});

  final String plantingId;

  static const _maxDays = 60;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final rules = ref.watch(plantingRulesProvider(plantingId)).value;
    final today = LocalDate.fromDateTime(ref.watch(clockProvider).now());
    final locale = Localizations.localeOf(context).toLanguageTag();
    String date(LocalDate d) =>
        DateFormat.yMMMd(locale).format(d.toLocalDateTime());

    void save(CareRule rule) => unawaited(
      ref.read(careRepositoryProvider).updateRule(rule, today: today),
    );

    if (rules == null) return const Center(child: CircularProgressIndicator());
    if (rules.isEmpty) {
      return Text(l10n.carePlanEmpty, style: theme.textTheme.bodyLarge);
    }
    final sorted = [...rules]
      ..sort((a, b) => a.type.index.compareTo(b.type.index));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.carePlanNote, style: theme.textTheme.bodyMedium),
        const SizedBox(height: AppSpacing.sm),
        for (final rule in sorted)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              children: [
                Icon(
                  rule.type.icon,
                  color: rule.type.color(context.careColors),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rule.type.label(l10n),
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        switch (rule.recurrence) {
                          FromCompletion(:final days) => l10n.carePlanAfterDone(
                            days,
                          ),
                          FixedInterval(:final days) => l10n.carePlanEvery(
                            days,
                          ),
                          Weekly() => l10n.carePlanWeekly,
                          Yearly(:final month, :final day) =>
                            l10n.carePlanYearly(
                              DateFormat.MMMMd(
                                locale,
                              ).format(DateTime(2026, month, day)),
                            ),
                          Once(date: final d) => l10n.carePlanOnce(date(d)),
                        },
                        style: theme.textTheme.bodySmall,
                      ),
                      if (rule.recurrence case final FromCompletion r
                          when rule.enabled)
                        Row(
                          children: [
                            IconButton(
                              tooltip: l10n.intervalShorter,
                              icon: const Icon(Icons.remove),
                              onPressed: r.days > 1
                                  ? () => save(
                                      rule.copyWith(
                                        recurrence: FromCompletion(
                                          days: r.days - 1,
                                          start: r.start,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            IconButton(
                              tooltip: l10n.intervalLonger,
                              icon: const Icon(Icons.add),
                              onPressed: r.days < _maxDays
                                  ? () => save(
                                      rule.copyWith(
                                        recurrence: FromCompletion(
                                          days: r.days + 1,
                                          start: r.start,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                Switch(
                  value: rule.enabled,
                  onChanged: (v) => save(rule.copyWith(enabled: v)),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
