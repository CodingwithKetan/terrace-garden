import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/app/app.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/settings/application/settings_controller.dart';
import 'package:terrace_garden/features/settings/domain/app_settings.dart';

import '../helpers/fake_settings_repository.dart';
import '../helpers/pump_app.dart';

void main() {
  late FakeSettingsRepository settings;

  setUp(() => settings = FakeSettingsRepository());

  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [settingsRepositoryProvider.overrideWithValue(settings)],
        child: const TerraceGardenApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('opens on Today and navigates between the four tabs', (
    tester,
  ) async {
    await pumpApp(tester);
    expect(find.text('Your garden day starts here'), findsOneWidget);

    await tester.tap(find.text('Garden'));
    await tester.pumpAndSettle();
    expect(find.text('Plan your terrace or balcony'), findsOneWidget);

    await tester.tap(find.text('Plants'));
    await tester.pumpAndSettle();
    expect(find.text('Plants that suit your space'), findsOneWidget);

    await tester.tap(find.text('Journal'));
    await tester.pumpAndSettle();
    expect(find.text('Watch your garden grow'), findsOneWidget);
  });

  testWidgets('settings change the theme and units, and persist them', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Measurement units'), findsOneWidget);

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();
    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark);

    await tester.tap(find.text('Imperial (in, ft)'));
    await tester.pumpAndSettle();
    expect(settings.stored.themePreference, ThemePreference.dark);
    expect(settings.stored.unitSystem, UnitSystem.imperial);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Your garden day starts here'), findsOneWidget);
  });

  testWidgets('image credits are reachable from settings', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Image credits'));
    await tester.pumpAndSettle();
    expect(find.text('Photo by Suresh Khole'), findsWidgets);
  });

  testWidgets('shows an error message when saving a setting fails', (
    tester,
  ) async {
    settings.failSaves = true;
    await pumpApp(tester);
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();

    expect(
      find.text("We couldn't save or read your data on this device."),
      findsOneWidget,
    );
    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.system);
  });

  group('responsive navigation', () {
    for (final (name, size, expectBar, expectRail) in [
      ('compact', const Size(360, 800), true, false),
      ('medium', const Size(700, 1000), false, true),
      ('expanded', const Size(1200, 800), false, true),
    ]) {
      testWidgets('$name width uses the right navigation', (tester) async {
        tester.setScreenSize(size);
        await pumpApp(tester);
        expect(find.byType(NavigationBar), expectBar ? findsOne : findsNothing);
        expect(
          find.byType(NavigationRail),
          expectRail ? findsOne : findsNothing,
        );
        expect(tester.takeException(), isNull);
      });
    }
  });

  testWidgets('survives 200% text scaling without overflow', (tester) async {
    tester.setScreenSize(const Size(360, 800));
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await pumpApp(tester);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
