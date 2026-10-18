import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/app/theme/care_colors.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/core/units/measurement_formatter.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/core/widgets/app_button.dart';
import 'package:terrace_garden/core/widgets/dialogs.dart';
import 'package:terrace_garden/core/widgets/error_state.dart';
import 'package:terrace_garden/core/widgets/selectable_chip_group.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';
import 'package:terrace_garden/features/garden/garden.dart';
import 'package:terrace_garden/features/garden_designer/garden_designer.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plant_catalog/plant_catalog.dart';
import 'package:terrace_garden/features/plantings/data/planting_providers.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';
import 'package:terrace_garden/features/plantings/domain/planting_fit.dart';
import 'package:terrace_garden/features/plantings/presentation/planting_labels.dart';
import 'package:terrace_garden/features/settings/settings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// PLT-05. Adds [species] to a garden (or edits [existing]), optionally in a
/// container from the layout, with fit warnings from documented figures.
/// Shows a confirmation snack bar when saved.
Future<void> showPlantingSheet(
  BuildContext context, {
  required PlantSpecies species,
  String? gardenId,
  Planting? existing,
}) async {
  final l10n = context.l10n;
  final messenger = ScaffoldMessenger.of(context);
  final saved = await showAppBottomSheet<(Planting, String)>(
    context,
    title: existing == null
        ? l10n.plantingAddTitle(species.commonName)
        : l10n.plantingEditTitle(species.commonName),
    builder: (context) => PlantingForm(
      species: species,
      gardenId: existing?.gardenId ?? gardenId,
      existing: existing,
    ),
  );
  if (saved == null || existing != null) return;
  final (_, gardenName) = saved;
  messenger.showSnackBar(
    SnackBar(content: Text(l10n.plantingAdded(species.commonName, gardenName))),
  );
}

class PlantingForm extends ConsumerStatefulWidget {
  const PlantingForm({
    required this.species,
    this.gardenId,
    this.existing,
    super.key,
  });

  final PlantSpecies species;
  final String? gardenId;
  final Planting? existing;

  @override
  ConsumerState<PlantingForm> createState() => _PlantingFormState();
}

class _PlantingFormState extends ConsumerState<PlantingForm> {
  String? _gardenId;
  String? _elementId;
  late int _quantity;
  late LocalDate _plantedOn;
  late PlantingStart _startedFrom;
  late final TextEditingController _notes;
  bool _saving = false;

  LocalDate get _today => LocalDate.fromDateTime(ref.read(clockProvider).now());

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _gardenId = widget.gardenId;
    _elementId = e?.elementId;
    _quantity = e?.quantity ?? 1;
    _plantedOn = e?.plantedOn ?? _today;
    _startedFrom =
        e?.startedFrom ??
        (widget.species.propagation?.method == PropagationMethod.transplant
            ? PlantingStart.seedling
            : PlantingStart.seed);
    _notes = TextEditingController(text: e?.notes);
  }

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final today = _today;
    final picked = await showDatePicker(
      context: context,
      initialDate: _plantedOn.toLocalDateTime(),
      firstDate: today.addDays(-5 * 365).toLocalDateTime(),
      lastDate: today.toLocalDateTime(),
    );
    if (picked != null) {
      setState(() => _plantedOn = LocalDate.fromDateTime(picked));
    }
  }

  Future<void> _save(Garden garden) async {
    setState(() => _saving = true);
    final notes = _notes.text.trim();
    final draft = PlantingDraft(
      gardenId: garden.id,
      speciesId: widget.species.id,
      elementId: _elementId,
      quantity: _quantity,
      plantedOn: _plantedOn,
      startedFrom: _startedFrom,
      notes: notes.isEmpty ? null : notes,
    );
    final repository = ref.read(plantingRepositoryProvider);
    final existing = widget.existing;
    final result = existing == null
        ? await repository.create(draft)
        : await repository.update(existing.id, draft);
    if (!mounted) return;
    switch (result) {
      case Ok(:final value):
        Navigator.of(context).pop((value, garden.name));
      case Err(:final failure):
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(ErrorState.messageFor(context.l10n, failure))),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final gardens = ref.watch(gardensProvider).value;
    if (gardens == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (gardens.isEmpty) {
      return Text(l10n.plantingNoGardens, style: theme.textTheme.bodyLarge);
    }
    final garden =
        gardens.where((g) => g.id == _gardenId).firstOrNull ?? gardens.first;
    final units =
        ref.watch(settingsControllerProvider).value?.unitSystem ??
        UnitSystem.metric;
    final format = MeasurementFormatter(
      units,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    final elements =
        ref.watch(layoutElementsProvider(garden.id)).value ?? const [];
    final containers = layoutContainers(elements);
    final plantings =
        ref.watch(gardenPlantingsProvider(garden.id)).value ?? const [];
    final container = containers.where((c) => c.id == _elementId).firstOrNull;
    final issues = container == null
        ? const <PlantingIssue>[]
        : PlantingFit.check(
            species: widget.species,
            container: container,
            quantity: _quantity,
            othersInContainer: plantings
                .where(
                  (p) =>
                      p.elementId == container.id &&
                      p.id != widget.existing?.id,
                )
                .toList(),
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (gardens.length > 1 && widget.existing == null) ...[
          _Label(l10n.plantingGarden),
          SelectableChipGroup<String>(
            multiSelect: false,
            allowEmpty: false,
            options: [
              for (final g in gardens) ChipOption(value: g.id, label: g.name),
            ],
            selected: {garden.id},
            onChanged: (ids) => setState(() {
              _gardenId = ids.first;
              _elementId = null;
            }),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
        _Label(l10n.plantingContainer),
        SelectableChipGroup<String>(
          multiSelect: false,
          allowEmpty: false,
          options: [
            ChipOption(value: '', label: l10n.plantingNotPlaced),
            for (final c in containers)
              ChipOption(
                value: c.id,
                label: containerDescription(l10n, format, c, containers),
              ),
          ],
          selected: {container?.id ?? ''},
          onChanged: (ids) => setState(
            () => _elementId = ids.first.isEmpty ? null : ids.first,
          ),
        ),
        for (final issue in issues)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 20,
                  color: context.careColors.warning,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    issue.message(l10n, format),
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: AppSpacing.lg),
        _Label(l10n.plantingQuantity),
        _QuantityStepper(
          value: _quantity,
          label: l10n.plantingQuantity,
          onChanged: (v) => setState(() => _quantity = v),
        ),
        const SizedBox(height: AppSpacing.lg),
        _Label(l10n.plantingPlantedOn),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.event_outlined),
            label: Text(
              DateFormat.yMMMd(
                Localizations.localeOf(context).toLanguageTag(),
              ).format(_plantedOn.toLocalDateTime()),
            ),
            onPressed: _pickDate,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _Label(l10n.plantingStartedFrom),
        SelectableChipGroup<PlantingStart>(
          multiSelect: false,
          allowEmpty: false,
          options: [
            for (final s in PlantingStart.values)
              ChipOption(value: s, label: s.label(l10n)),
          ],
          selected: {_startedFrom},
          onChanged: (v) => setState(() => _startedFrom = v.first),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextField(
          controller: _notes,
          maxLength: 500,
          maxLines: 3,
          minLines: 1,
          decoration: InputDecoration(labelText: l10n.plantingNotes),
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          label: widget.existing == null
              ? l10n.plantingSave
              : l10n.plantingUpdate,
          icon: Icons.check,
          onPressed: _saving ? null : () => _save(garden),
        ),
      ],
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

class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({
    required this.value,
    required this.label,
    required this.onChanged,
  });

  final int value;
  final String label;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton.outlined(
          tooltip: context.l10n.quantityDecrease,
          icon: const Icon(Icons.remove),
          onPressed: value > 1 ? () => onChanged(value - 1) : null,
        ),
        SizedBox(
          width: 56,
          child: Semantics(
            label: label,
            value: '$value',
            child: ExcludeSemantics(
              child: Text(
                '$value',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ),
        IconButton.outlined(
          tooltip: context.l10n.quantityIncrease,
          icon: const Icon(Icons.add),
          onPressed: value < PlantingDraft.maxQuantity
              ? () => onChanged(value + 1)
              : null,
        ),
      ],
    );
  }
}
