import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/app/theme/app_theme.dart';
import 'package:terrace_garden/features/care/application/care_controllers.dart';
import 'package:terrace_garden/features/settings/application/settings_controller.dart';
import 'package:terrace_garden/features/settings/domain/app_settings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

class TerraceGardenApp extends ConsumerWidget {
  const TerraceGardenApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Keeps care plans, tasks and digest notifications in step with data.
    ref.watch(careAutomationProvider);
    final settings = ref.watch(settingsControllerProvider);
    final themeMode = switch (settings.value?.themePreference) {
      ThemePreference.light => ThemeMode.light,
      ThemePreference.dark => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    // Settings decide the first screen (onboarding or Today). Loading them
    // takes milliseconds; until then show a plain surface instead of
    // flashing the wrong screen.
    if (!settings.hasValue) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: themeMode,
        home: const Scaffold(),
      );
    }

    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // Null follows the phone (falling back to English if unsupported).
      locale: switch (settings.value?.language.code) {
        final code? => Locale(code),
        null => null,
      },
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
