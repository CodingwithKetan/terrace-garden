import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_repository.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/plantings/data/drift_planting_repository.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';

import '../helpers/test_app.dart';

/// P6-06. Walks the main screens at tablet, landscape and phone-landscape
/// sizes: no layout exceptions, a navigation rail from medium width, and
/// list content kept to a readable width on wide windows.
void main() {
  final now = DateTime(2026, 10, 18, 9);

  Future<TestApp> seeded() async {
    final app = TestApp(now: now);
    final clock = FixedClock(now);
    const logger = DeveloperLogger();
    final gardenId =
        (await DriftGardenRepository(
              app.database,
              clock,
              SequentialIdGenerator('g'),
              logger,
            ).create(
              const GardenDraft(
                name: 'Home garden',
                length: Length.cm(400),
                width: Length.cm(300),
              ),
            ))
            .valueOrNull!
            .id;
    await DriftPlantingRepository(
      app.database,
      clock,
      SequentialIdGenerator('p'),
      logger,
    ).create(
      PlantingDraft(
        gardenId: gardenId,
        speciesId: 'tomato',
        plantedOn: LocalDate.fromDateTime(now),
        startedFrom: PlantingStart.seedling,
      ),
    );
    return app;
  }

  for (final size in const [Size(840, 1180), Size(1280, 800), Size(800, 360)]) {
    testWidgets(
      'main screens at ${size.width.toInt()}×${size.height.toInt()}',
      (
        tester,
      ) async {
        tester.view.physicalSize = size * tester.view.devicePixelRatio;
        addTearDown(tester.view.resetPhysicalSize);
        final app = await seeded();
        await app.pump(tester);

        expect(find.byType(NavigationRail), findsOneWidget);
        expect(find.byType(NavigationBar), findsNothing);
        expect(tester.takeException(), isNull, reason: 'Today');

        Future<void> visit(String label) async {
          await tester.tap(
            find.descendant(
              of: find.byType(NavigationRail),
              matching: find.text(label),
            ),
          );
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull, reason: label);
        }

        await visit('Plants');
        if (size.width >= 1000) {
          // Catalogue rows stay at a readable width, centred.
          final row = tester.getRect(find.text('Aloe vera').first);
          expect(row.left, greaterThan(300));
        }
        await visit('Journal');
        await visit('Seasons');
        await visit('Today');
        await tester.tap(find.text('Home garden'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: 'Garden overview');
        await tester.scrollUntilVisible(
          find.text('Design your layout'),
          100,
          scrollable: find
              .byWidgetPredicate(
                (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
              )
              .last,
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('Design your layout'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: 'Designer');
      },
    );
  }
}
