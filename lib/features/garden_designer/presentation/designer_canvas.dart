import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:terrace_garden/app/theme/canvas_colors.dart';
import 'package:terrace_garden/core/units/measurement_formatter.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/garden_designer/application/layout_editor_controller.dart';
import 'package:terrace_garden/features/garden_designer/domain/canvas_transform.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/presentation/garden_canvas_painter.dart';
import 'package:terrace_garden/features/garden_designer/presentation/selection_handles.dart';
import 'package:terrace_garden/features/plant_catalog/plant_catalog.dart';
import 'package:terrace_garden/l10n/l10n.dart';

enum _Mode { none, move, resize, rotate, pan, zoom }

/// The interactive garden canvas (DSN-01). One finger moves, resizes or
/// rotates the selected object, or pans the view; two fingers zoom.
/// Tapping selects immediately (no double-tap gesture, which would delay
/// every tap by ~300 ms; "Fit to screen" is a toolbar button instead).
class DesignerCanvas extends StatefulWidget {
  const DesignerCanvas({
    required this.controller,
    required this.unitSystem,
    this.fitRequest,
    this.style = CanvasStyle.garden,
    this.plants = const {},
    this.selectionToolbar,
    super.key,
  });

  final LayoutEditorController controller;
  final UnitSystem unitSystem;

  /// Each notification re-fits the garden to the viewport.
  final Listenable? fitRequest;
  final CanvasStyle style;

  /// Plant drawings by container id.
  final Map<String, List<PlantArtSpec>> plants;

  /// Floats above the selected object (or below it near the top edge);
  /// hidden while a gesture is in progress.
  final Widget Function(LayoutElement selected)? selectionToolbar;

  @override
  State<DesignerCanvas> createState() => DesignerCanvasState();
}

class DesignerCanvasState extends State<DesignerCanvas> {
  CanvasTransform? _transform;
  Size? _viewport;
  _Mode _mode = _Mode.none;
  Vec2 _gestureStartFocal = Vec2.zero;
  Vec2? _downPosition;
  CanvasTransform? _gestureStartTransform;

  /// Current world → screen mapping (exposed for adding objects at the
  /// centre of the visible area).
  CanvasTransform? get transform => _transform;

  /// World point at the centre of the viewport.
  Vec2? get viewportCenterWorld {
    final t = _transform;
    final v = _viewport;
    if (t == null || v == null) return null;
    return t.screenToWorld(Vec2(v.width / 2, v.height / 2));
  }

  /// World point under the [global] screen position, or null when it is
  /// outside the canvas (e.g. an object dropped back on the tray).
  Vec2? worldAtGlobal(Offset global) {
    final t = _transform;
    final box = context.findRenderObject() as RenderBox?;
    if (t == null || box == null || !box.hasSize) return null;
    final local = box.globalToLocal(global);
    if (!(Offset.zero & box.size).contains(local)) return null;
    return t.screenToWorld(_v(local));
  }

  @override
  void initState() {
    super.initState();
    widget.fitRequest?.addListener(_fit);
  }

  @override
  void didUpdateWidget(DesignerCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.fitRequest != widget.fitRequest) {
      oldWidget.fitRequest?.removeListener(_fit);
      widget.fitRequest?.addListener(_fit);
    }
  }

  @override
  void dispose() {
    widget.fitRequest?.removeListener(_fit);
    super.dispose();
  }

  void _fit() {
    final v = _viewport;
    if (v == null) return;
    setState(() => _transform = _fitted(v));
  }

  CanvasTransform _fitted(Size viewport) {
    final doc = widget.controller.document;
    return CanvasTransform.fit(
      gardenLength: doc.length,
      gardenWidth: doc.width,
      viewportWidth: viewport.width,
      viewportHeight: viewport.height,
      padding: 32,
    );
  }

  double get _minScale => _fitted(_viewport!).pxPerCm * 0.5;
  double get _maxScale => 12;

  static Vec2 _v(Offset o) => Vec2(o.dx, o.dy);

  void _onTapUp(TapUpDetails details) {
    final t = _transform;
    if (t == null) return;
    final world = t.screenToWorld(_v(details.localPosition));
    final hit = widget.controller.hitTest(
      world,
      tolerance: t.screenToWorldDistance(16),
    );
    if (hit != null) unawaited(HapticFeedback.selectionClick());
    widget.controller.select(hit?.id);
  }

  void _onScaleStart(ScaleStartDetails details) {
    final t = _transform;
    if (t == null) return;
    final c = widget.controller;
    // The scale gesture only starts after the finger has moved past the
    // slop (~36 px), so its focal point is not where the finger touched down.
    // Hit-test the touch-down point instead, or small objects would be
    // missed and the canvas would pan.
    final down = _downPosition;
    final screen = (details.pointerCount == 1 && down != null)
        ? down
        : _v(details.localFocalPoint);
    _gestureStartFocal = screen;
    _gestureStartTransform = t;

    if (details.pointerCount > 1) {
      _mode = _Mode.zoom;
      _gestureStartFocal = _v(details.localFocalPoint);
      return;
    }
    final selected = c.selected;
    if (selected != null) {
      final handles = SelectionHandles.of(selected, t);
      if (handles.hitsRotate(screen)) {
        _mode = _Mode.rotate;
        c.beginGesture();
        return;
      }
      // On small objects the handles' touch areas cover the body; a touch
      // inside the body that is nearer the centre than any handle moves it.
      final centerPx = t.worldToScreen(selected.center);
      final insideBody = selected.shape.contains(t.screenToWorld(screen));
      final prefersHandle =
          !insideBody ||
          handles.nearestResizeDistance(screen) < (screen - centerPx).length;
      if (handles.hitsResize(screen) && prefersHandle) {
        _mode = _Mode.resize;
        c.beginGesture();
        return;
      }
    }
    final hit = c.hitTest(
      t.screenToWorld(screen),
      tolerance: t.screenToWorldDistance(12),
    );
    // Sun areas and cut-outs cover large parts of the floor; dragging on one
    // pans the view unless it is the selected object.
    final movable =
        hit != null && (!hit.kind.isBackground || hit.id == c.selectedId);
    if (movable) {
      c
        ..select(hit.id)
        ..beginGesture();
      _mode = _Mode.move;
    } else {
      _mode = _Mode.pan;
    }
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final t = _transform;
    final start = _gestureStartTransform;
    if (t == null || start == null) return;
    final c = widget.controller;
    final screen = _v(details.localFocalPoint);
    switch (_mode) {
      case _Mode.move:
        final deltaPx = screen - _gestureStartFocal;
        c.moveSelected(deltaPx * (1 / t.pxPerCm));
      case _Mode.resize:
        c.resizeSelectedTo(t.screenToWorld(screen));
      case _Mode.rotate:
        c.rotateSelectedTo(t.screenToWorld(screen));
      case _Mode.pan:
        setState(() => _transform = start.pan(screen - _gestureStartFocal));
      case _Mode.zoom:
        setState(() {
          _transform = start
              .zoomAt(
                _gestureStartFocal,
                details.scale,
                minPxPerCm: _minScale,
                maxPxPerCm: _maxScale,
              )
              .pan(screen - _gestureStartFocal);
        });
      case _Mode.none:
        break;
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    if (_mode case _Mode.move || _Mode.resize || _Mode.rotate) {
      widget.controller.endGesture();
    }
    setState(() => _mode = _Mode.none);
    _gestureStartTransform = null;
  }

  /// The toolbar above the selected object, or below it when there is no
  /// room above; kept inside the viewport.
  Widget? _toolbar(Size viewport) {
    final builder = widget.selectionToolbar;
    final selected = widget.controller.selected;
    final t = _transform;
    if (builder == null || selected == null || t == null) return null;
    if (_mode != _Mode.none) return null;
    final b = selected.shape.bounds;
    final topLeft = t.worldToScreen(Vec2(b.left, b.top));
    final bottomRight = t.worldToScreen(Vec2(b.right, b.bottom));
    const height = 56.0;
    // Leaves room for the rotate handle above rectangles.
    final above = topLeft.y - SelectionHandles.rotateHandleGapPx - height - 12;
    final top = above >= 8
        ? above
        : math.min(bottomRight.y + 36, viewport.height - height - 8);
    final centerX = (topLeft.x + bottomRight.x) / 2;
    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: Align(
        alignment: Alignment(
          ((centerX / viewport.width) * 2 - 1).clamp(-1.0, 1.0),
          0,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: builder(selected),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        if (_viewport != size) {
          _viewport = size;
          _transform = _fitted(size);
        }
        final toolbar = _toolbar(size);
        return Stack(
          children: [
            Semantics(
              label: l10n.designerCanvasLabel(
                widget.controller.document.elements.length,
              ),
              child: Listener(
                onPointerDown: (event) =>
                    _downPosition = _v(event.localPosition),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapUp: _onTapUp,
                  onScaleStart: _onScaleStart,
                  onScaleUpdate: _onScaleUpdate,
                  onScaleEnd: _onScaleEnd,
                  child: CustomPaint(
                    size: size,
                    painter: GardenCanvasPainter(
                      controller: widget.controller,
                      transform: _transform!,
                      colors: context.canvasColors,
                      unitSystem: widget.unitSystem,
                      style: widget.style,
                      plants: widget.plants,
                      dusk: theme.brightness == Brightness.dark,
                      format: MeasurementFormatter(
                        widget.unitSystem,
                        locale: Localizations.localeOf(
                          context,
                        ).toLanguageTag(),
                      ),
                      labelStyle:
                          (theme.textTheme.labelMedium ?? const TextStyle())
                              .copyWith(
                                fontFeatures: const [
                                  FontFeature.tabularFigures(),
                                ],
                              ),
                    ),
                  ),
                ),
              ),
            ),
            ?toolbar,
          ],
        );
      },
    );
  }
}
