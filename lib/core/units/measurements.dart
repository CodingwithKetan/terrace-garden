/// Measurement value objects. All values are stored in canonical metric units
/// (centimetres, square centimetres, litres); unit systems only affect display
/// and input (see data-model.md §1 and ADR-017).
library;

import 'package:meta/meta.dart';

enum UnitSystem { metric, imperial }

const double cmPerInch = 2.54;
const double inchesPerFoot = 12;
const double litresPerUsGallon = 3.785411784;

/// A length in centimetres.
@immutable
final class Length implements Comparable<Length> {
  const Length.cm(this.cm);

  factory Length.metres(double metres) => Length.cm(metres * 100);

  factory Length.inches(double inches) => Length.cm(inches * cmPerInch);

  factory Length.feet(double feet) =>
      Length.cm(feet * inchesPerFoot * cmPerInch);

  static const zero = Length.cm(0);

  final double cm;

  double get metres => cm / 100;

  double get inches => cm / cmPerInch;

  double get feet => inches / inchesPerFoot;

  Length operator +(Length other) => Length.cm(cm + other.cm);

  Length operator -(Length other) => Length.cm(cm - other.cm);

  Length operator *(num factor) => Length.cm(cm * factor);

  Length abs() => Length.cm(cm.abs());

  /// Area of a rectangle with this length and [other] as its sides.
  Area by(Length other) => Area.cm2(cm * other.cm);

  bool isCloseTo(Length other, {double toleranceCm = 1e-6}) =>
      (cm - other.cm).abs() <= toleranceCm;

  @override
  int compareTo(Length other) => cm.compareTo(other.cm);

  bool operator <(Length other) => cm < other.cm;

  bool operator >(Length other) => cm > other.cm;

  @override
  bool operator ==(Object other) => other is Length && other.cm == cm;

  @override
  int get hashCode => cm.hashCode;

  @override
  String toString() => 'Length(${cm}cm)';
}

/// An area in square centimetres.
@immutable
final class Area implements Comparable<Area> {
  const Area.cm2(this.cm2);

  factory Area.m2(double squareMetres) => Area.cm2(squareMetres * 10000);

  static const zero = Area.cm2(0);

  final double cm2;

  double get m2 => cm2 / 10000;

  double get sqFt => cm2 / (cmPerInch * cmPerInch * inchesPerFoot * 12);

  Area operator +(Area other) => Area.cm2(cm2 + other.cm2);

  Area operator -(Area other) => Area.cm2(cm2 - other.cm2);

  /// Volume of a prism with this base and [depth].
  Volume times(Length depth) => Volume.litres(cm2 * depth.cm / 1000);

  @override
  int compareTo(Area other) => cm2.compareTo(other.cm2);

  @override
  bool operator ==(Object other) => other is Area && other.cm2 == cm2;

  @override
  int get hashCode => cm2.hashCode;

  @override
  String toString() => 'Area(${cm2}cm²)';
}

/// A volume in litres (soil and container capacity).
@immutable
final class Volume implements Comparable<Volume> {
  const Volume.litres(this.litres);

  factory Volume.usGallons(double gallons) =>
      Volume.litres(gallons * litresPerUsGallon);

  static const zero = Volume.litres(0);

  final double litres;

  double get usGallons => litres / litresPerUsGallon;

  Volume operator +(Volume other) => Volume.litres(litres + other.litres);

  @override
  int compareTo(Volume other) => litres.compareTo(other.litres);

  @override
  bool operator ==(Object other) => other is Volume && other.litres == litres;

  @override
  int get hashCode => litres.hashCode;

  @override
  String toString() => 'Volume(${litres}L)';
}
