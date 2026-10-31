part of 'plant_art.dart';

/// What makes a species recognisable within its growth form: a fruit,
/// head, flower or leaf shape. Each trait draws in both views; some replace
/// the form's drawing altogether ([replacesForm]).
enum ArtTrait {
  none,

  // Fruiting.
  fruitLong,
  fruitOblong,
  fruitPod,
  fruitPodCluster,
  fruitBell,
  fruitBerry,
  fruitCrowned,
  fruitPear,
  fruitCitrus,
  fruitBerryCluster,

  // Rosettes and roots.
  head,
  curd,
  florets,
  ruffled,
  roundLeaves,
  plume,
  feathery,
  redStems,
  tubers,

  // Small leaves.
  spike,
  lacy,
  trifoliate,
  pinnate,
  pinnateNarrow,
  bipinnate,
  glossyPinnate,

  // Blades.
  tubular,
  bulb,
  flatBlade,
  broadBlade,
  wideBlade,
  paddle,
  frond,
  striped,

  // Flowers.
  pompom,
  rays,
  daisy,
  bigPetals,
  trumpet,
  spiral,
  star,
  pinwheel,
  cup,
  flowerSpike,
  spathe,
  bracts,

  // Succulents.
  swords,
  coins,
  cactus,

  // Big leaves and vines.
  uprightPod,
  gourdBottle,
  gourdWarty,
  gourdRidged,
  gourdLong,
  gourdCucumber,
  gourdRound,
  figFruit,
  tree,
  bigLeaf,
  arrowhead,
  tendril,
  longPods,
  vineFlowers,

  // Added with the catalogue's second wave (ADR-035).
  knob,
  gourdSnake,
  gourdAsh,
  gourdIvy,
  corn,
  elephantEar,
  woodyHerb,
  caneHearts,
  creeping,
  scalloped,
  sunflower,
  floretBall,
  fanPalm,
  lantern,
  grapeBunch,
  pineapple;

  bool get isFruit =>
      index >= fruitLong.index && index <= fruitBerryCluster.index;

  /// The trait draws the whole plant instead of decorating the form.
  bool get replacesForm => const {
    roundLeaves,
    feathery,
    tubers,
    lacy,
    trifoliate,
    pinnate,
    pinnateNarrow,
    bipinnate,
    glossyPinnate,
    tubular,
    bulb,
    flatBlade,
    broadBlade,
    wideBlade,
    paddle,
    frond,
    striped,
    swords,
    coins,
    cactus,
    tree,
    bigLeaf,
    arrowhead,
    corn,
    elephantEar,
    woodyHerb,
    caneHearts,
    creeping,
    scalloped,
    sunflower,
    fanPalm,
    grapeBunch,
    pineapple,
  }.contains(this);
}

Paint _fill(Color c) => Paint()..color = c;

Paint _line(Color c, double width) => Paint()
  ..color = c
  ..strokeWidth = width
  ..style = PaintingStyle.stroke
  ..strokeCap = StrokeCap.round;

Color _darker(Color c, [double t = .3]) => Color.lerp(c, Colors.black, t)!;
Color _lighter(Color c, [double t = .4]) => Color.lerp(c, Colors.white, t)!;

/// Draws [draw] rotated by [angle] about [at].
void _at(Canvas canvas, Offset at, double angle, void Function() draw) {
  canvas
    ..save()
    ..translate(at.dx, at.dy)
    ..rotate(angle);
  draw();
  canvas.restore();
}

/// An ellipse along +x, centred on the origin.
void _ellipse(Canvas canvas, double length, double width, Color color) =>
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: length, height: width),
      _fill(color),
    );

/// A tapered pod hanging from [top]: [bend] curves it sideways.
void _pod(
  Canvas canvas,
  Offset top,
  double length,
  double width,
  double bend,
  Color color,
) {
  final end = top + Offset(bend, length);
  canvas.drawPath(
    Path()
      ..moveTo(top.dx - width / 2, top.dy)
      ..quadraticBezierTo(
        top.dx - width / 2 + bend * .2,
        top.dy + length * .6,
        end.dx,
        end.dy,
      )
      ..quadraticBezierTo(
        top.dx + width / 2 + bend * .6,
        top.dy + length * .5,
        top.dx + width / 2,
        top.dy,
      )
      ..close(),
    _fill(color),
  );
}

/// Leaflets in pairs along a stalk from the origin along +x.
void _pinnateLeaf(
  Canvas canvas,
  double length,
  double leaflet,
  double width,
  Color stalk,
  Color a,
  Color b, {
  int pairs = 5,
}) {
  canvas.drawLine(Offset.zero, Offset(length, 0), _line(stalk, width * .3));
  for (var i = 0; i < pairs; i++) {
    final x = length * (.25 + .7 * i / pairs);
    final l = leaflet * (1 - .35 * i / pairs);
    _leaf(canvas, Offset(x, 0), _rad(-55), l, width, a);
    _leaf(canvas, Offset(x, 0), _rad(55), l, width, b);
  }
  _leaf(canvas, Offset(length, 0), 0, leaflet * .7, width, a);
}

/// A five-pointed papery bract cluster, a star or a pinwheel.
void _petals(
  Canvas canvas,
  Offset centre,
  int count,
  double length,
  double width,
  Color color, {
  double offsetDeg = -90,
}) {
  for (var i = 0; i < count; i++) {
    _leaf(
      canvas,
      centre,
      _rad(offsetDeg + i * 360 / count),
      length,
      width,
      color,
    );
  }
}

/// One flower of [s], drawn at [centre] with radius [r]. [side] draws the
/// side-view variant where the shape differs (spikes, spathes).
void _bloom(
  Canvas canvas,
  Offset centre,
  double r,
  PlantArtSpec s, {
  bool side = false,
}) {
  final color = s.accent ?? const Color(0xFFF2C230);
  switch (s.trait) {
    case ArtTrait.pompom:
      for (var i = 0; i < 10; i++) {
        final a = _rad(i * 36.0);
        canvas.drawCircle(
          centre + Offset(math.cos(a), math.sin(a)) * r * .62,
          r * .36,
          _fill(color),
        );
      }
      for (var i = 0; i < 6; i++) {
        final a = _rad(i * 60.0 + 15);
        canvas.drawCircle(
          centre + Offset(math.cos(a), math.sin(a)) * r * .3,
          r * .3,
          _fill(_darker(color, .12)),
        );
      }
      canvas.drawCircle(centre, r * .2, _fill(_darker(color, .25)));
    case ArtTrait.rays || ArtTrait.daisy:
      final daisy = s.trait == ArtTrait.daisy;
      _petals(canvas, centre, daisy ? 12 : 18, r * 1.05, r * .22, color);
      if (!daisy) {
        _petals(canvas, centre, 12, r * .7, r * .2, _darker(color, .1));
      }
      canvas.drawCircle(
        centre,
        r * (daisy ? .4 : .26),
        _fill(daisy ? const Color(0xFF8A4B12) : _darker(color, .2)),
      );
    case ArtTrait.bigPetals:
      _petals(canvas, centre, 5, r * 1.25, r * .62, color);
      canvas
        ..drawCircle(centre, r * .28, _fill(_darker(color, .45)))
        ..drawLine(
          centre,
          centre + Offset(r * .9, -r * .9),
          _line(const Color(0xFFF2D24B), math.max(1, r * .1)),
        )
        ..drawCircle(
          centre + Offset(r * .9, -r * .9),
          r * .14,
          _fill(const Color(0xFFF2D24B)),
        );
    case ArtTrait.trumpet:
      _petals(canvas, centre, 5, r * 1.1, r * .55, color);
      canvas
        ..drawCircle(centre, r * .42, _fill(_lighter(color, .7)))
        ..drawCircle(centre, r * .16, _fill(_darker(color, .2)));
    case ArtTrait.spiral:
      canvas.drawCircle(centre, r, _fill(color));
      final arc = _line(_darker(color), math.max(1, r * .12));
      for (final (k, start) in const [(.75, 0.0), (.5, 2.0), (.28, 4.0)]) {
        canvas.drawArc(
          Rect.fromCircle(center: centre, radius: r * k),
          start,
          4.2,
          false,
          arc,
        );
      }
    case ArtTrait.star:
      _petals(canvas, centre, 5, r * 1.05, r * .34, color);
      canvas.drawCircle(centre, r * .18, _fill(const Color(0xFFE9D46B)));
    case ArtTrait.pinwheel:
      _petals(canvas, centre, 5, r * 1.05, r * .58, color, offsetDeg: -72);
      canvas
        ..drawCircle(centre, r * .26, _fill(_darker(color, .4)))
        ..drawCircle(centre, r * .1, _fill(Colors.white));
    case ArtTrait.cup:
      for (var i = 0; i < 5; i++) {
        final a = _rad(i * 72.0 - 90);
        canvas.drawCircle(
          centre + Offset(math.cos(a), math.sin(a)) * r * .4,
          r * .55,
          _fill(i.isEven ? color : _darker(color, .1)),
        );
      }
      canvas.drawCircle(centre, r * .26, _fill(const Color(0xFFF2D24B)));
    case ArtTrait.flowerSpike:
      if (side) {
        for (var i = 0; i < 6; i++) {
          canvas.drawOval(
            Rect.fromCenter(
              center: centre + Offset(0, i * r * .55 - r),
              width: r * .7,
              height: r * .5,
            ),
            _fill(i.isEven ? color : _darker(color, .15)),
          );
        }
      } else {
        for (var i = 0; i < 5; i++) {
          final a = _rad(i * 72.0);
          canvas.drawCircle(
            centre + Offset(math.cos(a), math.sin(a)) * r * .4,
            r * .32,
            _fill(i.isEven ? color : _darker(color, .15)),
          );
        }
      }
    case ArtTrait.spathe:
      _at(canvas, centre, _rad(side ? -90 : -60), () {
        canvas
          ..drawPath(leafPath(r * 2.2, r * .9), _fill(color))
          ..drawLine(
            Offset(r * .2, 0),
            Offset(r * 1.1, 0),
            _line(const Color(0xFFE9D46B), math.max(1.5, r * .22)),
          );
      });
    case ArtTrait.bracts:
      _petals(canvas, centre, 3, r * 1.15, r * .8, color, offsetDeg: -30);
      _petals(
        canvas,
        centre,
        3,
        r * .8,
        r * .55,
        _darker(color, .12),
        offsetDeg: 30,
      );
      canvas.drawCircle(centre, r * .14, _fill(const Color(0xFFF6F2E8)));
    case ArtTrait.floretBall:
      for (var i = 0; i < 8; i++) {
        final a = _rad(i * 45.0);
        _petals(
          canvas,
          centre + Offset(math.cos(a), math.sin(a)) * r * .6,
          4,
          r * .38,
          r * .2,
          i.isEven ? color : _darker(color, .1),
          offsetDeg: 45,
        );
      }
      _petals(canvas, centre, 4, r * .38, r * .2, color, offsetDeg: 45);
    case _:
      _flower(canvas, centre, r, color);
  }
}

// ---------------------------------------------------------------------------
// Top view
// ---------------------------------------------------------------------------

/// Adds [PlantArtSpec.trait] to the top view; for [ArtTrait.replacesForm]
/// traits this is the whole plant.
void _topTrait(Canvas canvas, double r, PlantArtSpec s) {
  final accent = s.accent ?? s.leafLight;
  switch (s.trait) {
    // --- Fruit ---------------------------------------------------------
    case ArtTrait.none:
      if (s.form == PlantForm.fruiting) _roundFruit(canvas, r, accent);
    case ArtTrait.fruitLong || ArtTrait.fruitOblong:
      final long = s.trait == ArtTrait.fruitLong;
      for (final (dx, dy, a) in const [
        (.34, -.2, 40.0),
        (.4, .2, 95.0),
        (-.3, .34, 140.0),
        (-.1, -.42, -30.0),
      ]) {
        _at(canvas, Offset(dx * r, dy * r), _rad(a), () {
          _ellipse(
            canvas,
            r * (long ? .46 : .4),
            r * (long ? .1 : .2),
            accent,
          );
          canvas.drawCircle(
            Offset(-r * (long ? .23 : .2), 0),
            r * (long ? .05 : .08),
            _fill(s.leafLight),
          );
        });
      }
    case ArtTrait.fruitPod || ArtTrait.fruitPodCluster:
      final pod = _line(accent, math.max(1.5, r * .07));
      final spots = s.trait == ArtTrait.fruitPod
          ? const [(.3, -.25, 60.0), (-.35, .2, 150.0), (.2, .35, 100.0)]
          : const [(.32, -.18, 30.0), (-.28, .3, 200.0)];
      for (final (dx, dy, a) in spots) {
        final at = Offset(dx * r, dy * r);
        final count = s.trait == ArtTrait.fruitPod ? 1 : 3;
        for (var i = 0; i < count; i++) {
          final d = Offset(math.cos(_rad(a)), math.sin(_rad(a)));
          final n = Offset(-d.dy, d.dx) * (i - (count - 1) / 2) * r * .08;
          canvas.drawLine(at + n, at + n + d * r * .42, pod);
        }
      }
    case ArtTrait.fruitBell:
      for (final (dx, dy) in const [(.32, -.2), (-.3, .3), (.25, .35)]) {
        final c = Offset(dx * r, dy * r);
        canvas
          ..drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromCenter(center: c, width: r * .3, height: r * .3),
              Radius.circular(r * .1),
            ),
            _fill(accent),
          )
          ..drawLine(
            c - Offset(0, r * .13),
            c + Offset(0, r * .13),
            _line(_darker(accent, .2), math.max(1, r * .03)),
          )
          ..drawCircle(c, r * .05, _fill(s.leafDark));
      }
    case ArtTrait.fruitBerry:
      for (final (dx, dy, a) in const [
        (.32, -.2, 30.0),
        (-.3, .3, 160.0),
        (.25, .38, 80.0),
      ]) {
        _at(canvas, Offset(dx * r, dy * r), _rad(a), () {
          canvas.drawPath(
            Path()
              ..moveTo(-r * .12, -r * .11)
              ..quadraticBezierTo(r * .22, -r * .14, r * .2, 0)
              ..quadraticBezierTo(r * .22, r * .14, -r * .12, r * .11)
              ..close(),
            _fill(accent),
          );
          for (final o in const [(.02, -.04), (.08, .04), (-.04, .03)]) {
            canvas.drawCircle(
              Offset(o.$1 * r, o.$2 * r),
              r * .015 + .4,
              _fill(const Color(0xFFF2D24B)),
            );
          }
          _petals(
            canvas,
            Offset(-r * .12, 0),
            4,
            r * .08,
            r * .04,
            s.leafLight,
          );
        });
      }
    case ArtTrait.fruitCrowned:
      for (final (dx, dy) in const [(.32, -.2), (-.3, .32)]) {
        final c = Offset(dx * r, dy * r);
        canvas
          ..drawCircle(c, r * .18, _fill(accent))
          ..drawCircle(
            c - Offset(r * .05, r * .05),
            r * .05,
            _fill(Colors.white.withValues(alpha: .3)),
          );
        _petals(canvas, c, 5, r * .07, r * .04, _darker(accent, .35));
      }
    case ArtTrait.fruitPear:
      for (final (dx, dy, a) in const [(.32, -.2, 40.0), (-.3, .3, 200.0)]) {
        _at(canvas, Offset(dx * r, dy * r), _rad(a), () {
          canvas
            ..drawCircle(Offset(r * .05, 0), r * .15, _fill(accent))
            ..drawCircle(Offset(-r * .1, 0), r * .1, _fill(accent))
            ..drawCircle(
              Offset(-r * .2, 0),
              r * .03,
              _fill(_darker(accent, .5)),
            );
        });
      }
    case ArtTrait.fruitCitrus:
      for (final (dx, dy) in const [(.32, -.22), (-.3, .3), (.2, .36)]) {
        final c = Offset(dx * r, dy * r);
        canvas
          ..drawCircle(c, r * .12, _fill(accent))
          ..drawCircle(
            c - Offset(r * .035, r * .035),
            r * .035,
            _fill(Colors.white.withValues(alpha: .4)),
          );
      }
      _petals(
        canvas,
        Offset(-r * .2, -r * .32),
        5,
        r * .1,
        r * .05,
        const Color(0xFFF7F5EE),
      );
    case ArtTrait.fruitBerryCluster:
      for (final (dx, dy, a) in const [
        (.32, -.2, 30.0),
        (-.3, .3, 150.0),
        (.22, .35, 80.0),
        (-.25, -.3, 250.0),
      ]) {
        _at(canvas, Offset(dx * r, dy * r), _rad(a), () {
          for (var i = 0; i < 4; i++) {
            canvas.drawCircle(
              Offset(i * r * .06, (i.isEven ? -1 : 1) * r * .02),
              r * .05,
              _fill(i == 3 ? _lighter(accent, .3) : accent),
            );
          }
        });
      }

    // --- Rosettes and roots --------------------------------------------
    case ArtTrait.head:
      canvas.drawCircle(Offset.zero, r * .55, _fill(s.leafLight));
      final arc = _line(s.leafMid, math.max(1, r * .04));
      for (final (k, start) in const [(.45, 0.4), (.32, 2.4), (.2, 4.4)]) {
        canvas.drawArc(
          Rect.fromCircle(center: Offset.zero, radius: r * k),
          start,
          3.6,
          false,
          arc,
        );
      }
    case ArtTrait.curd || ArtTrait.florets:
      final curd = s.trait == ArtTrait.curd;
      final c = curd ? const Color(0xFFF3ECD6) : const Color(0xFF5C8A3E);
      for (var i = 0; i < 8; i++) {
        final a = _rad(i * 45.0);
        canvas.drawCircle(
          Offset(math.cos(a), math.sin(a)) * r * .26,
          r * .17,
          _fill(i.isEven ? c : _darker(c, .08)),
        );
      }
      canvas.drawCircle(Offset.zero, r * .2, _fill(c));
      if (!curd) {
        for (var i = 0; i < 14; i++) {
          final a = _rad(i * 51.0);
          canvas.drawCircle(
            Offset(math.cos(a), math.sin(a)) * r * (.08 + (i % 4) * .08),
            r * .03,
            _fill(const Color(0xFF9CC46A)),
          );
        }
      }
    case ArtTrait.ruffled:
      for (var i = 0; i < 18; i++) {
        final a = _rad(i * 20.0);
        canvas.drawCircle(
          Offset(math.cos(a), math.sin(a)) * r * .78,
          r * .16,
          _fill(i.isEven ? s.leafLight : s.leafMid),
        );
      }
      canvas.drawCircle(Offset.zero, r * .45, _fill(s.leafMid));
      for (var i = 0; i < 9; i++) {
        final a = _rad(i * 40.0 + 10);
        canvas.drawCircle(
          Offset(math.cos(a), math.sin(a)) * r * .4,
          r * .13,
          _fill(s.leafLight),
        );
      }
    case ArtTrait.roundLeaves:
      for (var i = 0; i < 7; i++) {
        final a = _rad(i * 360 / 7 + 10);
        final p = Offset(math.cos(a), math.sin(a)) * r * (.5 + (i % 2) * .15);
        canvas
          ..drawLine(Offset.zero, p, _line(s.leafDark, math.max(1, r * .03)))
          ..drawCircle(p, r * .26, _fill(i.isEven ? s.leafMid : s.leafDark))
          ..drawLine(
            p,
            p + Offset(math.cos(a), math.sin(a)) * r * .24,
            _line(s.leafLight, math.max(1, r * .03)),
          );
      }
    case ArtTrait.plume:
      for (var i = 0; i < 9; i++) {
        final a = _rad(i * 40.0);
        canvas.drawCircle(
          Offset(math.cos(a), math.sin(a)) * r * .14,
          r * .1,
          _fill(i.isEven ? s.leafDark : _lighter(s.leafDark, .15)),
        );
      }
    case ArtTrait.feathery:
      _lacyTop(canvas, r, s);
      canvas.drawCircle(
        Offset.zero,
        r * .14,
        _fill(s.rootColor ?? const Color(0xFFE67E22)),
      );
    case ArtTrait.redStems:
      final vein = _line(s.rootColor!, math.max(1.2, r * .05));
      for (var i = 0; i < 8; i++) {
        final a = _rad(i * 45.0 + 4);
        canvas.drawLine(
          Offset.zero,
          Offset(math.cos(a), math.sin(a)) * r * .8,
          vein,
        );
      }
      canvas.drawCircle(Offset.zero, r * .12, _fill(s.rootColor!));
    case ArtTrait.tubers:
      final rnd = math.Random(11);
      for (var i = 0; i < 16; i++) {
        final a = rnd.nextDouble() * math.pi * 2;
        final d = (.2 + rnd.nextDouble() * .5) * r;
        _leaf(
          canvas,
          Offset(math.cos(a), math.sin(a)) * d * .5,
          a,
          r * .4,
          r * .2,
          i.isEven ? s.leafDark : s.leafMid,
        );
      }
      for (final (dx, dy) in const [(.3, -.25), (-.25, .3), (-.1, -.35)]) {
        _petals(
          canvas,
          Offset(dx * r, dy * r),
          5,
          r * .1,
          r * .06,
          const Color(0xFFF2EEF6),
        );
        canvas.drawCircle(
          Offset(dx * r, dy * r),
          r * .03,
          _fill(const Color(0xFFF2D24B)),
        );
      }

    // --- Small leaves ---------------------------------------------------
    case ArtTrait.spike:
      final c = s.accent ?? const Color(0xFFF4F1E6);
      for (final (dx, dy, a) in const [
        (.25, -.2, -40.0),
        (-.3, -.1, 200.0),
        (.05, .3, 90.0),
        (-.15, .28, 130.0),
      ]) {
        final d = Offset(math.cos(_rad(a)), math.sin(_rad(a)));
        for (var i = 0; i < 4; i++) {
          canvas.drawCircle(
            Offset(dx * r, dy * r) + d * (i * r * .07),
            r * .045,
            _fill(c),
          );
        }
      }
    case ArtTrait.lacy:
      _lacyTop(canvas, r, s);
    case ArtTrait.trifoliate:
      final rnd = math.Random(5);
      for (var i = 0; i < 9; i++) {
        final a = rnd.nextDouble() * math.pi * 2;
        final c =
            Offset(math.cos(a), math.sin(a)) *
            (.2 + rnd.nextDouble() * .55) *
            r;
        for (var j = 0; j < 3; j++) {
          final b = a + _rad(j * 120.0);
          canvas.drawCircle(
            c + Offset(math.cos(b), math.sin(b)) * r * .08,
            r * .09,
            _fill(j == 0 ? s.leafDark : s.leafMid),
          );
        }
      }
      canvas.drawCircle(Offset.zero, r * .08, _fill(s.leafLight));
    case ArtTrait.pinnate || ArtTrait.pinnateNarrow || ArtTrait.glossyPinnate:
      final narrow = s.trait == ArtTrait.pinnateNarrow;
      final glossy = s.trait == ArtTrait.glossyPinnate;
      for (var i = 0; i < 7; i++) {
        _at(canvas, Offset.zero, _rad(i * 360 / 7), () {
          _pinnateLeaf(
            canvas,
            r * .9,
            r * (narrow ? .26 : .2),
            r *
                (narrow
                    ? .06
                    : glossy
                    ? .12
                    : .09),
            s.leafDark,
            i.isEven ? s.leafMid : s.leafDark,
            i.isEven ? s.leafDark : s.leafMid,
            pairs: glossy ? 3 : 5,
          );
        });
      }
      if (glossy) {
        canvas.drawCircle(Offset.zero, r * .1, _fill(s.leafLight));
      }
    case ArtTrait.bipinnate:
      final rnd = math.Random(3);
      for (var i = 0; i < 70; i++) {
        final a = rnd.nextDouble() * math.pi * 2;
        final d = math.sqrt(rnd.nextDouble()) * r * .9;
        canvas.drawCircle(
          Offset(math.cos(a), math.sin(a)) * d,
          r * .06,
          _fill([s.leafDark, s.leafMid, s.leafLight][i % 3]),
        );
      }
      final pod = _line(
        s.accent ?? const Color(0xFF5E8A3A),
        math.max(1.5, r * .05),
      );
      canvas
        ..drawLine(Offset(r * .1, r * .1), Offset(r * .7, r * .5), pod)
        ..drawLine(Offset(-r * .1, 0), Offset(-r * .6, r * .55), pod);

    // --- Blades ---------------------------------------------------------
    case ArtTrait.tubular || ArtTrait.bulb:
      for (var i = 0; i < 7; i++) {
        final a = _rad(i * 360 / 7 + 12);
        final d = Offset(math.cos(a), math.sin(a));
        canvas
          ..drawLine(
            d * r * .12,
            d * r * .85,
            _line(i.isEven ? s.leafMid : s.leafDark, math.max(2, r * .13)),
          )
          ..drawCircle(d * r * .85, r * .05, _fill(s.leafLight));
      }
      canvas.drawCircle(
        Offset.zero,
        r * (s.trait == ArtTrait.bulb ? .26 : .16),
        _fill(s.rootColor ?? const Color(0xFFF2EEE2)),
      );
    case ArtTrait.flatBlade:
      for (var i = 0; i < 8; i++) {
        _leaf(
          canvas,
          Offset.zero,
          _rad(i * 45.0 + 20),
          r * .95,
          r * .1,
          i.isEven ? s.leafMid : s.leafDark,
        );
      }
      canvas.drawCircle(Offset.zero, r * .16, _fill(const Color(0xFFF2EEE2)));
    case ArtTrait.broadBlade || ArtTrait.wideBlade:
      final wide = s.trait == ArtTrait.wideBlade;
      for (var i = 0; i < (wide ? 6 : 3); i++) {
        final a = _rad(i * (wide ? 60.0 : 120.0) + 20);
        if (wide) {
          _leaf(canvas, Offset.zero, a, r * .98, r * .3, s.leafMid);
          _at(canvas, Offset.zero, a, () {
            canvas.drawLine(
              Offset.zero,
              Offset(r * .9, 0),
              _line(s.leafLight, math.max(1, r * .03)),
            );
          });
        } else {
          _at(canvas, Offset.zero, a, () {
            canvas.drawLine(
              Offset.zero,
              Offset(r * .9, 0),
              _line(s.leafDark, math.max(1, r * .04)),
            );
            for (var j = 0; j < 4; j++) {
              final x = r * (.2 + j * .2);
              _leaf(
                canvas,
                Offset(x, 0),
                _rad(j.isEven ? -50 : 50),
                r * .4,
                r * .09,
                j.isEven ? s.leafMid : s.leafLight,
              );
            }
          });
        }
      }
    case ArtTrait.paddle:
      for (var i = 0; i < 6; i++) {
        final a = _rad(i * 60.0 + 10);
        _leaf(
          canvas,
          Offset.zero,
          a,
          r,
          r * .38,
          i.isEven ? s.leafMid : s.leafDark,
        );
        _at(canvas, Offset.zero, a, () {
          canvas.drawLine(
            Offset.zero,
            Offset(r * .95, 0),
            _line(s.leafLight, math.max(1.2, r * .05)),
          );
          final tear = _line(_darker(s.leafDark, .15), math.max(.8, r * .015));
          for (final x in const [.4, .6, .78]) {
            canvas.drawLine(
              Offset(r * x, r * .05),
              Offset(r * (x + .06), r * .3),
              tear,
            );
          }
        });
      }
    case ArtTrait.frond:
      for (var i = 0; i < 7; i++) {
        final a = _rad(i * 360 / 7);
        _at(canvas, Offset.zero, a, () {
          canvas.drawLine(
            Offset.zero,
            Offset(r * .95, 0),
            _line(s.leafLight, math.max(1, r * .03)),
          );
          final leaflet = _line(
            i.isEven ? s.leafMid : s.leafDark,
            math.max(1, r * .035),
          );
          for (var j = 1; j < 9; j++) {
            final x = r * j * .1;
            final l = r * .22 * (1 - j / 12);
            canvas
              ..drawLine(Offset(x, 0), Offset(x + l * .5, -l), leaflet)
              ..drawLine(Offset(x, 0), Offset(x + l * .5, l), leaflet);
          }
        });
      }
    case ArtTrait.striped:
      for (var i = 0; i < 10; i++) {
        final a = _rad(i * 36.0 + 8);
        _leaf(canvas, Offset.zero, a, r * .95, r * .12, s.leafMid);
        _at(canvas, Offset.zero, a, () {
          canvas.drawLine(
            Offset(r * .05, 0),
            Offset(r * .8, 0),
            _line(s.leafLight, math.max(1, r * .04)),
          );
        });
      }

    // --- Succulents -----------------------------------------------------
    case ArtTrait.swords:
      for (var i = 0; i < 7; i++) {
        final a = _rad(i * 360 / 7 + 10);
        _at(canvas, Offset.zero, a, () {
          canvas
            ..drawPath(leafPath(r * .9, r * .26), _fill(s.leafLight))
            ..drawPath(leafPath(r * .84, r * .18), _fill(s.leafDark));
          final band = _line(s.leafMid, math.max(1, r * .03));
          for (final x in const [.25, .45, .65]) {
            canvas.drawLine(
              Offset(r * x, -r * .06),
              Offset(r * x, r * .06),
              band,
            );
          }
        });
      }
    case ArtTrait.coins:
      final rnd = math.Random(9);
      for (var i = 0; i < 26; i++) {
        final a = rnd.nextDouble() * math.pi * 2;
        final c =
            Offset(math.cos(a), math.sin(a)) *
            (.15 + rnd.nextDouble() * .62) *
            r;
        _at(canvas, c, a, () {
          _ellipse(canvas, r * .36, r * .26, const Color(0xFFB5523F));
          _ellipse(canvas, r * .33, r * .23, i.isEven ? s.leafMid : s.leafDark);
          canvas.drawCircle(
            Offset(-r * .04, -r * .03),
            r * .04,
            _fill(Colors.white.withValues(alpha: .25)),
          );
        });
      }
    case ArtTrait.cactus:
      for (var i = 0; i < 3; i++) {
        final a = _rad(i * 120.0 - 90);
        _at(canvas, Offset.zero, a, () {
          for (var j = 0; j < 3; j++) {
            canvas.drawCircle(
              Offset(r * (.2 + j * .25), 0),
              r * .14,
              _fill(j.isEven ? s.leafMid : s.leafDark),
            );
          }
        });
      }
      canvas
        ..drawCircle(Offset.zero, r * .18, _fill(s.leafDark))
        ..drawCircle(Offset(r * .45, r * .3), r * .14, _fill(s.leafLight));

    // --- Big leaves and vines -------------------------------------------
    case ArtTrait.uprightPod:
      final pod = _line(const Color(0xFF6E9E3A), math.max(2, r * .08));
      canvas
        ..drawLine(Offset(r * .15, -r * .1), Offset(r * .45, -r * .35), pod)
        ..drawLine(Offset(-r * .1, r * .15), Offset(-r * .4, r * .4), pod);
      _bloom(
        canvas,
        Offset(-r * .3, -r * .3),
        r * .16,
        PlantArtSpec(
          PlantForm.flowering,
          accent: accent,
          trait: ArtTrait.trumpet,
        ),
      );
    case ArtTrait.gourdBottle ||
        ArtTrait.gourdWarty ||
        ArtTrait.gourdRidged ||
        ArtTrait.gourdLong ||
        ArtTrait.gourdCucumber ||
        ArtTrait.gourdSnake ||
        ArtTrait.gourdAsh ||
        ArtTrait.gourdIvy:
      _at(canvas, Offset(r * .1, r * .42), _rad(-15), () {
        _gourd(canvas, s.trait, r * .9, horizontal: true);
      });
    case ArtTrait.gourdRound:
      _pumpkin(canvas, Offset(r * .25, r * .3), r * .36);
    case ArtTrait.figFruit:
      for (final (dx, dy, a) in const [(.35, -.15, 20.0), (-.3, .3, 200.0)]) {
        _at(canvas, Offset(dx * r, dy * r), _rad(a), () {
          canvas
            ..drawCircle(Offset(r * .04, 0), r * .14, _fill(accent))
            ..drawCircle(Offset(-r * .1, 0), r * .08, _fill(accent));
        });
      }
    case ArtTrait.tree:
      for (var i = 0; i < 7; i++) {
        final a = _rad(i * 360 / 7);
        final tip = Offset(math.cos(a), math.sin(a)) * r * .62;
        canvas.drawLine(
          Offset.zero,
          tip,
          _line(s.leafLight, math.max(1, r * .03)),
        );
        _at(canvas, tip, a, () {
          for (var j = -2; j <= 2; j++) {
            _leaf(
              canvas,
              Offset.zero,
              _rad(j * 32.0),
              r * .34,
              r * .12,
              s.leafMid,
            );
          }
        });
      }
      for (var i = 0; i < 4; i++) {
        final a = _rad(i * 90.0 + 45);
        _at(canvas, Offset(math.cos(a), math.sin(a)) * r * .12, a, () {
          _ellipse(canvas, r * .2, r * .13, accent);
        });
      }
    case ArtTrait.bigLeaf:
      for (var i = 0; i < 6; i++) {
        final a = _rad(i * 60.0 + 15);
        _leaf(
          canvas,
          Offset.zero,
          a,
          r * .95,
          r * .42,
          i.isEven ? s.leafMid : s.leafDark,
        );
        _at(canvas, Offset.zero, a, () {
          canvas.drawLine(
            Offset(r * .05, 0),
            Offset(r * .85, 0),
            _line(s.leafLight, math.max(1, r * .03)),
          );
        });
      }
      canvas.drawCircle(Offset.zero, r * .1, _fill(const Color(0xFFA33A3A)));
    case ArtTrait.arrowhead:
      for (var i = 0; i < 8; i++) {
        final a = _rad(i * 45.0);
        _arrow(
          canvas,
          Offset(math.cos(a), math.sin(a)) * r * .5,
          a,
          r * .46,
          i.isEven ? s.leafMid : s.leafDark,
          s.leafLight,
        );
      }
      _arrow(canvas, Offset.zero, _rad(-90), r * .4, s.leafLight, s.leafMid);
    case ArtTrait.tendril || ArtTrait.longPods || ArtTrait.vineFlowers:
      final flower = s.accent ?? const Color(0xFFF4F1F6);
      if (s.trait == ArtTrait.tendril) {
        final curl = _line(s.leafLight, math.max(1, r * .03));
        for (final (dx, dy) in const [(.5, -.4), (-.55, .2), (.1, .6)]) {
          canvas.drawArc(
            Rect.fromCircle(center: Offset(dx * r, dy * r), radius: r * .1),
            0,
            5,
            false,
            curl,
          );
        }
      }
      if (s.trait != ArtTrait.vineFlowers) {
        final pod = _line(
          const Color(0xFF7DB34A),
          math.max(2, r * (s.trait == ArtTrait.longPods ? .05 : .09)),
        );
        final len = s.trait == ArtTrait.longPods ? .6 : .3;
        canvas
          ..drawLine(
            Offset(r * .2, r * .1),
            Offset(r * (.2 + len), r * .3),
            pod,
          )
          ..drawLine(
            Offset(-r * .2, -r * .1),
            Offset(-r * (.2 + len * .8), -r * .35),
            pod,
          );
      }
      for (final (dx, dy) in const [(.4, -.1), (-.35, .35), (-.1, -.45)]) {
        _peaFlower(canvas, Offset(dx * r, dy * r), r * .13, flower);
      }
    // --- Second wave (ADR-035) ---------------------------------------------
    case ArtTrait.knob:
      final stalk = _line(s.leafLight, math.max(1, r * .04));
      for (var i = 0; i < 6; i++) {
        final a = _rad(i * 60.0 + 20);
        canvas.drawLine(
          Offset.zero,
          Offset(math.cos(a), math.sin(a)) * r * .5,
          stalk,
        );
      }
      canvas
        ..drawCircle(Offset.zero, r * .34, _fill(_lighter(s.leafLight, .25)))
        ..drawCircle(
          Offset(-r * .1, -r * .1),
          r * .1,
          _fill(Colors.white.withValues(alpha: .3)),
        );
    case ArtTrait.corn:
      for (var i = 0; i < 8; i++) {
        final a = _rad(i * 45.0 + 10);
        _leaf(
          canvas,
          Offset.zero,
          a,
          r * .98,
          r * .14,
          i.isEven ? s.leafMid : s.leafDark,
        );
        _at(canvas, Offset.zero, a, () {
          canvas.drawLine(
            Offset(r * .05, 0),
            Offset(r * .9, 0),
            _line(s.leafLight, math.max(.8, r * .025)),
          );
        });
      }
      _petals(canvas, Offset.zero, 6, r * .3, r * .05, const Color(0xFFD9B95A));
    case ArtTrait.elephantEar:
      for (var i = 0; i < 6; i++) {
        final a = _rad(i * 60.0 + 30);
        final c = Offset(math.cos(a), math.sin(a)) * r * .45;
        _at(canvas, c, a + math.pi / 2, () {
          _heart(
            canvas,
            Offset.zero,
            r * .62,
            i.isEven ? s.leafMid : s.leafDark,
          );
          canvas.drawLine(
            Offset(0, -r * .12),
            Offset(0, r * .28),
            _line(s.leafLight, math.max(.8, r * .025)),
          );
        });
      }
      canvas.drawCircle(Offset.zero, r * .08, _fill(s.leafLight));
    case ArtTrait.woodyHerb:
      final wood = _line(const Color(0xFF7A6A4E), math.max(1, r * .03));
      for (var i = 0; i < 7; i++) {
        final a = _rad(i * 360 / 7 + 8);
        _at(canvas, Offset.zero, a, () {
          canvas.drawLine(Offset.zero, Offset(r * .9, 0), wood);
          final needle = _line(
            i.isEven ? s.leafMid : s.leafDark,
            math.max(1, r * .04),
          );
          for (var j = 1; j < 9; j++) {
            final x = r * j * .1;
            canvas
              ..drawLine(Offset(x, 0), Offset(x + r * .04, -r * .09), needle)
              ..drawLine(Offset(x, 0), Offset(x + r * .04, r * .09), needle);
          }
        });
      }
      if (s.accent case final c?) {
        for (final (dx, dy) in const [
          (.4, -.2),
          (-.3, .35),
          (-.2, -.45),
          (.25, .45),
        ]) {
          canvas.drawCircle(Offset(dx * r, dy * r), r * .05, _fill(c));
        }
      }
    case ArtTrait.caneHearts:
      for (var i = 0; i < 7; i++) {
        final a = _rad(i * 360 / 7);
        _heart(
          canvas,
          Offset(math.cos(a), math.sin(a)) * r * .45,
          r * .6,
          i.isEven ? s.leafMid : s.leafDark,
        );
      }
      canvas.drawCircle(Offset.zero, r * .1, _fill(const Color(0xFFB59A6A)));
    case ArtTrait.creeping:
      final rnd = math.Random(13);
      for (var i = 0; i < 5; i++) {
        final a = _rad(i * 72.0);
        _at(canvas, Offset.zero, a, () {
          canvas.drawLine(
            Offset.zero,
            Offset(r * .9, 0),
            _line(s.leafDark, math.max(.8, r * .02)),
          );
          for (var j = 1; j < 7; j++) {
            final x = r * j * .14;
            for (final side in const [-1.0, 1.0]) {
              _at(canvas, Offset(x, side * r * .07), 0, () {
                _ellipse(
                  canvas,
                  r * .12,
                  r * .09,
                  j.isEven ? s.leafMid : s.leafLight,
                );
              });
            }
          }
        });
      }
      for (var i = 0; i < 6; i++) {
        final a = rnd.nextDouble() * math.pi * 2;
        _petals(
          canvas,
          Offset(math.cos(a), math.sin(a)) * r * (.3 + rnd.nextDouble() * .5),
          5,
          r * .06,
          r * .04,
          s.accent ?? const Color(0xFFF7F5EE),
        );
      }
    case ArtTrait.scalloped:
      for (var i = 0; i < 8; i++) {
        final a = _rad(i * 45.0 + 10);
        final c = Offset(math.cos(a), math.sin(a)) * r * (i.isEven ? .55 : .4);
        _scallopLeaf(canvas, c, r * .26, s, i.isEven);
      }
      _scallopLeaf(canvas, Offset.zero, r * .22, s, true);
    case ArtTrait.sunflower:
      for (var i = 0; i < 6; i++) {
        _leaf(canvas, Offset.zero, _rad(i * 60.0), r * .95, r * .34, s.leafMid);
      }
      final c = s.accent ?? const Color(0xFFF2C230);
      _petals(canvas, Offset.zero, 20, r * .62, r * .12, c);
      canvas
        ..drawCircle(Offset.zero, r * .32, _fill(const Color(0xFF5A3A1E)))
        ..drawCircle(Offset.zero, r * .2, _fill(const Color(0xFF6E4A26)));
    case ArtTrait.fanPalm:
      for (var i = 0; i < 6; i++) {
        final a = _rad(i * 60.0 + 15);
        final tip = Offset(math.cos(a), math.sin(a)) * r * .5;
        canvas.drawLine(
          Offset.zero,
          tip,
          _line(s.leafLight, math.max(.8, r * .02)),
        );
        _at(canvas, tip, a, () {
          for (var j = -3; j <= 3; j++) {
            _leaf(
              canvas,
              Offset.zero,
              _rad(j * 18.0),
              r * .42,
              r * .06,
              j.isEven ? s.leafMid : s.leafDark,
            );
          }
        });
      }
    case ArtTrait.lantern:
      for (final (dx, dy, a) in const [
        (.32, -.2, 30.0),
        (-.3, .3, 160.0),
        (.2, .38, 80.0),
      ]) {
        _at(canvas, Offset(dx * r, dy * r), _rad(a), () {
          canvas
            ..drawPath(leafPath(r * .34, r * .2), _fill(accent))
            ..drawLine(
              Offset(r * .03, 0),
              Offset(r * .3, 0),
              _line(_darker(accent, .2), math.max(.6, r * .02)),
            );
        });
      }
      canvas.drawCircle(
        Offset(r * .05, -r * .02),
        r * .06,
        _fill(const Color(0xFFF29A1A)),
      );
    case ArtTrait.grapeBunch:
      for (var i = 0; i < 5; i++) {
        final a = _rad(i * 72.0);
        _grapeLeaf(
          canvas,
          Offset(math.cos(a), math.sin(a)) * r * .42,
          r * .5,
          i.isEven ? s.leafMid : s.leafDark,
        );
      }
      for (final (dx, dy) in const [(.25, .2), (-.3, -.15)]) {
        _bunch(canvas, Offset(dx * r, dy * r), r * .06, accent);
      }
    case ArtTrait.pineapple:
      for (var i = 0; i < 14; i++) {
        _leaf(
          canvas,
          Offset.zero,
          _rad(i * 360 / 14),
          r * .95,
          r * .09,
          i.isEven ? s.leafMid : s.leafDark,
        );
      }
      canvas.drawCircle(Offset.zero, r * .26, _fill(accent));
      _petals(canvas, Offset.zero, 8, r * .3, r * .06, s.leafDark);
    case _:
      break;
  }
}

void _roundFruit(Canvas canvas, double r, Color color) {
  for (final (dx, dy, fr) in const [
    (.32, -.18, .14),
    (.45, .05, .12),
    (-.28, .36, .13),
  ]) {
    canvas
      ..drawCircle(Offset(dx * r, dy * r), fr * r, _fill(color))
      ..drawCircle(
        Offset((dx - .03) * r, (dy - .04) * r),
        fr * r * .3,
        _fill(Colors.white.withValues(alpha: .35)),
      );
  }
}

/// Finely divided leaves (coriander, carrot): fans of tiny leaflets.
void _lacyTop(Canvas canvas, double r, PlantArtSpec s) {
  for (var i = 0; i < 9; i++) {
    final a = _rad(i * 40.0 + (i.isEven ? 0 : 12));
    final reach = const [.82, .6, .74, .52, .8, .66, .58, .78, .7][i];
    _at(canvas, Offset.zero, a, () {
      canvas.drawLine(
        Offset.zero,
        Offset(r * reach, 0),
        _line(s.leafDark, math.max(.8, r * .025)),
      );
      for (var j = 1; j <= 4; j++) {
        final x = r * reach * j * .25;
        for (final side in const [-1.0, 0.0, 1.0]) {
          canvas.drawCircle(
            Offset(x + r * .04, side * r * .07),
            r * .055,
            _fill(j.isEven ? s.leafMid : s.leafLight),
          );
        }
      }
    });
  }
}

void _arrow(
  Canvas canvas,
  Offset at,
  double angle,
  double size,
  Color color,
  Color vein,
) {
  _at(canvas, at, angle, () {
    canvas
      ..drawPath(
        Path()
          ..moveTo(size * .6, 0)
          ..cubicTo(
            size * .3,
            -size * .12,
            0,
            -size * .4,
            -size * .3,
            -size * .36,
          )
          ..cubicTo(
            -size * .5,
            -size * .32,
            -size * .48,
            -size * .1,
            -size * .22,
            0,
          )
          ..cubicTo(
            -size * .48,
            size * .1,
            -size * .5,
            size * .32,
            -size * .3,
            size * .36,
          )
          ..cubicTo(0, size * .4, size * .3, size * .12, size * .6, 0)
          ..close(),
        _fill(color),
      )
      ..drawLine(
        Offset(-size * .25, 0),
        Offset(size * .45, 0),
        _line(vein, math.max(.8, size * .05)),
      );
  });
}

void _peaFlower(Canvas canvas, Offset c, double r, Color color) {
  canvas
    ..drawCircle(c, r, _fill(color))
    ..drawCircle(c + Offset(0, r * .5), r * .55, _fill(_darker(color, .12)))
    ..drawCircle(c + Offset(0, -r * .1), r * .25, _fill(_lighter(color, .6)));
}

const Map<ArtTrait, Color> _gourdColors = {
  ArtTrait.gourdBottle: Color(0xFFB9CF7A),
  ArtTrait.gourdWarty: Color(0xFF5E9E3A),
  ArtTrait.gourdRidged: Color(0xFF6E9A4A),
  ArtTrait.gourdLong: Color(0xFF86B35E),
  ArtTrait.gourdCucumber: Color(0xFF3E7A34),
  ArtTrait.gourdSnake: Color(0xFFB5D08A),
  ArtTrait.gourdAsh: Color(0xFF9DB89A),
  ArtTrait.gourdIvy: Color(0xFF4E8A3A),
};

/// A gourd hanging down (or lying along +x when [horizontal]), [length]
/// long, its stem end at the origin.
void _gourd(
  Canvas canvas,
  ArtTrait t,
  double length, {
  bool horizontal = false,
}) {
  final color = _gourdColors[t]!;
  canvas.save();
  if (horizontal) canvas.rotate(-math.pi / 2);
  final l = length;
  switch (t) {
    case ArtTrait.gourdBottle:
      canvas
        ..drawOval(
          Rect.fromCenter(
            center: Offset(0, l * .25),
            width: l * .2,
            height: l * .45,
          ),
          _fill(color),
        )
        ..drawCircle(Offset(0, l * .68), l * .24, _fill(color));
    case ArtTrait.gourdCucumber:
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(-l * .11, 0, l * .22, l * .62),
          Radius.circular(l * .11),
        ),
        _fill(color),
      );
      for (var i = 0; i < 5; i++) {
        canvas.drawCircle(
          Offset((i.isEven ? -1 : 1) * l * .04, l * (.1 + i * .1)),
          l * .015 + .4,
          _fill(_lighter(color, .5)),
        );
      }
    case ArtTrait.gourdSnake:
      // Very long, thin and curling.
      canvas.drawPath(
        Path()
          ..moveTo(0, 0)
          ..cubicTo(l * .2, l * .5, -l * .2, l * .9, l * .06, l * 1.0),
        _line(color, l * .09),
      );
      final stripe = _line(_lighter(color, .45), math.max(.6, l * .015));
      canvas.drawPath(
        Path()
          ..moveTo(0, l * .05)
          ..cubicTo(l * .2, l * .5, -l * .2, l * .9, l * .06, l * .96),
        stripe,
      );
    case ArtTrait.gourdAsh:
      // A large waxy oval with a pale bloom.
      canvas.drawOval(
        Rect.fromLTWH(-l * .26, l * .05, l * .52, l * .8),
        _fill(color),
      );
      for (var i = 0; i < 7; i++) {
        canvas.drawCircle(
          Offset((i % 3 - 1) * l * .12, l * (.2 + (i ~/ 3) * .22)),
          l * .03 + .5,
          _fill(_lighter(color, .6)),
        );
      }
    case ArtTrait.gourdIvy:
      // Small striped fruits in a cluster.
      for (final (dx, dy) in const [(-.1, 0.0), (.12, .08), (0.0, .3)]) {
        final c = Offset(dx * l, dy * l + l * .15);
        canvas
          ..drawOval(
            Rect.fromCenter(center: c, width: l * .22, height: l * .4),
            _fill(color),
          )
          ..drawLine(
            c - Offset(0, l * .12),
            c + Offset(0, l * .12),
            _line(_lighter(color, .6), math.max(.6, l * .02)),
          );
      }
    case _:
      final w = t == ArtTrait.gourdLong ? l * .16 : l * .2;
      final len = t == ArtTrait.gourdWarty ? l * .7 : l;
      canvas.drawPath(
        Path()
          ..moveTo(0, 0)
          ..quadraticBezierTo(w, len * .3, w * .5, len * .9)
          ..quadraticBezierTo(0, len * 1.02, -w * .5, len * .9)
          ..quadraticBezierTo(-w, len * .3, 0, 0)
          ..close(),
        _fill(color),
      );
      if (t == ArtTrait.gourdWarty) {
        for (var i = 0; i < 9; i++) {
          canvas.drawCircle(
            Offset((i % 3 - 1) * w * .32, len * (.2 + (i ~/ 3) * .22)),
            l * .025 + .5,
            _fill(_lighter(color, .3)),
          );
        }
      } else if (t == ArtTrait.gourdRidged) {
        final ridge = _line(_darker(color), math.max(.8, l * .015));
        for (final x in const [-.3, 0.0, .3]) {
          canvas.drawLine(
            Offset(x * w, len * .12),
            Offset(x * w * .8, len * .85),
            ridge,
          );
        }
      }
  }
  canvas.restore();
}

void _pumpkin(Canvas canvas, Offset c, double r) {
  const orange = Color(0xFFE67E22);
  for (final dx in const [-.45, .45, 0.0]) {
    canvas.drawOval(
      Rect.fromCenter(
        center: c + Offset(dx * r, 0),
        width: r * 1.2,
        height: r * 1.6,
      ),
      _fill(dx == 0 ? orange : _darker(orange, .12)),
    );
  }
  canvas.drawLine(
    c - Offset(0, r * .7),
    c - Offset(-r * .15, r * 1.05),
    _line(const Color(0xFF5E6E2A), math.max(1.5, r * .14)),
  );
}

// ---------------------------------------------------------------------------
// Side view (120 × 120 box; soil at y 80)
// ---------------------------------------------------------------------------

void _sideTrait(Canvas canvas, PlantArtSpec s) {
  final accent = s.accent ?? s.leafLight;
  switch (s.trait) {
    // --- Fruit ---------------------------------------------------------
    case ArtTrait.none:
      if (s.form == PlantForm.fruiting) {
        for (final (x, y, fr) in const [
          (44.0, 62.0, 7.0),
          (52.0, 66.0, 6.0),
          (76.0, 40.0, 6.0),
        ]) {
          canvas
            ..drawCircle(Offset(x, y), fr, _fill(accent))
            ..drawCircle(
              Offset(x - 2, y - 2),
              fr * .3,
              _fill(Colors.white.withValues(alpha: .35)),
            );
        }
      }
    case ArtTrait.fruitLong:
      for (final (x, y, b) in const [
        (48.0, 52.0, -4.0),
        (74.0, 42.0, 5.0),
        (56.0, 34.0, -3.0),
      ]) {
        canvas.drawCircle(Offset(x, y), 2, _fill(s.leafLight));
        _pod(canvas, Offset(x, y + 1), 20, 5, b, accent);
      }
    case ArtTrait.fruitOblong:
      canvas.drawPath(
        Path()
          ..moveTo(68, 46)
          ..cubicTo(82, 48, 86, 64, 80, 74)
          ..cubicTo(74, 82, 64, 76, 64, 64)
          ..cubicTo(64, 56, 64, 50, 68, 46),
        _fill(accent),
      );
      _petals(canvas, const Offset(68, 47), 4, 6, 3, s.leafMid, offsetDeg: 20);
      canvas.drawOval(
        const Rect.fromLTWH(70, 54, 4, 8),
        _fill(Colors.white.withValues(alpha: .25)),
      );
    case ArtTrait.fruitPod:
      final pod = _line(accent, 4);
      canvas
        ..drawLine(const Offset(48, 50), const Offset(46, 70), pod)
        ..drawLine(const Offset(74, 40), const Offset(77, 60), pod)
        ..drawLine(const Offset(54, 32), const Offset(52, 48), pod);
    case ArtTrait.fruitPodCluster:
      final pod = _line(accent, 3);
      for (final (x, y) in const [(64.0, 58.0), (64.0, 36.0)]) {
        for (final dx in const [-4.0, 0.0, 4.0]) {
          canvas.drawLine(Offset(x, y), Offset(x + 6 + dx, y - 14), pod);
        }
      }
    case ArtTrait.fruitBell:
      for (final (x, y) in const [(46.0, 58.0), (76.0, 40.0)]) {
        canvas
          ..drawRRect(
            RRect.fromRectAndCorners(
              Rect.fromLTWH(x - 7, y, 14, 15),
              topLeft: const Radius.circular(5),
              topRight: const Radius.circular(5),
              bottomLeft: const Radius.circular(4),
              bottomRight: const Radius.circular(4),
            ),
            _fill(accent),
          )
          ..drawLine(
            Offset(x, y + 2),
            Offset(x, y + 14),
            _line(_darker(accent, .2), 1),
          )
          ..drawLine(Offset(x, y), Offset(x, y - 4), _line(s.leafDark, 2));
      }
    case ArtTrait.fruitBerry:
      for (final (x, y) in const [(44.0, 60.0), (76.0, 50.0), (58.0, 66.0)]) {
        canvas.drawPath(
          Path()
            ..moveTo(x - 6, y)
            ..quadraticBezierTo(x - 6, y + 10, x, y + 13)
            ..quadraticBezierTo(x + 6, y + 10, x + 6, y)
            ..close(),
          _fill(accent),
        );
        for (final (dx, dy) in const [(-2.0, 4.0), (2.0, 6.0), (0.0, 9.0)]) {
          canvas.drawCircle(
            Offset(x + dx, y + dy),
            .8,
            _fill(const Color(0xFFF2D24B)),
          );
        }
        _petals(canvas, Offset(x, y), 4, 5, 2.5, s.leafLight, offsetDeg: -135);
      }
      _petals(canvas, const Offset(70, 30), 5, 6, 4, const Color(0xFFF7F5EE));
    case ArtTrait.fruitCrowned:
      for (final (x, y) in const [(46.0, 60.0), (77.0, 42.0)]) {
        canvas
          ..drawCircle(Offset(x, y), 8, _fill(accent))
          ..drawCircle(
            Offset(x - 2.5, y - 2.5),
            2.2,
            _fill(Colors.white.withValues(alpha: .3)),
          );
        _petals(
          canvas,
          Offset(x, y + 8),
          3,
          4,
          2.5,
          _darker(accent, .35),
          offsetDeg: 60,
        );
      }
    case ArtTrait.fruitPear:
      for (final (x, y) in const [(46.0, 56.0), (77.0, 38.0)]) {
        canvas
          ..drawCircle(Offset(x, y + 2), 4, _fill(accent))
          ..drawCircle(Offset(x, y + 9), 7, _fill(accent))
          ..drawLine(
            Offset(x, y - 2),
            Offset(x, y + 1),
            _line(s.leafDark, 1.5),
          );
      }
    case ArtTrait.fruitCitrus:
      for (final (x, y) in const [(46.0, 58.0), (76.0, 42.0), (56.0, 30.0)]) {
        canvas
          ..drawCircle(Offset(x, y), 5.5, _fill(accent))
          ..drawCircle(
            Offset(x - 1.6, y - 1.6),
            1.6,
            _fill(Colors.white.withValues(alpha: .4)),
          );
      }
      _petals(canvas, const Offset(70, 22), 5, 5, 2.5, const Color(0xFFF7F5EE));
    case ArtTrait.fruitBerryCluster:
      for (final (x, y) in const [(46.0, 52.0), (76.0, 38.0), (54.0, 30.0)]) {
        for (var i = 0; i < 4; i++) {
          canvas.drawCircle(
            Offset(x + (i.isEven ? -1 : 1), y + i * 2.6),
            2.4,
            _fill(i == 3 ? _lighter(accent, .3) : accent),
          );
        }
      }

    // --- Rosettes and roots --------------------------------------------
    case ArtTrait.head:
      canvas.drawCircle(const Offset(60, 64), 16, _fill(s.leafLight));
      final arc = _line(s.leafMid, 1.2);
      canvas
        ..drawArc(
          Rect.fromCircle(center: const Offset(60, 64), radius: 11),
          3.6,
          2.2,
          false,
          arc,
        )
        ..drawArc(
          Rect.fromCircle(center: const Offset(60, 66), radius: 6),
          3.4,
          2.4,
          false,
          arc,
        );
      for (final a in const [-160.0, -20.0]) {
        _leaf(canvas, const Offset(60, 78), _rad(a), 26, 12, s.leafMid);
      }
    case ArtTrait.curd || ArtTrait.florets:
      final curd = s.trait == ArtTrait.curd;
      final c = curd ? const Color(0xFFF3ECD6) : const Color(0xFF5C8A3E);
      if (!curd) {
        canvas.drawLine(
          const Offset(60, 78),
          const Offset(60, 58),
          _line(const Color(0xFF7FA86A), 6),
        );
      }
      for (final (dx, dy, fr) in const [
        (-9.0, 4.0, 7.0),
        (9.0, 4.0, 7.0),
        (-4.0, -2.0, 7.5),
        (5.0, -2.0, 7.5),
        (0.0, 4.0, 7.0),
      ]) {
        canvas.drawCircle(Offset(60 + dx, (curd ? 64 : 54) + dy), fr, _fill(c));
      }
      if (!curd) {
        for (final (dx, dy) in const [
          (-8.0, 2.0),
          (4.0, -4.0),
          (8.0, 4.0),
          (-2.0, 6.0),
        ]) {
          canvas.drawCircle(
            Offset(60 + dx, 54 + dy),
            1.4,
            _fill(const Color(0xFF6E9E5A)),
          );
        }
      }
      for (final a in const [-150.0, -30.0]) {
        _leaf(canvas, const Offset(60, 78), _rad(a), 24, 10, s.leafDark);
      }
    case ArtTrait.ruffled:
      for (final (dx, dy, fr, c) in [
        (-14.0, 70.0, 9.0, s.leafMid),
        (14.0, 70.0, 9.0, s.leafMid),
        (-8.0, 62.0, 9.0, s.leafLight),
        (8.0, 62.0, 9.0, s.leafLight),
        (0.0, 56.0, 8.0, s.leafMid),
        (0.0, 68.0, 9.0, s.leafLight),
      ]) {
        canvas.drawCircle(Offset(60 + dx, dy), fr, _fill(c));
      }
    case ArtTrait.roundLeaves:
      for (final (x, y, c) in [
        (40.0, 52.0, s.leafDark),
        (80.0, 50.0, s.leafDark),
        (52.0, 36.0, s.leafMid),
        (70.0, 40.0, s.leafMid),
        (60.0, 58.0, s.leafLight),
      ]) {
        canvas
          ..drawLine(
            Offset(60 + (x - 60) * .2, 80),
            Offset(x, y),
            _line(s.leafDark, 1.5),
          )
          ..drawCircle(Offset(x, y), 9, _fill(c))
          ..drawLine(Offset(x, y), Offset(x, y + 9), _line(_lighter(c, .3), 1));
      }
    case ArtTrait.plume:
      canvas
        ..drawLine(
          const Offset(60, 64),
          const Offset(60, 22),
          _line(s.leafDark, 3),
        )
        ..drawPath(
          Path()
            ..moveTo(60, 22)
            ..cubicTo(66, 14, 76, 18, 78, 32),
          _line(s.leafDark, 6),
        )
        ..drawPath(
          Path()
            ..moveTo(60, 26)
            ..cubicTo(54, 20, 46, 24, 44, 36),
          _line(_lighter(s.leafDark, .15), 5),
        );
    case ArtTrait.feathery:
      _lacySide(canvas, s, top: 22);
      _rootShoulder(canvas, s.rootColor ?? const Color(0xFFE67E22));
    case ArtTrait.redStems:
      final stalk = _line(s.rootColor!, 1.6);
      for (final a in const [-125.0, -55.0, -100.0, -80.0]) {
        final d = Offset(math.cos(_rad(a)), math.sin(_rad(a)));
        canvas.drawLine(
          const Offset(60, 64),
          const Offset(60, 64) + d * 30,
          stalk,
        );
      }
    case ArtTrait.tubers:
      for (final (x, y, a, c) in [
        (60.0, 70.0, -130.0, s.leafDark),
        (60.0, 70.0, -50.0, s.leafDark),
        (60.0, 56.0, -150.0, s.leafMid),
        (60.0, 56.0, -30.0, s.leafMid),
        (60.0, 44.0, -110.0, s.leafDark),
        (60.0, 44.0, -70.0, s.leafMid),
      ]) {
        _leaf(canvas, Offset(x, y), _rad(a), 22, 9, c);
      }
      canvas.drawLine(
        const Offset(60, 80),
        const Offset(60, 36),
        _line(s.leafDark, 2.5),
      );
      for (final o in const [Offset(50, 30), Offset(68, 28)]) {
        _petals(canvas, o, 5, 5, 3, const Color(0xFFF2EEF6));
        canvas.drawCircle(o, 1.2, _fill(const Color(0xFFF2D24B)));
      }
      for (final x in const [44.0, 76.0]) {
        canvas.drawOval(
          Rect.fromCenter(center: Offset(x, 78), width: 11, height: 8),
          _fill(s.rootColor!),
        );
      }

    // --- Small leaves ---------------------------------------------------
    case ArtTrait.spike:
      final c = s.accent ?? const Color(0xFFF4F1E6);
      for (final x in const [46.0, 60.0, 74.0]) {
        for (var i = 0; i < 4; i++) {
          canvas.drawCircle(Offset(x, 28.0 - i * 4), 2, _fill(c));
        }
      }
    case ArtTrait.lacy:
      _lacySide(canvas, s, top: 26);
    case ArtTrait.trifoliate:
      final stem = _line(s.leafDark, 1.5);
      for (final dx in const [-16.0, -5.0, 6.0, 16.0]) {
        canvas.drawLine(const Offset(60, 80), Offset(60 + dx, 34), stem);
        for (var i = 0; i < 3; i++) {
          final y = 66.0 - i * 13;
          final x = 60 + dx * (80 - y) / 46;
          for (var j = 0; j < 3; j++) {
            final a = _rad(-90 + (j - 1) * 50.0);
            canvas.drawCircle(
              Offset(x, y) + Offset(math.cos(a), math.sin(a)) * 3.5,
              3,
              _fill(j == 1 ? s.leafMid : s.leafDark),
            );
          }
        }
      }
    case ArtTrait.pinnate || ArtTrait.pinnateNarrow:
      final narrow = s.trait == ArtTrait.pinnateNarrow;
      canvas.drawLine(
        const Offset(60, 80),
        const Offset(60, 34),
        _line(const Color(0xFF6B5340), 3.5),
      );
      for (final (x, y, a) in const [
        (60.0, 50.0, -160.0),
        (60.0, 46.0, -20.0),
        (60.0, 36.0, -130.0),
        (60.0, 34.0, -50.0),
        (60.0, 34.0, -90.0),
      ]) {
        _at(canvas, Offset(x, y), _rad(a), () {
          _pinnateLeaf(
            canvas,
            30,
            narrow ? 9 : 7,
            narrow ? 2.2 : 3.2,
            s.leafDark,
            s.leafMid,
            s.leafDark,
          );
        });
      }
    case ArtTrait.glossyPinnate:
      for (final (dx, top) in const [
        (-14.0, 26.0),
        (0.0, 14.0),
        (14.0, 24.0),
      ]) {
        final from = Offset(60 + dx * .3, 80);
        final to = Offset(60 + dx, top);
        canvas.drawLine(from, to, _line(s.leafDark, 2.5));
        for (var i = 0; i < 4; i++) {
          final p = Offset.lerp(from, to, .3 + i * .2)!;
          _leaf(canvas, p, _rad(200), 10, 5, s.leafMid);
          _leaf(canvas, p, _rad(-20), 10, 5, s.leafDark);
        }
      }
    case ArtTrait.bipinnate:
      canvas.drawLine(
        const Offset(60, 80),
        const Offset(60, 30),
        _line(const Color(0xFF8A7560), 3),
      );
      final rnd = math.Random(3);
      for (var i = 0; i < 60; i++) {
        canvas.drawCircle(
          Offset(36 + rnd.nextDouble() * 48, 14 + rnd.nextDouble() * 26),
          2,
          _fill([s.leafDark, s.leafMid, s.leafLight][i % 3]),
        );
      }
      final pod = _line(s.accent ?? const Color(0xFF5E8A3A), 2.4);
      canvas
        ..drawLine(const Offset(50, 36), const Offset(46, 66), pod)
        ..drawLine(const Offset(70, 36), const Offset(75, 62), pod);

    // --- Blades ---------------------------------------------------------
    case ArtTrait.tubular || ArtTrait.bulb:
      for (final (dx, top, c) in [
        (-16.0, 18.0, s.leafDark),
        (-6.0, 10.0, s.leafMid),
        (4.0, 8.0, s.leafDark),
        (14.0, 16.0, s.leafMid),
      ]) {
        canvas.drawPath(
          Path()
            ..moveTo(60 + dx * .3, 78)
            ..quadraticBezierTo(60 + dx * .6, 44, 60 + dx, top),
          _line(c, 5),
        );
      }
      final bulb = s.trait == ArtTrait.bulb;
      canvas.drawOval(
        Rect.fromCenter(
          center: const Offset(60, 74),
          width: bulb ? 22 : 12,
          height: bulb ? 16 : 10,
        ),
        _fill(s.rootColor ?? const Color(0xFFF2EEE2)),
      );
    case ArtTrait.flatBlade:
      for (final (a, l, c) in [
        (-135.0, 40.0, s.leafDark),
        (-45.0, 40.0, s.leafDark),
        (-110.0, 52.0, s.leafMid),
        (-70.0, 52.0, s.leafMid),
        (-90.0, 58.0, s.leafLight),
      ]) {
        _leaf(canvas, const Offset(60, 76), _rad(a), l, 4.5, c);
      }
      canvas.drawOval(
        Rect.fromCenter(center: const Offset(60, 75), width: 16, height: 12),
        _fill(const Color(0xFFF2EEE2)),
      );
    case ArtTrait.broadBlade:
      for (final (x0, x1, top) in const [
        (54.0, 44.0, 18.0),
        (64.0, 74.0, 14.0),
      ]) {
        final from = Offset(x0, 80);
        final to = Offset(x1, top);
        canvas.drawLine(from, to, _line(s.leafDark, 2.5));
        for (var i = 0; i < 4; i++) {
          final p = Offset.lerp(from, to, .25 + i * .22)!;
          _leaf(
            canvas,
            p,
            _rad(i.isEven ? 200 : -20),
            20,
            5,
            i.isEven ? s.leafMid : s.leafLight,
          );
        }
      }
    case ArtTrait.wideBlade:
      for (final (a, l, c) in [
        (-140.0, 40.0, s.leafDark),
        (-40.0, 40.0, s.leafDark),
        (-110.0, 52.0, s.leafMid),
        (-70.0, 52.0, s.leafMid),
      ]) {
        _leaf(canvas, const Offset(60, 76), _rad(a), l, 13, c);
        _at(canvas, const Offset(60, 76), _rad(a), () {
          canvas.drawLine(
            const Offset(6, 0),
            Offset(l - 6, 0),
            _line(s.leafLight, 1),
          );
        });
      }
    case ArtTrait.paddle:
      canvas.drawLine(
        const Offset(60, 80),
        const Offset(60, 40),
        _line(const Color(0xFF8BA65A), 8),
      );
      for (final (a, l, c) in [
        (-160.0, 40.0, s.leafDark),
        (-20.0, 40.0, s.leafDark),
        (-125.0, 46.0, s.leafMid),
        (-55.0, 46.0, s.leafMid),
        (-92.0, 36.0, s.leafLight),
      ]) {
        _leaf(canvas, const Offset(60, 42), _rad(a), l, 13, c);
        _at(canvas, const Offset(60, 42), _rad(a), () {
          canvas.drawLine(
            Offset.zero,
            Offset(l * .95, 0),
            _line(_lighter(c, .3), 1.2),
          );
        });
      }
    case ArtTrait.frond:
      for (final (dx, ex, ey) in const [
        (-4.0, 26.0, 24.0),
        (0.0, 58.0, 8.0),
        (4.0, 94.0, 22.0),
      ]) {
        final from = Offset(60 + dx, 80);
        final ctrl = Offset(60 + dx, 30);
        final end = Offset(ex, ey);
        canvas.drawPath(
          Path()
            ..moveTo(from.dx, from.dy)
            ..quadraticBezierTo(ctrl.dx, ctrl.dy, end.dx, end.dy),
          _line(s.leafLight, 2),
        );
        for (var i = 1; i < 8; i++) {
          final t = .35 + i * .08;
          final p = Offset(
            (1 - t) * (1 - t) * from.dx +
                2 * (1 - t) * t * ctrl.dx +
                t * t * end.dx,
            (1 - t) * (1 - t) * from.dy +
                2 * (1 - t) * t * ctrl.dy +
                t * t * end.dy,
          );
          final leaflet = _line(i.isEven ? s.leafMid : s.leafDark, 1.6);
          canvas
            ..drawLine(p, p + const Offset(-6, 6), leaflet)
            ..drawLine(p, p + const Offset(6, 6), leaflet);
        }
      }
    case ArtTrait.striped:
      for (final (ex, ey) in const [
        (22.0, 70.0),
        (36.0, 40.0),
        (60.0, 26.0),
        (84.0, 40.0),
        (98.0, 72.0),
      ]) {
        final path = Path()
          ..moveTo(60, 78)
          ..quadraticBezierTo((60 + ex) / 2, 28, ex, ey);
        canvas
          ..drawPath(path, _line(s.leafMid, 5))
          ..drawPath(path, _line(s.leafLight, 1.6));
      }
      canvas.drawLine(
        const Offset(98, 72),
        const Offset(102, 96),
        _line(s.leafMid, 1.2),
      );
      _petals(canvas, const Offset(102, 96), 5, 7, 2, s.leafMid);

    // --- Succulents -----------------------------------------------------
    case ArtTrait.swords:
      for (final (x, top, lean) in const [
        (48.0, 26.0, -6.0),
        (56.0, 10.0, -2.0),
        (64.0, 8.0, 2.0),
        (72.0, 22.0, 6.0),
      ]) {
        final path = Path()
          ..moveTo(x - 5, 80)
          ..quadraticBezierTo(x - 6 + lean, (80 + top) / 2, x + lean, top)
          ..quadraticBezierTo(x + 6 + lean, (80 + top) / 2, x + 5, 80)
          ..close();
        canvas
          ..drawPath(path, _fill(s.leafLight))
          ..save()
          ..clipPath(path)
          ..drawRect(
            Rect.fromLTRB(x - 3.5 + lean * .3, top, x + 3.5 + lean * .3, 80),
            _fill(s.leafDark),
          );
        final band = _line(s.leafMid, 1.2);
        for (var y = top + 10; y < 78; y += 9) {
          canvas.drawLine(Offset(x - 5, y), Offset(x + 5, y + 2), band);
        }
        canvas.restore();
      }
    case ArtTrait.coins:
      final trunk = _line(const Color(0xFF7A6A4E), 4);
      canvas
        ..drawLine(const Offset(60, 80), const Offset(60, 50), trunk)
        ..drawLine(
          const Offset(60, 56),
          const Offset(44, 40),
          trunk..strokeWidth = 3,
        )
        ..drawLine(const Offset(60, 52), const Offset(76, 36), trunk);
      for (final (x, y, a) in const [
        (40.0, 36.0, -30.0),
        (48.0, 32.0, -70.0),
        (44.0, 46.0, 200.0),
        (78.0, 30.0, -110.0),
        (84.0, 38.0, -20.0),
        (72.0, 30.0, -80.0),
        (60.0, 44.0, -90.0),
        (66.0, 50.0, -10.0),
        (54.0, 50.0, 190.0),
      ]) {
        _at(canvas, Offset(x, y), _rad(a), () {
          _ellipse(canvas, 13, 9, const Color(0xFFB5523F));
          _ellipse(canvas, 12, 8, s.leafMid);
        });
      }
    case ArtTrait.cactus:
      for (final (dx, ex, ey) in const [
        (-4.0, 30.0, 30.0),
        (0.0, 62.0, 12.0),
        (4.0, 92.0, 34.0),
      ]) {
        final path = Path()
          ..moveTo(60 + dx, 80)
          ..quadraticBezierTo(60 + dx, 40, ex, ey);
        canvas
          ..drawPath(path, _line(s.leafMid, 9))
          ..drawPath(path, _line(s.leafDark, 3));
      }
      canvas.drawOval(
        Rect.fromCenter(center: const Offset(62, 10), width: 12, height: 14),
        _fill(s.leafLight),
      );
      _petals(canvas, const Offset(62, 10), 4, 7, 3, _lighter(s.leafMid, .1));

    // --- Big leaves and vines -------------------------------------------
    case ArtTrait.uprightPod:
      final pod = Paint()..color = const Color(0xFF6E9E3A);
      for (final (x, y) in const [(66.0, 48.0), (54.0, 36.0)]) {
        canvas.drawPath(
          Path()
            ..moveTo(x - 3, y + 2)
            ..lineTo(x + 3, y + 2)
            ..lineTo(x + 1, y - 16)
            ..close(),
          pod,
        );
      }
      _bloom(
        canvas,
        const Offset(70, 26),
        6,
        PlantArtSpec(
          PlantForm.flowering,
          accent: accent,
          trait: ArtTrait.trumpet,
        ),
      );
    case ArtTrait.gourdBottle ||
        ArtTrait.gourdWarty ||
        ArtTrait.gourdRidged ||
        ArtTrait.gourdLong ||
        ArtTrait.gourdCucumber ||
        ArtTrait.gourdSnake ||
        ArtTrait.gourdAsh ||
        ArtTrait.gourdIvy:
      final curl = _line(s.leafLight, 1.2);
      canvas.drawArc(
        Rect.fromCircle(center: const Offset(44, 24), radius: 4),
        0,
        5,
        false,
        curl,
      );
      canvas.drawLine(
        const Offset(62, 40),
        const Offset(74, 42),
        _line(s.leafDark, 1.5),
      );
      _at(canvas, const Offset(74, 42), 0, () => _gourd(canvas, s.trait, 34));
    case ArtTrait.gourdRound:
      _pumpkin(canvas, const Offset(80, 70), 9);
    case ArtTrait.figFruit:
      for (final (x, y) in const [(70.0, 46.0), (52.0, 30.0)]) {
        canvas
          ..drawCircle(Offset(x, y + 3), 3.5, _fill(accent))
          ..drawCircle(Offset(x, y + 9), 6, _fill(accent));
      }
    case ArtTrait.tree:
      canvas.drawLine(
        const Offset(60, 80),
        const Offset(60, 30),
        _line(const Color(0xFF9A8F6E), 6),
      );
      for (final (a, c) in [
        (-160.0, s.leafDark),
        (-20.0, s.leafDark),
        (-125.0, s.leafMid),
        (-55.0, s.leafMid),
        (-90.0, s.leafLight),
      ]) {
        final d = Offset(math.cos(_rad(a)), math.sin(_rad(a)));
        final tip = const Offset(60, 30) + d * 26;
        canvas.drawLine(const Offset(60, 30), tip, _line(s.leafLight, 1.5));
        for (var j = -2; j <= 2; j++) {
          _leaf(canvas, tip, _rad(a + j * 30), 12, 4.5, c);
        }
      }
      for (final (x, y) in const [(55.0, 40.0), (65.0, 40.0), (60.0, 46.0)]) {
        canvas.drawOval(
          Rect.fromCenter(center: Offset(x, y), width: 8, height: 11),
          _fill(accent),
        );
      }
    case ArtTrait.bigLeaf:
      canvas.drawLine(
        const Offset(60, 80),
        const Offset(60, 16),
        _line(s.leafDark, 3),
      );
      for (final (y, a) in const [
        (66.0, 200.0),
        (56.0, -20.0),
        (42.0, 205.0),
        (32.0, -25.0),
      ]) {
        _leaf(canvas, Offset(60, y), _rad(a), 30, 15, s.leafMid);
        _at(canvas, Offset(60, y), _rad(a), () {
          canvas.drawLine(
            const Offset(3, 0),
            const Offset(27, 0),
            _line(s.leafLight, 1),
          );
        });
      }
      _leaf(
        canvas,
        const Offset(60, 18),
        _rad(-90),
        10,
        3,
        const Color(0xFFA33A3A),
      );
    case ArtTrait.arrowhead:
      final vine = _line(s.leafDark, 2);
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
      for (final (x, y, a) in const [
        (28.0, 96.0, 100.0),
        (92.0, 96.0, 80.0),
        (46.0, 56.0, -120.0),
        (74.0, 54.0, -60.0),
        (60.0, 40.0, -90.0),
      ]) {
        _arrow(canvas, Offset(x, y), _rad(a), 22, s.leafMid, s.leafLight);
      }
      _arrow(
        canvas,
        const Offset(60, 64),
        _rad(-90),
        18,
        s.leafLight,
        s.leafMid,
      );
    case ArtTrait.tendril || ArtTrait.longPods || ArtTrait.vineFlowers:
      final flower = s.accent ?? const Color(0xFFF4F1F6);
      // A cane for the vine to climb.
      canvas.drawLine(
        const Offset(60, 82),
        const Offset(60, 6),
        _line(const Color(0xFFB59A6A), 2),
      );
      if (s.trait == ArtTrait.tendril) {
        final curl = _line(s.leafLight, 1.2);
        for (final o in const [Offset(54, 24), Offset(68, 36)]) {
          canvas.drawArc(
            Rect.fromCircle(center: o, radius: 4),
            0,
            5,
            false,
            curl,
          );
        }
      }
      if (s.trait != ArtTrait.vineFlowers) {
        final long = s.trait == ArtTrait.longPods;
        final pod = _line(const Color(0xFF7DB34A), long ? 2.2 : 4);
        canvas
          ..drawLine(const Offset(40, 56), Offset(38, long ? 84 : 70), pod)
          ..drawLine(const Offset(80, 50), Offset(83, long ? 80 : 64), pod);
      }
      for (final o in const [Offset(64, 22), Offset(44, 40), Offset(78, 36)]) {
        _peaFlower(canvas, o, 4.5, flower);
      }
    // --- Second wave (ADR-035) ---------------------------------------------
    case ArtTrait.knob:
      canvas
        ..drawCircle(
          const Offset(60, 70),
          12,
          _fill(_lighter(s.leafLight, .25)),
        )
        ..drawCircle(
          const Offset(56, 66),
          3.5,
          _fill(Colors.white.withValues(alpha: .3)),
        );
      final stalk = _line(s.leafLight, 1.4);
      for (final o in const [
        Offset(48, 66),
        Offset(72, 66),
        Offset(54, 60),
        Offset(66, 60),
      ]) {
        canvas.drawLine(o, o + Offset((o.dx - 60) * .5, -12), stalk);
      }
    case ArtTrait.corn:
      canvas.drawLine(
        const Offset(60, 82),
        const Offset(60, 10),
        _line(s.leafLight, 4),
      );
      for (final (y, a) in const [
        (70.0, -160.0),
        (60.0, -20.0),
        (48.0, -150.0),
        (38.0, -30.0),
        (28.0, -140.0),
      ]) {
        _leaf(canvas, Offset(60, y), _rad(a), 30, 5, s.leafMid);
      }
      canvas
        ..drawOval(
          Rect.fromCenter(center: const Offset(67, 48), width: 8, height: 18),
          _fill(const Color(0xFFF2D24B)),
        )
        ..drawPath(
          Path()
            ..moveTo(62, 58)
            ..quadraticBezierTo(60, 46, 66, 38)
            ..quadraticBezierTo(64, 50, 70, 58)
            ..close(),
          _fill(s.leafLight),
        )
        ..drawLine(
          const Offset(67, 39),
          const Offset(70, 33),
          _line(const Color(0xFFB5763A), 1.4),
        );
      _petals(canvas, const Offset(60, 10), 5, 8, 1.6, const Color(0xFFD9B95A));
    case ArtTrait.elephantEar:
      for (final (x, y, c) in [
        (36.0, 40.0, s.leafDark),
        (84.0, 38.0, s.leafDark),
        (52.0, 26.0, s.leafMid),
        (70.0, 24.0, s.leafMid),
      ]) {
        canvas.drawLine(
          Offset(60 + (x - 60) * .15, 80),
          Offset(x, y - 4),
          _line(s.leafLight, 2),
        );
        _at(canvas, Offset(x, y), math.pi, () {
          _heart(canvas, Offset.zero, 24, c);
        });
      }
    case ArtTrait.woodyHerb:
      final wood = _line(const Color(0xFF7A6A4E), 1.8);
      for (final dx in const [-18.0, -8.0, 2.0, 12.0, 20.0]) {
        final end = Offset(60 + dx, 18 + dx.abs() * .5);
        canvas.drawLine(Offset(60 + dx * .3, 80), end, wood);
        final needle = _line(dx < 0 ? s.leafMid : s.leafDark, 1.6);
        for (var i = 0; i < 7; i++) {
          final p = Offset.lerp(Offset(60 + dx * .3, 76), end, i / 7)!;
          canvas
            ..drawLine(p, p + const Offset(-3.5, -2.5), needle)
            ..drawLine(p, p + const Offset(3.5, -2.5), needle);
        }
        if (s.accent case final c?) canvas.drawCircle(end, 2, _fill(c));
      }
    case ArtTrait.caneHearts:
      canvas.drawLine(
        const Offset(60, 82),
        const Offset(60, 4),
        _line(const Color(0xFFB59A6A), 2.5),
      );
      for (final (y, dx) in const [
        (66.0, -12.0),
        (52.0, 12.0),
        (38.0, -12.0),
        (24.0, 12.0),
        (12.0, -8.0),
      ]) {
        _at(canvas, Offset(60 + dx, y), dx < 0 ? -0.5 : 0.5, () {
          _heart(canvas, Offset.zero, 20, dx < 0 ? s.leafMid : s.leafDark);
        });
      }
    case ArtTrait.creeping:
      final stem = _line(s.leafDark, 1.2);
      for (final (ex, ey) in const [
        (20.0, 100.0),
        (100.0, 98.0),
        (40.0, 66.0),
        (80.0, 64.0),
      ]) {
        final path = Path()
          ..moveTo(60, 78)
          ..quadraticBezierTo((60 + ex) / 2, math.min(ey, 70) - 6, ex, ey);
        canvas.drawPath(path, stem);
        for (final metric in path.computeMetrics()) {
          for (var d = 6.0; d < metric.length; d += 6) {
            final t = metric.getTangentForOffset(d)!;
            canvas
              ..drawOval(
                Rect.fromCenter(
                  center: t.position + const Offset(0, -2.5),
                  width: 5,
                  height: 4,
                ),
                _fill(s.leafMid),
              )
              ..drawOval(
                Rect.fromCenter(
                  center: t.position + const Offset(0, 2.5),
                  width: 5,
                  height: 4,
                ),
                _fill(s.leafLight),
              );
          }
        }
      }
      for (final o in const [Offset(46, 68), Offset(76, 66), Offset(28, 92)]) {
        _petals(canvas, o, 5, 3, 2, s.accent ?? const Color(0xFFF7F5EE));
      }
    case ArtTrait.scalloped:
      final stem = _line(s.leafDark, 2);
      for (final dx in const [-12.0, 0.0, 12.0]) {
        canvas.drawLine(const Offset(60, 80), Offset(60 + dx, 26), stem);
        for (var i = 0; i < 3; i++) {
          final y = 66.0 - i * 16;
          final x = 60 + dx * (80 - y) / 54;
          _scallopLeaf(canvas, Offset(x - 8, y), 7, s, i.isEven);
          _scallopLeaf(canvas, Offset(x + 8, y), 7, s, i.isOdd);
        }
      }
    case ArtTrait.sunflower:
      canvas.drawLine(
        const Offset(60, 82),
        const Offset(60, 22),
        _line(s.leafDark, 3),
      );
      for (final (y, a) in const [
        (68.0, 200.0),
        (58.0, -20.0),
        (44.0, 205.0),
        (34.0, -25.0),
      ]) {
        _leaf(canvas, Offset(60, y), _rad(a), 22, 11, s.leafMid);
      }
      final c = s.accent ?? const Color(0xFFF2C230);
      _petals(canvas, const Offset(60, 18), 16, 14, 4, c);
      canvas.drawCircle(
        const Offset(60, 18),
        7.5,
        _fill(const Color(0xFF5A3A1E)),
      );
    case ArtTrait.fanPalm:
      for (final (dx, ex, ey) in const [
        (-4.0, 34.0, 26.0),
        (0.0, 60.0, 10.0),
        (4.0, 86.0, 28.0),
      ]) {
        final tip = Offset(ex, ey);
        canvas.drawLine(
          Offset(60 + dx, 80),
          tip,
          _line(const Color(0xFF7A6A4E), 2),
        );
        for (var j = -3; j <= 3; j++) {
          _leaf(
            canvas,
            tip,
            _rad(-90 + j * 22.0),
            16,
            2.6,
            j.isEven ? s.leafMid : s.leafDark,
          );
        }
      }
    case ArtTrait.lantern:
      for (final (x, y) in const [(46.0, 52.0), (76.0, 44.0), (58.0, 66.0)]) {
        canvas
          ..drawPath(
            Path()
              ..moveTo(x, y)
              ..quadraticBezierTo(x + 7, y + 6, x, y + 14)
              ..quadraticBezierTo(x - 7, y + 6, x, y)
              ..close(),
            _fill(accent),
          )
          ..drawLine(
            Offset(x, y + 1),
            Offset(x, y + 13),
            _line(_darker(accent, .2), .8),
          );
      }
      canvas.drawCircle(
        const Offset(58, 74),
        3,
        _fill(const Color(0xFFF29A1A)),
      );
    case ArtTrait.grapeBunch:
      final cane = _line(const Color(0xFF8A6A4A), 2.5);
      canvas
        ..drawLine(const Offset(60, 82), const Offset(60, 20), cane)
        ..drawLine(const Offset(30, 20), const Offset(92, 20), cane);
      for (final o in const [
        Offset(36, 18),
        Offset(56, 14),
        Offset(78, 16),
        Offset(46, 30),
        Offset(70, 30),
      ]) {
        _grapeLeaf(canvas, o, 20, o.dy < 20 ? s.leafMid : s.leafDark);
      }
      for (final o in const [Offset(44, 38), Offset(74, 36)]) {
        _bunch(canvas, o, 2.6, accent);
      }
    case ArtTrait.pineapple:
      for (final a in const [
        -170.0,
        -150.0,
        -130.0,
        -110.0,
        -70.0,
        -50.0,
        -30.0,
        -10.0,
      ]) {
        _leaf(
          canvas,
          const Offset(60, 78),
          _rad(a),
          36,
          3.5,
          a.abs() > 90 ? s.leafMid : s.leafDark,
        );
      }
      canvas.drawOval(
        Rect.fromCenter(center: const Offset(60, 58), width: 18, height: 24),
        _fill(accent),
      );
      final hatch = _line(_darker(accent, .25), .8);
      for (var i = -2; i <= 2; i++) {
        canvas
          ..drawLine(Offset(52 + i * 4.0, 48), Offset(60 + i * 4.0, 68), hatch)
          ..drawLine(Offset(68 + i * 4.0, 48), Offset(60 + i * 4.0, 68), hatch);
      }
      _petals(canvas, const Offset(60, 46), 6, 10, 2.4, s.leafDark);
    case _:
      break;
  }
}

/// Finely divided leaves on thin stems.
void _lacySide(Canvas canvas, PlantArtSpec s, {required double top}) {
  final stem = _line(s.leafDark, 1.2);
  for (final dx in const [-22.0, -10.0, 0.0, 10.0, 22.0]) {
    final end = Offset(60 + dx, top + dx.abs() * .4);
    canvas.drawLine(const Offset(60, 78), end, stem);
    for (var i = 0; i < 4; i++) {
      final p = Offset.lerp(const Offset(60, 78), end, .45 + i * .18)!;
      for (final o in const [Offset(-3, -1), Offset(3, -1), Offset(0, -3.5)]) {
        canvas.drawCircle(
          p + o,
          2.2,
          _fill(i.isEven ? s.leafMid : s.leafLight),
        );
      }
    }
  }
}

void _rootShoulder(Canvas canvas, Color color) => canvas.drawPath(
  Path()
    ..moveTo(52, 78)
    ..cubicTo(52, 66, 68, 66, 68, 78)
    ..close(),
  _fill(color),
);

/// A round leaf with a scalloped edge; the spec's accent, when set,
/// colours the middle (coleus).
void _scallopLeaf(
  Canvas canvas,
  Offset c,
  double r,
  PlantArtSpec s,
  bool alt,
) {
  final edge = alt ? s.leafMid : s.leafDark;
  for (var i = 0; i < 10; i++) {
    final a = _rad(i * 36.0);
    canvas.drawCircle(
      c + Offset(math.cos(a), math.sin(a)) * r * .82,
      r * .3,
      _fill(edge),
    );
  }
  canvas
    ..drawCircle(c, r * .85, _fill(edge))
    ..drawCircle(c, r * .5, _fill(s.accent ?? s.leafLight));
}

/// A three-lobed vine leaf pointing up.
void _grapeLeaf(Canvas canvas, Offset c, double size, Color color) {
  for (final a in const [-90.0, -150.0, -30.0]) {
    _leaf(canvas, c, _rad(a), size * (a == -90 ? .55 : .45), size * .28, color);
  }
}

/// A hanging bunch of round berries, [r] each.
void _bunch(Canvas canvas, Offset top, double r, Color color) {
  for (var row = 0; row < 4; row++) {
    final n = 4 - row;
    for (var i = 0; i < n; i++) {
      canvas.drawCircle(
        top + Offset((i - (n - 1) / 2) * r * 1.8, row * r * 1.6),
        r,
        _fill(i.isEven ? color : _darker(color, .12)),
      );
    }
  }
}
