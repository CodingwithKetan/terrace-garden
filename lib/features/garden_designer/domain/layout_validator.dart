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
    IssueType.onPath => IssueSeverity.warning,
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
/// walls, railings) must not overlap each other; a container on a path is a
/// warning; markers never conflict.
List<LayoutIssue> validateLayout(LayoutDocument doc) {
  final issues = <LayoutIssue>[];
  final elements = doc.elements;

  for (final e in elements) {
    if (!insideGarden(e.shape, doc.length, doc.width)) {
      issues.add(LayoutIssue(elementId: e.id, type: IssueType.outOfBounds));
    }
  }

  bool isSolid(LayoutElement e) =>
      e.kind.role == ElementRole.container ||
      e.kind.role == ElementRole.structure;

  for (var i = 0; i < elements.length; i++) {
    for (var j = i + 1; j < elements.length; j++) {
      final a = elements[i];
      final b = elements[j];
      final IssueType? type;
      if (isSolid(a) && isSolid(b)) {
        type = IssueType.overlap;
      } else if (_isContainerOnPath(a, b) || _isContainerOnPath(b, a)) {
        type = IssueType.onPath;
      } else {
        type = null;
      }
      if (type == null || !shapesOverlap(a.shape, b.shape)) continue;
      if (type == IssueType.onPath) {
        final container = a.kind.isContainer ? a : b;
        final path = a.kind.isContainer ? b : a;
        issues.add(
          LayoutIssue(
            elementId: container.id,
            type: type,
            otherElementId: path.id,
          ),
        );
      } else {
        issues
          ..add(LayoutIssue(elementId: a.id, type: type, otherElementId: b.id))
          ..add(LayoutIssue(elementId: b.id, type: type, otherElementId: a.id));
      }
    }
  }
  return issues;
}

bool _isContainerOnPath(LayoutElement a, LayoutElement b) =>
    a.kind.isContainer && b.kind.role == ElementRole.walkway;
