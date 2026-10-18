import 'package:terrace_garden/core/units/measurement_formatter.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/presentation/designer_labels.dart';
import 'package:terrace_garden/features/plantings/domain/planting_fit.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// The containers on a layout, in drawing order.
List<LayoutElement> layoutContainers(List<LayoutElement> elements) =>
    elements.where((e) => e.kind.isContainer).toList();

/// A container's name: its label, or its kind and number ("Grow bag 2").
String containerName(
  AppLocalizations l10n,
  LayoutElement element,
  List<LayoutElement> elements,
) {
  if (element.label case final label?) return label;
  final sameKind = elements.where((e) => e.kind == element.kind).toList();
  final number = sameKind.indexWhere((e) => e.id == element.id) + 1;
  final kind = element.kind.label(l10n);
  return sameKind.length > 1 ? '$kind $number' : kind;
}

/// Name plus soil volume when known ("Grow bag 2 · 81 L").
String containerDescription(
  AppLocalizations l10n,
  MeasurementFormatter format,
  LayoutElement element,
  List<LayoutElement> elements,
) {
  final name = containerName(l10n, element, elements);
  final litres = element.soilLitres;
  return litres == null
      ? name
      : '$name · ${format.volume(Volume.litres(litres))}';
}

extension PlantingIssueText on PlantingIssue {
  String message(AppLocalizations l10n, MeasurementFormatter format) =>
      switch (kind) {
        PlantingIssueKind.lowVolume => l10n.plantingIssueLowVolume(
          format.volume(Volume.litres(actual!)),
          format.volume(Volume.litres(required!)),
        ),
        PlantingIssueKind.shallow => l10n.plantingIssueShallow(
          format.length(Length.cm(actual!)),
          format.length(Length.cm(required!)),
        ),
        PlantingIssueKind.crowded => l10n.plantingIssueCrowded(capacity!),
        PlantingIssueKind.shared => l10n.plantingIssueShared(capacity!),
        PlantingIssueKind.noDepth => l10n.plantingIssueNoDepth,
      };
}
