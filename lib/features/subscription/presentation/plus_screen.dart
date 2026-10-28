import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/features/subscription/data/subscription_providers.dart';
import 'package:terrace_garden/features/subscription/domain/plan.dart';
import 'package:terrace_garden/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

/// SET-PLUS (ADR-028). What stays free, what Plus adds, store prices and
/// plain renewal terms. No countdowns, no pre-selected plan, no trial
/// that turns into a yearly charge.
class PlusScreen extends ConsumerWidget {
  const PlusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final gutter = AppSpacing.contentInsetFor(MediaQuery.sizeOf(context).width);
    final entitlements = ref.watch(entitlementsProvider);
    final offers = ref.watch(planOffersProvider);
    final service = ref.watch(purchaseServiceProvider);

    Future<void> buy(PlanOffer offer) async {
      final messenger = ScaffoldMessenger.of(context);
      final result = await service.buy(offer);
      if (result case Err()) {
        messenger.showSnackBar(SnackBar(content: Text(l10n.plusBuyFailed)));
      }
    }

    Future<void> restore() async {
      final messenger = ScaffoldMessenger.of(context);
      final result = await service.restore();
      messenger.showSnackBar(
        SnackBar(
          content: Text(switch (result) {
            Ok() => l10n.plusRestored,
            Err() => l10n.errorGenericBody,
          }),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsPlan)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppBreakpoints.readableMaxWidth,
          ),
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              gutter,
              AppSpacing.md,
              gutter,
              AppSpacing.xxl,
            ),
            children: [
              Semantics(
                header: true,
                child: Text(
                  l10n.plusTitle,
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(l10n.plusTagline, style: theme.textTheme.bodyLarge),
              const SizedBox(height: AppSpacing.lg),
              _ListCard(
                title: l10n.plusFreeHeading,
                icon: Icons.check_circle_outline,
                iconColor: theme.colorScheme.primary,
                items: [
                  l10n.plusFreeCare,
                  l10n.plusFreeLibrary,
                  l10n.plusFreeLayout,
                  l10n.plusFreeJournal(PlanLimits.freeJournalPhotos),
                  l10n.plusFreeData,
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _ListCard(
                title: l10n.plusPaidHeading,
                icon: Icons.add_circle_outline,
                iconColor: theme.colorScheme.secondary,
                items: [
                  l10n.plusPaidGardens,
                  l10n.plusPaidPhotos,
                  l10n.plusPaidCompare,
                  l10n.plusPaidReport,
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              if (entitlements.isPlus)
                _Note(
                  icon: Icons.favorite_outline,
                  text: l10n.plusActive,
                )
              else
                switch (offers) {
                  AsyncData(value: final list) when list.isNotEmpty => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final offer in list)
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppSpacing.sm,
                          ),
                          child: _OfferTile(
                            offer: offer,
                            onChoose: () => buy(offer),
                          ),
                        ),
                    ],
                  ),
                  AsyncLoading() => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.lg),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  _ => _Note(
                    icon: Icons.info_outline,
                    text: l10n.plusNotOnSale,
                  ),
                },
              const SizedBox(height: AppSpacing.md),
              Text(l10n.plusTerms, style: theme.textTheme.bodySmall),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.plusPromise,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.sm,
                children: [
                  TextButton(
                    onPressed: restore,
                    child: Text(l10n.plusRestore),
                  ),
                  TextButton(
                    onPressed: () => launchUrl(
                      service.manageUrl,
                      mode: LaunchMode.externalApplication,
                    ),
                    child: Text(l10n.plusManage),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListCard extends StatelessWidget {
  const _ListCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.items,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(title, style: theme.textTheme.titleMedium),
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, size: 18, color: iconColor),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(item, style: theme.textTheme.bodyMedium),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _OfferTile extends StatelessWidget {
  const _OfferTile({required this.offer, required this.onChoose});

  final PlanOffer offer;
  final VoidCallback onChoose;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final (name, price) = switch (offer.period) {
      PlanPeriod.monthly => (
        l10n.plusMonthly,
        l10n.plusPerMonth(offer.priceLabel),
      ),
      PlanPeriod.yearly => (
        l10n.plusYearly,
        l10n.plusPerYear(offer.priceLabel),
      ),
      PlanPeriod.lifetime => (
        l10n.plusLifetime,
        l10n.plusOnce(offer.priceLabel),
      ),
    };
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: theme.textTheme.titleMedium),
                Text(price, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
          FilledButton(onPressed: onChoose, child: Text(l10n.plusChoose)),
        ],
      ),
    );
  }
}

class _Note extends StatelessWidget {
  const _Note({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.onPrimaryContainer),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
