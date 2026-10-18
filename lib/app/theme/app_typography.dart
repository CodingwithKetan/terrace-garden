import 'package:flutter/material.dart';

/// Type scale (design-system.md §3): Young Serif for display, headlines and
/// plant names (like herbarium labels); Schibsted Grotesk for UI and body
/// text. Both are bundled OFL assets (ADR-012, ADR-025).
abstract final class AppTypography {
  static const String display = 'YoungSerif';
  static const String ui = 'SchibstedGrotesk';

  static TextTheme textTheme(ColorScheme colors) {
    TextStyle style(
      String family,
      double size,
      double height,
      FontWeight weight, {
      Color? color,
    }) => TextStyle(
      fontFamily: family,
      fontSize: size,
      height: height / size,
      fontWeight: weight,
      color: color ?? colors.onSurface,
      leadingDistribution: TextLeadingDistribution.even,
    );

    const regular = FontWeight.w400;
    const medium = FontWeight.w500;
    const semiBold = FontWeight.w600;

    return TextTheme(
      displayLarge: style(display, 48, 56, regular),
      displayMedium: style(display, 42, 50, regular),
      displaySmall: style(display, 36, 44, regular),
      headlineLarge: style(display, 32, 40, regular),
      headlineMedium: style(display, 28, 36, regular),
      headlineSmall: style(display, 24, 32, regular),
      titleLarge: style(ui, 20, 28, semiBold),
      titleMedium: style(ui, 16, 24, semiBold),
      titleSmall: style(ui, 14, 20, semiBold),
      bodyLarge: style(ui, 16, 24, regular),
      bodyMedium: style(ui, 14, 20, regular),
      bodySmall: style(ui, 12, 16, regular, color: colors.onSurfaceVariant),
      labelLarge: style(ui, 14, 20, semiBold),
      labelMedium: style(ui, 12, 16, medium),
      labelSmall: style(ui, 11, 16, medium),
    );
  }

  /// Scientific (Latin) plant names are set in italic body text.
  static TextStyle scientificName(TextTheme theme) =>
      (theme.bodyMedium ?? const TextStyle()).copyWith(
        fontStyle: FontStyle.italic,
      );

  /// Canvas measurement labels use tabular figures so numbers don't jitter.
  static TextStyle measurement(TextTheme theme) =>
      (theme.labelMedium ?? const TextStyle()).copyWith(
        fontFeatures: const [FontFeature.tabularFigures()],
      );
}
