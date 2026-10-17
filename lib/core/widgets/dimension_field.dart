import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:terrace_garden/core/units/measurements.dart';

/// A numeric field for a garden side, entered in metres (metric) or feet
/// (imperial) and reported as a canonical [Length]. Empty means "not set".
class DimensionField extends StatefulWidget {
  const DimensionField({
    required this.label,
    required this.unitSystem,
    required this.unitLabel,
    required this.value,
    required this.onChanged,
    this.errorText,
    super.key,
  });

  final String label;
  final UnitSystem unitSystem;

  /// Localised unit suffix ("m" or "ft").
  final String unitLabel;
  final Length? value;

  /// Called with null when the field is empty or not a number.
  final ValueChanged<Length?> onChanged;
  final String? errorText;

  /// Parses user input in [system] units; accepts "." or "," as decimal mark.
  static Length? parse(String text, UnitSystem system) {
    final normalised = text.trim().replaceAll(',', '.');
    if (normalised.isEmpty) return null;
    final number = double.tryParse(normalised);
    if (number == null) return null;
    return switch (system) {
      UnitSystem.metric => Length.metres(number),
      UnitSystem.imperial => Length.feet(number),
    };
  }

  /// Formats [length] for editing (no unit, up to 2 decimals).
  static String format(Length? length, UnitSystem system, String locale) {
    if (length == null) return '';
    final value = switch (system) {
      UnitSystem.metric => length.metres,
      UnitSystem.imperial => length.feet,
    };
    return NumberFormat('0.##', locale).format(value);
  }

  @override
  State<DimensionField> createState() => _DimensionFieldState();
}

class _DimensionFieldState extends State<DimensionField> {
  late final TextEditingController _controller = TextEditingController();
  UnitSystem? _formattedFor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncText();
  }

  @override
  void didUpdateWidget(DimensionField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-format only when the unit system changes; otherwise keep what the
    // user is typing.
    if (oldWidget.unitSystem != widget.unitSystem) _syncText();
  }

  void _syncText() {
    if (_formattedFor == widget.unitSystem) return;
    _formattedFor = widget.unitSystem;
    _controller.text = DimensionField.format(
      widget.value,
      widget.unitSystem,
      Localizations.localeOf(context).toLanguageTag(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]'))],
      decoration: InputDecoration(
        labelText: widget.label,
        suffixText: widget.unitLabel,
        errorText: widget.errorText,
      ),
      onChanged: (text) =>
          widget.onChanged(DimensionField.parse(text, widget.unitSystem)),
    );
  }
}
