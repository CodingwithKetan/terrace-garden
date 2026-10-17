import 'package:flutter/material.dart';

/// Brand palette and Material colour schemes (design-system.md §2).
///
/// Screens never use these constants directly; they read
/// `Theme.of(context).colorScheme` or a ThemeExtension such as `CareColors`.
abstract final class AppPalette {
  static const fern = Color(0xFF2F5D3A);
  static const fernContainer = Color(0xFFCFE6D2);
  static const onFernContainer = Color(0xFF0F2A17);
  static const terracotta = Color(0xFFA4532F);
  static const terracottaContainer = Color(0xFFF6DCCD);
  static const onTerracottaContainer = Color(0xFF3A1606);

  /// Decorative accent (sun, harvest highlights). Too light for text on light
  /// surfaces; text and icons use [marigoldDeep].
  static const marigold = Color(0xFFC98A1C);
  static const marigoldDeep = Color(0xFF855B00);
  static const marigoldContainer = Color(0xFFFBE7BF);
  static const onMarigoldContainer = Color(0xFF2B1C00);
  static const paper = Color(0xFFF7F5EF);
  static const paperBright = Color(0xFFFFFFFF);
  static const paperDim = Color(0xFFECE8DE);
  static const ink = Color(0xFF1C2420);
  static const inkMuted = Color(0xFF4E5A52);
  static const outline = Color(0xFF7C877F);
  static const outlineVariant = Color(0xFFCBD1C9);
  static const error = Color(0xFFB3261E);

  // Dark theme surfaces: deep forest tones rather than black.
  static const forest = Color(0xFF121815);
  static const forestHigh = Color(0xFF242D28);
}

abstract final class AppColorSchemes {
  static const light = ColorScheme(
    brightness: Brightness.light,
    primary: AppPalette.fern,
    onPrimary: Colors.white,
    primaryContainer: AppPalette.fernContainer,
    onPrimaryContainer: AppPalette.onFernContainer,
    secondary: AppPalette.terracotta,
    onSecondary: Colors.white,
    secondaryContainer: AppPalette.terracottaContainer,
    onSecondaryContainer: AppPalette.onTerracottaContainer,
    tertiary: AppPalette.marigoldDeep,
    onTertiary: Colors.white,
    tertiaryContainer: AppPalette.marigoldContainer,
    onTertiaryContainer: AppPalette.onMarigoldContainer,
    error: AppPalette.error,
    onError: Colors.white,
    errorContainer: Color(0xFFF9DEDC),
    onErrorContainer: Color(0xFF410E0B),
    surface: AppPalette.paper,
    onSurface: AppPalette.ink,
    onSurfaceVariant: AppPalette.inkMuted,
    surfaceDim: Color(0xFFE3DFD4),
    surfaceBright: Color(0xFFFBFAF6),
    surfaceContainerLowest: AppPalette.paperBright,
    surfaceContainerLow: Color(0xFFFBFAF6),
    surfaceContainer: Color(0xFFF2EFE7),
    surfaceContainerHigh: AppPalette.paperDim,
    surfaceContainerHighest: Color(0xFFE6E1D6),
    outline: AppPalette.outline,
    outlineVariant: AppPalette.outlineVariant,
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: Color(0xFF2C332F),
    onInverseSurface: Color(0xFFEEF1EC),
    inversePrimary: Color(0xFF9CD3A7),
    surfaceTint: AppPalette.fern,
  );

  static const dark = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF9CD3A7),
    onPrimary: Color(0xFF0F3A1D),
    primaryContainer: Color(0xFF1F4A2B),
    onPrimaryContainer: AppPalette.fernContainer,
    secondary: Color(0xFFF0B394),
    onSecondary: Color(0xFF4A1F0B),
    secondaryContainer: Color(0xFF6E3418),
    onSecondaryContainer: AppPalette.terracottaContainer,
    tertiary: Color(0xFFF2C46B),
    onTertiary: Color(0xFF3F2B00),
    tertiaryContainer: Color(0xFF5C4100),
    onTertiaryContainer: AppPalette.marigoldContainer,
    error: Color(0xFFF2B8B5),
    onError: Color(0xFF601410),
    errorContainer: Color(0xFF8C1D18),
    onErrorContainer: Color(0xFFF9DEDC),
    surface: AppPalette.forest,
    onSurface: Color(0xFFE4EAE4),
    onSurfaceVariant: Color(0xFFB7C2BA),
    surfaceDim: AppPalette.forest,
    surfaceBright: Color(0xFF333D37),
    surfaceContainerLowest: Color(0xFF0D120F),
    surfaceContainerLow: Color(0xFF171E1A),
    surfaceContainer: Color(0xFF1B231F),
    surfaceContainerHigh: AppPalette.forestHigh,
    surfaceContainerHighest: Color(0xFF2E3832),
    outline: Color(0xFF86918A),
    outlineVariant: Color(0xFF3A453F),
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: Color(0xFFE4EAE4),
    onInverseSurface: Color(0xFF2C332F),
    inversePrimary: AppPalette.fern,
    surfaceTint: Color(0xFF9CD3A7),
  );
}
