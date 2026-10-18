import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The background behind a top-level screen.
///
/// Living Terrace replaced full-bleed stock photography with the plain
/// limestone surface (photos now appear only where they carry meaning: the
/// user's own garden and journal). [image] is kept for callers that have not
/// moved over yet and is no longer drawn.
class PhotoBackdrop extends StatelessWidget {
  const PhotoBackdrop({
    required this.image,
    required this.child,
    this.alignment = Alignment.center,
    super.key,
  });

  final ImageProvider image;
  final Widget child;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final dark = colors.brightness == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: ColoredBox(color: colors.surface, child: child),
    );
  }
}
