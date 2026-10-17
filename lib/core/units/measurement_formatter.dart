import 'package:intl/intl.dart';
import 'package:terrace_garden/core/units/measurements.dart';

/// Formats measurements for display in the user's unit system and locale.
///
/// Rounding rules (deliberately coarse; garden tasks don't need millimetres):
/// - metric lengths under 1 m: centimetres, up to 1 decimal ("45 cm");
///   from 1 m: metres, up to 2 decimals ("1.2 m")
/// - imperial lengths under 1 ft: inches, up to 1 decimal ("8.5 in");
///   from 1 ft: whole feet and inches ("3 ft 4 in")
/// - areas: m² (2 decimals) or sq ft (1 decimal)
/// - volumes: litres or US gallons (1 decimal)
final class MeasurementFormatter {
  MeasurementFormatter(this.system, {String? locale})
    : _oneDecimal = NumberFormat('#,##0.#', locale),
      _twoDecimals = NumberFormat('#,##0.##', locale),
      _whole = NumberFormat('#,##0', locale);

  final UnitSystem system;
  final NumberFormat _oneDecimal;
  final NumberFormat _twoDecimals;
  final NumberFormat _whole;

  String length(Length length) {
    final sign = length.cm < 0 ? '-' : '';
    final value = length.abs();
    return sign +
        switch (system) {
          UnitSystem.metric => _metricLength(value),
          UnitSystem.imperial => _imperialLength(value),
        };
  }

  String area(Area area) => switch (system) {
    UnitSystem.metric => '${_twoDecimals.format(area.m2)} m²',
    UnitSystem.imperial => '${_oneDecimal.format(area.sqFt)} sq ft',
  };

  String volume(Volume volume) => switch (system) {
    UnitSystem.metric => '${_oneDecimal.format(volume.litres)} L',
    UnitSystem.imperial => '${_oneDecimal.format(volume.usGallons)} gal',
  };

  String _metricLength(Length value) {
    // Round first so 99.96 cm shows as "1 m", not "100 cm".
    final roundedCm = (value.cm * 10).round() / 10;
    if (roundedCm < 100) return '${_oneDecimal.format(roundedCm)} cm';
    return '${_twoDecimals.format(value.metres)} m';
  }

  String _imperialLength(Length value) {
    final roundedInches = (value.inches * 10).round() / 10;
    if (roundedInches < inchesPerFoot) {
      return '${_oneDecimal.format(roundedInches)} in';
    }
    final totalInches = value.inches.round();
    final feet = totalInches ~/ inchesPerFoot;
    final inches = totalInches % inchesPerFoot.toInt();
    final feetText = '${_whole.format(feet)} ft';
    return inches == 0 ? feetText : '$feetText $inches in';
  }
}
