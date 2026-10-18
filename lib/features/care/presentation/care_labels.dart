import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/care_colors.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/l10n/l10n.dart';

extension CareTaskTypeLabel on CareTaskType {
  String label(AppLocalizations l10n) => switch (this) {
    CareTaskType.checkSoil => l10n.taskCheckSoil,
    CareTaskType.inspectPests => l10n.taskInspectPests,
    CareTaskType.feed => l10n.taskFeed,
    CareTaskType.transplant => l10n.taskTransplant,
    CareTaskType.harvest => l10n.taskHarvest,
    CareTaskType.prune => l10n.taskPrune,
  };

  IconData get icon => switch (this) {
    CareTaskType.checkSoil => Icons.water_drop_outlined,
    CareTaskType.inspectPests => Icons.bug_report_outlined,
    CareTaskType.feed => Icons.science_outlined,
    CareTaskType.transplant => Icons.move_down_outlined,
    CareTaskType.harvest => Icons.shopping_basket_outlined,
    CareTaskType.prune => Icons.content_cut_outlined,
  };

  Color color(CareColors colors) => switch (this) {
    CareTaskType.checkSoil => colors.water,
    CareTaskType.inspectPests => colors.inspect,
    CareTaskType.feed => colors.fertilise,
    CareTaskType.transplant => colors.sow,
    CareTaskType.harvest => colors.harvest,
    CareTaskType.prune => colors.prune,
  };

  /// How-to text. The soil check adapts to a species' sourced watering mode.
  String guide(AppLocalizations l10n, {PlantSpecies? species}) =>
      switch (this) {
        CareTaskType.checkSoil => switch (species?.watering?.mode) {
          WateringMode.dryBetween => l10n.guideCheckSoilDry,
          WateringMode.keepMoist => l10n.guideCheckSoilMoist,
          null => l10n.guideCheckSoil,
        },
        CareTaskType.inspectPests => l10n.guideInspectPests,
        CareTaskType.feed => l10n.guideFeed,
        CareTaskType.transplant => l10n.guideTransplant,
        CareTaskType.harvest => l10n.guideHarvest,
        CareTaskType.prune => l10n.guidePrune,
      };
}

extension SkipReasonLabel on SkipReason {
  String label(AppLocalizations l10n) => switch (this) {
    SkipReason.rained => l10n.skipRained,
    SkipReason.soilStillMoist => l10n.skipSoilMoist,
    SkipReason.notNeeded => l10n.skipNotNeeded,
    SkipReason.other => l10n.skipOther,
  };

  IconData get icon => switch (this) {
    SkipReason.rained => Icons.umbrella_outlined,
    SkipReason.soilStillMoist => Icons.water_outlined,
    SkipReason.notNeeded => Icons.do_not_disturb_on_outlined,
    SkipReason.other => Icons.more_horiz,
  };
}
