import 'dart:async';

import 'package:flutter/material.dart';
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
import 'package:terrace_garden/features/garden/data/garden_providers.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/garden_designer/application/layout_editor_controller.dart';
import 'package:terrace_garden/features/garden_designer/data/designer_providers.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/presentation/designer_canvas.dart';
import 'package:terrace_garden/features/garden_designer/presentation/designer_labels.dart';
import 'package:terrace_garden/features/garden_designer/presentation/designer_sheets.dart';
import 'package:terrace_garden/features/settings/application/settings_controller.dart';
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
  final _canvasKey = GlobalKey<DesignerCanvasState>();
  final _fitRequest = ValueNotifier<int>(0);

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

  Future<void> _add() async {
    final kind = await showElementPalette(context);
    if (kind == null) return;
    final at =
        _canvasKey.currentState?.viewportCenterWorld ??
        gardenCenter(_c.document);
    _c.add(kind, at);
  }

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

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final units =
        ref.watch(settingsControllerProvider).value?.unitSystem ??
        UnitSystem.metric;

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
          body: Stack(
            children: [
              Positioned.fill(
                child: DesignerCanvas(
                  key: _canvasKey,
                  controller: _c,
                  unitSystem: units,
                  fitRequest: _fitRequest,
                ),
              ),
              if (_c.errorCount > 0)
                Positioned(
                  top: AppSpacing.md,
                  left: AppSpacing.md,
                  child: ActionChip(
                    avatar: Icon(
                      Icons.warning_amber_rounded,
                      color: theme.colorScheme.error,
                    ),
                    label: Text(l10n.designerProblems(_c.errorCount)),
                    onPressed: () => _openObjects(units),
                  ),
                ),
              if (_c.document.elements.isEmpty)
                Positioned(
                  left: AppSpacing.xl,
                  right: AppSpacing.xl,
                  top: AppSpacing.xl,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Text(
                        l10n.designerEmptyHint,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: selected == null
                  ? _ToolBar(
                      snap: _c.snapEnabled,
                      onAdd: _add,
                      onToggleSnap: () => _c.snapEnabled = !_c.snapEnabled,
                      onFit: () => _fitRequest.value++,
                    )
                  : _SelectionBar(
                      element: selected,
                      onEdit: () => showInspector(context, _c, units),
                      onRotate: selected.kind.round
                          ? null
                          : _c.rotateSelectedBy90,
                      onDuplicate: _c.duplicateSelected,
                      onDelete: _c.deleteSelected,
                      onDeselect: () => _c.select(null),
                    ),
            ),
          ),
        );
      },
    );
  }
}

class _ToolBar extends StatelessWidget {
  const _ToolBar({
    required this.snap,
    required this.onAdd,
    required this.onToggleSnap,
    required this.onFit,
  });

  final bool snap;
  final VoidCallback onAdd;
  final VoidCallback onToggleSnap;
  final VoidCallback onFit;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        FilterChip(
          label: Text(l10n.designerSnap),
          avatar: const Icon(Icons.grid_on, size: 18),
          showCheckmark: false,
          selected: snap,
          onSelected: (_) => onToggleSnap(),
        ),
        const SizedBox(width: AppSpacing.sm),
        IconButton(
          tooltip: l10n.designerFit,
          icon: const Icon(Icons.fit_screen_outlined),
          onPressed: onFit,
        ),
        const Spacer(),
        AppButton(label: l10n.designerAdd, icon: Icons.add, onPressed: onAdd),
      ],
    );
  }
}

class _SelectionBar extends StatelessWidget {
  const _SelectionBar({
    required this.element,
    required this.onEdit,
    required this.onRotate,
    required this.onDuplicate,
    required this.onDelete,
    required this.onDeselect,
  });

  final LayoutElement element;
  final VoidCallback onEdit;
  final VoidCallback? onRotate;
  final VoidCallback onDuplicate;
  final VoidCallback onDelete;
  final VoidCallback onDeselect;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        IconButton(
          tooltip: l10n.actionDone,
          icon: const Icon(Icons.close),
          onPressed: onDeselect,
        ),
        Expanded(
          child: Text(
            element.label ?? element.kind.label(l10n),
            style: Theme.of(context).textTheme.titleSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
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
          tooltip: l10n.actionDelete,
          icon: const Icon(Icons.delete_outline),
          onPressed: onDelete,
        ),
        const SizedBox(width: AppSpacing.xs),
        AppButton.secondary(label: l10n.actionEdit, onPressed: onEdit),
      ],
    );
  }
}
