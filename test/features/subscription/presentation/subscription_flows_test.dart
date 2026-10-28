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

/// ADR-028: what stays free, the Plus screen's disclosures, buying, and
/// the calm upgrade sheet at each limit.
void main() {
  Future<void> addGarden(TestApp app, String name) async {
    await DriftGardenRepository(
      app.database,
      FixedClock(DateTime(2026, 10, 29)),
      SequentialIdGenerator(name),
      const DeveloperLogger(),
    ).create(GardenDraft(name: name));
  }

  testWidgets('the Plus screen shows store prices, terms and a cancel link', (
    tester,
  ) async {
    final app = TestApp(surface: const Size(412, 915));
    await app.pump(tester);
    await app.open(tester, AppRoutes.plus);

    expect(find.text('Terrace Garden Plus'), findsOneWidget);
    expect(find.text('Always free'), findsOneWidget);
    expect(find.text('Soil checks and care reminders'), findsOneWidget);
    expect(find.text('₹49.00 a month'), findsOneWidget);
    expect(find.text('₹399.00 a year'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Manage subscription'), 200);
    expect(find.text('₹999.00, paid once'), findsOneWidget);
    expect(
      find.textContaining('renew automatically until you cancel'),
      findsOne,
    );
    expect(
      find.text('We will never move a free feature behind Plus.'),
      findsOne,
    );
    expect(find.text('Manage subscription'), findsOneWidget);
  });

  testWidgets('buying Plus switches the plan and thanks the user', (
    tester,
  ) async {
    final app = TestApp(surface: const Size(412, 915));
    await app.pump(tester);
    await app.open(tester, AppRoutes.plus);

    final yearly = find.widgetWithText(FilledButton, 'Choose').at(1);
    await tester.ensureVisible(yearly);
    await tester.pumpAndSettle();
    await tester.tap(yearly);
    await tester.pumpAndSettle();
    expect(app.purchases.bought, ['terrace_plus_yearly']);
    expect(
      find.text('You have Plus. Thank you for supporting the app.'),
      findsOneWidget,
    );
    expect(find.widgetWithText(FilledButton, 'Choose'), findsNothing);
  });

  testWidgets('when Plus is not on sale, it says so and nothing is sold', (
    tester,
  ) async {
    final app = TestApp(surface: const Size(412, 915));
    app.purchases.onSale = false;
    await app.pump(tester);
    await app.open(tester, AppRoutes.plus);
    expect(
      find.text("Plus isn't on sale yet. Everything above stays free."),
      findsOneWidget,
    );
    expect(find.widgetWithText(FilledButton, 'Choose'), findsNothing);
  });

  testWidgets('a second garden on the free plan opens the upgrade sheet', (
    tester,
  ) async {
    final app = TestApp(surface: const Size(412, 915));
    await addGarden(app, 'Rooftop');
    await app.pump(tester);
    await app.open(tester, AppRoutes.gardens);

    await tester.tap(find.text('New garden'));
    await tester.pumpAndSettle();
    expect(find.text('Add another garden with Plus'), findsOneWidget);
    await tester.tap(find.text('Not now'));
    await tester.pumpAndSettle();
    expect(find.text('Add another garden with Plus'), findsNothing);
  });

  testWidgets('Plus can add another garden straight away', (tester) async {
    final app = TestApp(surface: const Size(412, 915), plan: Plan.plus);
    await addGarden(app, 'Rooftop');
    await app.pump(tester);
    await app.open(tester, AppRoutes.gardens);

    await tester.tap(find.text('New garden'));
    await tester.pumpAndSettle();
    expect(find.text('Add another garden with Plus'), findsNothing);
    expect(find.byType(TextFormField), findsWidgets);
  });

  testWidgets('Settings shows the plan and opens the Plus screen', (
    tester,
  ) async {
    final app = TestApp(surface: const Size(412, 915));
    await app.pump(tester);
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();

    final tile = find.byKey(const Key('yourPlan'));
    expect(
      find.descendant(of: tile, matching: find.text('Free')),
      findsOneWidget,
    );
    await tester.tap(tile);
    await tester.pumpAndSettle();
    expect(find.text('Terrace Garden Plus'), findsOneWidget);
  });
}
