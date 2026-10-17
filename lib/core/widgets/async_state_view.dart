import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/widgets/error_state.dart';
import 'package:terrace_garden/core/widgets/skeleton.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// Renders an [AsyncValue] consistently: skeleton while loading, [ErrorState]
/// on failure, and [data] otherwise. Previous data stays visible while a
/// refresh is in flight.
class AsyncStateView<T> extends StatelessWidget {
  const AsyncStateView({
    required this.value,
    required this.data,
    this.loading,
    this.onRetry,
    super.key,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final WidgetBuilder? loading;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return switch (value) {
      AsyncValue(:final value?, hasValue: true) => data(value),
      AsyncError(:final error) => ErrorState(
        failure: error is AppFailure ? error : UnexpectedFailure(error),
        onRetry: onRetry,
      ),
      _ =>
        loading?.call(context) ??
            SkeletonList(semanticLabel: context.l10n.loadingLabel),
    };
  }
}
