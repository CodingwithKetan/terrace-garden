import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:terrace_garden/core/storage/storage_providers.dart';

/// Shows a photo saved in app storage by its relative path. A missing file
/// (e.g. deleted outside the app) shows a placeholder instead of an error.
class StoredPhotoImage extends ConsumerWidget {
  const StoredPhotoImage({
    required this.relativePath,
    this.fit = BoxFit.cover,
    this.cacheWidth,
    this.semanticLabel,
    super.key,
  });

  final String relativePath;
  final BoxFit fit;

  /// Decode width in physical pixels; set it for thumbnails to save memory.
  final int? cacheWidth;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final root = ref.watch(photoRootProvider);
    final placeholder = _Placeholder(semanticLabel: semanticLabel);

    return switch (root) {
      AsyncData(value: final dir) => Image.file(
        File(p.join(dir.path, relativePath)),
        fit: fit,
        cacheWidth: cacheWidth,
        semanticLabel: semanticLabel,
        excludeFromSemantics: semanticLabel == null,
        errorBuilder: (_, _, _) => placeholder,
      ),
      AsyncError() => placeholder,
      _ => ColoredBox(color: Theme.of(context).colorScheme.surfaceContainer),
    };
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({this.semanticLabel});

  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      label: semanticLabel,
      child: ColoredBox(
        color: colors.surfaceContainerHigh,
        child: Center(
          child: Icon(
            Icons.broken_image_outlined,
            color: colors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
