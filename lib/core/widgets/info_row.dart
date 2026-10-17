import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';

/// A labelled value in a profile. When [value] is null it shows
/// [notSetLabel] ("Not set · Add") so missing details invite completion
/// instead of disappearing (progressive onboarding, design-system §8).
class InfoRow extends StatelessWidget {
  const InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.notSetLabel,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final String? value;
  final String notSetLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSet = value != null;

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadii.smAll,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: AppSizes.minTouchTarget),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Row(
            children: [
              Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(label, style: theme.textTheme.bodyMedium),
              ),
              const SizedBox(width: AppSpacing.md),
              Flexible(
                child: Text(
                  value ?? notSetLabel,
                  textAlign: TextAlign.end,
                  style: isSet
                      ? theme.textTheme.titleSmall
                      : theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
