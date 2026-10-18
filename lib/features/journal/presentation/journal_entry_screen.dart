import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/storage/photo_picker.dart';
import 'package:terrace_garden/core/storage/storage_providers.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/core/widgets/app_button.dart';
import 'package:terrace_garden/core/widgets/error_state.dart';
import 'package:terrace_garden/core/widgets/selectable_chip_group.dart';
import 'package:terrace_garden/features/garden/garden.dart';
import 'package:terrace_garden/features/journal/data/drift_journal_repository.dart';
import 'package:terrace_garden/features/journal/data/journal_providers.dart';
import 'package:terrace_garden/features/journal/domain/journal_entry.dart';
import 'package:terrace_garden/features/journal/presentation/journal_labels.dart';
import 'package:terrace_garden/features/plant_catalog/plant_catalog.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';
import 'package:terrace_garden/features/plantings/plantings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// JRN-02. A dated note with optional photos, plant, milestone and harvest.
class JournalEntryScreen extends ConsumerStatefulWidget {
  const JournalEntryScreen({this.gardenId, this.plantingId, super.key});

  final String? gardenId;
  final String? plantingId;

  @override
  ConsumerState<JournalEntryScreen> createState() => _JournalEntryScreenState();
}

class _JournalEntryScreenState extends ConsumerState<JournalEntryScreen> {
  String? _gardenId;
  String? _plantingId;
  late LocalDate _date;
  Milestone? _milestone;
  HarvestUnit? _unit;
  final _quantity = TextEditingController();
  final _note = TextEditingController();
  final _photos = <String>[];
  String? _error;
  bool _saving = false;

  LocalDate get _today => LocalDate.fromDateTime(ref.read(clockProvider).now());

  @override
  void initState() {
    super.initState();
    _gardenId = widget.gardenId;
    _plantingId = widget.plantingId;
    _date = _today;
  }

  @override
  void dispose() {
    _quantity.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _addPhotos() async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final source = await showPhotoSourceSheet(context);
    if (source == null) return;
    final picked = await ref
        .read(photoPickerProvider)
        .pick(source, multiple: source == PhotoSource.gallery);
    switch (picked) {
      case Err(failure: PermissionFailure()):
        messenger.showSnackBar(SnackBar(content: Text(l10n.photoPermission)));
      case Err(:final failure):
        messenger.showSnackBar(
          SnackBar(content: Text(ErrorState.messageFor(l10n, failure))),
        );
      case Ok(value: final paths):
        setState(() {
          _photos.addAll(paths);
          if (_photos.length > DriftJournalRepository.maxPhotos) {
            _photos.removeRange(
              DriftJournalRepository.maxPhotos,
              _photos.length,
            );
          }
        });
    }
  }

  Future<void> _pickDate() async {
    final today = _today;
    final picked = await showDatePicker(
      context: context,
      initialDate: _date.toLocalDateTime(),
      firstDate: today.addDays(-5 * 365).toLocalDateTime(),
      lastDate: today.toLocalDateTime(),
    );
    if (picked != null) setState(() => _date = LocalDate.fromDateTime(picked));
  }

  Future<void> _save(String gardenId) async {
    final l10n = context.l10n;
    final harvest = _milestone == Milestone.harvest;
    final quantityText = _quantity.text.trim().replaceAll(',', '.');
    final quantity = quantityText.isEmpty
        ? null
        : double.tryParse(quantityText);
    if (harvest && quantityText.isNotEmpty && quantity == null) {
      setState(() => _error = l10n.journalQuantityError);
      return;
    }
    final draft = JournalDraft(
      gardenId: gardenId,
      plantingId: _plantingId,
      date: _date,
      note: _note.text,
      milestone: _milestone,
      harvestQuantity: harvest ? quantity : null,
      harvestUnit: harvest && quantity != null ? _unit : null,
    );
    final errors = draft.validate(today: _today, photoCount: _photos.length);
    if (errors.isNotEmpty) {
      setState(
        () => _error = errors.first == 'empty'
            ? l10n.journalEmptyError
            : l10n.journalQuantityError,
      );
      return;
    }
    setState(() {
      _error = null;
      _saving = true;
    });
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final result = await ref
        .read(journalRepositoryProvider)
        .create(draft, photoSourcePaths: _photos);
    if (!mounted) return;
    switch (result) {
      case Ok():
        messenger.showSnackBar(SnackBar(content: Text(l10n.journalSaved)));
        navigator.pop();
      case Err(:final failure):
        setState(() => _saving = false);
        messenger.showSnackBar(
          SnackBar(content: Text(ErrorState.messageFor(l10n, failure))),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final gardens = ref.watch(gardensProvider).value;
    final catalogue = ref.watch(plantCatalogueProvider).value;
    final gutter = AppSpacing.gutterFor(MediaQuery.sizeOf(context).width);
    final locale = Localizations.localeOf(context).toLanguageTag();

    if (gardens == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final garden =
        gardens.where((g) => g.id == _gardenId).firstOrNull ??
        gardens.firstOrNull;
    final plantings = garden == null
        ? const <Planting>[]
        : (ref.watch(gardenPlantingsProvider(garden.id)).value ?? const []);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.journalNewTitle)),
      body: garden == null
          ? Center(child: Text(l10n.plantingNoGardens))
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
                    if (gardens.length > 1) ...[
                      _Label(l10n.journalGarden),
                      SelectableChipGroup<String>(
                        multiSelect: false,
                        allowEmpty: false,
                        options: [
                          for (final g in gardens)
                            ChipOption(value: g.id, label: g.name),
                        ],
                        selected: {garden.id},
                        onChanged: (v) => setState(() {
                          _gardenId = v.first;
                          _plantingId = null;
                        }),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                    if (plantings.isNotEmpty) ...[
                      _Label(l10n.journalPlant),
                      SelectableChipGroup<String>(
                        multiSelect: false,
                        allowEmpty: false,
                        options: [
                          ChipOption(value: '', label: l10n.journalWholeGarden),
                          for (final p in plantings)
                            ChipOption(
                              value: p.id,
                              label:
                                  catalogue?.byId(p.speciesId)?.name(l10n) ??
                                  l10n.plantingUnknownSpecies,
                            ),
                        ],
                        selected: {_plantingId ?? ''},
                        onChanged: (v) => setState(
                          () => _plantingId = v.first.isEmpty ? null : v.first,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                    _Label(l10n.journalDate),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.event_outlined),
                        label: Text(
                          DateFormat.yMMMd(
                            locale,
                          ).format(_date.toLocalDateTime()),
                        ),
                        onPressed: _pickDate,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _Label(l10n.journalMilestone),
                    SelectableChipGroup<Milestone>(
                      multiSelect: false,
                      options: [
                        for (final m in Milestone.values)
                          ChipOption(value: m, label: m.label(l10n)),
                      ],
                      selected: {?_milestone},
                      onChanged: (v) =>
                          setState(() => _milestone = v.firstOrNull),
                    ),
                    if (_milestone == Milestone.harvest) ...[
                      const SizedBox(height: AppSpacing.lg),
                      _Label(l10n.journalHarvestAmount),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 120,
                            child: TextField(
                              controller: _quantity,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              decoration: InputDecoration(
                                labelText: l10n.journalHarvestAmount,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: SelectableChipGroup<HarvestUnit>(
                              multiSelect: false,
                              options: [
                                for (final u in HarvestUnit.values)
                                  ChipOption(value: u, label: u.label(l10n)),
                              ],
                              selected: {?_unit},
                              onChanged: (v) =>
                                  setState(() => _unit = v.firstOrNull),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: AppSpacing.lg),
                    TextField(
                      controller: _note,
                      maxLength: JournalDraft.maxNoteLength,
                      minLines: 2,
                      maxLines: 6,
                      decoration: InputDecoration(
                        labelText: l10n.journalNote,
                        hintText: l10n.journalNoteHint,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _Label(l10n.journalPhotos),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        for (final (i, path) in _photos.indexed)
                          _PickedPhoto(
                            path: path,
                            removeLabel: l10n.journalRemovePhoto,
                            onRemove: () => setState(() => _photos.removeAt(i)),
                          ),
                        if (_photos.length < DriftJournalRepository.maxPhotos)
                          OutlinedButton.icon(
                            icon: const Icon(Icons.add_a_photo_outlined),
                            label: Text(l10n.journalAddPhoto),
                            onPressed: _addPhotos,
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.journalPhotoLimit(DriftJournalRepository.maxPhotos),
                      style: theme.textTheme.bodySmall,
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        _error!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.lg),
                    AppButton(
                      label: l10n.journalSave,
                      icon: Icons.check,
                      onPressed: _saving ? null : () => _save(garden.id),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
    child: Text(text, style: Theme.of(context).textTheme.titleSmall),
  );
}

class _PickedPhoto extends StatelessWidget {
  const _PickedPhoto({
    required this.path,
    required this.removeLabel,
    required this.onRemove,
  });

  final String path;
  final String removeLabel;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 88,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: AppRadii.mdAll,
            child: Image.file(
              File(path),
              fit: BoxFit.cover,
              cacheWidth: 264,
              excludeFromSemantics: true,
              errorBuilder: (_, _, _) => const ColoredBox(
                color: Colors.black12,
                child: Icon(Icons.image_outlined),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: IconButton.filledTonal(
              visualDensity: VisualDensity.compact,
              tooltip: removeLabel,
              icon: const Icon(Icons.close, size: 18),
              onPressed: onRemove,
            ),
          ),
        ],
      ),
    );
  }
}
