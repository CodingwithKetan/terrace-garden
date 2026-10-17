import 'package:terrace_garden/features/garden_designer/domain/layout.dart';

/// Undo/redo for layout edits (PRD FR-C6) as a stack of immutable snapshots.
///
/// Callers record the document *before* each committed change. A drag is one
/// change: record once at the start, not on every frame.
class LayoutHistory {
  LayoutHistory({this.maxDepth = 50});

  final int maxDepth;
  final List<LayoutDocument> _past = [];
  final List<LayoutDocument> _future = [];

  bool get canUndo => _past.isNotEmpty;
  bool get canRedo => _future.isNotEmpty;
  int get undoDepth => _past.length;

  /// Records [before] as an undo point. A new change clears redo.
  void record(LayoutDocument before) {
    _past.add(before);
    if (_past.length > maxDepth) _past.removeAt(0);
    _future.clear();
  }

  /// Returns the previous document, storing [current] for redo.
  LayoutDocument? undo(LayoutDocument current) {
    if (_past.isEmpty) return null;
    _future.add(current);
    return _past.removeLast();
  }

  /// Returns the next document, storing [current] for undo.
  LayoutDocument? redo(LayoutDocument current) {
    if (_future.isEmpty) return null;
    _past.add(current);
    return _future.removeLast();
  }

  void clear() {
    _past.clear();
    _future.clear();
  }
}
