import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:terrace_garden/app/router/app_shell.dart';
import 'package:terrace_garden/features/care/presentation/today_screen.dart';
import 'package:terrace_garden/features/garden/presentation/garden_form_screen.dart';
import 'package:terrace_garden/features/garden/presentation/garden_home_screen.dart';
import 'package:terrace_garden/features/garden/presentation/garden_overview_screen.dart';
import 'package:terrace_garden/features/garden/presentation/photo_gallery_screen.dart';
import 'package:terrace_garden/features/garden/presentation/photo_viewer_screen.dart';
import 'package:terrace_garden/features/garden/presentation/terrace_checklist_screen.dart';
import 'package:terrace_garden/features/garden_designer/presentation/designer_screen.dart';
import 'package:terrace_garden/features/journal/presentation/journal_screen.dart';
import 'package:terrace_garden/features/onboarding/presentation/onboarding_screen.dart';
import 'package:terrace_garden/features/plant_catalog/presentation/plant_detail_screen.dart';
import 'package:terrace_garden/features/plant_catalog/presentation/plants_home_screen.dart';
import 'package:terrace_garden/features/plant_catalog/presentation/recommendations_screen.dart';
import 'package:terrace_garden/features/settings/application/settings_controller.dart';
import 'package:terrace_garden/features/settings/presentation/image_credits_screen.dart';
import 'package:terrace_garden/features/settings/presentation/settings_screen.dart';

part 'app_router.g.dart';

/// Route paths. Screens inside a tab (keeping the navigation bar) live under
/// the tab's path, e.g. `/garden/...`. Full-screen pages (forms, viewers)
/// are top-level routes, e.g. `/gardens/...`, so they sit on the root
/// navigator and system back always targets them rather than the tab's
/// navigator underneath. Tested in garden_flows_test ("Discard changes?").
abstract final class AppRoutes {
  static const onboarding = '/onboarding';
  static const today = '/today';
  static const garden = '/garden';
  static const plants = '/plants';
  static const journal = '/journal';
  static const settings = '/settings';
  static const imageCredits = '/settings/credits';

  // In the Garden tab.
  static String gardenDetail(String id) => '/garden/$id';
  static String gardenPhotos(String id) => '/garden/$id/photos';
  static String gardenChecklist(String id) => '/garden/$id/checklist';

  // Full screen.
  static const gardenNew = '/gardens/new';
  static String gardenEdit(String id) => '/gardens/$id/edit';
  static String gardenDesign(String id) => '/gardens/$id/design';
  static String gardenPhoto(String id, String photoId) =>
      '/gardens/$id/photos/$photoId';
  static String gardenIdeas(String id) => '/gardens/$id/ideas';

  /// Plant detail; [gardenId] preselects that garden when adding a planting.
  static String plantDetail(String speciesId, {String? gardenId}) => Uri(
    path: '/catalogue/$speciesId',
    queryParameters: gardenId == null ? null : {'garden': gardenId},
  ).toString();
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

/// Built once settings have loaded (see `TerraceGardenApp`), so the first
/// screen is known: onboarding on first launch, otherwise Today.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  bool onboarded() =>
      ref.read(settingsControllerProvider).value?.onboardingCompleted ?? true;

  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: onboarded() ? AppRoutes.today : AppRoutes.onboarding,
    redirect: (context, state) {
      final atOnboarding = state.matchedLocation == AppRoutes.onboarding;
      if (!onboarded() && !atOnboarding) return AppRoutes.onboarding;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        pageBuilder: (context, state) =>
            appPage(state, const OnboardingScreen()),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          _branch(AppRoutes.today, const TodayScreen()),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.garden,
                pageBuilder: (context, state) =>
                    appPage(state, const GardenHomeScreen()),
                routes: [
                  GoRoute(
                    path: ':gardenId',
                    pageBuilder: (context, state) => appPage(
                      state,
                      GardenOverviewScreen(gardenId: _gardenId(state)),
                    ),
                    routes: [
                      GoRoute(
                        path: 'photos',
                        pageBuilder: (context, state) => appPage(
                          state,
                          PhotoGalleryScreen(gardenId: _gardenId(state)),
                        ),
                      ),
                      GoRoute(
                        path: 'checklist',
                        pageBuilder: (context, state) =>
                            appPage(state, const TerraceChecklistScreen()),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          _branch(AppRoutes.plants, const PlantsHomeScreen()),
          _branch(AppRoutes.journal, const JournalScreen()),
        ],
      ),
      // Full-screen pages (see AppRoutes for why they are top-level).
      GoRoute(
        path: AppRoutes.gardenNew,
        pageBuilder: (context, state) =>
            appPage(state, const GardenFormScreen()),
      ),
      GoRoute(
        path: '/gardens/:gardenId/edit',
        pageBuilder: (context, state) =>
            appPage(state, GardenFormScreen(gardenId: _gardenId(state))),
      ),
      GoRoute(
        path: '/gardens/:gardenId/design',
        pageBuilder: (context, state) =>
            appPage(state, DesignerScreen(gardenId: _gardenId(state))),
      ),
      GoRoute(
        path: '/gardens/:gardenId/ideas',
        pageBuilder: (context, state) => appPage(
          state,
          RecommendationsScreen(gardenId: _gardenId(state)),
        ),
      ),
      GoRoute(
        path: '/catalogue/:speciesId',
        pageBuilder: (context, state) => appPage(
          state,
          PlantDetailScreen(
            speciesId: state.pathParameters['speciesId']!,
            gardenId: state.uri.queryParameters['garden'],
          ),
        ),
      ),
      GoRoute(
        path: '/gardens/:gardenId/photos/:photoId',
        pageBuilder: (context, state) => appPage(
          state,
          PhotoViewerScreen(
            gardenId: _gardenId(state),
            photoId: state.pathParameters['photoId']!,
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.settings,
        pageBuilder: (context, state) => appPage(state, const SettingsScreen()),
        routes: [
          GoRoute(
            path: 'credits',
            pageBuilder: (context, state) =>
                appPage(state, const ImageCreditsScreen()),
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
}

String _gardenId(GoRouterState state) => state.pathParameters['gardenId']!;

StatefulShellBranch _branch(String path, Widget screen) => StatefulShellBranch(
  routes: [
    GoRoute(
      path: path,
      pageBuilder: (context, state) => appPage(state, screen),
    ),
  ],
);
