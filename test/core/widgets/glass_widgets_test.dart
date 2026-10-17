import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/app/theme/app_imagery.dart';
import 'package:terrace_garden/core/widgets/glass_icon_button.dart';
import 'package:terrace_garden/core/widgets/glass_panel.dart';
import 'package:terrace_garden/core/widgets/immersive_empty_state.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('GlassPanel', () {
    testWidgets('blurs its backdrop by default', (tester) async {
      await tester.pumpLocalized(const GlassPanel(child: Text('Hello')));
      expect(find.byType(BackdropFilter), findsOneWidget);
      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('renders an opaque surface when high contrast is on', (
      tester,
    ) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(highContrast: true);
      addTearDown(
        tester.platformDispatcher.clearAccessibilityFeaturesTestValue,
      );

      await tester.pumpLocalized(const GlassPanel(child: Text('Hello')));
      expect(find.byType(BackdropFilter), findsNothing);
      expect(find.text('Hello'), findsOneWidget);
    });
  });

  testWidgets('GlassIconButton has a tooltip and a 48dp target', (
    tester,
  ) async {
    var taps = 0;
    await tester.pumpLocalized(
      Center(
        child: GlassIconButton(
          icon: Icons.settings_outlined,
          tooltip: 'Settings',
          onPressed: () => taps++,
        ),
      ),
    );
    await tester.tap(find.byTooltip('Settings'));
    expect(taps, 1);
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
  });

  group('ImmersiveEmptyState', () {
    Widget state({VoidCallback? onAction}) => ImmersiveEmptyState(
      screenTitle: 'Garden',
      image: const AssetImage(AppPhotos.gardenTerrace),
      icon: Icons.yard_outlined,
      title: 'Plan your terrace or balcony',
      body: 'Garden setup is coming in the next update.',
      badge: 'Coming soon',
      actionLabel: onAction == null ? null : 'Create garden',
      onAction: onAction,
    );

    testWidgets('shows title, message and badge without dead buttons', (
      tester,
    ) async {
      await tester.pumpLocalized(state());
      expect(find.text('Garden'), findsOneWidget);
      expect(find.text('Plan your terrace or balcony'), findsOneWidget);
      expect(find.text('Coming soon'), findsOneWidget);
      expect(find.byType(FilledButton), findsNothing);
    });

    testWidgets('shows a working action when provided', (tester) async {
      var tapped = false;
      await tester.pumpLocalized(state(onAction: () => tapped = true));
      await tester.tap(find.text('Create garden'));
      expect(tapped, isTrue);
    });

    testWidgets('keeps the panel above the bottom inset (navigation bar)', (
      tester,
    ) async {
      tester.setScreenSize(const Size(400, 860));
      const navigationBarInset = 100.0;
      await tester.pumpLocalized(
        Builder(
          builder: (context) => MediaQuery(
            data:
                MediaQuery.of(
                  context,
                ).copyWith(
                  padding: const EdgeInsets.only(bottom: navigationBarInset),
                ),
            child: state(),
          ),
        ),
      );
      final panelBottom = tester.getBottomLeft(find.byType(GlassPanel)).dy;
      expect(panelBottom, lessThanOrEqualTo(860 - navigationBarInset));
    });

    testWidgets('fits a small phone at 200% text without overflow', (
      tester,
    ) async {
      tester.setScreenSize(const Size(360, 740));
      await tester.pumpLocalized(state(), textScale: 2);
      expect(tester.takeException(), isNull);
    });
  });
}
