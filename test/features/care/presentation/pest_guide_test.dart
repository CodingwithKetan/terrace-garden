import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_repository.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/subscription/domain/plan.dart';

import '../../../helpers/test_app.dart';

void main() {
  testWidgets('the pest guide opens from Plants and cites its sources', (
    tester,
  ) async {
    final app = TestApp(surface: const Size(412, 915));
    await app.pump(tester);
    await tester.tap(find.text('Plants'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pest guide'));
    await tester.pumpAndSettle();

    expect(find.textContaining('same pests as garden plants'), findsOneWidget);
    await tester.tap(find.text('Aphids'));
    await tester.pumpAndSettle();
    expect(find.text('Look for'), findsOneWidget);
    expect(find.textContaining('strong spray of water'), findsOneWidget);
    expect(
      find.text('Sources: UC IPM, University of California ANR'),
      findsOneWidget,
    );

    await tester.scrollUntilVisible(
      find.textContaining("We don't give doses for chemical pesticides"),
      300,
    );
    expect(find.text('Before you spray'), findsOneWidget);
    expect(find.textContaining('Never use neem products on pets'), findsOne);
  });

  group('garden report', () {
    Future<String> garden(TestApp app) async => (await DriftGardenRepository(
      app.database,
      FixedClock(DateTime(2026, 10, 29)),
      SequentialIdGenerator('g'),
      const DeveloperLogger(),
    ).create(const GardenDraft(name: 'Rooftop'))).valueOrNull!.id;

    testWidgets('is a Plus feature', (tester) async {
      final app = TestApp(surface: const Size(412, 915));
      final id = await garden(app);
      await app.pump(tester);
      await app.open(tester, AppRoutes.gardenDetail(id));
      await tester.scrollUntilVisible(find.text('Garden report'), 200);
      await tester.tap(find.text('Garden report'));
      await tester.pumpAndSettle();
      expect(find.text('Garden report with Plus'), findsOneWidget);
    });

    testWidgets('summarises the garden for Plus users', (tester) async {
      final app = TestApp(surface: const Size(412, 915), plan: Plan.plus);
      final id = await garden(app);
      await app.pump(tester);
      await app.open(tester, AppRoutes.gardenDetail(id));
      await tester.scrollUntilVisible(find.text('Garden report'), 200);
      await tester.tap(find.text('Garden report'));
      await tester.pumpAndSettle();

      expect(find.text('Rooftop'), findsOneWidget);
      expect(find.text('No plants yet.'), findsOneWidget);
      expect(find.text('Care in the last 30 days'), findsOneWidget);
      expect(find.text('No harvests recorded yet.'), findsOneWidget);
      expect(find.byTooltip('Share'), findsOneWidget);
    });
  });
}
