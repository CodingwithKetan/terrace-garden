import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/canvas_colors.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/units/measurement_formatter.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/garden_designer/application/layout_editor_controller.dart';
import 'package:terrace_garden/features/garden_designer/domain/canvas_transform.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_repository.dart';
import 'package:terrace_garden/features/garden_designer/presentation/garden_canvas_painter.dart';
import 'package:terrace_garden/features/plant_catalog/plant_catalog.dart';

class _NoopRepository implements LayoutRepository {
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

/// Locks down the canvas drawing: grid, object styles, problem highlighting,
/// selection handles on the corners of a rotated object, the rotate handle
/// above it, and the size and distance labels.
void main() {
  const size = Size(400, 320);
  const doc = LayoutDocument(
    gardenId: 'g',
    length: 400,
    width: 300,
    elements: [
      LayoutElement(
        id: 'rail',
        kind: ElementKind.railing,
        center: Vec2(200, 297.5),
        width: 400,
        height: 5,
      ),
      LayoutElement(
        id: 'path',
        kind: ElementKind.path,
        center: Vec2(200, 250),
        width: 400,
        height: 60,
      ),
      LayoutElement(
        id: 'bed',
        kind: ElementKind.raisedBed,
        center: Vec2(200, 110),
        width: 120,
        height: 60,
        rotationDeg: 30,
        depthCm: 30,
      ),
      LayoutElement(
        id: 'pot1',
        kind: ElementKind.roundPot,
        center: Vec2(60, 60),
        width: 40,
        height: 40,
      ),
      LayoutElement(
        id: 'pot2',
        kind: ElementKind.roundPot,
        center: Vec2(85, 60),
        width: 40,
        height: 40,
      ),
      LayoutElement(
        id: 'tap',
        kind: ElementKind.waterPoint,
        center: Vec2(370, 30),
        width: 15,
        height: 15,
      ),
    ],
  );

  // Every newer kind on a 4 m × 3 m terrace, with plants in the containers.
  const terrace = LayoutDocument(
    gardenId: 'g',
    length: 400,
    width: 300,
    elements: [
      LayoutElement(
        id: 'stairs',
        kind: ElementKind.stairs,
        center: Vec2(340, 120),
        width: 120,
        height: 240,
      ),
      LayoutElement(
        id: 'door',
        kind: ElementKind.door,
        center: Vec2(235, 45),
        width: 90,
        height: 90,
      ),
      LayoutElement(
        id: 'tank',
        kind: ElementKind.waterTank,
        center: Vec2(60, 60),
        width: 110,
        height: 110,
      ),
      LayoutElement(
        id: 'trellis',
        kind: ElementKind.trellis,
        center: Vec2(180, 297),
        width: 160,
        height: 6,
      ),
      LayoutElement(
        id: 'bench',
        kind: ElementKind.seating,
        center: Vec2(330, 270),
        width: 100,
        height: 45,
      ),
      LayoutElement(
        id: 'drain',
        kind: ElementKind.drain,
        center: Vec2(20, 280),
        width: 15,
        height: 15,
      ),
      LayoutElement(
        id: 'bag1',
        kind: ElementKind.roundGrowBag,
        center: Vec2(60, 200),
        width: 38,
        height: 38,
        depthCm: 38,
      ),
      LayoutElement(
        id: 'bag2',
        kind: ElementKind.roundGrowBag,
        center: Vec2(110, 200),
        width: 38,
        height: 38,
        depthCm: 38,
      ),
      LayoutElement(
        id: 'long',
        kind: ElementKind.growBag,
        center: Vec2(200, 260),
        width: 120,
        height: 45,
        depthCm: 30,
      ),
      LayoutElement(
        id: 'hang',
        kind: ElementKind.hangingPot,
        center: Vec2(200, 160),
        width: 25,
        height: 25,
        depthCm: 15,
      ),
    ],
  );
  const plants = {
    'bag1': [PlantArtSpec(PlantForm.fruiting, accent: Color(0xFFD7402B))],
    'bag2': [PlantArtSpec(PlantForm.cluster)],
    'long': [
      PlantArtSpec(PlantForm.rosette),
      PlantArtSpec(PlantForm.rosette),
      PlantArtSpec(PlantForm.rosette),
    ],
    'hang': [PlantArtSpec(PlantForm.trailing)],
  };

  Widget canvas(
    CanvasColors colors, {
    LayoutDocument document = doc,
    String select = 'bed',
    CanvasStyle style = CanvasStyle.blueprint,
    bool dusk = false,
  }) {
    final controller = LayoutEditorController(
      initial: document,
      repository: _NoopRepository(),
      ids: SequentialIdGenerator(),
    )..select(select);
    return SizedBox.fromSize(
      size: size,
      child: CustomPaint(
        painter: GardenCanvasPainter(
          controller: controller,
          transform: CanvasTransform.fit(
            gardenLength: document.length,
            gardenWidth: document.width,
            viewportWidth: size.width,
            viewportHeight: size.height,
          ),
          colors: colors,
          format: MeasurementFormatter(UnitSystem.metric, locale: 'en'),
          labelStyle: const TextStyle(fontSize: 11),
          unitSystem: UnitSystem.metric,
          style: style,
          plants: plants,
          dusk: dusk,
        ),
      ),
    );
  }

  unawaited(
    goldenTest(
      'designer canvas',
      fileName: 'designer_canvas',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'light, rotated bed selected, overlapping pots',
            child: canvas(CanvasColors.light),
          ),
          GoldenTestScenario(
            name: 'dark',
            child: canvas(CanvasColors.dark),
          ),
        ],
      ),
    ),
  );

  unawaited(
    goldenTest(
      'designer canvas, garden style',
      fileName: 'designer_canvas_garden',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'every newer kind, plants, a hanging pot selected',
            child: canvas(
              CanvasColors.light,
              document: terrace,
              select: 'hang',
              style: CanvasStyle.garden,
            ),
          ),
          GoldenTestScenario(
            name: 'dusk',
            child: canvas(
              CanvasColors.dark,
              document: terrace,
              select: 'long',
              style: CanvasStyle.garden,
              dusk: true,
            ),
          ),
          GoldenTestScenario(
            name: 'overlapping pots in garden style',
            child: canvas(CanvasColors.light, style: CanvasStyle.garden),
          ),
        ],
      ),
    ),
  );
}
