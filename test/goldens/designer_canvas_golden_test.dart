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

  Widget canvas(CanvasColors colors) {
    final controller = LayoutEditorController(
      initial: doc,
      repository: _NoopRepository(),
      ids: SequentialIdGenerator(),
    )..select('bed');
    return SizedBox.fromSize(
      size: size,
      child: CustomPaint(
        painter: GardenCanvasPainter(
          controller: controller,
          transform: CanvasTransform.fit(
            gardenLength: doc.length,
            gardenWidth: doc.width,
            viewportWidth: size.width,
            viewportHeight: size.height,
          ),
          colors: colors,
          format: MeasurementFormatter(UnitSystem.metric, locale: 'en'),
          labelStyle: const TextStyle(fontSize: 11),
          unitSystem: UnitSystem.metric,
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
}
