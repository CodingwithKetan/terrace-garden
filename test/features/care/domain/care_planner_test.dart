import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/care/domain/care_planner.dart';
import 'package:terrace_garden/features/care/domain/recurrence.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';
import 'package:terrace_garden/features/plant_catalog/data/catalogue_parser.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';

void main() {
  final catalogue = CatalogueParser.parse(
    plantsJson: File('assets/catalogue/plants.json').readAsStringSync(),
    sourcesJson: File('assets/catalogue/sources.json').readAsStringSync(),
  );
  final today = LocalDate(2026, 10, 18);

  Planting planting(
    String speciesId, {
    PlantingStart from = PlantingStart.seed,
    LocalDate? plantedOn,
  }) => Planting(
    id: 'p',
    gardenId: 'g',
    speciesId: speciesId,
    quantity: 1,
    plantedOn: plantedOn ?? today,
    startedFrom: from,
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
  );

  Map<CareTaskType, Recurrence> plan(
    String speciesId, {
    PlantingStart from = PlantingStart.seed,
    LocalDate? plantedOn,
    GrowingRegion? region = GrowingRegion.northIndia,
  }) => {
    for (final r in CarePlanner.plan(
      planting: planting(speciesId, from: from, plantedOn: plantedOn),
      species: catalogue.byId(speciesId)!,
      region: region,
      today: today,
    ))
      r.type: r.recurrence,
  };

  test('tomato from seed: soil, pests, feed, transplant, harvest', () {
    final p = plan('tomato');
    expect(p.keys, {
      CareTaskType.checkSoil,
      CareTaskType.inspectPests,
      CareTaskType.feed,
      CareTaskType.transplant,
      CareTaskType.harvest,
    });
    expect(p[CareTaskType.checkSoil], FromCompletion(days: 1, start: today));
    expect(p[CareTaskType.inspectPests], FromCompletion(days: 3, start: today));
    expect(
      p[CareTaskType.feed],
      FromCompletion(days: 28, start: today.addDays(28)),
    );
    // Nursery 25–30 days (S11): transplant from day 25.
    expect(p[CareTaskType.transplant], Once(today.addDays(25)));
    // 90–130 days to harvest (S1): harvest may start at day 90.
    expect(p[CareTaskType.harvest], Once(today.addDays(90)));
  });

  test('a seedling needs no transplant task', () {
    expect(
      plan('tomato', from: PlantingStart.seedling).keys,
      isNot(contains(CareTaskType.transplant)),
    );
  });

  test('direct-sown okra has no transplant task', () {
    expect(plan('okra').keys, isNot(contains(CareTaskType.transplant)));
  });

  test('ornamentals get no feed or harvest task', () {
    final p = plan('snakePlant');
    expect(p.keys, {CareTaskType.checkSoil, CareTaskType.inspectPests});
  });

  test('species without documented harvest days get no harvest task', () {
    expect(plan('mint').keys, isNot(contains(CareTaskType.harvest)));
  });

  test('jasmine pruning only in Tamil Nadu (S18)', () {
    expect(
      plan('jasmine', region: GrowingRegion.tamilNadu)[CareTaskType.prune],
      Yearly(month: 11, day: 24, start: today),
    );
    expect(plan('jasmine').keys, isNot(contains(CareTaskType.prune)));
  });

  test('a back-dated planting starts checks today, feed not before today', () {
    final p = plan('tomato', plantedOn: today.addDays(-60));
    expect(p[CareTaskType.checkSoil], FromCompletion(days: 1, start: today));
    expect(p[CareTaskType.feed], FromCompletion(days: 28, start: today));
  });

  test('every task type cites sources (harvest uses the species)', () {
    for (final type in CareTaskType.values) {
      expect(CarePlanner.sourcesFor.containsKey(type), isTrue);
    }
    expect(catalogue.byId('tomato')!.daysToHarvest!.sources, isNotEmpty);
  });

  group('TaskMaterializer', () {
    CareTask task(
      LocalDate due, {
      TaskStatus status = TaskStatus.pending,
      LocalDate? finishedOn,
    }) => CareTask(
      id: 't-$due',
      ruleId: 'r',
      gardenId: 'g',
      plantingId: 'p',
      type: CareTaskType.feed,
      dueOn: due,
      status: status,
      completedOn: finishedOn,
    );

    CareRule rule(Recurrence r, {bool enabled = true, LocalDate? createdOn}) =>
        CareRule(
          id: 'r',
          gardenId: 'g',
          plantingId: 'p',
          type: CareTaskType.feed,
          recurrence: r,
          createdOn: createdOn ?? today,
          enabled: enabled,
        );

    test('completion-based rules get one task, then none while pending', () {
      final r = rule(FromCompletion(days: 1, start: today));
      expect(
        TaskMaterializer.datesToCreate(
          rule: r,
          existing: const [],
          today: today,
        ),
        [today],
      );
      expect(
        TaskMaterializer.datesToCreate(
          rule: r,
          existing: [task(today)],
          today: today.addDays(5),
        ),
        isEmpty,
      );
    });

    test('with nothing pending, counts from the last finished task', () {
      final r = rule(FromCompletion(days: 7, start: today));
      final done = task(
        today,
        status: TaskStatus.done,
        finishedOn: today.addDays(1),
      );
      expect(
        TaskMaterializer.datesToCreate(
          rule: r,
          existing: [done],
          today: today.addDays(2),
        ),
        [today.addDays(8)],
      );
      // Long after the last one: due today, never in the past.
      expect(
        TaskMaterializer.datesToCreate(
          rule: r,
          existing: [done],
          today: today.addDays(30),
        ),
        [today.addDays(30)],
      );
    });

    test('fixed rules fill the 30-day horizon without duplicates', () {
      final r = rule(FixedInterval(days: 7, anchor: today));
      final first = TaskMaterializer.datesToCreate(
        rule: r,
        existing: const [],
        today: today,
      );
      expect(first, [
        today,
        today.addDays(7),
        today.addDays(14),
        today.addDays(21),
        today.addDays(28),
      ]);
      final again = TaskMaterializer.datesToCreate(
        rule: r,
        existing: [for (final d in first) task(d)],
        today: today.addDays(3),
      );
      expect(again, isEmpty);
    });

    test('never creates tasks before the rule existed', () {
      final r = rule(
        FixedInterval(days: 1, anchor: today.addDays(-10)),
        createdOn: today,
      );
      final dates = TaskMaterializer.datesToCreate(
        rule: r,
        existing: const [],
        today: today,
      );
      expect(dates.first, today);
    });

    test('disabled rules and past one-offs create nothing', () {
      expect(
        TaskMaterializer.datesToCreate(
          rule: rule(Once(today), enabled: false),
          existing: const [],
          today: today,
        ),
        isEmpty,
      );
      expect(
        TaskMaterializer.datesToCreate(
          rule: rule(Once(today.addDays(-1))),
          existing: const [],
          today: today,
        ),
        isEmpty,
      );
    });

    test('one-offs beyond the horizon wait until they are in range', () {
      final r = rule(Once(today.addDays(90)));
      expect(
        TaskMaterializer.datesToCreate(
          rule: r,
          existing: const [],
          today: today,
        ),
        isEmpty,
      );
      expect(
        TaskMaterializer.datesToCreate(
          rule: r,
          existing: const [],
          today: today.addDays(70),
        ),
        [today.addDays(90)],
      );
    });
  });

  test('catalogue watering modes parse for succulents and moist-lovers', () {
    expect(catalogue.byId('aloeVera')!.watering!.mode, WateringMode.dryBetween);
    expect(
      catalogue.byId('lemongrass')!.watering!.mode,
      WateringMode.keepMoist,
    );
    expect(catalogue.byId('tomato')!.watering, isNull);
  });
}
