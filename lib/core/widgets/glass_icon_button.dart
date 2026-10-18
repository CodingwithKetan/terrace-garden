import 'package:flutter/material.dart';
import 'package:terrace_garden/core/widgets/glass_panel.dart';

/// A circular paper button for header actions.
class GlassIconButton extends StatelessWidget {
  const GlassIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: EdgeInsets.zero,
      child: IconButton(
        tooltip: tooltip,
        icon: Icon(icon),
        color: Theme.of(context).colorScheme.onSurface,
        onPressed: onPressed,
      ),
    );
  }
}
