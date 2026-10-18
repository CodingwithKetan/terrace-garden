import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';
import 'package:terrace_garden/features/plant_catalog/data/catalogue_parser.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';

/// P4-DATA-01. Validates the real bundled catalogue: every record parses,
/// every citation resolves to `sources.json` and to the provenance register
/// in `gardening-references.md`, and only fully verified (F) sources are
/// cited.
void main() {
  final plantsJson = File('assets/catalogue/plants.json').readAsStringSync();
  final sourcesJson = File('assets/catalogue/sources.json').readAsStringSync();
  final references = File(
    'docs/research/gardening-references.md',
  ).readAsStringSync();

  PlantCatalogue parse({String? plants, String? sources}) =>
      CatalogueParser.parse(
        plantsJson: plants ?? plantsJson,
        sourcesJson: sources ?? sourcesJson,
      );

  group('bundled catalogue', () {
    final catalogue = parse();

    test('parses with unique ids and at least 25 species', () {
      expect(catalogue.species.length, greaterThanOrEqualTo(25));
      expect(catalogue.version, greaterThanOrEqualTo(1));
    });

    test('every source is in the provenance register as fully verified', () {
      for (final id in catalogue.sources.keys) {
        final row = RegExp(
          '^\\| $id \\|.*\$',
          multiLine: true,
        ).firstMatch(references);
        expect(row, isNotNull, reason: '$id missing from references');
        final cells = row!.group(0)!.split('|').map((c) => c.trim()).toList();
        // Columns: | ID | Title | URL | Publisher | Covers | Quality | Fetch |
        expect(
          cells[7],
          // "F", or "F" for the cited page when another page was SS.
          matches(RegExp(r'\bF\b')),
          reason: '$id is not fully verified (fetch status "${cells[7]}")',
        );
      }
    });

    test('species cite only sources listed in sources.json', () {
      for (final s in catalogue.species) {
        expect(
          catalogue.sources.keys,
          containsAll(s.citedSources),
          reason: s.id,
        );
      }
    });

    test('verified records have sourced sun, container and harvest data', () {
      for (final s in catalogue.species.where(
        (s) => s.dataStatus == DataStatus.verified,
      )) {
        expect(s.sun, isNotNull, reason: s.id);
        expect(s.container.status, EvidenceStatus.verified, reason: s.id);
        expect(s.daysToHarvest, isNotNull, reason: s.id);
      }
    });

    test('container figures are within plausible bounds', () {
      for (final s in catalogue.species) {
        final c = s.container;
        if (c.minVolumeL != null) {
          expect(c.minVolumeL, inInclusiveRange(1, 100), reason: s.id);
        }
        if (c.minDepthCm != null) {
          expect(c.minDepthCm, inInclusiveRange(5, 90), reason: s.id);
        }
      }
    });

    test('known facts match the register (spot checks)', () {
      final tomato = catalogue.byId('tomato')!;
      expect(tomato.sun!.minHours, 6);
      expect(tomato.container.minVolumeL, closeTo(18.9, 0.1));
      expect(tomato.petSafety.status, PetSafetyStatus.toxic);
      expect(
        tomato.sowingFor(GrowingRegion.northIndia)!.window.months,
        {6, 7, 8, 11, 12},
      );
      final okra = catalogue.byId('okra')!;
      expect(okra.container.minVolumeL, closeTo(18.9, 0.1));
      expect(okra.container.sources, ['S53']);
      // No sourced pot size: shown as not documented, never guessed.
      final curryLeaf = catalogue.byId('curryLeaf')!;
      expect(curryLeaf.container.status, EvidenceStatus.unverified);
      expect(curryLeaf.container.minVolumeL, isNull);
      expect(
        catalogue.byId('coriander')!.petSafety.status,
        PetSafetyStatus.nonToxic,
      );
      expect(
        catalogue.byId('jasmine')!.petSafety.status,
        PetSafetyStatus.nonToxic,
      );
    });
  });

  group('sowingFor', () {
    final catalogue = parse();

    test('prefers the state window, then falls back to the macro region', () {
      final okra = catalogue.byId('okra')!;
      final tn = okra.sowingFor(GrowingRegion.tamilNadu)!;
      expect(tn.isFallback, isFalse);
      expect(tn.window.source, 'S14');

      final kerala = okra.sowingFor(GrowingRegion.kerala)!;
      expect(kerala.isFallback, isTrue);
      expect(kerala.window.region, GrowingRegion.southIndia);
    });

    test('returns null when neither state nor macro data exists', () {
      final coriander = catalogue.byId('coriander')!;
      expect(coriander.sowingFor(GrowingRegion.telangana), isNull);
      expect(coriander.sowingFor(GrowingRegion.kerala), isNull);
    });
  });

  group('parser rejects bad data', () {
    Map<String, Object?> tomatoRecord() {
      final root = jsonDecode(plantsJson) as Map<String, Object?>;
      final species = (root['species']! as List<Object?>)
          .cast<Map<String, Object?>>();
      return jsonDecode(jsonEncode(species.first)) as Map<String, Object?>;
    }

    String withSpecies(List<Map<String, Object?>> species) =>
        jsonEncode({'catalogueVersion': 1, 'species': species});

    test('an unknown citation', () {
      final r = tomatoRecord();
      (r['sun']! as Map<String, Object?>)['sources'] = ['S999'];
      expect(
        () => parse(plants: withSpecies([r])),
        throwsA(isA<FormatException>()),
      );
    });

    test('a duplicate id', () {
      expect(
        () => parse(plants: withSpecies([tomatoRecord(), tomatoRecord()])),
        throwsA(isA<FormatException>()),
      );
    });

    test('an unverified container that still has sizes', () {
      final r = tomatoRecord();
      (r['container']! as Map<String, Object?>)['status'] = 'unverified';
      expect(
        () => parse(plants: withSpecies([r])),
        throwsA(isA<FormatException>()),
      );
    });

    test('a fact without sources', () {
      final r = tomatoRecord();
      (r['daysToHarvest']! as Map<String, Object?>)['sources'] = <String>[];
      expect(
        () => parse(plants: withSpecies([r])),
        throwsA(isA<FormatException>()),
      );
    });

    test('a month outside 1–12 and a reversed range', () {
      final r = tomatoRecord();
      ((r['sowing']! as List<Object?>).first!
          as Map<String, Object?>)['months'] = [
        0,
        13,
      ];
      expect(
        () => parse(plants: withSpecies([r])),
        throwsA(isA<FormatException>()),
      );
      final r2 = tomatoRecord();
      (r2['daysToHarvest']! as Map<String, Object?>)
        ..['min'] = 90
        ..['max'] = 30;
      expect(
        () => parse(plants: withSpecies([r2])),
        throwsA(isA<FormatException>()),
      );
    });

    test('a toxicity claim without a source', () {
      final r = tomatoRecord();
      (r['petSafety']! as Map<String, Object?>)['sources'] = <String>[];
      expect(
        () => parse(plants: withSpecies([r])),
        throwsA(isA<FormatException>()),
      );
    });
  });

  test('search matches local and scientific names, sorted', () {
    final catalogue = parse();
    expect(catalogue.search(query: 'bhindi').single.id, 'okra');
    expect(catalogue.search(query: 'ocimum').single.id, 'tulsi');
    final herbs = catalogue.search(category: PlantCategory.herb);
    expect(
      herbs.map((s) => s.commonName).toList(),
      [
        ...herbs.map((s) => s.commonName),
      ]..sort(),
    );
    expect(herbs.every((s) => s.category == PlantCategory.herb), isTrue);
  });
}
