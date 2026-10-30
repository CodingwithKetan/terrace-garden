import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/presentation/terrace_artist.dart';
import 'package:terrace_garden/features/plant_catalog/plant_catalog.dart';

/// What a container on the plan is flagged with.
enum PlanBadge {
  none,

  /// A care task is due (a water-drop pin).
  due,

  /// Today's tasks are done (a tick).
  done,
}

/// How a container suits a plant being added (the add-plant picker).
enum PlanFit { none, fits, fitsShared, unsuitable }

/// One element on the plan with what to draw on and around it.
@immutable
final class PlanItem {
  const PlanItem({
    required this.element,
    this.plants = const [],
    this.tag,
    this.badge = PlanBadge.none,
    this.fit = PlanFit.none,
    this.semanticLabel,
  });

  final LayoutElement element;

  /// One drawing per planting (top view), in planting order.
  final List<PlantArtSpec> plants;

  /// The name tag under the container ("Tomato · A").
  final String? tag;
  final PlanBadge badge;
  final PlanFit fit;

  /// Announced by screen readers; defaults to [tag].
  final String? semanticLabel;
}

/// The Living Terrace plan: the user's own terrace drawn to scale from
/// above, with each container's plants, name tags and task pins
/// (docs/design/redesign-living-terrace). Containers are buttons when
/// [onTapItem] is set.
class TerracePlan extends StatelessWidget {
  const TerracePlan({
    required this.lengthCm,
    required this.widthCm,
    required this.items,
    this.onTapItem,
    this.selectedId,
    this.semanticLabel,
    this.dusk = false,
    super.key,
  });

  final double lengthCm;
  final double widthCm;
  final List<PlanItem> items;
  final ValueChanged<PlanItem>? onTapItem;

  /// The highlighted container in the add-plant picker.
  final String? selectedId;
  final String? semanticLabel;

  /// Dims the floor for the evening (dark theme) look.
  final bool dusk;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth;
        final maxH = constraints.hasBoundedHeight
            ? constraints.maxHeight
            : maxW * 1.1;
        final scale = math.min(maxW / lengthCm, maxH / widthCm);
        final size = Size(lengthCm * scale, widthCm * scale);
        final textScale = MediaQuery.textScalerOf(context);
        return Center(
          child: SizedBox.fromSize(
            size: size,
            child: Semantics(
              container: true,
              explicitChildNodes: true,
              label: semanticLabel,
              child: Stack(
                children: [
                  ExcludeSemantics(
                    child: CustomPaint(
                      size: size,
                      painter: TerracePlanPainter(
                        lengthCm: lengthCm,
                        widthCm: widthCm,
                        items: items,
                        selectedId: selectedId,
                        dusk: dusk,
                        textScaler: textScale,
                        tagStyle: Theme.of(context).textTheme.labelSmall!,
                      ),
                    ),
                  ),
                  for (final item in items)
                    if (item.element.kind.isContainer) _hitArea(item, scale),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _hitArea(PlanItem item, double scale) {
    final b = item.element.shape.bounds;
    // At least 48 dp, centred on the container.
    final w = math.max(48, b.width * scale).toDouble();
    final h = math.max(48, b.height * scale).toDouble();
    final cx = (b.left + b.width / 2) * scale;
    final cy = (b.top + b.height / 2) * scale;
    return Positioned(
      left: cx - w / 2,
      top: cy - h / 2,
      width: w,
      height: h,
      child: Semantics(
        container: true,
        button: onTapItem != null,
        selected: selectedId == item.element.id,
        label: item.semanticLabel ?? item.tag,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTapItem == null ? null : () => onTapItem!(item),
        ),
      ),
    );
  }
}

class TerracePlanPainter extends CustomPainter {
  TerracePlanPainter({
    required this.lengthCm,
    required this.widthCm,
    required this.items,
    required this.selectedId,
    required this.dusk,
    required this.textScaler,
    required this.tagStyle,
  });

  final double lengthCm;
  final double widthCm;
  final List<PlanItem> items;
  final String? selectedId;
  final bool dusk;
  final TextScaler textScaler;
  final TextStyle tagStyle;

  static const Color _leaf = TerraceArtist.leaf;
  static const Color _water = TerraceArtist.water;
  static const Color _ink = TerraceArtist.ink;
  static const _tagFill = Color(0xF0FBFAF7);
  static const _dim = Color(0xB8F2F0EA);
  static const _unsuitableText = Color(0xFF7A2E12);

  @override
  void paint(Canvas canvas, Size size) {
    final k = size.width / lengthCm;
    final rect = Offset.zero & size;

    canvas
      ..save()
      ..clipRRect(RRect.fromRectAndRadius(rect, const Radius.circular(20)));
    TerraceArtist.paintFloor(canvas, lengthCm, widthCm, k);
    // Parapet.
    final wall = math.max(8, math.min(size.width, size.height) * .04);
    canvas.drawRect(
      rect.deflate(wall / 2),
      Paint()
        ..color = TerraceArtist.parapet
        ..style = PaintingStyle.stroke
        ..strokeWidth = wall.toDouble(),
    );

    final byId = {for (final i in items) i.element.id: i};
    final doc = LayoutDocument(
      gardenId: '',
      length: lengthCm,
      width: widthCm,
      elements: [for (final i in items) i.element],
    );
    // Sun areas are planning marks for the designer, not shown on plans.
    for (final e in doc.drawOrder) {
      if (e.kind.role == ElementRole.zone) continue;
      TerraceArtist.paintElement(canvas, e, k, plants: byId[e.id]!.plants);
    }

    if (dusk) {
      canvas
        ..drawRect(rect, Paint()..color = const Color(0x850B1A12))
        ..drawRect(
          rect,
          Paint()
            ..shader = const RadialGradient(
              center: Alignment(.7, .8),
              radius: .9,
              colors: [Color(0x47F3C969), Color(0x00F3C969)],
            ).createShader(rect),
        );
    }

    // Overlays drawn above the dusk tint so they stay legible.
    for (final item in items.where((i) => i.element.kind.isContainer)) {
      _drawOverlay(canvas, item, k);
    }
    canvas.restore();
  }

  void _drawOverlay(Canvas canvas, PlanItem item, double k) {
    final b = item.element.shape.bounds;
    final box = Rect.fromLTRB(b.left * k, b.top * k, b.right * k, b.bottom * k);
    final round = item.element.kind.round;
    final selected = selectedId == item.element.id;

    switch (item.fit) {
      case PlanFit.unsuitable:
        _outline(canvas, box, round, Paint()..color = _dim);
      case PlanFit.fitsShared:
        _outline(
          canvas,
          box.inflate(5),
          round,
          Paint()
            ..color = _leaf
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.5,
          dashed: true,
        );
      case PlanFit.fits || PlanFit.none:
        break;
    }
    if (selected) {
      _outline(
        canvas,
        box.inflate(6),
        round,
        Paint()
          ..color = _leaf
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4,
      );
      _check(canvas, Offset(box.right + 2, box.top - 2), _leaf);
    }

    switch (item.badge) {
      case PlanBadge.due:
        final p = Offset(box.right - 4, box.top + 2);
        canvas
          ..drawCircle(p, 13, Paint()..color = _water.withValues(alpha: .22))
          ..drawCircle(p, 9.5, Paint()..color = Colors.white)
          ..drawCircle(p, 8, Paint()..color = _water);
        final drop = Path()
          ..moveTo(p.dx, p.dy - 4.5)
          ..cubicTo(
            p.dx - 2.6,
            p.dy - 1,
            p.dx - 3.4,
            p.dy + .6,
            p.dx - 3.4,
            p.dy + 1.6,
          )
          ..arcToPoint(
            Offset(p.dx + 3.4, p.dy + 1.6),
            radius: const Radius.circular(3.4),
            clockwise: false,
          )
          ..cubicTo(
            p.dx + 3.4,
            p.dy + .6,
            p.dx + 2.6,
            p.dy - 1,
            p.dx,
            p.dy - 4.5,
          )
          ..close();
        canvas.drawPath(drop, Paint()..color = Colors.white);
      case PlanBadge.done:
        _check(
          canvas,
          Offset(box.right - 4, box.top + 2),
          const Color(0xFF3E8E46),
        );
      case PlanBadge.none:
        break;
    }

    final tag = item.tag;
    if (tag != null) {
      final unsuitable = item.fit == PlanFit.unsuitable;
      final strong = item.fit == PlanFit.fits && selected;
      final tp = TextPainter(
        text: TextSpan(
          text: tag,
          style: tagStyle.copyWith(
            color: strong
                ? Colors.white
                : unsuitable
                ? _unsuitableText
                : _ink,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
        textScaler: textScaler.clamp(maxScaleFactor: 1.3),
        maxLines: 1,
        ellipsis: '…',
      )..layout(maxWidth: math.max(76, box.width + 48));
      final pill = Rect.fromCenter(
        center: Offset(box.center.dx, box.bottom + tp.height / 2 + 7),
        width: tp.width + 16,
        height: tp.height + 6,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(pill, Radius.circular(pill.height / 2)),
        Paint()..color = strong ? _leaf : _tagFill,
      );
      tp.paint(canvas, Offset(pill.left + 8, pill.top + 3));
    }
  }

  void _outline(
    Canvas canvas,
    Rect box,
    bool round,
    Paint paint, {
    bool dashed = false,
  }) {
    final path = round
        ? (Path()..addOval(box))
        : (Path()..addRRect(
            RRect.fromRectAndRadius(box, const Radius.circular(14)),
          ));
    if (!dashed) {
      canvas.drawPath(path, paint);
      return;
    }
    for (final metric in path.computeMetrics()) {
      for (var d = 0.0; d < metric.length; d += 11) {
        canvas.drawPath(metric.extractPath(d, d + 6), paint);
      }
    }
  }

  void _check(Canvas canvas, Offset at, Color color) {
    canvas
      ..drawCircle(at, 11.5, Paint()..color = Colors.white)
      ..drawCircle(at, 10, Paint()..color = color)
      ..drawPath(
        Path()
          ..moveTo(at.dx - 4.5, at.dy + .5)
          ..lineTo(at.dx - 1.2, at.dy + 3.8)
          ..lineTo(at.dx + 5, at.dy - 3),
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.4
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
  }

  @override
  bool shouldRepaint(TerracePlanPainter oldDelegate) =>
      oldDelegate.items != items ||
      oldDelegate.selectedId != selectedId ||
      oldDelegate.dusk != dusk ||
      oldDelegate.lengthCm != lengthCm ||
      oldDelegate.widthCm != widthCm;
}
