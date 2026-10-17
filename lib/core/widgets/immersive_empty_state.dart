import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/app/theme/glass_theme.dart';
import 'package:terrace_garden/core/widgets/app_button.dart';
import 'package:terrace_garden/core/widgets/glass_panel.dart';
import 'package:terrace_garden/core/widgets/photo_backdrop.dart';

/// A full-screen photo with the screen title on it and a frosted panel that
/// explains what will appear here. Used for top-level screens that have no
/// content yet. Offer an action only when it really works.
class ImmersiveEmptyState extends StatelessWidget {
  const ImmersiveEmptyState({
    required this.screenTitle,
    required this.image,
    required this.icon,
    required this.title,
    required this.body,
    this.badge,
    this.actionLabel,
    this.onAction,
    this.photoAlignment = Alignment.center,
    super.key,
  }) : assert(
         (actionLabel == null) == (onAction == null),
         'Provide both actionLabel and onAction, or neither.',
       );

  final String screenTitle;
  final ImageProvider image;
  final IconData icon;
  final String title;
  final String body;
  final String? badge;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Alignment photoAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final insets = MediaQuery.paddingOf(context);

    return PhotoBackdrop(
      image: image,
      alignment: photoAlignment,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final gutter = AppSpacing.gutterFor(constraints.maxWidth);
          // Scrolls only when the content is taller than the screen (large
          // text); otherwise the panel rests at the bottom, below the photo.
          // The padding lives inside SliverFillRemaining: wrapping it in a
          // SliverPadding instead would ignore the bottom inset and push the
          // panel under the floating navigation bar.
          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    gutter,
                    insets.top + AppSpacing.lg,
                    gutter,
                    insets.bottom + AppSpacing.xl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Semantics(
                        header: true,
                        child: Text(
                          screenTitle,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: context.glass.onPhoto,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(height: AppSpacing.xl),
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: AppBreakpoints.readableMaxWidth,
                          ),
                          child: _MessagePanel(
                            icon: icon,
                            title: title,
                            body: body,
                            badge: badge,
                            actionLabel: actionLabel,
                            onAction: onAction,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MessagePanel extends StatelessWidget {
  const _MessagePanel({
    required this.icon,
    required this.title,
    required this.body,
    required this.badge,
    required this.actionLabel,
    required this.onAction,
  });

  final IconData icon;
  final String title;
  final String body;
  final String? badge;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return GlassPanel(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Wrap lets the badge drop below the icon when text is enlarged.
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.sm,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Icon(icon, color: colors.onPrimaryContainer),
                ),
              ),
              if (badge != null)
                DecoratedBox(
                  decoration: ShapeDecoration(
                    color: colors.tertiaryContainer,
                    shape: const StadiumBorder(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    child: Text(
                      badge!,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colors.onTertiaryContainer,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(title, style: theme.textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.sm),
          Text(body, style: theme.textTheme.bodyLarge),
          if (actionLabel != null) ...[
            const SizedBox(height: AppSpacing.xl),
            AppButton(label: actionLabel!, onPressed: onAction, expand: true),
          ],
        ],
      ),
    );
  }
}
