import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/presentation/terrace_plan.dart';
import 'package:terrace_garden/features/plant_catalog/presentation/art/plant_art.dart';

import '../../../helpers/pump_app.dart';

void main() {
  final pot = PlanItem(
    element: const LayoutElement(
      id: 'pot',
      kind: ElementKind.roundPot,
      center: Vec2(100, 100),
      width: 40,
      height: 40,
    ),
    plants: [PlantArtSpec.of('tomato')],
    tag: 'Tomato',
    semanticLabel: 'Tomato, round pot, soil check due',
  );
  const tap = PlanItem(
    element: LayoutElement(
      id: 'tap',
      kind: ElementKind.waterPoint,
      center: Vec2(20, 20),
      width: 15,
      height: 15,
    ),
  );

  testWidgets('containers are labelled buttons; markers are not', (
    tester,
  ) async {
    PlanItem? tapped;
    final handle = tester.ensureSemantics();
    await tester.pumpLocalized(
      SizedBox(
        width: 300,
        height: 300,
        child: TerracePlan(
          lengthCm: 200,
          widthCm: 200,
          items: [pot, tap],
          semanticLabel: 'My terrace',
          onTapItem: (i) => tapped = i,
        ),
      ),
    );
    final button = find.bySemanticsLabel('Tomato, round pot, soil check due');
    expect(button, findsOneWidget);
    await tester.tap(button);
    expect(tapped?.element.id, 'pot');
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    handle.dispose();
  });

  testWidgets('keeps the garden proportions inside the box', (tester) async {
    await tester.pumpLocalized(
      SizedBox(
        width: 400,
        height: 400,
        child: TerracePlan(lengthCm: 300, widthCm: 120, items: [pot]),
      ),
    );
    final size = tester.getSize(
      find.descendant(
        of: find.byType(TerracePlan),
        matching: find.byType(CustomPaint),
      ),
    );
    expect(size.width / size.height, closeTo(300 / 120, .01));
  });
}
