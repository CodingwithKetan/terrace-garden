import 'dart:async';

import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';

/// A placeholder block that gently pulses while content loads.
/// The pulse is disabled when the platform requests reduced motion.
class SkeletonBox extends StatefulWidget {
  const SkeletonBox({
    this.width,
    this.height = 16,
    this.borderRadius = AppRadii.smAll,
    super.key,
  });

  final double? width;
  final double height;
  final BorderRadius borderRadius;

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      unawaited(_controller.repeat(reverse: true));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return FadeTransition(
      opacity: Tween<double>(begin: 1, end: 0.55).animate(_controller),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest,
          borderRadius: widget.borderRadius,
        ),
      ),
    );
  }
}

/// A column of list-row skeletons, announced once as "Loading".
class SkeletonList extends StatelessWidget {
  const SkeletonList({
    required this.semanticLabel,
    this.itemCount = 4,
    super.key,
  });

  final String semanticLabel;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      liveRegion: true,
      child: ExcludeSemantics(
        child: ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.lg),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.lg),
          itemBuilder: (_, _) => const Row(
            children: [
              SkeletonBox(width: 56, height: 56, borderRadius: AppRadii.mdAll),
              SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonBox(width: 160),
                    SizedBox(height: AppSpacing.sm),
                    SkeletonBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
