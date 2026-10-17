import 'package:flutter/material.dart';

/// Garden designer colours (design-system.md §12). Problems are never shown by
/// colour alone: invalid objects also get a badge and listed issues.
@immutable
class CanvasColors extends ThemeExtension<CanvasColors> {
  const CanvasColors({
    required this.outside,
    required this.garden,
    required this.boundary,
    required this.gridMinor,
    required this.gridMajor,
    required this.containerFill,
    required this.containerStroke,
    required this.bedFill,
    required this.bedStroke,
    required this.structure,
    required this.pathFill,
    required this.pathStroke,
    required this.marker,
    required this.selection,
    required this.error,
    required this.warning,
    required this.labelBackground,
    required this.labelText,
  });

  static const light = CanvasColors(
    outside: Color(0xFFECE8DE),
    garden: Color(0xFFFFFFFF),
    boundary: Color(0xFF1C2420),
    gridMinor: Color(0x0F1C2420),
    gridMajor: Color(0x261C2420),
    containerFill: Color(0x33A4532F),
    containerStroke: Color(0xFFA4532F),
    bedFill: Color(0x2E2F5D3A),
    bedStroke: Color(0xFF2F5D3A),
    structure: Color(0xFF4E5A52),
    pathFill: Color(0xFFE3DFD4),
    pathStroke: Color(0xFF7C877F),
    marker: Color(0xFF2F6F9F),
    selection: Color(0xFF2F5D3A),
    error: Color(0xFFB3261E),
    warning: Color(0xFF9A6B00),
    labelBackground: Color(0xF2FFFFFF),
    labelText: Color(0xFF1C2420),
  );

  static const dark = CanvasColors(
    outside: Color(0xFF0D120F),
    garden: Color(0xFF1B231F),
    boundary: Color(0xFFE4EAE4),
    gridMinor: Color(0x14E4EAE4),
    gridMajor: Color(0x2EE4EAE4),
    containerFill: Color(0x40F0B394),
    containerStroke: Color(0xFFF0B394),
    bedFill: Color(0x339CD3A7),
    bedStroke: Color(0xFF9CD3A7),
    structure: Color(0xFFB7C2BA),
    pathFill: Color(0xFF2E3832),
    pathStroke: Color(0xFF86918A),
    marker: Color(0xFF8EC1E8),
    selection: Color(0xFF9CD3A7),
    error: Color(0xFFF2B8B5),
    warning: Color(0xFFE9C46A),
    labelBackground: Color(0xF2242D28),
    labelText: Color(0xFFE4EAE4),
  );

  final Color outside;
  final Color garden;
  final Color boundary;
  final Color gridMinor;
  final Color gridMajor;
  final Color containerFill;
  final Color containerStroke;
  final Color bedFill;
  final Color bedStroke;
  final Color structure;
  final Color pathFill;
  final Color pathStroke;
  final Color marker;
  final Color selection;
  final Color error;
  final Color warning;
  final Color labelBackground;
  final Color labelText;

  @override
  CanvasColors copyWith() => this;

  @override
  CanvasColors lerp(covariant CanvasColors? other, double t) {
    if (other == null) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return CanvasColors(
      outside: l(outside, other.outside),
      garden: l(garden, other.garden),
      boundary: l(boundary, other.boundary),
      gridMinor: l(gridMinor, other.gridMinor),
      gridMajor: l(gridMajor, other.gridMajor),
      containerFill: l(containerFill, other.containerFill),
      containerStroke: l(containerStroke, other.containerStroke),
      bedFill: l(bedFill, other.bedFill),
      bedStroke: l(bedStroke, other.bedStroke),
      structure: l(structure, other.structure),
      pathFill: l(pathFill, other.pathFill),
      pathStroke: l(pathStroke, other.pathStroke),
      marker: l(marker, other.marker),
      selection: l(selection, other.selection),
      error: l(error, other.error),
      warning: l(warning, other.warning),
      labelBackground: l(labelBackground, other.labelBackground),
      labelText: l(labelText, other.labelText),
    );
  }
}

extension CanvasColorsContext on BuildContext {
  CanvasColors get canvasColors =>
      Theme.of(this).extension<CanvasColors>() ?? CanvasColors.light;
}
