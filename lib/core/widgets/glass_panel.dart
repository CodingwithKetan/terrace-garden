import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/glass_theme.dart';

/// A frosted-glass surface: blurs whatever is behind it and draws a
/// translucent tint with a hairline edge (design-system.md §2.4).
///
/// Use it over photography, not over flat colour (where blur adds cost but no
/// effect). When the platform requests high contrast, it renders as an opaque
/// surface instead.
class GlassPanel extends StatelessWidget {
  const GlassPanel({
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = const BorderRadius.all(Radius.circular(28)),
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final highContrast = MediaQuery.highContrastOf(context);
    final fill = highContrast
        ? Theme.of(context).colorScheme.surfaceContainerLowest
        : glass.tint;

    final panel = DecoratedBox(
      decoration: BoxDecoration(
        color: fill,
        borderRadius: borderRadius,
        border: Border.all(color: glass.border),
      ),
      child: Padding(padding: padding, child: child),
    );

    if (highContrast) return panel;
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: glass.blurSigma,
          sigmaY: glass.blurSigma,
        ),
        child: panel,
      ),
    );
  }
}
