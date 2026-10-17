import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/widgets/app_button.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// Plain-language error with a retry action (design-system.md §8).
/// Never shows technical details; those are logged instead.
class ErrorState extends StatelessWidget {
  const ErrorState({this.failure, this.onRetry, super.key});

  final AppFailure? failure;
  final VoidCallback? onRetry;

  static String messageFor(AppLocalizations l10n, AppFailure? failure) =>
      switch (failure) {
        NotFoundFailure() => l10n.errorNotFound,
        StorageFailure() => l10n.errorStorage,
        PermissionFailure() => l10n.errorPermission,
        ValidationFailure() ||
        UnexpectedFailure() ||
        null => l10n.errorGenericBody,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppBreakpoints.readableMaxWidth,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: AppSpacing.lg),
              Semantics(
                header: true,
                child: Text(
                  l10n.errorGenericTitle,
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                messageFor(l10n, failure),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                const SizedBox(height: AppSpacing.xl),
                AppButton.secondary(
                  label: l10n.actionRetry,
                  icon: Icons.refresh_rounded,
                  onPressed: onRetry,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
