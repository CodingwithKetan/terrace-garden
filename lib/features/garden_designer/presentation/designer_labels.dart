import 'package:flutter/material.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_validator.dart';
import 'package:terrace_garden/l10n/l10n.dart';

extension ElementKindLabel on ElementKind {
  String label(AppLocalizations l10n) => switch (this) {
    ElementKind.roundPot => l10n.kindRoundPot,
    ElementKind.rectPlanter => l10n.kindRectPlanter,
    ElementKind.growBag => l10n.kindGrowBag,
    ElementKind.raisedBed => l10n.kindRaisedBed,
    ElementKind.verticalPlanter => l10n.kindVerticalPlanter,
    ElementKind.wall => l10n.kindWall,
    ElementKind.railing => l10n.kindRailing,
    ElementKind.path => l10n.kindPath,
    ElementKind.waterPoint => l10n.kindWaterPoint,
  };

  IconData get icon => switch (this) {
    ElementKind.roundPot => Icons.circle_outlined,
    ElementKind.rectPlanter => Icons.crop_landscape_outlined,
    ElementKind.growBag => Icons.shopping_bag_outlined,
    ElementKind.raisedBed => Icons.grid_view_outlined,
    ElementKind.verticalPlanter => Icons.view_column_outlined,
    ElementKind.wall => Icons.horizontal_rule,
    ElementKind.railing => Icons.fence_outlined,
    ElementKind.path => Icons.directions_walk_outlined,
    ElementKind.waterPoint => Icons.water_drop_outlined,
  };
}

extension IssueTypeLabel on IssueType {
  String label(AppLocalizations l10n) => switch (this) {
    IssueType.outOfBounds => l10n.issueOutOfBounds,
    IssueType.overlap => l10n.issueOverlap,
    IssueType.onPath => l10n.issueOnPath,
  };
}
