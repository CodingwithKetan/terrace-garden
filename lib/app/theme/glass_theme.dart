import 'package:flutter/material.dart';

/// Frosted-glass surface tokens (design-system.md §2.4).
///
/// Tint opacity is chosen so body text keeps WCAG AA contrast even when the
/// photo behind the glass is pure black or pure white
/// (`test/app/theme/contrast_test.dart`).
@immutable
class GlassTheme extends ThemeExtension<GlassTheme> {
  const GlassTheme({
    required this.tint,
    required this.border,
    required this.blurSigma,
    required this.photoScrim,
    required this.onPhoto,
  });

  // Living Terrace drops frosted glass for solid paper on limestone: the
  // tokens stay so existing surfaces switch over in one place.
  static const light = GlassTheme(
    tint: Color(0xFFFBFAF7),
    border: Color(0xFFE5E1D6),
    blurSigma: 0,
    photoScrim: Color(0x00000000),
    onPhoto: Color(0xFF17301F),
  );

  static const dark = GlassTheme(
    tint: Color(0xFF18301F),
    border: Color(0xFF24402D),
    blurSigma: 0,
    photoScrim: Color(0x00000000),
    onPhoto: Color(0xFFECE8DE),
  );

  /// Translucent fill drawn over the blurred backdrop.
  final Color tint;

  /// Hairline highlight that defines the glass edge.
  final Color border;
  final double blurSigma;

  /// Darkest point of the gradient behind text placed directly on photos.
  final Color photoScrim;

  /// Text and icon colour directly on photos (over [photoScrim]).
  final Color onPhoto;

  @override
  GlassTheme copyWith({
    Color? tint,
    Color? border,
    double? blurSigma,
    Color? photoScrim,
    Color? onPhoto,
  }) => GlassTheme(
    tint: tint ?? this.tint,
    border: border ?? this.border,
    blurSigma: blurSigma ?? this.blurSigma,
    photoScrim: photoScrim ?? this.photoScrim,
    onPhoto: onPhoto ?? this.onPhoto,
  );

  @override
  GlassTheme lerp(covariant GlassTheme? other, double t) {
    if (other == null) return this;
    return GlassTheme(
      tint: Color.lerp(tint, other.tint, t)!,
      border: Color.lerp(border, other.border, t)!,
      blurSigma: blurSigma + (other.blurSigma - blurSigma) * t,
      photoScrim: Color.lerp(photoScrim, other.photoScrim, t)!,
      onPhoto: Color.lerp(onPhoto, other.onPhoto, t)!,
    );
  }
}

extension GlassThemeContext on BuildContext {
  GlassTheme get glass =>
      Theme.of(this).extension<GlassTheme>() ?? GlassTheme.light;
}
