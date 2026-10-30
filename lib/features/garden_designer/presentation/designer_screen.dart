import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/units/measurement_formatter.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/core/widgets/app_button.dart';
import 'package:terrace_garden/core/widgets/dimension_field.dart';
import 'package:terrace_garden/core/widgets/error_state.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/garden/garden.dart';
import 'package:terrace_garden/features/garden_designer/application/layout_editor_controller.dart';
import 'package:terrace_garden/features/garden_designer/data/designer_providers.dart';
import 'package:terrace_garden/features/garden_designer/domain/container_presets.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_templates.dart';
import 'package:terrace_garden/features/garden_designer/domain/sun_areas.dart';
import 'package:terrace_garden/features/garden_designer/presentation/designer_add.dart';
import 'package:terrace_garden/features/garden_designer/presentation/designer_canvas.dart';
import 'package:terrace_garden/features/garden_designer/presentation/designer_labels.dart';
import 'package:terrace_garden/features/garden_designer/presentation/designer_sheets.dart';
import 'package:terrace_garden/features/garden_designer/presentation/garden_canvas_painter.dart';
import 'package:terrace_garden/features/plant_catalog/plant_catalog.dart';
import 'package:terrace_garden/features/plantings/plantings.dart';
import 'package:terrace_garden/features/settings/settings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// DSN-01. Loads the garden and its saved layout, asks for the garden's size
/// if it is missing, then hosts the interactive designer.
class DesignerScreen extends ConsumerStatefulWidget {
  const DesignerScreen({required this.gardenId, super.key});

  final String gardenId;

  @override
  ConsumerState<DesignerScreen> createState() => _DesignerScreenState();
}

class _DesignerScreenState extends ConsumerState<DesignerScreen> {
  Garden? _garden;
  LayoutEditorController? _controller;
  bool _loading = true;
  bool _notFound = false;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    final garden = await ref
        .read(gardenRepositoryProvider)
        .find(widget.gardenId);
    if (!mounted) return;
    if (garden == null) {
      setState(() {
        _loading = false;
        _notFound = true;
      });
      return;
    }
    _garden = garden;
    if (garden.hasDimensions) await _startEditor(garden);
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _startEditor(Garden garden) async {
    final elements = await ref
        .read(layoutRepositoryProvider)
        .loadElements(garden.id);
    if (!mounted) return;
    final units =
        ref.read(settingsControllerProvider).value?.unitSystem ??
        UnitSystem.metric;
    _controller?.dispose();
    _controller = LayoutEditorController(
      initial: LayoutDocument(
        gardenId: garden.id,
        length: garden.length!.cm,
        width: garden.width!.cm,
        elements: elements,
      ),
      repository: ref.read(layoutRepositoryProvider),
      ids: ref.read(idGeneratorProvider),
      gridStep: units == UnitSystem.metric ? 5 : cmPerInch * 2,
    );
  }

  Future<void> _saveSize(Length length, Length width) async {
    final garden = _garden!;
    final result = await ref
        .read(gardenRepositoryProvider)
        .update(
          garden.id,
          GardenDraft.fromGarden(garden).copyWith(length: length, width: width),
        );
    if (!mounted) return;
    switch (result) {
      case Ok(:final value):
        _garden = value;
        await _startEditor(value);
        if (mounted) setState(() {});
      case Err(:final failure):
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(ErrorState.messageFor(context.l10n, failure))),
        );
    }
  }

  @override
  void dispose() {
    final controller = _controller;
    if (controller != null) {
      // Save any pending change before leaving.
      unawaited(controller.flush());
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final controller = _controller;
    final garden = _garden;

    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_notFound || garden == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const ErrorState(failure: NotFoundFailure()),
      );
    }
    if (controller == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.designerTitle)),
        body: _SizePrompt(onSubmit: _saveSize),
      );
    }
    return _DesignerView(garden: garden, controller: controller);
  }
}

class _SizePrompt extends ConsumerStatefulWidget {
  const _SizePrompt({required this.onSubmit});

  final Future<void> Function(Length length, Length width) onSubmit;

  @override
  ConsumerState<_SizePrompt> createState() => _SizePromptState();
}

class _SizePromptState extends ConsumerState<_SizePrompt> {
  Length? _length;
  Length? _width;
  bool _showErrors = false;
  bool _saving = false;

  bool _valid(Length? l) => l != null && l.cm > 0 && !(l > GardenDraft.maxSide);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final units =
        ref.watch(settingsControllerProvider).value?.unitSystem ??
        UnitSystem.metric;
    final unit = units == UnitSystem.metric
        ? l10n.unitMetresShort
        : l10n.unitFeetShort;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      children: [
        Icon(
          Icons.straighten_outlined,
          size: 48,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(l10n.designerNeedsSizeTitle, style: theme.textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.sm),
        Text(l10n.designerNeedsSizeBody, style: theme.textTheme.bodyLarge),
        const SizedBox(height: AppSpacing.xl),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DimensionField(
                label: l10n.fieldLength,
                unitSystem: units,
                unitLabel: unit,
                value: _length,
                errorText: _showErrors && !_valid(_length)
                    ? l10n.errDimension
                    : null,
                onChanged: (v) => setState(() => _length = v),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: DimensionField(
                label: l10n.fieldWidth,
                unitSystem: units,
                unitLabel: unit,
                value: _width,
                errorText: _showErrors && !_valid(_width)
                    ? l10n.errDimension
                    : null,
                onChanged: (v) => setState(() => _width = v),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        AppButton(
          label: l10n.designerStart,
          isLoading: _saving,
          expand: true,
          onPressed: () async {
            if (!_valid(_length) || !_valid(_width)) {
              setState(() => _showErrors = true);
              return;
            }
            setState(() => _saving = true);
            await widget.onSubmit(_length!, _width!);
            if (mounted) setState(() => _saving = false);
          },
        ),
      ],
    );
  }
}

class _DesignerView extends ConsumerStatefulWidget {
  const _DesignerView({required this.garden, required this.controller});

  final Garden garden;
  final LayoutEditorController controller;

  @override
  ConsumerState<_DesignerView> createState() => _DesignerViewState();
}

class _DesignerViewState extends ConsumerState<_DesignerView> {
  /// The tray's quick picks, most used first.
  static const List<ElementKind> _trayKinds = [
    ElementKind.roundGrowBag,
    ElementKind.roundPot,
    ElementKind.growBag,
    ElementKind.rectPlanter,
    ElementKind.raisedBed,
    ElementKind.hangingPot,
  ];

  final _canvasKey = GlobalKey<DesignerCanvasState>();
  final _fitRequest = ValueNotifier<int>(0);
  CanvasStyle _style = CanvasStyle.garden;

  /// The size last placed for each kind, which dragging from the tray uses.
  final Map<ElementKind, ElementPreset?> _lastSize = {};

  LayoutEditorController get _c => widget.controller;

  @override
  void dispose() {
    _fitRequest.dispose();
    super.dispose();
  }

  MeasurementFormatter _format(UnitSystem units) => MeasurementFormatter(
    units,
    locale: Localizations.localeOf(context).toLanguageTag(),
  );

  void _place(Placement p, {Vec2? at}) {
    final where =
        at ??
        _canvasKey.currentState?.viewportCenterWorld ??
        gardenCenter(_c.document);
    final preset = p.preset;
    if (preset == null) {
      _c.add(p.kind, where);
    } else {
      _c.addPreset(preset, where);
    }
    _lastSize[p.kind] = preset;
    unawaited(HapticFeedback.lightImpact());
  }

  Future<void> _pickSize(ElementKind kind, UnitSystem units) async {
    final placement = await showSizePicker(context, kind, _format(units));
    if (placement != null && mounted) _place(placement);
  }

  Future<void> _more(UnitSystem units) async {
    final placement = await showAddSheet(context, _format(units));
    if (placement != null && mounted) _place(placement);
  }

  Future<void> _markSun(UnitSystem units) async {
    final placement = await showSunShapeSheet(context, _format(units));
    if (placement != null && mounted) _place(placement);
  }

  /// Templates that fit this terrace, with what they would place.
  List<(LayoutTemplate, String, List<LayoutElement>)> _templates(
    AppLocalizations l10n,
  ) => [
    for (final t in LayoutTemplate.values)
      (
        t,
        switch (t) {
          LayoutTemplate.railingPlanters => l10n.templateRailing,
          LayoutTemplate.growBagRows => l10n.templateBagRows,
          LayoutTemplate.bedsAndBags => l10n.templateBedsBags,
        },
        buildTemplate(
          t,
          length: _c.document.length,
          width: _c.document.width,
          newId: ref.read(idGeneratorProvider).newId,
        ),
      ),
  ].where((t) => t.$3.isNotEmpty).toList();

  Future<void> _openObjects(UnitSystem units) async {
    final id = await showObjectsList(context, _c, _format(units));
    if (id == null || !mounted) return;
    _c.select(id);
    await showInspector(context, _c, units);
  }

  String _statusText(AppLocalizations l10n) => switch (_c.status) {
    SaveStatus.saved => l10n.designerSaved,
    SaveStatus.pending => l10n.designerNotSaved,
    SaveStatus.saving => l10n.designerSaving,
    SaveStatus.failed => l10n.designerSaveFailed,
  };

  /// Plant drawings for each container, from the garden's plantings.
  Map<String, List<PlantArtSpec>> _plants() {
    final plantings =
        ref.watch(gardenPlantingsProvider(widget.garden.id)).value ?? const [];
    final catalogue = ref.watch(plantCatalogueProvider).value;
    final byElement = <String, List<PlantArtSpec>>{};
    for (final p in plantings) {
      final id = p.elementId;
      if (id == null) continue;
      (byElement[id] ??= []).add(
        PlantArtSpec.of(
          p.speciesId,
          category: catalogue?.byId(p.speciesId)?.category,
        ),
      );
    }
    return byElement;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final units =
        ref.watch(settingsControllerProvider).value?.unitSystem ??
        UnitSystem.metric;
    final plants = _plants();

    return ListenableBuilder(
      listenable: _c,
      builder: (context, _) {
        final selected = _c.selected;
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.garden.name, style: theme.textTheme.titleMedium),
                Text(
                  _statusText(l10n),
                  style: theme.textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            actions: [
              IconButton(
                tooltip: l10n.designerUndo,
                icon: const Icon(Icons.undo),
                onPressed: _c.canUndo ? _c.undo : null,
              ),
              IconButton(
                tooltip: l10n.designerRedo,
                icon: const Icon(Icons.redo),
                onPressed: _c.canRedo ? _c.redo : null,
              ),
              IconButton(
                tooltip: l10n.designerObjects,
                icon: const Icon(Icons.list_alt_outlined),
                onPressed: () => _openObjects(units),
              ),
              IconButton(
                tooltip: l10n.designerSummary,
                icon: const Icon(Icons.pie_chart_outline),
                onPressed: () => showSpaceSummary(context, _c, _format(units)),
              ),
            ],
          ),
          // The whole body accepts drops, so an object let go over the
          // empty-state card or a chip still lands on the terrace beneath.
          body: DragTarget<Placement>(
            onAcceptWithDetails: (details) {
              final at = _canvasKey.currentState?.worldAtGlobal(
                details.offset,
              );
              if (at != null) _place(details.data, at: at);
            },
            builder: (context, _, _) => Stack(
              children: [
                Positioned.fill(
                  child: DesignerCanvas(
                    key: _canvasKey,
                    controller: _c,
                    unitSystem: units,
                    fitRequest: _fitRequest,
                    style: _style,
                    plants: plants,
                    selectionToolbar: (e) => _FloatingTools(
                      element: e,
                      onRotate: _c.rotateSelectedBy90,
                      onDuplicate: _c.duplicateSelected,
                      onRepeat: () => showRepeatSheet(context, _c, units),
                      onDelete: _c.deleteSelected,
                    ),
                  ),
                ),
                Positioned(
                  top: AppSpacing.md,
                  right: AppSpacing.md,
                  child: SegmentedButton<CanvasStyle>(
                    showSelectedIcon: false,
                    style: const ButtonStyle(
                      visualDensity: VisualDensity.compact,
                    ),
                    segments: [
                      ButtonSegment(
                        value: CanvasStyle.garden,
                        icon: const Icon(Icons.yard_outlined),
                        label: Text(l10n.designerViewGarden),
                      ),
                      ButtonSegment(
                        value: CanvasStyle.blueprint,
                        icon: const Icon(Icons.architecture),
                        label: Text(l10n.designerViewBlueprint),
                      ),
                    ],
                    selected: {_style},
                    onSelectionChanged: (s) => setState(() => _style = s.first),
                  ),
                ),
                Positioned(
                  top: AppSpacing.huge,
                  left: AppSpacing.md,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_c.errorCount > 0)
                        ActionChip(
                          avatar: Icon(
                            Icons.warning_amber_rounded,
                            color: theme.colorScheme.error,
                          ),
                          label: Text(l10n.designerProblems(_c.errorCount)),
                          onPressed: () => _openObjects(units),
                        ),
                      // Sun areas matter once there is something to grow.
                      if (_c.document.elements.any((e) => e.kind.isContainer) &&
                          !_c.document.elements.any(
                            (e) => e.kind.role == ElementRole.zone,
                          ))
                        Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.sm),
                          child: ActionChip(
                            avatar: const Icon(Icons.wb_sunny_outlined),
                            label: Text(l10n.designerMarkSun),
                            onPressed: () => _markSun(units),
                          ),
                        ),
                    ],
                  ),
                ),
                Positioned(
                  right: AppSpacing.md,
                  bottom: AppSpacing.md,
                  child: Column(
                    children: [
                      IconButton.filledTonal(
                        tooltip: l10n.designerSnap,
                        isSelected: _c.snapEnabled,
                        icon: const Icon(Icons.grid_off),
                        selectedIcon: const Icon(Icons.grid_on),
                        onPressed: () => _c.snapEnabled = !_c.snapEnabled,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      IconButton.filledTonal(
                        tooltip: l10n.designerFit,
                        icon: const Icon(Icons.fit_screen_outlined),
                        onPressed: () => _fitRequest.value++,
                      ),
                    ],
                  ),
                ),
                if (_c.document.elements.isEmpty)
                  Positioned(
                    left: AppSpacing.xl,
                    right: AppSpacing.xl,
                    top: AppSpacing.huge,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              l10n.designerEmptyHint,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge,
                            ),
                            if (_templates(l10n) case final templates
                                when templates.isNotEmpty) ...[
                              const SizedBox(height: AppSpacing.lg),
                              Text(
                                l10n.templateTitle,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.titleSmall,
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: AppSpacing.sm,
                                runSpacing: AppSpacing.sm,
                                children: [
                                  for (final (_, label, elements) in templates)
                                    ActionChip(
                                      label: Text(label),
                                      onPressed: () => _c.addAll(elements),
                                    ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          bottomNavigationBar: Material(
            color: theme.colorScheme.surface,
            elevation: 3,
            child: SafeArea(
              child: selected == null
                  ? _AddTray(
                      kinds: _trayKinds,
                      lastSize: _lastSize,
                      pxPerCm: _canvasKey.currentState?.transform?.pxPerCm ?? 1,
                      onTap: (kind) => _pickSize(kind, units),
                      onMore: () => _more(units),
                    )
                  : _SelectionBar(
                      element: selected,
                      size: [
                        _sizeText(selected, _format(units)),
                        if (selected.kind.isContainer)
                          if (sunFor(_c.document, selected) case final sun?)
                            l10n.sunHere(sun.label(l10n)),
                      ].join(' · '),
                      onEdit: () => showInspector(context, _c, units),
                      onDeselect: () => _c.select(null),
                    ),
            ),
          ),
        );
      },
    );
  }

  static String _sizeText(LayoutElement e, MeasurementFormatter format) {
    final w = format.length(Length.cm(e.width));
    if (e.kind.round) return 'Ø $w';
    return '$w × ${format.length(Length.cm(e.height))}';
  }
}

/// Quick picks along the bottom: tap to choose a size, or drag one straight
/// onto the terrace at the size last used.
class _AddTray extends StatelessWidget {
  const _AddTray({
    required this.kinds,
    required this.lastSize,
    required this.pxPerCm,
    required this.onTap,
    required this.onMore,
  });

  final List<ElementKind> kinds;
  final Map<ElementKind, ElementPreset?> lastSize;
  final double pxPerCm;
  final ValueChanged<ElementKind> onTap;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.xs,
          ),
          child: Text(
            l10n.designerTrayHint,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.xs,
            AppSpacing.md,
            AppSpacing.md,
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final kind in kinds) ...[
                  _draggable(context, (kind: kind, preset: lastSize[kind])),
                  const SizedBox(width: AppSpacing.sm),
                ],
                SizedBox(
                  width: KindTile.width,
                  child: Material(
                    color: theme.colorScheme.secondaryContainer,
                    borderRadius: AppRadii.mdAll,
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: onMore,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.md,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.add,
                              size: 32,
                              color: theme.colorScheme.onSecondaryContainer,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              l10n.designerMore,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.colorScheme.onSecondaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _draggable(BuildContext context, Placement placement) {
    final preset = placement.preset;
    final element = placementElement(placement);
    final b = element.shape.bounds;
    // The dragged object is shown at its real size on the current zoom.
    final side = (math.max(b.width, b.height) * pxPerCm / .9).clamp(
      24.0,
      320.0,
    );
    return Draggable<Placement>(
      data: placement,
      affinity: Axis.vertical,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: FractionalTranslation(
        translation: const Offset(-.5, -.5),
        child: Opacity(
          opacity: .85,
          child: ElementThumbnail(element: element, size: side),
        ),
      ),
      child: KindTile(
        placement: placement,
        caption: preset == null
            ? null
            : context.l10n.presetInches(preset.sizeLabel),
        onTap: () => onTap(placement.kind),
      ),
    );
  }
}

/// Quick actions floating next to the selected object.
class _FloatingTools extends StatelessWidget {
  const _FloatingTools({
    required this.element,
    required this.onRotate,
    required this.onDuplicate,
    required this.onRepeat,
    required this.onDelete,
  });

  final LayoutElement element;
  final VoidCallback onRotate;
  final VoidCallback onDuplicate;
  final VoidCallback onRepeat;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Material(
      elevation: 4,
      color: theme.colorScheme.surface,
      shape: const StadiumBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!element.kind.round)
              IconButton(
                tooltip: l10n.actionRotate,
                icon: const Icon(Icons.rotate_90_degrees_cw_outlined),
                onPressed: onRotate,
              ),
            IconButton(
              tooltip: l10n.actionDuplicate,
              icon: const Icon(Icons.copy_outlined),
              onPressed: onDuplicate,
            ),
            IconButton(
              tooltip: l10n.designerRepeat,
              icon: const Icon(Icons.view_week_outlined),
              onPressed: onRepeat,
            ),
            IconButton(
              tooltip: l10n.actionDelete,
              icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectionBar extends StatelessWidget {
  const _SelectionBar({
    required this.element,
    required this.size,
    required this.onEdit,
    required this.onDeselect,
  });

  final LayoutElement element;
  final String size;
  final VoidCallback onEdit;
  final VoidCallback onDeselect;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          IconButton(
            tooltip: l10n.actionDone,
            icon: const Icon(Icons.close),
            onPressed: onDeselect,
          ),
          ElementThumbnail(element: element),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  element.label ?? element.kind.label(l10n),
                  style: theme.textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  size,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          AppButton.secondary(label: l10n.actionEdit, onPressed: onEdit),
        ],
      ),
    );
  }
}
