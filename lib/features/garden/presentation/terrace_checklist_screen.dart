import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/widgets/app_card.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// GDN-06 / FR-I. Terrace safety and care guidance. Every item cites only
/// fully verified sources from gardening-references §1 (S2, S4–S6, S11, S12,
/// S42); it never claims a structure is safe.
class TerraceChecklistScreen extends StatelessWidget {
  const TerraceChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final insets = MediaQuery.paddingOf(context);
    final gutter = AppSpacing.gutterFor(MediaQuery.sizeOf(context).width);
    final items = [
      (
        Icons.scale_outlined,
        l10n.checkLoadTitle,
        l10n.checkLoadBody,
        l10n.checkLoadSources,
      ),
      (
        Icons.foundation_outlined,
        l10n.checkWallsTitle,
        l10n.checkWallsBody,
        l10n.checkWallsSources,
      ),
      (
        Icons.water_drop_outlined,
        l10n.checkDrainTitle,
        l10n.checkDrainBody,
        l10n.checkDrainSources,
      ),
      (
        Icons.roofing_outlined,
        l10n.checkWaterproofTitle,
        l10n.checkWaterproofBody,
        l10n.checkWaterproofSources,
      ),
      (
        Icons.thunderstorm_outlined,
        l10n.checkMonsoonTitle,
        l10n.checkMonsoonBody,
        l10n.checkMonsoonSources,
      ),
      (
        Icons.wb_sunny_outlined,
        l10n.checkHeatTitle,
        l10n.checkHeatBody,
        l10n.checkHeatSources,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.checklistTitle)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppBreakpoints.readableMaxWidth,
          ),
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              gutter,
              AppSpacing.lg,
              gutter,
              insets.bottom + AppSpacing.xxl,
            ),
            children: [
              Text(l10n.checklistIntro, style: theme.textTheme.bodyLarge),
              const SizedBox(height: AppSpacing.xl),
              for (final (icon, title, body, sources) in items) ...[
                AppCard(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(icon, color: theme.colorScheme.primary),
                      const SizedBox(width: AppSpacing.lg),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Semantics(
                              header: true,
                              child: Text(
                                title,
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(body, style: theme.textTheme.bodyMedium),
                            const SizedBox(height: AppSpacing.sm),
                            Text(sources, style: theme.textTheme.labelSmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
