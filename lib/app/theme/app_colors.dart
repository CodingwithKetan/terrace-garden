import 'package:flutter/material.dart';

/// Brand palette and Material colour schemes (design-system.md §2).
///
/// Screens never use these constants directly; they read
/// `Theme.of(context).colorScheme` or a ThemeExtension such as `CareColors`.
abstract final class AppPalette {
  // Living Terrace (design direction C, docs/design/redesign-living-terrace).
  // Colours are taken from a terrace: limestone floor, neem leaves,
  // terracotta pots, haldi, water.
  static const limestone = Color(0xFFF2F0EA);
  static const paper = Color(0xFFFBFAF7);
  static const stone = Color(0xFFE7E4DA);
  static const stoneDeep = Color(0xFFDDD8CC);
  static const neem = Color(0xFF17301F);
  static const neemMuted = Color(0xFF4E5D52);
  static const leaf = Color(0xFF2B6530);
  static const leafContainer = Color(0xFFD6E8D2);
  static const onLeafContainer = Color(0xFF0E2A12);

  /// Pots and accents. Decorative; text uses [terracottaDeep] (4.5:1).
  static const terracotta = Color(0xFFC2592B);
  static const terracottaDeep = Color(0xFFA4471F);
  static const terracottaContainer = Color(0xFFF5DCD0);
  static const onTerracottaContainer = Color(0xFF3D1505);

  /// Sun and sowing highlights. Decorative; text uses [haldiDeep].
  static const haldi = Color(0xFFE3A21A);
  static const haldiDeep = Color(0xFF855B00);
  static const haldiContainer = Color(0xFFF7E3B5);
  static const onHaldiContainer = Color(0xFF2B1C00);
  static const water = Color(0xFF2E6FB0);
  static const outline = Color(0xFF8C8472);
  static const error = Color(0xFFB3261E);

  // Dark (evening) surfaces: deep neem rather than black.
  static const dusk = Color(0xFF0F2017);
  static const duskHigh = Color(0xFF18301F);
  static const duskHighest = Color(0xFF24402D);
}

abstract final class AppColorSchemes {
  static const light = ColorScheme(
    brightness: Brightness.light,
    primary: AppPalette.leaf,
    onPrimary: Colors.white,
    primaryContainer: AppPalette.leafContainer,
    onPrimaryContainer: AppPalette.onLeafContainer,
    secondary: AppPalette.terracottaDeep,
    onSecondary: Colors.white,
    secondaryContainer: AppPalette.terracottaContainer,
    onSecondaryContainer: AppPalette.onTerracottaContainer,
    tertiary: AppPalette.haldiDeep,
    onTertiary: Colors.white,
    tertiaryContainer: AppPalette.haldiContainer,
    onTertiaryContainer: AppPalette.onHaldiContainer,
    error: AppPalette.error,
    onError: Colors.white,
    errorContainer: Color(0xFFF9DEDC),
    onErrorContainer: Color(0xFF410E0B),
    surface: AppPalette.limestone,
    onSurface: AppPalette.neem,
    onSurfaceVariant: AppPalette.neemMuted,
    surfaceDim: Color(0xFFE4DFD3),
    surfaceBright: AppPalette.paper,
    surfaceContainerLowest: AppPalette.paper,
    surfaceContainerLow: Color(0xFFF7F5F0),
    surfaceContainer: Color(0xFFEFECE4),
    surfaceContainerHigh: AppPalette.stone,
    surfaceContainerHighest: AppPalette.stoneDeep,
    outline: AppPalette.outline,
    outlineVariant: AppPalette.stoneDeep,
    shadow: Color(0xFF2B2418),
    scrim: Colors.black,
    inverseSurface: AppPalette.neem,
    onInverseSurface: AppPalette.limestone,
    inversePrimary: Color(0xFF93CE8C),
    surfaceTint: Colors.transparent,
  );

  static const dark = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF93CE8C),
    onPrimary: Color(0xFF0E2A12),
    primaryContainer: Color(0xFF26502B),
    onPrimaryContainer: AppPalette.leafContainer,
    secondary: Color(0xFFF0B394),
    onSecondary: Color(0xFF4A1F0B),
    secondaryContainer: Color(0xFF6E3418),
    onSecondaryContainer: AppPalette.terracottaContainer,
    tertiary: Color(0xFFF2C46B),
    onTertiary: Color(0xFF3F2B00),
    tertiaryContainer: Color(0xFF5C4100),
    onTertiaryContainer: AppPalette.haldiContainer,
    error: Color(0xFFF2B8B5),
    onError: Color(0xFF601410),
    errorContainer: Color(0xFF8C1D18),
    onErrorContainer: Color(0xFFF9DEDC),
    surface: AppPalette.dusk,
    onSurface: Color(0xFFECE8DE),
    onSurfaceVariant: Color(0xFFA9B7AD),
    surfaceDim: AppPalette.dusk,
    surfaceBright: AppPalette.duskHighest,
    surfaceContainerLowest: AppPalette.duskHigh,
    surfaceContainerLow: Color(0xFF13281C),
    surfaceContainer: AppPalette.duskHigh,
    surfaceContainerHigh: Color(0xFF1F3627),
    surfaceContainerHighest: AppPalette.duskHighest,
    outline: Color(0xFF7F8F84),
    outlineVariant: AppPalette.duskHighest,
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: Color(0xFFECE8DE),
    onInverseSurface: AppPalette.neem,
    inversePrimary: AppPalette.leaf,
    surfaceTint: Colors.transparent,
  );
}
