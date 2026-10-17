import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/core/widgets/app_button.dart';
import 'package:terrace_garden/core/widgets/dialogs.dart';
import 'package:terrace_garden/core/widgets/error_state.dart';
import 'package:terrace_garden/core/widgets/section_header.dart';
import 'package:terrace_garden/features/garden/data/garden_providers.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/garden/presentation/widgets/garden_form_sections.dart';
import 'package:terrace_garden/features/settings/application/settings_controller.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// GDN-03. Creates a garden ([gardenId] null) or edits one. All fields are
/// optional except the name; leaving with unsaved changes asks first.
class GardenFormScreen extends ConsumerStatefulWidget {
  const GardenFormScreen({this.gardenId, super.key});

  final String? gardenId;

  @override
  ConsumerState<GardenFormScreen> createState() => _GardenFormScreenState();
}

class _GardenFormScreenState extends ConsumerState<GardenFormScreen> {
  GardenDraft? _initial;
  GardenDraft? _draft;
  bool _showErrors = false;
  bool _saving = false;

  bool get _isEditing => widget.gardenId != null;
  bool get _dirty => _draft != _initial;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    final id = widget.gardenId;
    if (id == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final draft = GardenDraft(name: context.l10n.defaultGardenName);
        setState(() => _initial = _draft = draft);
      });
      return;
    }
    final garden = await ref.read(gardenRepositoryProvider).find(id);
    if (!mounted || garden == null) return;
    final draft = GardenDraft.fromGarden(garden);
    setState(() => _initial = _draft = draft);
  }

  Future<void> _save() async {
    final draft = _draft!;
    if (!draft.isValid) {
      setState(() => _showErrors = true);
      return;
    }
    setState(() => _saving = true);
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    final repository = ref.read(gardenRepositoryProvider);
    final result = _isEditing
        ? await repository.update(widget.gardenId!, draft)
        : await repository.create(draft);
    if (!mounted) return;
    setState(() => _saving = false);
    switch (result) {
      case Ok(:final value):
        _initial = _draft;
        messenger.showSnackBar(SnackBar(content: Text(l10n.gardenSaved)));
        if (_isEditing) {
          router.pop();
        } else {
          router.go(AppRoutes.gardenDetail(value.id));
        }
      case Err(:final failure):
        messenger.showSnackBar(
          SnackBar(content: Text(ErrorState.messageFor(l10n, failure))),
        );
    }
  }

  Future<void> _confirmDiscard() async {
    final l10n = context.l10n;
    final navigator = Navigator.of(context);
    final discard = await showConfirmDialog(
      context,
      title: l10n.unsavedTitle,
      message: l10n.unsavedBody,
      confirmLabel: l10n.unsavedDiscard,
      destructive: true,
    );
    if (discard) {
      _initial = _draft;
      navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final draft = _draft;
    final units =
        ref.watch(settingsControllerProvider).value?.unitSystem ??
        UnitSystem.metric;
    final gutter = AppSpacing.gutterFor(MediaQuery.sizeOf(context).width);

    return PopScope(
      canPop: !_dirty,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) unawaited(_confirmDiscard());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEditing ? l10n.gardenEditTitle : l10n.gardenNew),
        ),
        body: draft == null
            ? const Center(child: CircularProgressIndicator())
            : Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppBreakpoints.readableMaxWidth,
                  ),
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(
                      gutter,
                      AppSpacing.lg,
                      gutter,
                      AppSpacing.xxl,
                    ),
                    children: [
                      SectionHeader(title: l10n.gardenSectionSpace),
                      GardenSpaceSection(
                        draft: draft,
                        unitSystem: units,
                        errors: _showErrors ? draft.validate() : const {},
                        onEdit: (edit) =>
                            setState(() => _draft = edit(_draft!)),
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      SectionHeader(title: l10n.gardenSectionLight),
                      GardenLightSection(
                        draft: draft,
                        onEdit: (edit) =>
                            setState(() => _draft = edit(_draft!)),
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      SectionHeader(title: l10n.gardenSectionGoals),
                      GardenGoalsSection(
                        draft: draft,
                        onEdit: (edit) =>
                            setState(() => _draft = edit(_draft!)),
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      GardenNotesSection(
                        draft: draft,
                        onEdit: (edit) =>
                            setState(() => _draft = edit(_draft!)),
                      ),
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              gutter,
              AppSpacing.sm,
              gutter,
              AppSpacing.md,
            ),
            child: AppButton(
              label: l10n.actionSave,
              isLoading: _saving,
              expand: true,
              onPressed: draft == null ? null : _save,
            ),
          ),
        ),
      ),
    );
  }
}
