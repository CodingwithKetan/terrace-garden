import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:terrace_garden/app/app.dart';

/// P2-08 + P4 + P5-09: onboarding → garden created → plant added from the
/// ideas screen → app restarted → the soil check is on Today and completes →
/// the daily digest is scheduled with the platform → garden and planting
/// still there.
///
/// Runs against the real database, storage and bundled catalogue on a device
/// or emulator. Onboarding only appears on first launch, so the app must not
/// already be installed with data (e.g. from `flutter run`); uninstall it
/// first. `flutter test` removes the app after each run.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('a garden created during onboarding survives a restart', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: TerraceGardenApp()));
    await pumpUntilFound(
      tester,
      find.text('Grow a garden that suits your terrace'),
      // A first debug launch on a busy emulator can take a while.
      timeout: const Duration(minutes: 2),
    );
    await tester.tap(find.text('Set up my garden'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'Rooftop test');
    // Close the keyboard so it doesn't cover the space-type chips.
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Rooftop'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rooftop'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create my garden'));
    await pumpUntilFound(tester, find.text('Your space'));

    // P4: the bundled catalogue loads on the device and a planting saves.
    await tester.tap(find.text('Plant ideas').first);
    await pumpUntilFound(tester, find.text('Good choices now'));
    await tester.tap(find.text('Add to a garden').first);
    await pumpUntilFound(tester, find.text('Add planting'));
    await tester.ensureVisible(find.text('Add planting'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add planting'));
    await pumpUntilFound(tester, find.textContaining('added to Rooftop test'));

    // "Restart": dispose the whole app (closing the database), then start a
    // fresh instance that must read everything back from disk.
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
    await tester.pumpWidget(const ProviderScope(child: TerraceGardenApp()));

    // P5: the planting's care plan put a soil check on Today. Completing it
    // schedules the next one (from completion).
    await pumpUntilFound(tester, find.text('Check the soil'));
    await tester.tap(find.byTooltip('Mark done').first);
    await pumpUntilFound(tester, find.text('Done today'));

    // Turning on the daily digest reaches the real platform scheduler.
    // Grant POST_NOTIFICATIONS first (adb shell pm grant …) so Android 13+
    // doesn't show its permission dialog.
    await tester.tap(find.byTooltip('Settings'));
    await pumpUntilFound(tester, find.text('Measurement units'));
    await tester.scrollUntilVisible(
      find.text('Daily care digest'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Daily care digest'));
    await pumpUntilFound(
      tester,
      find.byWidgetPredicate((w) => w is Switch && w.value),
    );
    final pending = await pumpUntilPending();
    expect(pending, isNotEmpty);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Garden'));
    await pumpUntilFound(tester, find.text('Rooftop test'));
    await tester.tap(find.text('Rooftop test'));
    // My plants is further down a lazily built list, so scroll to it.
    await pumpUntilFound(tester, find.text('Plant ideas'));
    await tester.scrollUntilVisible(
      find.textContaining('1 plant · since'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.textContaining('1 plant · since'), findsOneWidget);
  });
}

/// Pumps frames until [finder] matches, for work that completes on the real
/// platform (settings, database, files) rather than on an animation.
Future<void> pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 15),
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 100));
    if (finder.evaluate().isNotEmpty) {
      await tester.pumpAndSettle();
      return;
    }
  }
  final visible = find
      .byType(Text)
      .evaluate()
      .map((e) => (e.widget as Text).data)
      .whereType<String>()
      .join(' | ');
  throw TestFailure('Timed out waiting for $finder. Visible text: $visible');
}

/// Waits for the digest to reach the platform; scheduling runs in the
/// background after the setting is saved.
Future<List<PendingNotificationRequest>> pumpUntilPending() async {
  final plugin = FlutterLocalNotificationsPlugin();
  final end = DateTime.now().add(const Duration(seconds: 15));
  var pending = <PendingNotificationRequest>[];
  while (DateTime.now().isBefore(end)) {
    pending = await plugin.pendingNotificationRequests();
    if (pending.isNotEmpty) break;
    await Future<void>.delayed(const Duration(milliseconds: 200));
  }
  return pending;
}
