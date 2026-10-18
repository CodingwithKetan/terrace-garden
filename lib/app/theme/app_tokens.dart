import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Spacing scale in logical pixels (design-system.md §4).
abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
  static const double huge = 64;

  /// Horizontal screen padding for a given window width.
  static double gutterFor(double width) => switch (width) {
    < AppBreakpoints.medium => lg,
    < AppBreakpoints.expanded => xl,
    _ => xxl,
  };

  /// Horizontal padding that keeps list content at a readable width
  /// ([AppBreakpoints.readableMaxWidth]) centred on wide windows, and never
  /// less than the gutter.
  static double contentInsetFor(double width) => math.max(
    gutterFor(width),
    (width - AppBreakpoints.readableMaxWidth) / 2,
  );
}

/// Material 3 window size classes.
abstract final class AppBreakpoints {
  static const double medium = 600;
  static const double expanded = 840;

  /// Comfortable maximum width for blocks of text on large screens.
  static const double readableMaxWidth = 640;
}

/// Corner radii (design-system.md §5).
abstract final class AppRadii {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double full = 999;

  static const BorderRadius smAll = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdAll = BorderRadius.all(Radius.circular(md));
  static const BorderRadius fullAll = BorderRadius.all(Radius.circular(full));
  static const BorderRadius lgTop = BorderRadius.vertical(
    top: Radius.circular(lg),
  );
}

/// Motion durations and curves (design-system.md §9).
abstract final class AppMotion {
  static const Duration short = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 250);
  static const Duration long = Duration(milliseconds: 400);
  static const Curve emphasized = Curves.easeInOutCubicEmphasized;
  static const Curve standard = Curves.easeOutCubic;

  /// Returns [duration], or zero when the platform requests reduced motion.
  static Duration of(BuildContext context, Duration duration) =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : duration;
}

/// Sizes that guarantee accessible touch targets (design-system.md §10).
abstract final class AppSizes {
  static const double minTouchTarget = 48;
  static const double buttonHeight = 52;
}

abstract final class AppShadows {
  /// The single soft shadow for elements floating over imagery or the canvas.
  static const List<BoxShadow> floating = [
    BoxShadow(color: Color(0x1F1C2420), blurRadius: 16, offset: Offset(0, 4)),
  ];
}
