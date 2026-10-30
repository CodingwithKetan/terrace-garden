import 'package:flutter/material.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_validator.dart';
import 'package:terrace_garden/l10n/l10n.dart';

extension ElementKindLabel on ElementKind {
  String label(AppLocalizations l10n) => switch (this) {
    ElementKind.roundPot => l10n.kindRoundPot,
    ElementKind.roundGrowBag => l10n.kindRoundGrowBag,
    ElementKind.rectPlanter => l10n.kindRectPlanter,
    ElementKind.growBag => l10n.kindGrowBag,
    ElementKind.raisedBed => l10n.kindRaisedBed,
    ElementKind.verticalPlanter => l10n.kindVerticalPlanter,
    ElementKind.hangingPot => l10n.kindHangingPot,
    ElementKind.wall => l10n.kindWall,
    ElementKind.railing => l10n.kindRailing,
    ElementKind.trellis => l10n.kindTrellis,
    ElementKind.waterTank => l10n.kindWaterTank,
    ElementKind.stairs => l10n.kindStairs,
    ElementKind.seating => l10n.kindSeating,
    ElementKind.path => l10n.kindPath,
    ElementKind.door => l10n.kindDoor,
    ElementKind.waterPoint => l10n.kindWaterPoint,
    ElementKind.drain => l10n.kindDrain,
    ElementKind.northArrow => l10n.kindNorthArrow,
    ElementKind.sunFull => l10n.kindSunFull,
    ElementKind.sunPart => l10n.kindSunPart,
    ElementKind.shade => l10n.kindShade,
    ElementKind.cutOut => l10n.kindCutOut,
  };

  IconData get icon => switch (this) {
    ElementKind.roundPot => Icons.circle_outlined,
    ElementKind.roundGrowBag => Icons.local_mall_outlined,
    ElementKind.rectPlanter => Icons.crop_landscape_outlined,
    ElementKind.growBag => Icons.shopping_bag_outlined,
    ElementKind.raisedBed => Icons.grid_view_outlined,
    ElementKind.verticalPlanter => Icons.view_column_outlined,
    ElementKind.hangingPot => Icons.light_outlined,
    ElementKind.wall => Icons.horizontal_rule,
    ElementKind.railing => Icons.fence_outlined,
    ElementKind.trellis => Icons.grid_4x4,
    ElementKind.waterTank => Icons.propane_tank_outlined,
    ElementKind.stairs => Icons.stairs_outlined,
    ElementKind.seating => Icons.chair_outlined,
    ElementKind.path => Icons.directions_walk_outlined,
    ElementKind.door => Icons.door_front_door_outlined,
    ElementKind.waterPoint => Icons.water_drop_outlined,
    ElementKind.drain => Icons.adjust,
    ElementKind.northArrow => Icons.navigation_outlined,
    ElementKind.sunFull => Icons.wb_sunny_outlined,
    ElementKind.sunPart => Icons.wb_cloudy_outlined,
    ElementKind.shade => Icons.beach_access_outlined,
    ElementKind.cutOut => Icons.block,
  };
}

extension IssueTypeLabel on IssueType {
  String label(AppLocalizations l10n) => switch (this) {
    IssueType.outOfBounds => l10n.issueOutOfBounds,
    IssueType.overlap => l10n.issueOverlap,
    IssueType.onPath => l10n.issueOnPath,
    IssueType.blocksDoor => l10n.issueBlocksDoor,
    IssueType.coversDrain => l10n.issueCoversDrain,
  };
}
