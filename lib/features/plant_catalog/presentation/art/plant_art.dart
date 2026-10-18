import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';

/// Botanical illustrations drawn in code (Living Terrace). Every species
/// maps to a growth form plus colours, so all catalogue plants get a
/// drawing — from above for the terrace plan, from the side for cards and
/// plant pages — without bundling image files (KI-016 stays open for photos).
enum PlantForm {
  /// Compound leaves with fruit (tomato, chilli, brinjal, beans).
  fruiting,

  /// Big lobed leaves with a yellow flower (okra, gourds).
  palmate,

  /// A rosette of broad leaves (palak, lettuce, amaranth).
  rosette,

  /// A rosette with a root at the soil line (radish, carrot).
  root,

  /// Many small leaves (mint, tulsi, curry leaf, coriander, methi).
  cluster,

  /// Upright blades (lemongrass).
  grass,

  /// Foliage with flowers (marigold, hibiscus, jasmine, rose).
  flowering,

  /// Thick upright leaves (aloe vera, snake plant).
  succulent,

  /// Heart-shaped leaves on trailing stems (money plant).
  trailing,
}

@immutable
final class PlantArtSpec {
  const PlantArtSpec(
    this.form, {
    this.accent,
    this.leafDark = const Color(0xFF2E6A32),
    this.leafMid = const Color(0xFF4E8E3E),
    this.leafLight = const Color(0xFF7DB35A),
    this.rootColor,
  });

  /// The drawing for a species; falls back on its category.
  factory PlantArtSpec.of(String speciesId, {PlantCategory? category}) =>
      _bySpecies[speciesId] ??
      switch (category) {
        PlantCategory.vegetable => const PlantArtSpec(
          PlantForm.fruiting,
          accent: _red,
        ),
        PlantCategory.leafyGreen => const PlantArtSpec(PlantForm.rosette),
        PlantCategory.herb => const PlantArtSpec(PlantForm.cluster),
        PlantCategory.climber => const PlantArtSpec(PlantForm.palmate),
        PlantCategory.flower => const PlantArtSpec(
          PlantForm.flowering,
          accent: Color(0xFFF08C1A),
        ),
        PlantCategory.ornamental => const PlantArtSpec(PlantForm.succulent),
        null => const PlantArtSpec(PlantForm.cluster),
      };
  final PlantForm form;

  /// Fruit or flower colour.
  final Color? accent;
  final Color leafDark;
  final Color leafMid;
  final Color leafLight;
  final Color? rootColor;

  static const _red = Color(0xFFD9452B);
  static const _purple = Color(0xFF5B2A6E);

  static const Map<String, PlantArtSpec> _bySpecies = {
    'tomato': PlantArtSpec(PlantForm.fruiting, accent: _red),
    'chilli': PlantArtSpec(PlantForm.fruiting, accent: Color(0xFFC8311E)),
    'brinjal': PlantArtSpec(PlantForm.fruiting, accent: _purple),
    'frenchBean': PlantArtSpec(
      PlantForm.fruiting,
      accent: Color(0xFF8CBF4E),
    ),
    'okra': PlantArtSpec(PlantForm.palmate, accent: Color(0xFFE9D46B)),
    'bitterGourd': PlantArtSpec(PlantForm.palmate, accent: Color(0xFFF2C94C)),
    'bottleGourd': PlantArtSpec(PlantForm.palmate, accent: Color(0xFFF7F3E8)),
    'palak': PlantArtSpec(PlantForm.rosette),
    'lettuce': PlantArtSpec(
      PlantForm.rosette,
      leafDark: Color(0xFF6AA84F),
      leafMid: Color(0xFF8FC566),
      leafLight: Color(0xFFC8E68E),
    ),
    'amaranth': PlantArtSpec(
      PlantForm.rosette,
      leafDark: Color(0xFF7A2E4A),
      leafMid: Color(0xFF9E3D5C),
      leafLight: Color(0xFF6E9E50),
    ),
    'radish': PlantArtSpec(PlantForm.root, rootColor: Color(0xFFF3EEE6)),
    'carrot': PlantArtSpec(PlantForm.root, rootColor: Color(0xFFE67E22)),
    'mint': PlantArtSpec(
      PlantForm.cluster,
      leafDark: Color(0xFF3F8A42),
      leafMid: Color(0xFF5FA052),
      leafLight: Color(0xFF8CCB75),
    ),
    'tulsi': PlantArtSpec(
      PlantForm.cluster,
      leafDark: Color(0xFF3B6B3A),
      leafMid: Color(0xFF6B4A6E),
      leafLight: Color(0xFF7FAE5E),
    ),
    'curryLeaf': PlantArtSpec(PlantForm.cluster),
    'coriander': PlantArtSpec(
      PlantForm.cluster,
      leafDark: Color(0xFF4F9A45),
      leafMid: Color(0xFF6DB257),
      leafLight: Color(0xFF9ACF7C),
    ),
    'methi': PlantArtSpec(
      PlantForm.cluster,
      leafDark: Color(0xFF4A8F3E),
      leafMid: Color(0xFF68AA52),
      leafLight: Color(0xFF94C978),
    ),
    'lemongrass': PlantArtSpec(
      PlantForm.grass,
      leafDark: Color(0xFF5E8F3E),
      leafMid: Color(0xFF86B356),
      leafLight: Color(0xFFB6D57E),
    ),
    'marigold': PlantArtSpec(PlantForm.flowering, accent: Color(0xFFF08C1A)),
    'hibiscus': PlantArtSpec(PlantForm.flowering, accent: Color(0xFFD7263D)),
    'jasmine': PlantArtSpec(PlantForm.flowering, accent: Color(0xFFFFFFFF)),
    'rose': PlantArtSpec(PlantForm.flowering, accent: Color(0xFFD8456B)),
    'aloeVera': PlantArtSpec(
      PlantForm.succulent,
      leafDark: Color(0xFF5E8C6A),
      leafMid: Color(0xFF7FAA86),
      leafLight: Color(0xFFA9CBAE),
    ),
    'snakePlant': PlantArtSpec(
      PlantForm.succulent,
      leafDark: Color(0xFF2F5B3A),
      leafMid: Color(0xFF4F7F4E),
      leafLight: Color(0xFFC9C46A),
    ),
    'moneyPlant': PlantArtSpec(
      PlantForm.trailing,
      leafMid: Color(0xFF4F9A45),
      leafLight: Color(0xFFE2D36B),
    ),
  };
}

/// A leaf pointing along +x from the origin: [length] long, [width] wide.
Path leafPath(double length, double width) => Path()
  ..moveTo(0, 0)
  ..cubicTo(length * .22, -width * .9, length * .72, -width * .95, length, 0)
  ..cubicTo(length * .72, width * .95, length * .22, width * .9, 0, 0)
  ..close();

void _leaf(
  Canvas canvas,
  Offset origin,
  double angle,
  double length,
  double width,
  Color color,
) {
  canvas
    ..save()
    ..translate(origin.dx, origin.dy)
    ..rotate(angle)
    ..drawPath(leafPath(length, width), Paint()..color = color)
    ..restore();
}

double _rad(double degrees) => degrees * math.pi / 180;

// ---------------------------------------------------------------------------
// Top view
// ---------------------------------------------------------------------------

/// A plant seen from above, centred, filling a circle of [size].
class PlantTopArt extends StatelessWidget {
  const PlantTopArt({
    required this.spec,
    required this.size,
    this.semanticLabel,
    super.key,
  });

  final PlantArtSpec spec;
  final double size;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final art = CustomPaint(
      size: Size.square(size),
      painter: PlantTopPainter(spec),
    );
    return semanticLabel == null
        ? ExcludeSemantics(child: art)
        : Semantics(image: true, label: semanticLabel, child: art);
  }
}

class PlantTopPainter extends CustomPainter {
  const PlantTopPainter(this.spec);

  final PlantArtSpec spec;

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.shortestSide / 2;
    canvas
      ..save()
      ..translate(size.width / 2, size.height / 2);
    final s = spec;
    switch (s.form) {
      case PlantForm.fruiting:
        _radial(canvas, 7, r * .95, r * .34, s.leafDark, 0);
        _radial(canvas, 7, r * .72, r * .27, s.leafMid, 26);
        _radial(canvas, 3, r * .38, r * .16, s.leafLight, 60);
        final fruit = Paint()..color = s.accent ?? s.leafLight;
        for (final (dx, dy, fr) in const [
          (.32, -.18, .14),
          (.45, .05, .12),
          (-.28, .36, .13),
        ]) {
          canvas
            ..drawCircle(Offset(dx * r, dy * r), fr * r, fruit)
            ..drawCircle(
              Offset((dx - .03) * r, (dy - .04) * r),
              fr * r * .3,
              Paint()..color = Colors.white.withValues(alpha: .35),
            );
        }
      case PlantForm.palmate:
        for (var i = 0; i < 5; i++) {
          _lobed(canvas, _rad(i * 72.0 - 90), r * .95, s.leafMid);
        }
        _radial(canvas, 3, r * .55, r * .22, s.leafLight, 36);
        canvas.drawCircle(
          Offset.zero,
          r * .12,
          Paint()..color = s.accent ?? const Color(0xFFE9D46B),
        );
      case PlantForm.rosette || PlantForm.root:
        _radial(canvas, 8, r * .95, r * .36, s.leafDark, 0, fromCentre: true);
        _radial(canvas, 4, r * .6, r * .28, s.leafMid, 22, fromCentre: true);
        final vein = Paint()
          ..color = s.leafLight.withValues(alpha: .8)
          ..strokeWidth = math.max(1, r * .03)
          ..style = PaintingStyle.stroke;
        for (var i = 0; i < 8; i++) {
          final a = _rad(i * 45.0);
          canvas.drawLine(
            Offset.zero,
            Offset(math.cos(a), math.sin(a)) * r * .75,
            vein,
          );
        }
      case PlantForm.cluster:
        final rnd = math.Random(7);
        for (var i = 0; i < 14; i++) {
          final a = rnd.nextDouble() * math.pi * 2;
          final d = (.25 + rnd.nextDouble() * .55) * r;
          _leaf(
            canvas,
            Offset(math.cos(a), math.sin(a)) * d * .4,
            a,
            r * .42,
            r * .16,
            i.isEven ? s.leafDark : s.leafMid,
          );
        }
        _radial(canvas, 4, r * .32, r * .13, s.leafLight, 15);
      case PlantForm.grass:
        final blade = Paint()
          ..color = s.leafMid
          ..strokeWidth = math.max(1.5, r * .07)
          ..strokeCap = StrokeCap.round;
        for (var i = 0; i < 12; i++) {
          final a = _rad(i * 30.0 + 8);
          canvas.drawLine(
            Offset.zero,
            Offset(math.cos(a), math.sin(a)) * r * .95,
            blade..color = i.isEven ? s.leafMid : s.leafDark,
          );
        }
        canvas.drawCircle(Offset.zero, r * .14, Paint()..color = s.leafLight);
      case PlantForm.flowering:
        _radial(canvas, 8, r * .9, r * .3, s.leafDark, 0);
        _radial(canvas, 6, r * .6, r * .24, s.leafMid, 30);
        for (final (dx, dy) in const [(.3, -.3), (-.35, -.1), (.1, .38)]) {
          _flower(canvas, Offset(dx * r, dy * r), r * .2, s.accent!);
        }
      case PlantForm.succulent:
        for (var i = 0; i < 9; i++) {
          _leaf(
            canvas,
            Offset.zero,
            _rad(i * 40.0),
            r * .95,
            r * .2,
            i.isEven ? s.leafDark : s.leafMid,
          );
        }
        _radial(canvas, 5, r * .5, r * .14, s.leafLight, 20);
      case PlantForm.trailing:
        for (var i = 0; i < 9; i++) {
          final a = _rad(i * 40.0);
          final p = Offset(math.cos(a), math.sin(a)) * r * .55;
          _heart(canvas, p, r * .46, i.isEven ? s.leafMid : s.leafDark);
        }
        _heart(canvas, Offset.zero, r * .42, s.leafLight);
    }
    canvas.restore();
  }

  void _radial(
    Canvas canvas,
    int count,
    double length,
    double width,
    Color color,
    double offsetDeg, {
    bool fromCentre = false,
  }) {
    for (var i = 0; i < count; i++) {
      final a = _rad(offsetDeg + i * 360 / count);
      _leaf(
        canvas,
        fromCentre ? Offset.zero : Offset(math.cos(a), math.sin(a)) * 2,
        a,
        length,
        width,
        color,
      );
    }
  }

  void _lobed(Canvas canvas, double angle, double length, Color color) {
    final path = Path()
      ..moveTo(0, 0)
      ..cubicTo(
        length * .2,
        -length * .3,
        length * .6,
        -length * .35,
        length * .85,
        -length * .18,
      )
      ..quadraticBezierTo(length * .7, -length * .05, length, 0)
      ..quadraticBezierTo(length * .7, length * .05, length * .85, length * .18)
      ..cubicTo(length * .6, length * .35, length * .2, length * .3, 0, 0)
      ..close();
    canvas
      ..save()
      ..rotate(angle)
      ..drawPath(path, Paint()..color = color)
      ..drawLine(
        Offset.zero,
        Offset(length * .9, 0),
        Paint()
          ..color = Colors.white.withValues(alpha: .25)
          ..strokeWidth = math.max(1, length * .025),
      )
      ..restore();
  }

  @override
  bool shouldRepaint(PlantTopPainter oldDelegate) => oldDelegate.spec != spec;
}

void _flower(Canvas canvas, Offset centre, double r, Color color) {
  final petal = Paint()..color = color;
  for (var i = 0; i < 6; i++) {
    final a = _rad(i * 60.0);
    canvas.drawCircle(
      centre + Offset(math.cos(a), math.sin(a)) * r * .55,
      r * .45,
      petal,
    );
  }
  canvas.drawCircle(
    centre,
    r * .35,
    Paint()
      ..color = color == const Color(0xFFFFFFFF)
          ? const Color(0xFFE9D46B)
          : Color.lerp(color, Colors.black, .25)!,
  );
}

void _heart(Canvas canvas, Offset centre, double size, Color color) {
  final p = Path()
    ..moveTo(centre.dx, centre.dy + size * .5)
    ..cubicTo(
      centre.dx - size * .9,
      centre.dy - size * .05,
      centre.dx - size * .5,
      centre.dy - size * .75,
      centre.dx,
      centre.dy - size * .3,
    )
    ..cubicTo(
      centre.dx + size * .5,
      centre.dy - size * .75,
      centre.dx + size * .9,
      centre.dy - size * .05,
      centre.dx,
      centre.dy + size * .5,
    )
    ..close();
  canvas.drawPath(p, Paint()..color = color);
}

// ---------------------------------------------------------------------------
// Side view
// ---------------------------------------------------------------------------

enum PotStyle { terracotta, growBag }

/// A plant in a pot, seen from the side. Drawn in a box of `size`
/// (width × 1.0 height).
class PlantSideArt extends StatelessWidget {
  const PlantSideArt({
    required this.spec,
    required this.size,
    this.pot = PotStyle.terracotta,
    this.semanticLabel,
    super.key,
  });

  final PlantArtSpec spec;
  final double size;
  final PotStyle pot;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final art = CustomPaint(
      size: Size.square(size),
      painter: PlantSidePainter(spec, pot),
    );
    return semanticLabel == null
        ? ExcludeSemantics(child: art)
        : Semantics(image: true, label: semanticLabel, child: art);
  }
}

class PlantSidePainter extends CustomPainter {
  const PlantSidePainter(this.spec, this.pot);

  final PlantArtSpec spec;
  final PotStyle pot;

  @override
  void paint(Canvas canvas, Size size) {
    // Work in a 120 × 120 box.
    final k = size.shortestSide / 120;
    canvas
      ..save()
      ..scale(k);
    final s = spec;

    // Shadow.
    canvas.drawOval(
      const Rect.fromLTWH(18, 108, 84, 10),
      Paint()..color = const Color(0x262B2418),
    );

    // Plant behind the pot rim.
    const soil = Offset(60, 80);
    switch (s.form) {
      case PlantForm.fruiting:
        final stem = Paint()
          ..color = const Color(0xFF3E7A34)
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
        canvas.drawPath(
          Path()
            ..moveTo(60, 80)
            ..cubicTo(58, 60, 64, 40, 62, 16),
          stem,
        );
        for (final (x, y, a, l) in const [
          (61.0, 66.0, 200.0, 26.0),
          (61.0, 60.0, -20.0, 26.0),
          (62.0, 44.0, 205.0, 24.0),
          (62.0, 38.0, -25.0, 24.0),
          (62.0, 22.0, 230.0, 18.0),
          (62.0, 18.0, -50.0, 18.0),
        ]) {
          _leaf(canvas, Offset(x, y), _rad(a), l, 8, s.leafDark);
        }
        for (final (x, y, a) in const [
          (61.0, 54.0, 190.0),
          (62.0, 30.0, -10.0),
        ]) {
          _leaf(canvas, Offset(x, y), _rad(a), 18, 6, s.leafMid);
        }
        final fruit = Paint()..color = s.accent ?? s.leafLight;
        if (s.accent == const Color(0xFF5B2A6E)) {
          // Brinjal: an oblong hanging fruit.
          canvas.drawPath(
            Path()
              ..moveTo(68, 46)
              ..cubicTo(82, 48, 86, 64, 80, 74)
              ..cubicTo(74, 82, 64, 76, 64, 64)
              ..cubicTo(64, 56, 64, 50, 68, 46),
            fruit,
          );
        } else if (s.accent == const Color(0xFF8CBF4E)) {
          // Beans: hanging pods.
          final pod = Paint()
            ..color = s.accent!
            ..strokeWidth = 4
            ..strokeCap = StrokeCap.round;
          canvas
            ..drawLine(const Offset(48, 50), const Offset(46, 70), pod)
            ..drawLine(const Offset(74, 40), const Offset(77, 60), pod)
            ..drawLine(const Offset(54, 32), const Offset(52, 48), pod);
        } else {
          for (final (x, y, fr) in const [
            (44.0, 62.0, 7.0),
            (52.0, 66.0, 6.0),
            (76.0, 40.0, 6.0),
          ]) {
            canvas.drawCircle(Offset(x, y), fr, fruit);
          }
        }
      case PlantForm.palmate:
        final stem = Paint()
          ..color = const Color(0xFF4B6B3A)
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;
        canvas.drawLine(soil, const Offset(60, 14), stem);
        for (final (x, y, a) in const [
          (60.0, 62.0, 205.0),
          (60.0, 56.0, -25.0),
          (60.0, 38.0, 215.0),
          (60.0, 32.0, -35.0),
        ]) {
          _leaf(canvas, Offset(x, y), _rad(a), 30, 13, s.leafMid);
        }
        _leaf(canvas, const Offset(60, 22), _rad(-90), 14, 8, s.leafLight);
        canvas.drawCircle(
          const Offset(68, 28),
          5,
          Paint()..color = s.accent ?? const Color(0xFFE9D46B),
        );
      case PlantForm.rosette:
        for (final (a, l, w, c) in [
          (-150.0, 32.0, 14.0, s.leafDark),
          (-30.0, 32.0, 14.0, s.leafDark),
          (-122.0, 40.0, 17.0, s.leafDark),
          (-58.0, 40.0, 17.0, s.leafDark),
          (-90.0, 46.0, 18.0, s.leafMid),
          (-108.0, 34.0, 14.0, s.leafMid),
          (-72.0, 34.0, 14.0, s.leafMid),
          (-90.0, 26.0, 10.0, s.leafLight),
        ]) {
          _leaf(canvas, const Offset(60, 78), _rad(a), l, w, c);
        }
      case PlantForm.root:
        final root = Paint()..color = s.rootColor ?? Colors.white;
        for (final (a, l, c) in [
          (-125.0, 34.0, s.leafDark),
          (-55.0, 34.0, s.leafDark),
          (-100.0, 40.0, s.leafMid),
          (-80.0, 40.0, s.leafMid),
        ]) {
          _leaf(canvas, const Offset(60, 64), _rad(a), l, 10, c);
        }
        // The root's shoulder shows above the soil.
        canvas.drawPath(
          Path()
            ..moveTo(49, 76)
            ..cubicTo(49, 62, 71, 62, 71, 76)
            ..close(),
          root,
        );
      case PlantForm.cluster:
        final stem = Paint()
          ..color = s.leafDark
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;
        for (final dx in const [-14.0, 0.0, 14.0]) {
          canvas.drawLine(soil, Offset(60 + dx, 30), stem);
          for (var i = 0; i < 4; i++) {
            final y = 70.0 - i * 11;
            final x = 60 + dx * (80 - y) / 50;
            _leaf(canvas, Offset(x, y), _rad(200), 11, 5, s.leafMid);
            _leaf(canvas, Offset(x, y), _rad(-20), 11, 5, s.leafDark);
          }
          _leaf(canvas, Offset(60 + dx, 30), _rad(-90), 9, 5, s.leafLight);
        }
      case PlantForm.grass:
        final blade = Paint()
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;
        for (final (dx, top, c) in [
          (-24.0, 20.0, s.leafDark),
          (-12.0, 8.0, s.leafMid),
          (0.0, 4.0, s.leafDark),
          (12.0, 10.0, s.leafMid),
          (24.0, 22.0, s.leafLight),
        ]) {
          canvas.drawPath(
            Path()
              ..moveTo(60 + dx / 4, 80)
              ..quadraticBezierTo(60 + dx / 2, 40, 60 + dx, top),
            blade..color = c,
          );
        }
      case PlantForm.flowering:
        for (final (a, l, c) in [
          (-130.0, 30.0, s.leafDark),
          (-50.0, 30.0, s.leafDark),
          (-100.0, 34.0, s.leafMid),
          (-80.0, 34.0, s.leafMid),
        ]) {
          _leaf(canvas, soil, _rad(a), l, 12, c);
        }
        for (final o in const [
          Offset(46, 40),
          Offset(74, 38),
          Offset(60, 26),
        ]) {
          _flower(canvas, o, 8, s.accent!);
        }
      case PlantForm.succulent:
        for (final (a, l, c) in [
          (-125.0, 38.0, s.leafMid),
          (-55.0, 38.0, s.leafMid),
          (-105.0, 54.0, s.leafDark),
          (-75.0, 54.0, s.leafDark),
          (-90.0, 60.0, s.leafLight),
        ]) {
          _leaf(canvas, soil, _rad(a), l, 7, c);
        }
      case PlantForm.trailing:
        final vine = Paint()
          ..color = s.leafDark
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;
        canvas
          ..drawPath(
            Path()
              ..moveTo(50, 80)
              ..cubicTo(30, 84, 24, 96, 26, 108),
            vine,
          )
          ..drawPath(
            Path()
              ..moveTo(70, 80)
              ..cubicTo(90, 84, 96, 96, 94, 106),
            vine,
          );
        for (final o in const [
          Offset(28, 96),
          Offset(92, 96),
          Offset(48, 60),
          Offset(70, 58),
          Offset(60, 44),
        ]) {
          _heart(canvas, o, 16, s.leafMid);
        }
        _heart(canvas, const Offset(60, 66), 14, s.leafLight);
    }

    // Pot.
    switch (pot) {
      case PotStyle.terracotta:
        canvas
          ..drawPath(
            Path()
              ..moveTo(28, 80)
              ..lineTo(92, 80)
              ..lineTo(86, 110)
              ..quadraticBezierTo(60, 116, 34, 110)
              ..close(),
            Paint()
              ..shader = const LinearGradient(
                colors: [
                  Color(0xFFB9532A),
                  Color(0xFFD2703F),
                  Color(0xFFA4441D),
                ],
                stops: [0, .55, 1],
              ).createShader(const Rect.fromLTWH(28, 80, 64, 36)),
          )
          ..drawRRect(
            RRect.fromRectAndRadius(
              const Rect.fromLTWH(24, 74, 72, 10),
              const Radius.circular(3),
            ),
            Paint()..color = const Color(0xFFC2592B),
          );
      case PotStyle.growBag:
        canvas
          ..drawPath(
            Path()
              ..moveTo(28, 78)
              ..lineTo(92, 78)
              ..lineTo(87, 110)
              ..quadraticBezierTo(60, 116, 33, 110)
              ..close(),
            Paint()
              ..shader = const LinearGradient(
                colors: [
                  Color(0xFF262E2A),
                  Color(0xFF3A4540),
                  Color(0xFF1F2622),
                ],
                stops: [0, .5, 1],
              ).createShader(const Rect.fromLTWH(28, 78, 64, 38)),
          )
          ..drawOval(
            const Rect.fromLTWH(30, 74, 60, 8),
            Paint()..color = const Color(0xFF5A3E2B),
          );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(PlantSidePainter oldDelegate) =>
      oldDelegate.spec != spec || oldDelegate.pot != pot;
}
