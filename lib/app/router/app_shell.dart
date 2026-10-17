import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/widgets/glass_panel.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// The top-level scaffold with the four main destinations
/// (screen-inventory.md): a bottom navigation bar on compact screens and a
/// navigation rail from medium width (design-system.md §4).
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _onSelect(int index) => navigationShell.goBranch(
    index,
    // Re-selecting the current tab returns it to its first screen.
    initialLocation: index == navigationShell.currentIndex,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final destinations = [
      (Icons.wb_sunny_outlined, Icons.wb_sunny_rounded, l10n.navToday),
      (Icons.yard_outlined, Icons.yard_rounded, l10n.navGarden),
      (
        Icons.local_florist_outlined,
        Icons.local_florist_rounded,
        l10n.navPlants,
      ),
      (
        Icons.photo_library_outlined,
        Icons.photo_library_rounded,
        l10n.navJournal,
      ),
    ];

    final width = MediaQuery.sizeOf(context).width;
    if (width < AppBreakpoints.medium) {
      // A floating glass bar; screens draw their photos underneath it
      // (extendBody) and pad their content by MediaQuery.padding.bottom.
      return Scaffold(
        extendBody: true,
        body: navigationShell,
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.md,
          ),
          child: GlassPanel(
            padding: EdgeInsets.zero,
            borderRadius: const BorderRadius.all(Radius.circular(32)),
            child: NavigationBar(
              height: 72,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _onSelect,
              destinations: [
                for (final (icon, selectedIcon, label) in destinations)
                  NavigationDestination(
                    icon: Icon(icon),
                    selectedIcon: Icon(selectedIcon),
                    label: label,
                  ),
              ],
            ),
          ),
        ),
      );
    }

    final extended = width >= AppBreakpoints.expanded;
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            right: false,
            child: NavigationRail(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _onSelect,
              extended: extended,
              labelType: extended ? NavigationRailLabelType.none : null,
              destinations: [
                for (final (icon, selectedIcon, label) in destinations)
                  NavigationRailDestination(
                    icon: Icon(icon),
                    selectedIcon: Icon(selectedIcon),
                    label: Text(label),
                  ),
              ],
            ),
          ),
          const VerticalDivider(),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}
