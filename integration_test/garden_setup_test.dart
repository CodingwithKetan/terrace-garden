import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:terrace_garden/app/app.dart';

/// P2-08: onboarding → garden created → app restarted → garden still there.
///
/// Runs against the real database and storage on a device or emulator.
/// Start from a clean install (`adb shell pm clear <package>`), because
/// onboarding only appears on first launch.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('a garden created during onboarding survives a restart', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: TerraceGardenApp()));
    await pumpUntilFound(
      tester,
      find.text('Grow a garden that suits your terrace'),
    );
    await tester.tap(find.text('Set up my garden'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'Rooftop test');
    await tester.tap(find.text('Rooftop'));
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create my garden'));
    await pumpUntilFound(tester, find.text('Your space'));

    // "Restart": dispose the whole app (closing the database), then start a
    // fresh instance that must read everything back from disk.
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
    await tester.pumpWidget(const ProviderScope(child: TerraceGardenApp()));
    await pumpUntilFound(tester, find.text('Your garden day starts here'));
    await tester.tap(find.text('Garden'));
    await pumpUntilFound(tester, find.text('Rooftop test'));
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
