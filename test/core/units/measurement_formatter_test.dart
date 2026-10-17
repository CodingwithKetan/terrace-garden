import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/units/measurement_formatter.dart';
import 'package:terrace_garden/core/units/measurements.dart';

void main() {
  group('metric', () {
    final format = MeasurementFormatter(UnitSystem.metric, locale: 'en');

    test('lengths under 1 m use centimetres with up to one decimal', () {
      expect(format.length(const Length.cm(45)), '45 cm');
      expect(format.length(const Length.cm(12.34)), '12.3 cm');
      expect(format.length(Length.zero), '0 cm');
    });

    test('lengths from 1 m use metres with up to two decimals', () {
      expect(format.length(const Length.cm(120)), '1.2 m');
      expect(format.length(const Length.cm(305)), '3.05 m');
      expect(format.length(const Length.cm(1000)), '10 m');
    });

    test('rounding up to 100 cm switches to metres', () {
      expect(format.length(const Length.cm(99.96)), '1 m');
    });

    test('negative lengths keep their sign', () {
      expect(format.length(const Length.cm(-30)), '-30 cm');
    });

    test('areas and volumes', () {
      expect(format.area(Area.m2(3.6)), '3.6 m²');
      expect(format.volume(const Volume.litres(22.5)), '22.5 L');
      expect(format.area(Area.m2(1234.5)), '1,234.5 m²');
    });
  });

  group('imperial', () {
    final format = MeasurementFormatter(UnitSystem.imperial, locale: 'en');

    test('lengths under 1 ft use inches with up to one decimal', () {
      expect(format.length(Length.inches(8)), '8 in');
      expect(format.length(Length.inches(8.5)), '8.5 in');
    });

    test('lengths from 1 ft use whole feet and inches', () {
      expect(format.length(Length.inches(40)), '3 ft 4 in');
      expect(format.length(Length.feet(3)), '3 ft');
      expect(format.length(Length.metres(1.2)), '3 ft 11 in');
    });

    test('inches that round to 12 roll over into feet', () {
      expect(format.length(Length.inches(35.8)), '3 ft');
    });

    test('areas and volumes', () {
      expect(format.area(Area.m2(1)), '10.8 sq ft');
      expect(format.volume(Volume.usGallons(5)), '5 gal');
    });
  });

  test('uses locale-specific decimal separators', () {
    final format = MeasurementFormatter(UnitSystem.metric, locale: 'de');
    expect(format.length(const Length.cm(12.5)), '12,5 cm');
  });
}
