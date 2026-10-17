import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/canvas_colors.dart';
import 'package:terrace_garden/core/units/measurement_formatter.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/garden_designer/application/layout_editor_controller.dart';
import 'package:terrace_garden/features/garden_designer/domain/canvas_transform.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_validator.dart';
import 'package:terrace_garden/features/garden_designer/presentation/designer_labels.dart';
import 'package:terrace_garden/features/garden_designer/presentation/selection_handles.dart';

/// Draws the garden, grid, objects, problems and selection
/// (design-system.md §12). Repaints whenever the controller notifies.
class GardenCanvasPainter extends CustomPainter {
  GardenCanvasPainter({
    required this.controller,
    required this.transform,
    required this.colors,
    required this.format,
    required this.labelStyle,
    required this.unitSystem,
  }) : super(repaint: controller);

  final LayoutEditorController controller;
  final CanvasTransform transform;
  final CanvasColors colors;
  final MeasurementFormatter format;
  final TextStyle labelStyle;
  final UnitSystem unitSystem;

  Offset _o(Vec2 v) {
    final s = transform.worldToScreen(v);
    return Offset(s.x, s.y);
  }

  double get _scale => transform.pxPerCm;

  /// For points that are already in screen space (e.g. selection handles).
  static Offset _screen(Vec2 v) => Offset(v.x, v.y);

  @override
  void paint(Canvas canvas, Size size) {
    final doc = controller.document;
    canvas.drawRect(Offset.zero & size, Paint()..color = colors.outside);
    final garden = Rect.fromPoints(
      _o(Vec2.zero),
      _o(Vec2(doc.length, doc.width)),
    );
    canvas.drawRect(garden, Paint()..color = colors.garden);
    _paintGrid(canvas, garden);
    canvas.drawRect(
      garden,
      Paint()
        ..color = colors.boundary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    for (final element in doc.elements) {
      _paintElement(canvas, element);
    }
    final selected = controller.selected;
    if (selected != null) _paintSelection(canvas, selected, doc);
  }

  void _paintGrid(Canvas canvas, Rect garden) {
    final (minor, major) = switch (unitSystem) {
      UnitSystem.metric => (10.0, 100.0),
      UnitSystem.imperial => (cmPerInch * 6, cmPerInch * 12),
    };
    canvas
      ..save()
      ..clipRect(garden);
    for (final (step, color) in [
      (minor, colors.gridMinor),
      (major, colors.gridMajor),
    ]) {
      // Hide lines that would be closer than 8 px.
      if (step * _scale < 8) continue;
      final paint = Paint()
        ..color = color
        ..strokeWidth = 1;
      final doc = controller.document;
      for (var x = step; x < doc.length; x += step) {
        canvas.drawLine(_o(Vec2(x, 0)), _o(Vec2(x, doc.width)), paint);
      }
      for (var y = step; y < doc.width; y += step) {
        canvas.drawLine(_o(Vec2(0, y)), _o(Vec2(doc.length, y)), paint);
      }
    }
    canvas.restore();
  }

  (Color fill, Color stroke) _styleFor(ElementKind kind) => switch (kind.role) {
    ElementRole.container =>
      kind == ElementKind.raisedBed
          ? (colors.bedFill, colors.bedStroke)
          : (colors.containerFill, colors.containerStroke),
    ElementRole.structure => (colors.structure, colors.structure),
    ElementRole.walkway => (colors.pathFill, colors.pathStroke),
    ElementRole.marker => (
      colors.marker.withValues(alpha: 0.25),
      colors.marker,
    ),
  };

  void _drawShape(Canvas canvas, LayoutElement e, Paint paint) {
    final shape = e.shape;
    switch (shape) {
      case CircleShape():
        canvas.drawCircle(_o(shape.center), shape.radius * _scale, paint);
      case RectShape():
        canvas
          ..save()
          ..translate(_o(shape.center).dx, _o(shape.center).dy)
          ..rotate(shape.rotationDeg * math.pi / 180)
          ..drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromCenter(
                center: Offset.zero,
                width: shape.width * _scale,
                height: shape.height * _scale,
              ),
              Radius.circular(
                e.kind.role == ElementRole.container ? 3 : 0,
              ),
            ),
            paint,
          )
          ..restore();
    }
  }

  void _paintElement(Canvas canvas, LayoutElement e) {
    final (fill, stroke) = _styleFor(e.kind);
    _drawShape(canvas, e, Paint()..color = fill);
    _drawShape(
      canvas,
      e,
      Paint()
        ..color = stroke
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    final issues = controller.issuesFor(e.id);
    final hasError = issues.any((i) => i.severity == IssueSeverity.error);
    if (issues.isNotEmpty) {
      final color = hasError ? colors.error : colors.warning;
      _drawShape(
        canvas,
        e,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3,
      );
      final b = e.shape.bounds;
      _badge(canvas, _o(Vec2(b.right, b.top)), color);
    }

    // Icon in the middle when the object is big enough on screen.
    final b = e.shape.bounds;
    final minSidePx = math.min(b.width, b.height) * _scale;
    if (minSidePx >= 28) {
      final icon = e.kind.icon;
      _text(
        canvas,
        String.fromCharCode(icon.codePoint),
        _o(e.center),
        TextStyle(
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          fontSize: math.min(24, minSidePx * 0.45),
          color: stroke,
        ),
      );
    }
    if (e.label != null && minSidePx >= 56) {
      _pill(
        canvas,
        e.label!,
        _o(e.center) + Offset(0, math.min(24, minSidePx * 0.45) * 0.9),
      );
    }
  }

  void _paintSelection(Canvas canvas, LayoutElement e, LayoutDocument doc) {
    _drawShape(
      canvas,
      e,
      Paint()
        ..color = colors.selection
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );
    final handles = SelectionHandles.of(e, transform);
    final handleFill = Paint()..color = colors.garden;
    final handleStroke = Paint()
      ..color = colors.selection
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (final h in handles.resize) {
      canvas
        ..drawCircle(_screen(h), SelectionHandles.visualRadiusPx, handleFill)
        ..drawCircle(_screen(h), SelectionHandles.visualRadiusPx, handleStroke);
    }
    final rotate = handles.rotate;
    if (rotate != null) {
      final rect = e.shape as RectShape;
      final topMid = _o(
        Vec2(0, -rect.height / 2).rotate(rect.rotationDeg) + rect.center,
      );
      canvas
        ..drawLine(topMid, _screen(rotate), handleStroke)
        ..drawCircle(
          _screen(rotate),
          SelectionHandles.visualRadiusPx + 1,
          handleFill,
        )
        ..drawCircle(
          _screen(rotate),
          SelectionHandles.visualRadiusPx + 1,
          handleStroke,
        );
    }

    // Size label below the object and distances to the nearest edges.
    final b = e.shape.bounds;
    final w = format.length(Length.cm(e.width));
    final h = format.length(Length.cm(e.height));
    final sizeText = e.kind.round ? 'Ø $w' : '$w × $h';
    _pill(
      canvas,
      sizeText,
      _o(Vec2(e.center.x, b.bottom)) + const Offset(0, 16),
    );

    final d = distancesToEdges(e.shape, doc.length, doc.width);
    final guide = Paint()
      ..color = colors.selection.withValues(alpha: 0.7)
      ..strokeWidth = 1;
    final cy = e.center.y;
    final cx = e.center.x;
    if (d.left <= d.right && d.left > 0.5) {
      _guide(canvas, Vec2(0, cy), Vec2(b.left, cy), d.left, guide);
    } else if (d.right > 0.5) {
      _guide(canvas, Vec2(b.right, cy), Vec2(doc.length, cy), d.right, guide);
    }
    if (d.top <= d.bottom && d.top > 0.5) {
      _guide(canvas, Vec2(cx, 0), Vec2(cx, b.top), d.top, guide);
    } else if (d.bottom > 0.5) {
      _guide(canvas, Vec2(cx, b.bottom), Vec2(cx, doc.width), d.bottom, guide);
    }
  }

  void _guide(Canvas canvas, Vec2 from, Vec2 to, double cm, Paint paint) {
    canvas.drawLine(_o(from), _o(to), paint);
    if ((to - from).length * _scale > 36) {
      _pill(canvas, format.length(Length.cm(cm)), _o((from + to) * 0.5));
    }
  }

  void _badge(Canvas canvas, Offset at, Color color) {
    canvas.drawCircle(at, 9, Paint()..color = color);
    _text(
      canvas,
      '!',
      at,
      labelStyle.copyWith(color: colors.garden, fontWeight: FontWeight.w700),
    );
  }

  void _pill(Canvas canvas, String text, Offset center) {
    final painter = _layout(text, labelStyle.copyWith(color: colors.labelText));
    final rect = Rect.fromCenter(
      center: center,
      width: painter.width + 12,
      height: painter.height + 4,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(999)),
      Paint()..color = colors.labelBackground,
    );
    painter.paint(
      canvas,
      center - Offset(painter.width / 2, painter.height / 2),
    );
  }

  void _text(Canvas canvas, String text, Offset center, TextStyle style) {
    final painter = _layout(text, style);
    painter.paint(
      canvas,
      center - Offset(painter.width / 2, painter.height / 2),
    );
  }

  TextPainter _layout(String text, TextStyle style) => TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
  )..layout();

  @override
  bool shouldRepaint(GardenCanvasPainter oldDelegate) =>
      oldDelegate.transform != transform ||
      oldDelegate.colors != colors ||
      oldDelegate.unitSystem != unitSystem ||
      oldDelegate.controller != controller;
}
