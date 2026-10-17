import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:terrace_garden/app/router/app_shell.dart';
import 'package:terrace_garden/features/care/presentation/today_screen.dart';
import 'package:terrace_garden/features/garden/presentation/garden_home_screen.dart';
import 'package:terrace_garden/features/journal/presentation/journal_screen.dart';
import 'package:terrace_garden/features/plant_catalog/presentation/plants_home_screen.dart';
import 'package:terrace_garden/features/settings/presentation/settings_screen.dart';

part 'app_router.g.dart';

abstract final class AppRoutes {
  static const today = '/today';
  static const garden = '/garden';
  static const plants = '/plants';
  static const journal = '/journal';
  static const settings = '/settings';
}

/// Wraps a screen in the SDK's [MaterialPage].
///
/// go_router 18 detects Material apps via the standalone `material_ui`
/// package, not `package:flutter/material.dart`, so its default pages would
/// lose Material transitions in this app. Every route uses this helper
/// instead (ADR-004).
Page<void> appPage(GoRouterState state, Widget child) =>
    MaterialPage<void>(key: state.pageKey, name: state.name, child: child);

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.today,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          _branch(AppRoutes.today, const TodayScreen()),
          _branch(AppRoutes.garden, const GardenHomeScreen()),
          _branch(AppRoutes.plants, const PlantsHomeScreen()),
          _branch(AppRoutes.journal, const JournalScreen()),
        ],
      ),
      GoRoute(
        path: AppRoutes.settings,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => appPage(state, const SettingsScreen()),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
}

StatefulShellBranch _branch(String path, Widget screen) => StatefulShellBranch(
  routes: [
    GoRoute(
      path: path,
      pageBuilder: (context, state) => appPage(state, screen),
    ),
  ],
);
