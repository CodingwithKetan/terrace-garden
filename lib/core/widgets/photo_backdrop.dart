import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:terrace_garden/app/theme/glass_theme.dart';

/// A full-bleed photograph behind a screen's content, with a gradient scrim
/// at the top so light text and status-bar icons stay readable.
///
/// The photo is decorative: screen content carries the meaning.
class PhotoBackdrop extends StatelessWidget {
  const PhotoBackdrop({
    required this.image,
    required this.child,
    this.alignment = Alignment.center,
    super.key,
  });

  final ImageProvider image;
  final Widget child;

  /// Which part of the photo to keep when it is cropped to the screen.
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final colors = Theme.of(context).colorScheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: image,
            fit: BoxFit.cover,
            alignment: alignment,
            excludeFromSemantics: true,
            errorBuilder: (_, _, _) =>
                ColoredBox(color: colors.surfaceContainerHigh),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 0.38, 0.7, 1],
                colors: [
                  glass.photoScrim,
                  glass.photoScrim.withValues(alpha: 0),
                  glass.photoScrim.withValues(alpha: 0),
                  glass.photoScrim.withValues(alpha: glass.photoScrim.a * 0.6),
                ],
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
