import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/glass_theme.dart';

/// A card surface (design-system.md §2.4). In Living Terrace it is solid
/// paper on the limestone background; the tokens still allow a blurred,
/// translucent variant over imagery when `blurSigma` is above zero.
///
/// When the platform requests high contrast it always renders opaque.
class GlassPanel extends StatelessWidget {
  const GlassPanel({
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
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
      // A transparent Material above the fill so ink ripples from InkWell and
      // ListTile children paint on top of it instead of under it.
      child: Material(
        type: MaterialType.transparency,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: Padding(padding: padding, child: child),
      ),
    );

    if (highContrast || glass.blurSigma <= 0) return panel;
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
