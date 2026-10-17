import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';

/// A photo with a title block below it (design-system.md §7, §11).
///
/// Shows a calm placeholder when [image] is null or fails to load, so a
/// missing or deleted photo never breaks the layout.
class ImageCard extends StatelessWidget {
  const ImageCard({
    required this.title,
    this.image,
    this.subtitle,
    this.onTap,
    this.aspectRatio = 4 / 3,
    this.placeholderIcon = Icons.local_florist_outlined,
    this.imageSemanticLabel,
    super.key,
  });

  final String title;
  final ImageProvider? image;
  final String? subtitle;
  final VoidCallback? onTap;
  final double aspectRatio;
  final IconData placeholderIcon;

  /// Describes the image for screen readers; null marks it decorative.
  final String? imageSemanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final placeholder = _Placeholder(icon: placeholderIcon);

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: aspectRatio,
          child: image == null
              ? placeholder
              : Image(
                  image: image!,
                  fit: BoxFit.cover,
                  semanticLabel: imageSemanticLabel,
                  excludeFromSemantics: imageSemanticLabel == null,
                  errorBuilder: (_, _, _) => placeholder,
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.titleMedium),
              if (subtitle != null) ...[
                const SizedBox(height: AppSpacing.xxs),
                Text(subtitle!, style: theme.textTheme.bodySmall),
              ],
            ],
          ),
        ),
      ],
    );

    return Card(
      child: onTap == null ? content : InkWell(onTap: onTap, child: content),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ColoredBox(
      color: colors.surfaceContainerHigh,
      child: Center(
        child: Icon(icon, size: 40, color: colors.onSurfaceVariant),
      ),
    );
  }
}
