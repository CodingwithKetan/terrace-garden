import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';

class ChipOption<T> {
  const ChipOption({required this.value, required this.label, this.icon});

  final T value;
  final String label;
  final IconData? icon;
}

/// A wrapping group of filter chips for single or multiple selection
/// (garden goals, catalogue filters).
class SelectableChipGroup<T> extends StatelessWidget {
  const SelectableChipGroup({
    required this.options,
    required this.selected,
    required this.onChanged,
    this.multiSelect = true,
    this.allowEmpty = true,
    super.key,
  });

  final List<ChipOption<T>> options;
  final Set<T> selected;
  final ValueChanged<Set<T>> onChanged;
  final bool multiSelect;

  /// In single-select mode, whether tapping the selected chip clears it.
  final bool allowEmpty;

  void _toggle(T value) {
    final isSelected = selected.contains(value);
    if (multiSelect) {
      onChanged(
        isSelected ? ({...selected}..remove(value)) : {...selected, value},
      );
    } else if (isSelected) {
      if (allowEmpty) onChanged(<T>{});
    } else {
      onChanged({value});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final option in options)
          FilterChip(
            label: Text(option.label),
            avatar: option.icon == null ? null : Icon(option.icon, size: 18),
            selected: selected.contains(option.value),
            showCheckmark: option.icon == null,
            onSelected: (_) => _toggle(option.value),
          ),
      ],
    );
  }
}
