import 'package:flutter/material.dart';
import 'package:terrace_garden/core/widgets/empty_state.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// PLT-01. The sourced plant catalogue arrives in Phase 4.
class PlantsHomeScreen extends StatelessWidget {
  const PlantsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navPlants)),
      body: EmptyState(
        icon: Icons.local_florist_outlined,
        title: l10n.plantsEmptyTitle,
        body: l10n.plantsEmptyBody,
        badge: l10n.comingSoonLabel,
      ),
    );
  }
}
