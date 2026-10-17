import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/app_imagery.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/widgets/app_card.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// SET-02 (part). Credits for bundled photography, as their licences require.
class ImageCreditsScreen extends StatelessWidget {
  const ImageCreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final gutter = AppSpacing.gutterFor(MediaQuery.sizeOf(context).width);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.imageCreditsTitle)),
      body: ListView.separated(
        padding: EdgeInsets.fromLTRB(
          gutter,
          AppSpacing.lg,
          gutter,
          AppSpacing.xxl,
        ),
        itemCount: photoCredits.length,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) {
          final credit = photoCredits[index];
          return AppCard(
            padding: EdgeInsets.zero,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 88,
                  height: 120,
                  child: Image.asset(
                    credit.asset,
                    fit: BoxFit.cover,
                    cacheWidth: 264,
                    excludeFromSemantics: true,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(credit.title, style: theme.textTheme.titleSmall),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          l10n.imageCreditsBy(credit.author),
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(credit.licence, style: theme.textTheme.bodySmall),
                        const SizedBox(height: AppSpacing.xs),
                        SelectableText(
                          credit.source,
                          style: theme.textTheme.bodySmall,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
