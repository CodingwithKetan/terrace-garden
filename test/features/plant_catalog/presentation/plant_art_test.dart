import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/features/plant_catalog/presentation/art/plant_art.dart';

void main() {
  final ids = [
    for (final s
        in (jsonDecode(File('assets/catalogue/plants.json').readAsStringSync())
                as Map<String, dynamic>)['species']
            as List)
      (s as Map<String, dynamic>)['id'] as String,
  ];

  test('every catalogue species has its own drawing', () {
    expect(ids.where((id) => !PlantArtSpec.hasOwnDrawing(id)), isEmpty);
  });

  test('no two species share a drawing', () {
    final byLook = <Object, List<String>>{};
    for (final id in ids) {
      byLook.putIfAbsent(PlantArtSpec.of(id).look, () => []).add(id);
    }
    expect(byLook.values.where((same) => same.length > 1), isEmpty);
  });

  test('only a short, deliberate list of species has no trait', () {
    // Species without a trait rely on colour alone; keep that list short
    // and deliberate (one plain example per form).
    final plain = [
      for (final id in ids)
        if (PlantArtSpec.of(id).trait == ArtTrait.none) id,
    ];
    expect(
      plain,
      unorderedEquals([
        'tomato',
        'palak',
        'radish',
        'mint',
        'lemongrass',
        'vetiver',
        'aloeVera',
        'moneyPlant',
        'sweetPotato',
      ]),
    );
  });
}
