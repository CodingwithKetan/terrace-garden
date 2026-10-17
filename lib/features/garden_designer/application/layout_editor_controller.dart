import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_history.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_repository.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_validator.dart';

enum SaveStatus { saved, pending, saving, failed }

/// Interactive state of the designer (ADR-003: a ChangeNotifier drives the
/// canvas painter directly for smooth 60 fps updates).
///
/// Every committed change records an undo point and schedules an autosave.
/// A gesture (drag, resize, rotate) is one change: call [beginGesture],
/// update as often as needed, then [endGesture].
class LayoutEditorController extends ChangeNotifier {
  LayoutEditorController({
    required LayoutDocument initial,
    required this._repository,
    required this._ids,
    this.gridStep = 5,
    this.autosaveDelay = const Duration(milliseconds: 800),
  }) : _document = initial,
       _issues = validateLayout(initial);

  final LayoutRepository _repository;
  final IdGenerator _ids;
  final LayoutHistory _history = LayoutHistory();

  /// Snap step in cm (5 cm metric; 2 in ≈ 5.08 cm imperial).
  final double gridStep;
  final Duration autosaveDelay;

  LayoutDocument _document;
  List<LayoutIssue> _issues;
  String? _selectedId;
  bool _snap = true;
  SaveStatus _status = SaveStatus.saved;
  Timer? _saveTimer;
  bool _disposed = false;

  // Gesture state.
  LayoutDocument? _gestureStart;
  LayoutElement? _gestureElement;

  LayoutDocument get document => _document;
  List<LayoutIssue> get issues => _issues;
  String? get selectedId => _selectedId;
  LayoutElement? get selected =>
      _selectedId == null ? null : _document.elementById(_selectedId!);
  bool get snapEnabled => _snap;
  SaveStatus get status => _status;
  bool get canUndo => _history.canUndo;
  bool get canRedo => _history.canRedo;
  int get errorCount =>
      _issues.where((i) => i.severity == IssueSeverity.error).length;

  List<LayoutIssue> issuesFor(String elementId) =>
      _issues.where((i) => i.elementId == elementId).toList();

  set snapEnabled(bool value) {
    _snap = value;
    notifyListeners();
  }

  void select(String? id) {
    if (_selectedId == id) return;
    _selectedId = id;
    notifyListeners();
  }

  /// Topmost element under [world], with [tolerance] cm of slack so small
  /// objects stay easy to tap.
  LayoutElement? hitTest(Vec2 world, {double tolerance = 0}) {
    for (final e in _document.elements.reversed) {
      if (e.shape.contains(world)) return e;
    }
    if (tolerance <= 0) return null;
    LayoutElement? nearest;
    var best = tolerance;
    for (final e in _document.elements.reversed) {
      final d = (e.center - world).length - _halfMinSide(e);
      if (d <= best) {
        best = d;
        nearest = e;
      }
    }
    return nearest;
  }

  static double _halfMinSide(LayoutElement e) =>
      math.min(e.width, e.kind.round ? e.width : e.height) / 2;

  /// Adds an element of [kind] at [at] (snapped) and selects it.
  LayoutElement add(ElementKind kind, Vec2 at) {
    var element = LayoutElement(
      id: _ids.newId(),
      kind: kind,
      center: at,
      width: kind.w,
      height: kind.round ? kind.w : kind.h,
      depthCm: kind.depth,
    );
    element = element.copyWith(center: _snapCenter(element, at));
    _commit(_document.upsert(element));
    _selectedId = element.id;
    notifyListeners();
    return element;
  }

  // --- Gestures -----------------------------------------------------------

  void beginGesture() {
    _gestureStart = _document;
    _gestureElement = selected;
  }

  /// Moves the selected element by [totalDelta] cm from where the gesture
  /// started.
  void moveSelected(Vec2 totalDelta) {
    final start = _gestureElement;
    if (start == null) return;
    final target = start.center + totalDelta;
    _updateLive(start.copyWith(center: _snapCenter(start, target)));
  }

  /// Resizes the selected element so the dragged corner follows [world],
  /// keeping its centre fixed.
  void resizeSelectedTo(Vec2 world) {
    final start = _gestureElement;
    if (start == null) return;
    const min = ElementKind.minSide;
    if (start.kind.round) {
      var d = math.max(min, 2 * (world - start.center).length);
      if (_snap) d = math.max(min, snapTo(d, gridStep));
      _updateLive(start.copyWith(width: d, height: d));
      return;
    }
    final local = (start.shape as RectShape).toLocal(world);
    var w = math.max(min, 2 * local.x.abs());
    var h = math.max(min, 2 * local.y.abs());
    if (_snap) {
      w = math.max(min, snapTo(w, gridStep));
      h = math.max(min, snapTo(h, gridStep));
    }
    _updateLive(start.copyWith(width: w, height: h));
  }

  /// Rotates the selected element so its rotation handle (above the top
  /// edge) points at [world]. Snaps to 15° when snapping is on.
  void rotateSelectedTo(Vec2 world) {
    final start = _gestureElement;
    if (start == null || start.kind.round) return;
    final v = world - start.center;
    var degrees = math.atan2(v.y, v.x) * 180 / math.pi + 90;
    degrees = _snap ? snapAngle(degrees) : normaliseAngle(degrees);
    _updateLive(start.copyWith(rotationDeg: degrees));
  }

  void endGesture() {
    final before = _gestureStart;
    _gestureStart = null;
    _gestureElement = null;
    if (before != null && before != _document) {
      _history.record(before);
      _scheduleSave();
      notifyListeners();
    }
  }

  // --- Discrete edits -------------------------------------------------------

  /// Applies [change] to the selected element (inspector edits).
  void updateSelected(LayoutElement Function(LayoutElement) change) {
    final current = selected;
    if (current == null) return;
    final next = change(current);
    if (next == current) return;
    _commit(_document.upsert(next));
  }

  void rotateSelectedBy90() => updateSelected(
    (e) => e.copyWith(rotationDeg: normaliseAngle(e.rotationDeg + 90)),
  );

  void duplicateSelected() {
    final current = selected;
    if (current == null) return;
    final copy = current.copyWith(
      id: _ids.newId(),
      center: current.center + Vec2(gridStep * 4, gridStep * 4),
    );
    _commit(_document.upsert(copy));
    _selectedId = copy.id;
    notifyListeners();
  }

  void deleteSelected() {
    final id = _selectedId;
    if (id == null) return;
    _selectedId = null;
    _commit(_document.remove(id));
  }

  void undo() {
    final previous = _history.undo(_document);
    if (previous == null) return;
    _apply(previous);
  }

  void redo() {
    final next = _history.redo(_document);
    if (next == null) return;
    _apply(next);
  }

  /// Saves immediately if a save is pending (e.g. when leaving the screen).
  Future<void> flush() async {
    if (_status != SaveStatus.pending && _status != SaveStatus.failed) return;
    _saveTimer?.cancel();
    await _save();
  }

  // --- Internals ------------------------------------------------------------

  Vec2 _snapCenter(LayoutElement element, Vec2 target) {
    if (!_snap) return target;
    final moved = element.copyWith(center: target);
    return snapCenter(
      center: target,
      boundsAtCenter: moved.shape.bounds,
      gridStep: gridStep,
      gardenLength: _document.length,
      gardenWidth: _document.width,
    );
  }

  /// Updates during a gesture: no undo point, no save until [endGesture].
  void _updateLive(LayoutElement element) {
    _document = _document.upsert(element);
    _issues = validateLayout(_document);
    notifyListeners();
  }

  void _commit(LayoutDocument next) {
    _history.record(_document);
    _apply(next);
  }

  void _apply(LayoutDocument next) {
    _document = next;
    _issues = validateLayout(next);
    if (_selectedId != null && next.elementById(_selectedId!) == null) {
      _selectedId = null;
    }
    _scheduleSave();
    notifyListeners();
  }

  void _scheduleSave() {
    _status = SaveStatus.pending;
    _saveTimer?.cancel();
    _saveTimer = Timer(autosaveDelay, _save);
  }

  Future<void> _save() async {
    _status = SaveStatus.saving;
    _notifyIfAlive();
    final snapshot = _document;
    final result = await _repository.saveElements(
      snapshot.gardenId,
      snapshot.elements,
    );
    if (result case Err()) {
      _status = SaveStatus.failed;
    } else if (identical(snapshot, _document)) {
      _status = SaveStatus.saved;
    } else {
      // Changed while saving: another save is already scheduled.
      _status = SaveStatus.pending;
    }
    _notifyIfAlive();
  }

  void _notifyIfAlive() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _saveTimer?.cancel();
    super.dispose();
  }
}
