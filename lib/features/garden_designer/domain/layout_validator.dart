import 'package:meta/meta.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';

enum IssueSeverity { error, warning }

enum IssueType {
  /// Part of the element lies outside the garden boundary.
  outOfBounds,

  /// Two solid elements (containers, walls, railings) overlap.
  overlap,

  /// A container stands on a path.
  onPath,

  /// Something solid stands where a door opens.
  blocksDoor,

  /// Something solid covers a floor drain.
  coversDrain,
}

@immutable
final class LayoutIssue {
  const LayoutIssue({
    required this.elementId,
    required this.type,
    this.otherElementId,
  });

  final String elementId;
  final IssueType type;
  final String? otherElementId;

  IssueSeverity get severity => switch (type) {
    IssueType.outOfBounds || IssueType.overlap => IssueSeverity.error,
    IssueType.onPath ||
    IssueType.blocksDoor ||
    IssueType.coversDrain => IssueSeverity.warning,
  };

  @override
  bool operator ==(Object other) =>
      other is LayoutIssue &&
      other.elementId == elementId &&
      other.type == type &&
      other.otherElementId == otherElementId;

  @override
  int get hashCode => Object.hash(elementId, type, otherElementId);

  @override
  String toString() => 'LayoutIssue($elementId, $type, $otherElementId)';
}

/// Validates a layout (PRD FR-C5). Pure function; overlap issues are
/// reported on both elements.
///
/// Rules: anything outside the garden is an error; solids (containers,
/// walls, railings, tanks, seating) must not overlap each other; a container
/// on a path is a warning, and so is a solid where a door opens or over a
/// drain; other markers never conflict. Hanging pots only conflict with each
/// other, since they hang above the floor. Sun areas never conflict, and
/// anything on a cut-out is outside the garden.
List<LayoutIssue> validateLayout(LayoutDocument doc) {
  final issues = <LayoutIssue>[];
  final elements = doc.elements;

  for (final e in elements) {
    // Sun areas are marks, not objects; one may overhang the edge.
    if (e.kind.role == ElementRole.zone) continue;
    if (!insideGarden(e.shape, doc.length, doc.width)) {
      issues.add(LayoutIssue(elementId: e.id, type: IssueType.outOfBounds));
    }
  }

  for (var i = 0; i < elements.length; i++) {
    for (var j = i + 1; j < elements.length; j++) {
      final a = elements[i];
      final b = elements[j];
      if (a.kind.role == ElementRole.zone || b.kind.role == ElementRole.zone) {
        continue;
      }
      final aCut = a.kind.role == ElementRole.cutOut;
      final bCut = b.kind.role == ElementRole.cutOut;
      if (aCut || bCut) {
        // Standing on a cut-out is standing outside the usable floor.
        if (aCut == bCut || !shapesOverlap(a.shape, b.shape)) continue;
        final (on, cut) = aCut ? (b, a) : (a, b);
        issues.add(
          LayoutIssue(
            elementId: on.id,
            type: IssueType.outOfBounds,
            otherElementId: cut.id,
          ),
        );
        continue;
      }
      if (a.kind.overhead != b.kind.overhead) continue;
      if (_isSolid(a) && _isSolid(b)) {
        if (!shapesOverlap(a.shape, b.shape)) continue;
        issues
          ..add(
            LayoutIssue(
              elementId: a.id,
              type: IssueType.overlap,
              otherElementId: b.id,
            ),
          )
          ..add(
            LayoutIssue(
              elementId: b.id,
              type: IssueType.overlap,
              otherElementId: a.id,
            ),
          );
        continue;
      }
      final issue = _keepClearIssue(a, b) ?? _keepClearIssue(b, a);
      if (issue != null && shapesOverlap(a.shape, b.shape)) issues.add(issue);
    }
  }
  return issues;
}

bool _isSolid(LayoutElement e) =>
    e.kind.role == ElementRole.container ||
    e.kind.role == ElementRole.structure;

/// The warning for [a] standing on [b], when [b] is an area to keep clear.
LayoutIssue? _keepClearIssue(LayoutElement a, LayoutElement b) {
  final type = switch (b.kind) {
    ElementKind.door when _isSolid(a) => IssueType.blocksDoor,
    ElementKind.drain when _isSolid(a) => IssueType.coversDrain,
    ElementKind.path when a.kind.isContainer => IssueType.onPath,
    _ => null,
  };
  if (type == null) return null;
  return LayoutIssue(elementId: a.id, type: type, otherElementId: b.id);
}
