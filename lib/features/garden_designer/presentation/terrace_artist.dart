import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/plant_catalog/plant_catalog.dart';

/// Draws the terrace in the Living Terrace style (design-system.md §12):
/// tiled floor, parapet, and each object seen from above with its plants.
/// Shared by the read-only `TerracePlan` and the editing canvas, so what the
/// user edits is what they see everywhere else.
///
/// Coordinates: the caller translates the canvas so the garden's top-left
/// corner is at the origin; `k` is pixels per centimetre. Strokes and sizes
/// are in pixels, so the drawing stays crisp at any zoom.
abstract final class TerraceArtist {
  static const floor = Color(0xFFE4DFD3);
  static const tileLine = Color(0xFFD3CDBF);
  static const parapet = Color(0xFFCFC8B8);
  static const terracotta = Color(0xFFC2592B);
  static const terracottaDark = Color(0xFFA9461F);
  static const soil = Color(0xFF5A3E2B);
  static const bag = Color(0xFF2F3A35);
  static const water = Color(0xFF2E6FB0);
  static const leaf = Color(0xFF2B6530);
  static const ink = Color(0xFF17301F);
  static const _concrete = Color(0xFFBDB4A2);
  static const _concreteLine = Color(0xFF9E947F);
  static const _wood = Color(0xFFA0784F);
  static const _woodDark = Color(0xFF7D5B39);
  static const _tank = Color(0xFF2B2F2E);
  static const _steel = Color(0xFF8C8472);

  /// The floor with a tile line every 50 cm.
  static void paintFloor(
    Canvas canvas,
    double lengthCm,
    double widthCm,
    double k,
  ) {
    final size = Size(lengthCm * k, widthCm * k);
    canvas.drawRect(Offset.zero & size, Paint()..color = floor);
    final tile = Paint()
      ..color = tileLine
      ..strokeWidth = 1;
    for (var x = 50.0; x < lengthCm; x += 50) {
      canvas.drawLine(Offset(x * k, 0), Offset(x * k, size.height), tile);
    }
    for (var y = 50.0; y < widthCm; y += 50) {
      canvas.drawLine(Offset(0, y * k), Offset(size.width, y * k), tile);
    }
  }

  /// Draws [e] with its [plants] (top views, in planting order).
  static void paintElement(
    Canvas canvas,
    LayoutElement e,
    double k, {
    List<PlantArtSpec> plants = const [],
  }) {
    final c = Offset(e.center.x * k, e.center.y * k);
    final w = e.width * k;
    final h = e.height * k;
    canvas
      ..save()
      ..translate(c.dx, c.dy);
    if (!e.kind.round) canvas.rotate(e.rotationDeg * math.pi / 180);
    final body = Rect.fromCenter(center: Offset.zero, width: w, height: h);
    final shadow = Paint()
      ..color = const Color(0x472B2418)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    switch (e.kind) {
      case ElementKind.roundPot:
        final r = w / 2;
        canvas
          ..drawCircle(Offset(r * .12, r * .16), r, shadow)
          ..drawCircle(
            Offset.zero,
            r,
            Paint()
              ..shader = const RadialGradient(
                center: Alignment(-.2, -.3),
                colors: [Color(0xFFD8774A), terracottaDark],
              ).createShader(Rect.fromCircle(center: Offset.zero, radius: r)),
          )
          ..drawCircle(Offset.zero, r * .82, Paint()..color = soil);
        _plants(canvas, plants, Size.square(r * 1.64));
      case ElementKind.roundGrowBag:
        final r = w / 2;
        canvas
          ..drawCircle(Offset(r * .1, r * .14), r, shadow)
          ..drawCircle(Offset.zero, r, Paint()..color = bag)
          ..drawCircle(Offset.zero, r * .86, Paint()..color = soil);
        // Fabric folds on the rim.
        final fold = Paint()
          ..color = const Color(0x33FFFFFF)
          ..strokeWidth = math.max(1, r * .04);
        for (var i = 0; i < 8; i++) {
          final a = i * math.pi / 4 + .3;
          canvas.drawLine(
            Offset(math.cos(a), math.sin(a)) * (r * .88),
            Offset(math.cos(a), math.sin(a)) * (r * .98),
            fold,
          );
        }
        _plants(canvas, plants, Size.square(r * 1.72));
      case ElementKind.hangingPot:
        final r = w / 2;
        canvas
          ..drawCircle(
            Offset(r * .25, r * .35),
            r * .9,
            Paint()
              ..color = const Color(0x292B2418)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
          )
          ..drawCircle(Offset.zero, r, Paint()..color = const Color(0xFFD46A3A))
          ..drawCircle(Offset.zero, r * .8, Paint()..color = soil);
        _plants(canvas, plants, Size.square(r * 1.6));
        // The hanger's three cords meeting at the hook.
        final cord = Paint()
          ..color = const Color(0xCC3B3326)
          ..strokeWidth = math.max(1, r * .05);
        for (var i = 0; i < 3; i++) {
          final a = -math.pi / 2 + i * 2 * math.pi / 3;
          canvas.drawLine(
            Offset.zero,
            Offset(math.cos(a), math.sin(a)) * r * .92,
            cord,
          );
        }
        canvas.drawCircle(
          Offset.zero,
          math.max(2, r * .1),
          Paint()..color = const Color(0xFF3B3326),
        );
      case ElementKind.rectPlanter || ElementKind.raisedBed:
        final rr = RRect.fromRectAndRadius(body, Radius.circular(h * .14));
        final rim = math.min(w, h) * .12;
        canvas
          ..drawRRect(rr.shift(Offset(w * .03, h * .08)), shadow)
          ..drawRRect(rr, Paint()..color = terracotta)
          ..drawRRect(
            RRect.fromRectAndRadius(
              body.deflate(rim),
              Radius.circular(h * .08),
            ),
            Paint()..color = soil,
          );
        _plants(canvas, plants, body.deflate(rim).size);
      case ElementKind.growBag:
        final rr = RRect.fromRectAndRadius(body, Radius.circular(h * .18));
        final rim = math.min(w, h) * .09;
        canvas
          ..drawRRect(rr.shift(Offset(w * .04, h * .08)), shadow)
          ..drawRRect(rr, Paint()..color = bag)
          ..drawRRect(
            RRect.fromRectAndRadius(
              body.deflate(rim),
              Radius.circular(h * .12),
            ),
            Paint()..color = soil,
          );
        _plants(canvas, plants, body.deflate(rim).size);
      case ElementKind.verticalPlanter:
        canvas.drawRRect(
          RRect.fromRectAndRadius(body, const Radius.circular(4)),
          Paint()..color = const Color(0xFF4A5A4E),
        );
        for (var i = -1; i <= 1; i++) {
          canvas.drawCircle(
            Offset(i * w / 3.2, 0),
            math.min(w / 8, h / 3),
            Paint()..color = soil,
          );
        }
        _plants(canvas, plants, Size(w * .8, h * .8));
      case ElementKind.wall || ElementKind.railing:
        canvas.drawRect(
          body,
          Paint()
            ..color = e.kind == ElementKind.wall
                ? const Color(0xFFB8AE99)
                : _steel,
        );
      case ElementKind.trellis:
        canvas.drawRect(body, Paint()..color = _wood);
        final slat = Paint()
          ..color = _woodDark
          ..strokeWidth = math.max(1, math.min(w, h) * .25);
        final step = math.max(6, math.min(w, h) * 1.6).toDouble();
        final long = w >= h;
        final length = long ? w : h;
        for (var d = step / 2; d < length; d += step) {
          final t = -length / 2 + d;
          canvas.drawLine(
            long ? Offset(t, body.top) : Offset(body.left, t),
            long ? Offset(t, body.bottom) : Offset(body.right, t),
            slat,
          );
        }
      case ElementKind.waterTank:
        final r = w / 2;
        canvas
          ..drawCircle(Offset(r * .06, r * .08), r, shadow)
          ..drawCircle(Offset.zero, r, Paint()..color = _tank);
        final ridge = Paint()
          ..color = const Color(0x24FFFFFF)
          ..style = PaintingStyle.stroke
          ..strokeWidth = math.max(1, r * .03);
        for (final f in [.85, .7]) {
          canvas.drawCircle(Offset.zero, r * f, ridge);
        }
        canvas
          ..drawCircle(
            Offset.zero,
            r * .32,
            Paint()..color = const Color(0xFF3A403E),
          )
          ..drawCircle(
            Offset.zero,
            r * .32,
            ridge..color = const Color(0x40FFFFFF),
          );
      case ElementKind.stairs:
        canvas
          ..drawRect(body.shift(Offset(w * .02, h * .02)), shadow)
          ..drawRect(body, Paint()..color = _concrete);
        final step = Paint()
          ..color = _concreteLine
          ..strokeWidth = 1;
        final long = h >= w;
        final across = long ? h : w;
        // Treads about every 25 cm, as steps run across the long side.
        final gap = math.max(5, 25 * k).toDouble();
        for (var d = gap; d < across; d += gap) {
          final t = -across / 2 + d;
          canvas.drawLine(
            long ? Offset(body.left, t) : Offset(t, body.top),
            long ? Offset(body.right, t) : Offset(t, body.bottom),
            step,
          );
        }
        canvas.drawRect(
          body,
          Paint()
            ..color = _concreteLine
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        );
      case ElementKind.seating:
        final rr = RRect.fromRectAndRadius(
          body,
          Radius.circular(math.min(w, h) * .12),
        );
        canvas
          ..drawRRect(rr.shift(Offset(w * .02, h * .1)), shadow)
          ..drawRRect(rr, Paint()..color = _wood);
        final plank = Paint()
          ..color = _woodDark
          ..strokeWidth = 1;
        final long = w >= h;
        final across = long ? h : w;
        for (var i = 1; i < 4; i++) {
          final t = -across / 2 + across * i / 4;
          canvas.drawLine(
            long ? Offset(body.left + 2, t) : Offset(t, body.top + 2),
            long ? Offset(body.right - 2, t) : Offset(t, body.bottom - 2),
            plank,
          );
        }
      case ElementKind.path:
        canvas
          ..save()
          ..clipRect(body)
          ..drawRect(body, Paint()..color = const Color(0xFFDCD5C5));
        final hatch = Paint()
          ..color = const Color(0x2E17301F)
          ..strokeWidth = 2;
        for (var x = -h; x < w + h; x += 9) {
          canvas.drawLine(
            Offset(body.left + x, body.bottom),
            Offset(body.left + x + h, body.top),
            hatch,
          );
        }
        canvas.restore();
      case ElementKind.door:
        // The architect's symbol: the frame on one edge, the open leaf and
        // the arc it sweeps.
        final r = math.min(w, h);
        final hinge = body.topLeft;
        canvas
          ..drawRect(body, Paint()..color = const Color(0x1417301F))
          ..drawLine(
            hinge,
            hinge + Offset(r, 0),
            Paint()
              ..color = const Color(0xFF6E6555)
              ..strokeWidth = math.max(3, 6 * k),
          );
        final swing = Paint()
          ..color = const Color(0x9917301F)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2;
        final arc = Path()
          ..addArc(
            Rect.fromCircle(center: hinge, radius: r),
            0,
            math.pi / 2,
          );
        for (final metric in arc.computeMetrics()) {
          for (var d = 0.0; d < metric.length; d += 8) {
            canvas.drawPath(metric.extractPath(d, d + 4), swing);
          }
        }
        canvas.drawLine(
          hinge,
          hinge + Offset(0, r),
          Paint()
            ..color = _woodDark
            ..strokeWidth = math.max(2, 4 * k),
        );
      case ElementKind.waterPoint:
        final r = math.max(10, w / 2).toDouble();
        canvas
          ..drawCircle(Offset.zero, r, Paint()..color = const Color(0xFFF7F5EF))
          ..drawCircle(
            Offset.zero,
            r,
            Paint()
              ..color = _steel
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.5,
          );
        final drop = Path()
          ..moveTo(0, -r * .5)
          ..cubicTo(-r * .4, -r * .05, -r * .45, r * .15, -r * .45, r * .25)
          ..arcToPoint(
            Offset(r * .45, r * .25),
            radius: Radius.circular(r * .45),
            clockwise: false,
          )
          ..cubicTo(r * .45, r * .15, r * .4, -r * .05, 0, -r * .5)
          ..close();
        canvas.drawPath(drop, Paint()..color = water);
      case ElementKind.drain:
        final r = math.max(10, w / 2).toDouble();
        canvas
          ..drawCircle(Offset.zero, r, Paint()..color = const Color(0xFF7D766A))
          ..save()
          ..clipPath(
            Path()
              ..addOval(Rect.fromCircle(center: Offset.zero, radius: r * .78)),
          )
          ..drawCircle(
            Offset.zero,
            r,
            Paint()..color = const Color(0xFF3F3A33),
          );
        final bar = Paint()
          ..color = const Color(0xFF9A9284)
          ..strokeWidth = math.max(1.5, r * .14);
        for (var y = -r; y <= r; y += r * .36) {
          canvas.drawLine(Offset(-r, y), Offset(r, y), bar);
        }
        canvas.restore();
      case ElementKind.sunFull || ElementKind.sunPart || ElementKind.shade:
        _sunArea(canvas, e.kind, body);
      case ElementKind.cutOut:
        canvas
          ..save()
          ..clipRect(body)
          ..drawRect(body, Paint()..color = parapet);
        final hatch = Paint()
          ..color = const Color(0x3317301F)
          ..strokeWidth = 1.5;
        for (var x = -h; x < w + h; x += 8) {
          canvas.drawLine(
            Offset(body.left + x, body.top),
            Offset(body.left + x + h, body.bottom),
            hatch,
          );
        }
        canvas
          ..restore()
          ..drawRect(
            body,
            Paint()
              ..color = const Color(0xFFB3AA97)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2,
          );
      case ElementKind.northArrow:
        _northArrow(canvas, math.min(w, h) / 2);
    }
    canvas.restore();
  }

  static const _sunFill = Color(0x40F2B92E);
  static const _sunInk = Color(0xFFB7860B);
  static const _shadeFill = Color(0x383D5566);
  static const _shadeInk = Color(0xFF3D5566);

  /// A sun area: a soft tint, a dashed edge and a glyph in the middle.
  static void _sunArea(Canvas canvas, ElementKind kind, Rect body) {
    final (fill, ink) = switch (kind) {
      ElementKind.sunFull => (_sunFill, _sunInk),
      ElementKind.sunPart => (const Color(0x26F2B92E), _sunInk),
      _ => (_shadeFill, _shadeInk),
    };
    final rr = RRect.fromRectAndRadius(body, const Radius.circular(10));
    canvas.drawRRect(rr, Paint()..color = fill);
    final edge = Paint()
      ..color = ink.withValues(alpha: .7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    for (final metric in (Path()..addRRect(rr)).computeMetrics()) {
      for (var d = 0.0; d < metric.length; d += 10) {
        canvas.drawPath(metric.extractPath(d, d + 5), edge);
      }
    }
    final r = math.min(14, math.min(body.width, body.height) / 5).toDouble();
    if (r < 4) return;
    final glyph = Paint()
      ..color = ink
      ..strokeWidth = math.max(1.2, r * .16)
      ..strokeCap = StrokeCap.round;
    switch (kind) {
      case ElementKind.sunFull:
        canvas.drawCircle(Offset.zero, r * .5, glyph);
        for (var i = 0; i < 8; i++) {
          final a = i * math.pi / 4;
          final dir = Offset(math.cos(a), math.sin(a));
          canvas.drawLine(dir * (r * .72), dir * r, glyph);
        }
      case ElementKind.sunPart:
        // A sun half behind a cloud.
        canvas.drawCircle(Offset(-r * .25, -r * .2), r * .5, glyph);
        final cloud = Paint()..color = const Color(0xFFF7F5EF);
        canvas
          ..drawCircle(Offset(r * .05, r * .25), r * .42, cloud)
          ..drawCircle(Offset(r * .45, r * .3), r * .34, cloud)
          ..drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTRB(-r * .3, r * .25, r * .8, r * .64),
              Radius.circular(r * .2),
            ),
            cloud,
          );
      case _:
        // An umbrella: canopy and handle.
        final canopy = Path()
          ..moveTo(-r, 0)
          ..arcToPoint(Offset(r, 0), radius: Radius.circular(r))
          ..close();
        canvas
          ..drawPath(canopy, glyph)
          ..drawLine(
            Offset.zero,
            Offset(0, r * .9),
            glyph..style = PaintingStyle.stroke,
          );
    }
  }

  /// A compass needle pointing up (north, before the element's rotation),
  /// with an N above it.
  static void _northArrow(Canvas canvas, double r) {
    canvas
      ..drawCircle(Offset.zero, r, Paint()..color = const Color(0xF2FBFAF7))
      ..drawCircle(
        Offset.zero,
        r,
        Paint()
          ..color = ink
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    final north = Path()
      ..moveTo(0, -r * .46)
      ..lineTo(r * .26, r * .1)
      ..lineTo(-r * .26, r * .1)
      ..close();
    final south = Path()
      ..moveTo(0, r * .62)
      ..lineTo(r * .26, r * .1)
      ..lineTo(-r * .26, r * .1)
      ..close();
    canvas
      ..drawPath(north, Paint()..color = terracottaDark)
      ..drawPath(
        south,
        Paint()
          ..color = ink
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2,
      );
    // The letter N drawn as strokes, just inside the top of the ring.
    final s = r * .17;
    final top = -r * .88;
    canvas.drawPath(
      Path()
        ..moveTo(-s, top + 2 * s)
        ..lineTo(-s, top)
        ..lineTo(s, top + 2 * s)
        ..lineTo(s, top),
      Paint()
        ..color = ink
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(1, r * .08)
        ..strokeJoin = StrokeJoin.round,
    );
  }

  /// Draws the plants' top-view art inside a container's soil area.
  static void _plants(Canvas canvas, List<PlantArtSpec> plants, Size soil) {
    if (plants.isEmpty) return;
    final long = soil.width >= soil.height;
    final n = plants.length;
    final cell = long
        ? Size(soil.width / n, soil.height)
        : Size(soil.width, soil.height / n);
    final d = math.min(cell.width, cell.height) * 1.08;
    for (var i = 0; i < n; i++) {
      final offset = long
          ? Offset(-soil.width / 2 + cell.width * (i + .5), 0)
          : Offset(0, -soil.height / 2 + cell.height * (i + .5));
      canvas
        ..save()
        ..translate(offset.dx - d / 2, offset.dy - d / 2);
      PlantTopPainter(plants[i]).paint(canvas, Size.square(d));
      canvas.restore();
    }
  }
}
