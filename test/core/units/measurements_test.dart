import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/units/measurements.dart';

void main() {
  const tolerance = 1e-6;

  group('Length', () {
    test('converts between metric and imperial units', () {
      expect(Length.metres(1.2).cm, closeTo(120, tolerance));
      expect(Length.inches(1).cm, closeTo(2.54, tolerance));
      expect(Length.feet(1).cm, closeTo(30.48, tolerance));
      expect(const Length.cm(254).inches, closeTo(100, tolerance));
      expect(const Length.cm(30.48).feet, closeTo(1, tolerance));
    });

    test('round-trips through every unit within tolerance', () {
      for (final cm in <double>[0, 0.1, 2.54, 45, 99.99, 120, 365.76, 2000]) {
        final length = Length.cm(cm);
        expect(Length.metres(length.metres).cm, closeTo(cm, tolerance));
        expect(Length.inches(length.inches).cm, closeTo(cm, tolerance));
        expect(Length.feet(length.feet).cm, closeTo(cm, tolerance));
      }
    });

    test('supports arithmetic and comparison', () {
      const a = Length.cm(100);
      const b = Length.cm(20);
      expect((a + b).cm, 120);
      expect((a - b).cm, 80);
      expect((b * 3).cm, 60);
      expect(a > b, isTrue);
      expect(b < a, isTrue);
      expect(const Length.cm(-5).abs().cm, 5);
      expect(a.compareTo(b), greaterThan(0));
    });

    test('multiplying two lengths gives a rectangle area', () {
      final area = Length.metres(3).by(Length.metres(1.2));
      expect(area.m2, closeTo(3.6, tolerance));
    });

    test('isCloseTo tolerates floating point error', () {
      final viaInches = Length.inches(Length.metres(1).inches);
      expect(viaInches.isCloseTo(Length.metres(1)), isTrue);
      expect(const Length.cm(1).isCloseTo(const Length.cm(1.1)), isFalse);
    });
  });

  group('Area', () {
    test('converts square metres and square feet', () {
      expect(Area.m2(1).cm2, 10000);
      expect(Area.m2(1).sqFt, closeTo(10.7639104, 1e-6));
    });

    test('area times depth gives volume in litres', () {
      // A 30 cm x 30 cm pot filled 25 cm deep holds 22.5 L.
      final volume = const Length.cm(
        30,
      ).by(const Length.cm(30)).times(const Length.cm(25));
      expect(volume.litres, closeTo(22.5, tolerance));
    });
  });

  group('Volume', () {
    test('converts US gallons', () {
      expect(Volume.usGallons(5).litres, closeTo(18.927, 1e-3));
      expect(const Volume.litres(3.785411784).usGallons, closeTo(1, tolerance));
    });

    test('adds volumes', () {
      const total = Volume.litres(10.5);
      expect((total + const Volume.litres(2)).litres, 12.5);
    });
  });
}
