import 'dart:io';
import 'dart:ui';

import 'package:drift/native.dart';
import 'package:flutter/material.dart' hide Canvas;
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/app/theme/canvas_colors.dart';
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/core/units/measurement_formatter.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/care/data/drift_care_repository.dart';
import 'package:terrace_garden/features/care/domain/care_planner.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_repository.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';
import 'package:terrace_garden/features/garden_designer/application/layout_editor_controller.dart';
import 'package:terrace_garden/features/garden_designer/domain/canvas_transform.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_repository.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_validator.dart';
import 'package:terrace_garden/features/garden_designer/presentation/garden_canvas_painter.dart';
import 'package:terrace_garden/features/plant_catalog/data/catalogue_parser.dart';
import 'package:terrace_garden/features/plant_catalog/domain/recommendation_engine.dart';
import 'package:terrace_garden/features/plantings/data/drift_planting_repository.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';

/// P6-07. Host-side budgets for the heaviest code paths. Timings are from
/// debug-mode JIT on the development machine, so they only catch gross
/// regressions (e.g. accidental quadratic-in-the-database work); device
/// profiling in profile mode is still needed (known-issues KI-029).
void main() {
  // 100 pots on a 10 m × 10 m roof in a 10 × 10 grid, some overlapping.
  final elements = [
    for (var i = 0; i < 100; i++)
      LayoutElement(
        id: 'e$i',
        kind: i.isEven ? ElementKind.roundPot : ElementKind.growBag,
        center: Vec2(50.0 + (i % 10) * 95, 50.0 + (i ~/ 10) * 95),
        width: i.isEven ? 40 : 60,
        height: 45,
        depthCm: 30,
      ),
  ];
  final doc = LayoutDocument(
    gardenId: 'g',
    length: 1000,
    width: 1000,
    elements: elements,
  );

  /// The median of [runs] timed runs after a warm-up. The median, not the
  /// mean, so a run preempted while the rest of the suite runs in parallel
  /// does not fail the budget.
  Duration time(void Function() body, {int runs = 21}) {
    body(); // warm up
    final samples = <Duration>[
      for (var i = 0; i < runs; i++)
        (() {
          final watch = Stopwatch()..start();
          body();
          return watch.elapsed;
        })(),
    ]..sort();
    return samples[runs ~/ 2];
  }

  test('validating 100 objects stays well under one frame', () {
    final t = time(() => validateLayout(doc));
    printOnFailure('validate 100: ${t.inMicroseconds} µs');
    expect(t, lessThan(const Duration(milliseconds: 16)));
  });

  testWidgets('painting 100 objects stays under the frame budget', (
    tester,
  ) async {
    const size = Size(800, 800);
    final controller = LayoutEditorController(
      initial: doc,
      repository: _NoopLayouts(),
      ids: SequentialIdGenerator(),
    );
    final painter = GardenCanvasPainter(
      controller: controller,
      transform: CanvasTransform.fit(
        gardenLength: doc.length,
        gardenWidth: doc.width,
        viewportWidth: size.width,
        viewportHeight: size.height,
      ),
      colors: CanvasColors.light,
      format: MeasurementFormatter(UnitSystem.metric, locale: 'en'),
      labelStyle: const TextStyle(fontSize: 11),
      unitSystem: UnitSystem.metric,
    );
    final t = time(() {
      final recorder = PictureRecorder();
      painter.paint(Canvas(recorder), size);
      recorder.endRecording().dispose();
    });
    printOnFailure('paint 100: ${t.inMicroseconds} µs');
    expect(t, lessThan(const Duration(milliseconds: 16)));
    controller.dispose();
  });

  test('ranking the whole catalogue against 100 containers is instant', () {
    final catalogue = CatalogueParser.parse(
      plantsJson: File('assets/catalogue/plants.json').readAsStringSync(),
      sourcesJson: File('assets/catalogue/sources.json').readAsStringSync(),
    );
    final garden = Garden(
      id: 'g',
      name: 'Roof',
      spaceType: SpaceType.rooftop,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
      sun: SunExposure.moreThan6Hours,
      region: GrowingRegion.kerala,
    );
    final containers = [
      for (final e in elements)
        ContainerSpace(id: e.id, soilLitres: e.soilLitres!, depthCm: 30),
    ];
    final t = time(
      () => RecommendationEngine.rank(
        garden: garden,
        species: catalogue.species,
        containers: containers,
        month: 7,
      ),
    );
    printOnFailure('rank: ${t.inMicroseconds} µs');
    expect(t, lessThan(const Duration(milliseconds: 16)));
  });

  test('materialising tasks for 50 plantings takes under a second', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final clock = FixedClock(DateTime(2026, 10, 18, 9));
    final today = LocalDate(2026, 10, 18);
    const logger = DeveloperLogger();
    final gardenId = (await DriftGardenRepository(
      db,
      clock,
      SequentialIdGenerator('g'),
      logger,
    ).create(const GardenDraft(name: 'Roof'))).valueOrNull!.id;
    final plantings = DriftPlantingRepository(
      db,
      clock,
      SequentialIdGenerator('p'),
      logger,
    );
    final care = DriftCareRepository(db, SequentialIdGenerator('c'), logger);
    final catalogue = CatalogueParser.parse(
      plantsJson: File('assets/catalogue/plants.json').readAsStringSync(),
      sourcesJson: File('assets/catalogue/sources.json').readAsStringSync(),
    );
    for (var i = 0; i < 50; i++) {
      final species = catalogue.species[i % catalogue.species.length];
      final planting = (await plantings.create(
        PlantingDraft(
          gardenId: gardenId,
          speciesId: species.id,
          plantedOn: today,
        ),
      )).valueOrNull!;
      await care.addRules(
        gardenId: gardenId,
        plantingId: planting.id,
        drafts: CarePlanner.plan(
          planting: planting,
          species: species,
          region: GrowingRegion.tamilNadu,
          today: today,
        ),
        createdOn: today,
      );
    }
    final watch = Stopwatch()..start();
    final created = await care.materialize(today);
    final first = watch.elapsed;
    expect(created, isA<Ok<int>>());
    watch.reset();
    await care.materialize(today);
    final again = watch.elapsed;
    printOnFailure('materialise: first $first, repeat $again');
    expect(first, lessThan(const Duration(seconds: 1)));
    expect(again, lessThan(const Duration(seconds: 1)));
  });
}

class _NoopLayouts implements LayoutRepository {
  @override
  Future<List<LayoutElement>> loadElements(String gardenId) async => [];

  @override
  Stream<List<LayoutElement>> watchElements(String gardenId) =>
      const Stream.empty();

  @override
  Future<Result<void>> saveElements(
    String gardenId,
    List<LayoutElement> elements,
  ) async => const Ok(null);
}
