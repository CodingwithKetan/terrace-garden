import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/units/measurement_formatter.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/core/widgets/dialogs.dart';
import 'package:terrace_garden/core/widgets/dimension_field.dart';
import 'package:terrace_garden/core/widgets/status_chip.dart';
import 'package:terrace_garden/features/garden_designer/application/layout_editor_controller.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_validator.dart';
import 'package:terrace_garden/features/garden_designer/presentation/designer_labels.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// DSN-02. Resolves to the chosen kind, or null if dismissed.
Future<ElementKind?> showElementPalette(BuildContext context) {
  final l10n = context.l10n;
  final groups = [
    (l10n.paletteContainers, ElementRole.container),
    (l10n.paletteStructures, ElementRole.structure),
    (l10n.paletteOther, null),
  ];
  return showAppBottomSheet<ElementKind>(
    context,
    title: l10n.designerAdd,
    builder: (context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (title, role) in groups) ...[
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.md),
            child: Text(title, style: Theme.of(context).textTheme.titleSmall),
          ),
          for (final kind in ElementKind.values.where(
            (k) => role == null
                ? k.role == ElementRole.walkway || k.role == ElementRole.marker
                : k.role == role,
          ))
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(kind.icon),
              title: Text(kind.label(l10n)),
              onTap: () => Navigator.of(context).pop(kind),
            ),
        ],
      ],
    ),
  );
}

/// DSN-03. Precise edits of the selected element, applied live.
Future<void> showInspector(
  BuildContext context,
  LayoutEditorController controller,
  UnitSystem unitSystem,
) {
  final l10n = context.l10n;
  return showAppBottomSheet<void>(
    context,
    title: l10n.inspectorTitle,
    builder: (context) => ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final e = controller.selected;
        if (e == null) return const SizedBox.shrink();
        return _InspectorBody(
          element: e,
          controller: controller,
          unitSystem: unitSystem,
        );
      },
    ),
  );
}

class _InspectorBody extends StatelessWidget {
  const _InspectorBody({
    required this.element,
    required this.controller,
    required this.unitSystem,
  });

  final LayoutElement element;
  final LayoutEditorController controller;
  final UnitSystem unitSystem;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final unit = unitSystem == UnitSystem.metric
        ? l10n.unitCmShort
        : l10n.unitInShort;
    final e = element;

    void setSize({Length? width, Length? height}) {
      bool valid(Length? l) => l == null || l.cm >= ElementKind.minSide;
      if (!valid(width) || !valid(height)) return;
      controller.updateSelected((current) {
        if (current.kind.round) {
          final d = width?.cm ?? current.width;
          return current.copyWith(width: d, height: d);
        }
        return current.copyWith(
          width: width?.cm ?? current.width,
          height: height?.cm ?? current.height,
        );
      });
    }

    final issues = controller.issuesFor(e.id);
    final degrees = l10n.degreesValue(e.rotationDeg.round());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(e.kind.icon),
            const SizedBox(width: AppSpacing.sm),
            Text(e.kind.label(l10n), style: theme.textTheme.titleMedium),
          ],
        ),
        if (issues.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              for (final issue in issues)
                StatusChip(
                  label: issue.type.label(l10n),
                  icon: Icons.warning_amber_rounded,
                  color: issue.severity == IssueSeverity.error
                      ? theme.colorScheme.error
                      : theme.colorScheme.tertiary,
                ),
            ],
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        // Keyed by element so switching selection re-formats the fields.
        Row(
          key: ValueKey('size-${e.id}'),
          children: [
            Expanded(
              child: DimensionField(
                fine: true,
                label: e.kind.round ? l10n.fieldDiameter : l10n.fieldLength,
                unitSystem: unitSystem,
                unitLabel: unit,
                value: Length.cm(e.width),
                onChanged: (v) => setSize(width: v),
              ),
            ),
            if (!e.kind.round) ...[
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: DimensionField(
                  fine: true,
                  label: l10n.fieldWidth,
                  unitSystem: unitSystem,
                  unitLabel: unit,
                  value: Length.cm(e.height),
                  onChanged: (v) => setSize(height: v),
                ),
              ),
            ],
          ],
        ),
        if (e.kind.isContainer) ...[
          const SizedBox(height: AppSpacing.md),
          DimensionField(
            key: ValueKey('depth-${e.id}'),
            fine: true,
            label: l10n.fieldDepth,
            unitSystem: unitSystem,
            unitLabel: unit,
            value: e.depthCm == null ? null : Length.cm(e.depthCm!),
            onChanged: (v) => controller.updateSelected(
              (current) => current.copyWith(depthCm: v?.cm),
            ),
          ),
        ],
        if (!e.kind.round) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(
            '${l10n.fieldRotation}: $degrees',
            style: theme.textTheme.titleSmall,
          ),
          Slider(
            value: e.rotationDeg.clamp(0, 345),
            max: 345,
            divisions: 23,
            label: l10n.degreesValue(e.rotationDeg.round()),
            onChanged: (v) => controller.updateSelected(
              (current) => current.copyWith(rotationDeg: v),
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          key: ValueKey('label-${e.id}'),
          initialValue: e.label,
          maxLength: 40,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: l10n.fieldLabel,
            hintText: l10n.fieldLabelHint,
          ),
          onChanged: (v) => controller.updateSelected(
            (current) =>
                current.copyWith(label: v.trim().isEmpty ? null : v.trim()),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionDone),
        ),
      ],
    );
  }
}

/// DSN-04. Every object with its size and problems; an accessible way to
/// review and edit the layout without precise dragging. Resolves to the id
/// the user chose to edit, or null.
Future<String?> showObjectsList(
  BuildContext context,
  LayoutEditorController controller,
  MeasurementFormatter format,
) {
  final l10n = context.l10n;
  return showAppBottomSheet<String>(
    context,
    title: l10n.designerObjects,
    builder: (context) => ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final elements = controller.document.elements;
        if (elements.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(l10n.objectsEmpty),
          );
        }
        return Column(
          children: [
            for (final e in elements)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(e.kind.icon),
                title: Text(e.label ?? e.kind.label(l10n)),
                subtitle: Text(
                  [
                    _sizeText(e, format),
                    for (final issue in controller.issuesFor(e.id))
                      issue.type.label(l10n),
                  ].join(' · '),
                ),
                trailing: IconButton(
                  tooltip: l10n.actionDelete,
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    controller
                      ..select(e.id)
                      ..deleteSelected();
                  },
                ),
                onTap: () => Navigator.of(context).pop(e.id),
              ),
          ],
        );
      },
    ),
  );
}

/// DSN-05.
Future<void> showSpaceSummary(
  BuildContext context,
  LayoutEditorController controller,
  MeasurementFormatter format,
) {
  final l10n = context.l10n;
  final summary = LayoutSummary.of(controller.document);
  final theme = Theme.of(context);
  final containerArea = format.area(Area.cm2(summary.containerArea));
  final share = l10n.summaryContainerShare(
    (summary.containerShare * 100).round(),
  );
  final rows = [
    (l10n.summaryGardenArea, format.area(Area.cm2(summary.gardenArea))),
    (l10n.summaryContainerArea, '$containerArea · $share'),
    (l10n.summaryWalkway, format.area(Area.cm2(summary.walkwayArea))),
    (l10n.summarySoil, format.volume(Volume.litres(summary.soilLitres))),
  ];
  return showAppBottomSheet<void>(
    context,
    title: l10n.designerSummary,
    builder: (context) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (label, value) in rows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Row(
              children: [
                Expanded(child: Text(label, style: theme.textTheme.bodyLarge)),
                Text(value, style: theme.textTheme.titleSmall),
              ],
            ),
          ),
        const Divider(height: AppSpacing.xl),
        Text(l10n.summaryCounts, style: theme.textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final MapEntry(key: kind, value: count)
                in summary.countsByKind.entries)
              Chip(
                avatar: Icon(kind.icon, size: 18),
                label: Text('${kind.label(l10n)} × $count'),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(l10n.summaryNote, style: theme.textTheme.bodySmall),
      ],
    ),
  );
}

/// Centre of [doc]'s garden, used when no viewport position is available.
Vec2 gardenCenter(LayoutDocument doc) => Vec2(doc.length / 2, doc.width / 2);

String _sizeText(LayoutElement e, MeasurementFormatter format) {
  final width = format.length(Length.cm(e.width));
  if (e.kind.round) return 'Ø $width';
  final height = format.length(Length.cm(e.height));
  return '$width × $height';
}
