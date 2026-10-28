import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/widgets/dialogs.dart';
import 'package:terrace_garden/features/subscription/data/subscription_providers.dart';
import 'package:terrace_garden/features/subscription/domain/plan.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// Returns true when [allowed]; otherwise explains what Plus adds for
/// [feature] (one calm sheet, "Not now" always available) and returns
/// false. Never interrupts anything the free plan covers.
Future<bool> requirePlus(
  BuildContext context,
  WidgetRef ref,
  PlusFeature feature, {
  bool? allowed,
  int? count,
}) async {
  // Wait for the plan if it is still loading (the cache answers at once).
  final plan = await ref.read(currentPlanProvider.future);
  if (allowed ?? Entitlements(plan).allows(feature)) return true;
  if (!context.mounted) return false;
  await showUpgradeSheet(context, feature, count: count);
  return false;
}

Future<void> showUpgradeSheet(
  BuildContext context,
  PlusFeature feature, {
  int? count,
}) {
  final l10n = context.l10n;
  final (title, body) = switch (feature) {
    PlusFeature.moreGardens => (
      l10n.upgradeGardensTitle,
      l10n.upgradeGardensBody,
    ),
    PlusFeature.morePhotos => (
      l10n.upgradePhotosTitle(count ?? PlanLimits.freeJournalPhotos),
      l10n.upgradePhotosBody,
    ),
    PlusFeature.photoComparison => (
      l10n.upgradeCompareTitle,
      l10n.upgradeCompareBody,
    ),
    PlusFeature.gardenReport => (
      l10n.upgradeReportTitle,
      l10n.upgradeReportBody,
    ),
  };
  return showAppBottomSheet<void>(
    context,
    title: title,
    builder: (sheet) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(body, style: Theme.of(sheet).textTheme.bodyLarge),
        const SizedBox(height: AppSpacing.lg),
        FilledButton(
          onPressed: () {
            Navigator.of(sheet).pop();
            unawaited(context.push(AppRoutes.plus));
          },
          child: Text(l10n.upgradeSeePlus),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextButton(
          onPressed: () => Navigator.of(sheet).pop(),
          child: Text(l10n.upgradeNotNow),
        ),
      ],
    ),
  );
}
