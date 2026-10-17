import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';
import 'package:terrace_garden/features/settings/domain/app_settings.dart';

import '../../../helpers/test_app.dart';
import '../../../helpers/test_images.dart';

void main() {
  group('onboarding', () {
    testWidgets('first launch shows onboarding; explore skips to Today', (
      tester,
    ) async {
      final app = TestApp(settings: AppSettings.defaults);
      await app.pump(tester);

      expect(
        find.text('Grow a garden that suits your terrace'),
        findsOneWidget,
      );
      await tester.tap(find.text("I'll explore first"));
      await tester.pumpAndSettle();

      expect(find.text('Your garden day starts here'), findsOneWidget);
      expect(app.settings.stored.onboardingCompleted, isTrue);
      expect(await app.database.select(app.database.gardens).get(), isEmpty);
    });

    testWidgets('creates a garden through every step', (tester) async {
      final app = TestApp(settings: AppSettings.defaults);
      await app.pump(tester);

      await tester.tap(find.text('Set up my garden'));
      await tester.pumpAndSettle();
      expect(find.text('Step 1 of 3'), findsOneWidget);
      // The name is prefilled, so the user can continue straight away.
      expect(find.widgetWithText(TextFormField, 'My terrace'), findsOneWidget);
      await tester.tap(find.text('Balcony'));
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(find.text('Light and location'), findsOneWidget);
      await tester.tap(find.text('6+ hours'));
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(find.text('What would you like to grow?'), findsOneWidget);
      await tester.tap(find.text('Herbs'));
      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();

      expect(find.text('Ready to create your garden'), findsOneWidget);
      await tester.tap(find.text('Create my garden'));
      await tester.pumpAndSettle();

      // Lands on the new garden's overview.
      expect(find.text('My terrace'), findsWidgets);
      expect(find.text('Your space'), findsOneWidget);
      final gardens = await app.database.select(app.database.gardens).get();
      expect(gardens.single.spaceType, SpaceType.balcony);
      expect(gardens.single.sun, SunExposure.moreThan6Hours);
      expect(gardens.single.goals, 'herbs');
      expect(app.settings.stored.onboardingCompleted, isTrue);
    });

    testWidgets('keeps both edits made within the same frame', (tester) async {
      final app = TestApp(settings: AppSettings.defaults);
      await app.pump(tester);
      await tester.tap(find.text('Set up my garden'));
      await tester.pumpAndSettle();

      // No pump between the two edits: the second must not overwrite the
      // first (regression: the name was lost on a real device).
      await tester.enterText(find.byType(TextFormField).first, 'Rooftop test');
      await tester.tap(find.text('Rooftop'));
      await tester.pump();
      for (final button in ['Continue', 'Skip', 'Skip', 'Create my garden']) {
        await tester.tap(find.text(button));
        await tester.pumpAndSettle();
      }

      final row =
          (await app.database.select(app.database.gardens).get()).single;
      expect(row.name, 'Rooftop test');
      expect(row.spaceType, SpaceType.rooftop);
    });

    testWidgets('requires a name before continuing', (tester) async {
      final app = TestApp(settings: AppSettings.defaults);
      await app.pump(tester);
      await tester.tap(find.text('Set up my garden'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, '   ');
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(find.text('Give your garden a name'), findsOneWidget);
      expect(find.text('Step 1 of 3'), findsOneWidget);
    });
  });

  group('gardens', () {
    Future<TestApp> openGardenTab(WidgetTester tester) async {
      final app = TestApp();
      await app.pump(tester);
      await tester.tap(find.text('Garden'));
      await tester.pumpAndSettle();
      return app;
    }

    Future<void> createGarden(WidgetTester tester, String name) async {
      await tester.tap(find.text('Create your garden'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).first, name);
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
    }

    testWidgets('creates a garden from the Garden tab with a city', (
      tester,
    ) async {
      final app = await openGardenTab(tester);
      await tester.tap(find.text('Create your garden'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).first, 'Rooftop');

      await tester.scrollUntilVisible(
        find.text('Choose your city'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Choose your city'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, 'chen');
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ListTile, 'Chennai'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('Rooftop'), findsWidgets);
      expect(find.text('Tamil Nadu'), findsWidgets);
      final row =
          (await app.database.select(app.database.gardens).get()).single;
      expect(row.region, GrowingRegion.tamilNadu);
    });

    testWidgets('shows "Not set · Add" for unknown details', (tester) async {
      await openGardenTab(tester);
      await createGarden(tester, 'Balcony garden');
      expect(find.text('Not set · Add'), findsWidgets);
    });

    testWidgets('a city without sourced data explains the limitation', (
      tester,
    ) async {
      await openGardenTab(tester);
      await tester.tap(find.text('Create your garden'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('Choose your city'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Choose your city'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, 'Mumbai');
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ListTile, 'Mumbai'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining("Sowing calendars for this city aren't available"),
        findsOneWidget,
      );
    });

    testWidgets('edits a garden and asks before discarding changes', (
      tester,
    ) async {
      await openGardenTab(tester);
      await createGarden(tester, 'Roof');

      await tester.tap(find.byTooltip('Edit'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).first, 'Roof garden');
      // Let the form rebuild so it knows it has unsaved changes.
      await tester.pump();
      // System back (Android back button) must ask before discarding.
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.text('Discard changes?'), findsOneWidget);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(find.text('Roof garden'), findsWidgets);
    });

    testWidgets('deletes a garden after confirmation', (tester) async {
      final app = await openGardenTab(tester);
      await createGarden(tester, 'Old balcony');

      await tester.tap(find.byTooltip('More actions'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete garden'));
      await tester.pumpAndSettle();
      expect(find.text('Delete Old balcony?'), findsOneWidget);
      await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
      await tester.pumpAndSettle();

      expect(find.text('Plan your terrace or balcony'), findsOneWidget);
      expect(await app.database.select(app.database.gardens).get(), isEmpty);
    });

    testWidgets('opens the terrace checklist with sourced guidance', (
      tester,
    ) async {
      await openGardenTab(tester);
      await createGarden(tester, 'Roof');
      await tester.scrollUntilVisible(
        find.text('Terrace care checklist'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Terrace care checklist'));
      await tester.pumpAndSettle();

      expect(find.text('Check the roof can take the weight'), findsOneWidget);
      expect(find.textContaining('IS 875'), findsOneWidget);
      expect(find.textContaining('structural engineer'), findsOneWidget);
    });

    testWidgets('adds a photo from the gallery picker', (tester) async {
      final app = await openGardenTab(tester);
      await createGarden(tester, 'Roof');
      final png = await tester.runAsync(
        () => writeTestPng(p.join(app.photoRoot.path, 'picked.png')),
      );
      app.picker.next = Ok([png!.path]);

      await tester.scrollUntilVisible(
        find.text('Add photo'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      // Lift the button clear of the floating navigation bar before tapping.
      await tester.drag(find.byType(Scrollable).first, const Offset(0, -300));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add photo'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Choose from gallery'));
      // Each file step completes on the real event loop, then continues on
      // the test's fake clock, so alternate the two.
      for (var i = 0; i < 20; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 20)),
        );
        await tester.pump();
      }
      await tester.pumpAndSettle();

      final photos = await app.database.select(app.database.gardenPhotos).get();
      expect(photos, hasLength(1));
      expect(find.text('See all'), findsOneWidget);
    });
  });
}
