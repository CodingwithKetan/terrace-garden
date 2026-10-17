import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/core/widgets/dimension_field.dart';
import 'package:terrace_garden/core/widgets/selectable_chip_group.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden/presentation/garden_labels.dart';
import 'package:terrace_garden/features/garden/presentation/widgets/city_picker_sheet.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// An edit applied to the latest draft. Sections send edits rather than whole
/// drafts so two changes in the same frame (or after an awaited picker) can't
/// overwrite each other.
typedef DraftEdit = GardenDraft Function(GardenDraft draft);

/// Form sections for a [GardenDraft], shared by onboarding (one section per
/// step) and the edit screen (all sections) so both stay consistent.
class GardenSpaceSection extends StatelessWidget {
  const GardenSpaceSection({
    required this.draft,
    required this.onEdit,
    required this.unitSystem,
    this.errors = const {},
    super.key,
  });

  final GardenDraft draft;
  final ValueChanged<DraftEdit> onEdit;
  final UnitSystem unitSystem;

  /// Errors to display; pass them only after the user tried to continue.
  final Set<GardenDraftError> errors;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final unit = unitSystem == UnitSystem.metric
        ? l10n.unitMetresShort
        : l10n.unitFeetShort;

    String? nameError() {
      if (errors.contains(GardenDraftError.nameRequired)) {
        return l10n.errNameRequired;
      }
      if (errors.contains(GardenDraftError.nameTooLong)) {
        return l10n.errNameTooLong;
      }
      return null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: draft.name,
          textCapitalization: TextCapitalization.sentences,
          maxLength: GardenDraft.maxNameLength,
          decoration: InputDecoration(
            labelText: l10n.fieldGardenName,
            errorText: nameError(),
          ),
          onChanged: (value) => onEdit((d) => d.copyWith(name: value)),
        ),
        const SizedBox(height: AppSpacing.lg),
        _Labeled(
          label: l10n.fieldSpaceType,
          child: SelectableChipGroup<SpaceType>(
            multiSelect: false,
            allowEmpty: false,
            options: [
              for (final type in SpaceType.values)
                ChipOption(
                  value: type,
                  label: type.label(l10n),
                  icon: type.icon,
                ),
            ],
            selected: {draft.spaceType},
            onChanged: (s) => onEdit((d) => d.copyWith(spaceType: s.single)),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(l10n.fieldDimensions, style: theme.textTheme.titleSmall),
        const SizedBox(height: AppSpacing.xs),
        Text(l10n.fieldDimensionsHelp, style: theme.textTheme.bodySmall),
        const SizedBox(height: AppSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DimensionField(
                label: l10n.fieldLength,
                unitSystem: unitSystem,
                unitLabel: unit,
                value: draft.length,
                errorText: errors.contains(GardenDraftError.lengthOutOfRange)
                    ? l10n.errDimension
                    : null,
                onChanged: (v) => onEdit((d) => d.copyWith(length: v)),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: DimensionField(
                label: l10n.fieldWidth,
                unitSystem: unitSystem,
                unitLabel: unit,
                value: draft.width,
                errorText: errors.contains(GardenDraftError.widthOutOfRange)
                    ? l10n.errDimension
                    : null,
                onChanged: (v) => onEdit((d) => d.copyWith(width: v)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class GardenLightSection extends StatelessWidget {
  const GardenLightSection({
    required this.draft,
    required this.onEdit,
    super.key,
  });

  final GardenDraft draft;
  final ValueChanged<DraftEdit> onEdit;

  Future<void> _pickCity(BuildContext context) async {
    final choice = await showCityPicker(context);
    if (choice == null) return;
    onEdit(
      (d) =>
          d.copyWith(cityName: choice.city?.name, region: choice.city?.region),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final hasCityWithoutRegion = draft.cityName != null && draft.region == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Labeled(
          label: l10n.fieldCity,
          child: OutlinedButton.icon(
            onPressed: () => _pickCity(context),
            icon: const Icon(Icons.location_on_outlined),
            label: Text(draft.cityName ?? l10n.cityChoose),
          ),
        ),
        if (hasCityWithoutRegion) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.cityNoRegion, style: theme.textTheme.bodySmall),
        ],
        const SizedBox(height: AppSpacing.xl),
        _EnumChips<SunExposure>(
          label: l10n.fieldSun,
          values: SunExposure.values,
          selected: draft.sun,
          labelOf: (v) => v.label(l10n),
          onSelected: (v) => onEdit((d) => d.copyWith(sun: v)),
        ),
        const SizedBox(height: AppSpacing.xl),
        _EnumChips<Facing>(
          label: l10n.fieldFacing,
          values: Facing.values,
          selected: draft.facing,
          labelOf: (v) => v.label(l10n),
          onSelected: (v) => onEdit((d) => d.copyWith(facing: v)),
        ),
        const SizedBox(height: AppSpacing.xl),
        _EnumChips<WindExposure>(
          label: l10n.fieldWind,
          values: WindExposure.values,
          selected: draft.wind,
          labelOf: (v) => v.label(l10n),
          onSelected: (v) => onEdit((d) => d.copyWith(wind: v)),
        ),
        const SizedBox(height: AppSpacing.xl),
        _EnumChips<WaterAccess>(
          label: l10n.fieldWater,
          values: WaterAccess.values,
          selected: draft.water,
          labelOf: (v) => v.label(l10n),
          onSelected: (v) => onEdit((d) => d.copyWith(water: v)),
        ),
      ],
    );
  }
}

class GardenGoalsSection extends StatelessWidget {
  const GardenGoalsSection({
    required this.draft,
    required this.onEdit,
    super.key,
  });

  final GardenDraft draft;
  final ValueChanged<DraftEdit> onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Labeled(
          label: l10n.fieldGoals,
          child: SelectableChipGroup<GardenGoal>(
            options: [
              for (final goal in GardenGoal.values)
                ChipOption(value: goal, label: goal.label(l10n)),
            ],
            selected: draft.goals,
            onChanged: (goals) => onEdit((d) => d.copyWith(goals: goals)),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        _Labeled(
          label: l10n.fieldExperience,
          child: SelectableChipGroup<ExperienceLevel>(
            multiSelect: false,
            options: [
              for (final level in ExperienceLevel.values)
                ChipOption(value: level, label: level.label(l10n)),
            ],
            selected: {?draft.experience},
            onChanged: (s) => onEdit(
              (d) => d.copyWith(experience: s.isEmpty ? null : s.single),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        _EnumChips<WeeklyTime>(
          label: l10n.fieldWeeklyTime,
          values: WeeklyTime.values,
          selected: draft.weeklyTime,
          labelOf: (v) => v.label(l10n),
          onSelected: (v) => onEdit((d) => d.copyWith(weeklyTime: v)),
        ),
        const SizedBox(height: AppSpacing.xl),
        _EnumChips<BudgetBand>(
          label: l10n.fieldBudget,
          values: BudgetBand.values,
          selected: draft.budget,
          labelOf: (v) => v.label(l10n),
          onSelected: (v) => onEdit((d) => d.copyWith(budget: v)),
        ),
        const SizedBox(height: AppSpacing.xl),
        _Labeled(
          label: l10n.fieldStyle,
          child: SelectableChipGroup<GardenStyle>(
            multiSelect: false,
            options: [
              for (final style in GardenStyle.values)
                ChipOption(value: style, label: style.label(l10n)),
            ],
            selected: {?draft.style},
            onChanged: (s) =>
                onEdit((d) => d.copyWith(style: s.isEmpty ? null : s.single)),
          ),
        ),
      ],
    );
  }
}

class GardenNotesSection extends StatelessWidget {
  const GardenNotesSection({
    required this.draft,
    required this.onEdit,
    super.key,
  });

  final GardenDraft draft;
  final ValueChanged<DraftEdit> onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return TextFormField(
      initialValue: draft.notes,
      minLines: 3,
      maxLines: 6,
      maxLength: 500,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: l10n.fieldNotes,
        hintText: l10n.fieldNotesHint,
        alignLabelWithHint: true,
      ),
      onChanged: (value) => onEdit((d) => d.copyWith(notes: value)),
    );
  }
}

/// Single-choice chips for an enum whose last value means "Not sure".
class _EnumChips<T extends Enum> extends StatelessWidget {
  const _EnumChips({
    required this.label,
    required this.values,
    required this.selected,
    required this.labelOf,
    required this.onSelected,
  });

  final String label;
  final List<T> values;
  final T selected;
  final String Function(T) labelOf;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return _Labeled(
      label: label,
      child: SelectableChipGroup<T>(
        multiSelect: false,
        allowEmpty: false,
        options: [
          for (final v in values) ChipOption(value: v, label: labelOf(v)),
        ],
        selected: {selected},
        onChanged: (s) => onSelected(s.single),
      ),
    );
  }
}

class _Labeled extends StatelessWidget {
  const _Labeled({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        child,
      ],
    );
  }
}
