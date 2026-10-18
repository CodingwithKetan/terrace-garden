import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/presentation/terrace_plan.dart';
import 'package:terrace_garden/features/plant_catalog/presentation/art/plant_art.dart';

const _species = [
  'tomato',
  'chilli',
  'brinjal',
  'frenchBean',
  'okra',
  'bitterGourd',
  'bottleGourd',
  'palak',
  'lettuce',
  'amaranth',
  'radish',
  'carrot',
  'mint',
  'tulsi',
  'curryLeaf',
  'coriander',
  'methi',
  'lemongrass',
  'marigold',
  'hibiscus',
  'jasmine',
  'rose',
  'aloeVera',
  'snakePlant',
  'moneyPlant',
];

final _items = [
  const PlanItem(
    element: LayoutElement(
      id: 'path',
      kind: ElementKind.path,
      center: Vec2(200, 270),
      width: 400,
      height: 60,
    ),
  ),
  PlanItem(
    element: const LayoutElement(
      id: 'a',
      kind: ElementKind.growBag,
      center: Vec2(85, 80),
      width: 100,
      height: 75,
      depthCm: 30,
    ),
    plants: [PlantArtSpec.of('tomato')],
    tag: 'Tomato',
    badge: PlanBadge.due,
  ),
  PlanItem(
    element: const LayoutElement(
      id: 'b',
      kind: ElementKind.roundPot,
      center: Vec2(205, 75),
      width: 70,
      height: 70,
    ),
    plants: [PlantArtSpec.of('okra')],
    tag: 'Okra',
    badge: PlanBadge.done,
  ),
  PlanItem(
    element: const LayoutElement(
      id: 'c',
      kind: ElementKind.rectPlanter,
      center: Vec2(205, 185),
      width: 160,
      height: 48,
    ),
    plants: [
      PlantArtSpec.of('palak'),
      PlantArtSpec.of('palak'),
      PlantArtSpec.of('palak'),
    ],
    tag: 'Palak',
  ),
  const PlanItem(
    element: LayoutElement(
      id: 'w',
      kind: ElementKind.waterPoint,
      center: Vec2(370, 260),
      width: 15,
      height: 15,
    ),
  ),
];

Widget _plan({
  List<PlanItem>? items,
  String? selectedId,
  bool dusk = false,
}) => SizedBox(
  width: 360,
  height: 280,
  child: TerracePlan(
    lengthCm: 400,
    widthCm: 300,
    items: items ?? _items,
    selectedId: selectedId,
    dusk: dusk,
  ),
);

/// Locks down the Living Terrace drawings: every species' top and side
/// art, and the terrace plan in its normal, picker and dusk states.
void main() {
  unawaited(
    goldenTest(
      'plant art for every catalogue species',
      fileName: 'plant_art',
      builder: () => GoldenTestGroup(
        columns: 5,
        children: [
          for (final id in _species)
            GoldenTestScenario(
              name: id,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      color: Color(0xFF5A3E2B),
                      shape: BoxShape.circle,
                    ),
                    child: PlantTopArt(spec: PlantArtSpec.of(id), size: 72),
                  ),
                  PlantSideArt(spec: PlantArtSpec.of(id), size: 96),
                ],
              ),
            ),
        ],
      ),
    ),
  );

  unawaited(
    goldenTest(
      'terrace plan',
      fileName: 'terrace_plan',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(name: 'tasks', child: _plan()),
          GoldenTestScenario(
            name: 'add-plant picker',
            child: _plan(
              selectedId: 'a',
              items: [
                for (final i in _items)
                  PlanItem(
                    element: i.element,
                    plants: i.plants,
                    tag: i.tag,
                    fit: switch (i.element.id) {
                      'a' => PlanFit.fits,
                      'b' => PlanFit.fitsShared,
                      _ => PlanFit.unsuitable,
                    },
                  ),
              ],
            ),
          ),
          GoldenTestScenario(name: 'dusk', child: _plan(dusk: true)),
        ],
      ),
    ),
  );
}
