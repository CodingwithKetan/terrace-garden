import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:terrace_garden/features/journal/domain/journal_entry.dart';
import 'package:terrace_garden/l10n/l10n.dart';

extension MilestoneLabel on Milestone {
  String label(AppLocalizations l10n) => switch (this) {
    Milestone.germinated => l10n.milestoneGerminated,
    Milestone.transplanted => l10n.milestoneTransplanted,
    Milestone.flowering => l10n.milestoneFlowering,
    Milestone.firstFruit => l10n.milestoneFirstFruit,
    Milestone.harvest => l10n.milestoneHarvest,
    Milestone.other => l10n.milestoneOther,
  };

  IconData get icon => switch (this) {
    Milestone.germinated => Icons.grass_outlined,
    Milestone.transplanted => Icons.move_down_outlined,
    Milestone.flowering => Icons.local_florist_outlined,
    Milestone.firstFruit => Icons.eco_outlined,
    Milestone.harvest => Icons.shopping_basket_outlined,
    Milestone.other => Icons.star_outline,
  };
}

extension HarvestUnitLabel on HarvestUnit {
  String label(AppLocalizations l10n) => switch (this) {
    HarvestUnit.grams => l10n.unitGrams,
    HarvestUnit.pieces => l10n.unitPieces,
    HarvestUnit.bunches => l10n.unitBunches,
  };
}

/// "250 g", "6 pieces"; null when the entry has no harvest amount.
String? harvestText(BuildContext context, JournalEntry entry) {
  final quantity = entry.harvestQuantity;
  final unit = entry.harvestUnit;
  if (quantity == null || unit == null) return null;
  final l10n = context.l10n;
  final amount = NumberFormat.decimalPattern(
    Localizations.localeOf(context).toLanguageTag(),
  ).format(quantity);
  return switch (unit) {
    HarvestUnit.grams => l10n.journalHarvestGrams(amount),
    HarvestUnit.pieces => l10n.journalHarvestPieces(amount),
    HarvestUnit.bunches => l10n.journalHarvestBunches(amount),
  };
}
