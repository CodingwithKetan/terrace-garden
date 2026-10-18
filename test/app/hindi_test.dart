import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/features/settings/domain/app_settings.dart';

import '../helpers/test_app.dart';

/// Hindi (PD-003): the language picker switches the whole app, the choice
/// is saved, and Hindi text (often longer) fits a small phone at 200%.
void main() {
  testWidgets('choosing हिन्दी in Settings switches the app and is saved', (
    tester,
  ) async {
    final app = TestApp(surface: const Size(412, 915));
    await app.pump(tester);
    expect(find.text('Today'), findsOneWidget);

    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('हिन्दी'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('हिन्दी'));
    await tester.pumpAndSettle();
    expect(app.settings.stored.language, AppLanguage.hindi);
    expect(find.text('सेटिंग्स'), findsWidgets);

    // pageBack() looks for the English "Back" tooltip.
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    for (final tab in ['आज', 'पौधे', 'मौसम', 'डायरी']) {
      expect(find.text(tab), findsWidgets, reason: tab);
    }
    expect(find.text('आइए, अपनी छत का नक्शा बनाएँ'), findsOneWidget);
  });

  testWidgets('Hindi at 200% text on a small phone: no overflow', (
    tester,
  ) async {
    tester.view.physicalSize =
        const Size(360, 780) * tester.view.devicePixelRatio;
    addTearDown(tester.view.resetPhysicalSize);
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    final app = TestApp(
      settings: const AppSettings(
        onboardingCompleted: true,
        language: AppLanguage.hindi,
      ),
    );
    await app.pump(tester);
    expect(tester.takeException(), isNull, reason: 'आज');
    for (final tab in ['पौधे', 'मौसम', 'डायरी']) {
      await tester.tap(find.text(tab).last);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: tab);
    }
    await tester.tap(find.text('आज').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('सेटिंग्स'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull, reason: 'सेटिंग्स');
  });
}
