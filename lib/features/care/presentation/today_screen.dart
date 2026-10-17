import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/core/widgets/empty_state.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// HOME-01. Shows today's care agenda once gardens and plantings exist
/// (Phase 5); until then, an honest empty state.
class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navToday),
        actions: [
          IconButton(
            tooltip: l10n.settingsTooltip,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      body: EmptyState(
        icon: Icons.wb_sunny_outlined,
        title: l10n.todayEmptyTitle,
        body: l10n.todayEmptyBody,
      ),
    );
  }
}
