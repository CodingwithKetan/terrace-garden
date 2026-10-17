import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';

/// A surface for grouped content, optionally tappable.
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.semanticLabel,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  /// Label announced for the whole card when it is tappable.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final body = Padding(padding: padding, child: child);
    return Card(
      child: onTap == null
          ? body
          : Semantics(
              button: true,
              label: semanticLabel,
              child: InkWell(onTap: onTap, child: body),
            ),
    );
  }
}
