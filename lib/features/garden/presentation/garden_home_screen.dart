import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/app_imagery.dart';
import 'package:terrace_garden/core/widgets/immersive_empty_state.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// GDN-01. Garden list and setup arrive in Phase 2.
class GardenHomeScreen extends StatelessWidget {
  const GardenHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: ImmersiveEmptyState(
        screenTitle: l10n.navGarden,
        image: const AssetImage(AppPhotos.gardenTerrace),
        icon: Icons.yard_outlined,
        title: l10n.gardenEmptyTitle,
        body: l10n.gardenEmptyBody,
        badge: l10n.comingSoonLabel,
      ),
    );
  }
}
