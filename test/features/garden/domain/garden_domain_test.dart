import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';

void main() {
  group('GardenDraft.validate', () {
    test('accepts a draft with only a name', () {
      expect(const GardenDraft(name: 'My terrace').validate(), isEmpty);
    });

    test('requires a non-blank name', () {
      expect(
        const GardenDraft(name: '   ').validate(),
        contains(GardenDraftError.nameRequired),
      );
    });

    test('limits the name length', () {
      expect(
        GardenDraft(name: 'x' * 61).validate(),
        contains(GardenDraftError.nameTooLong),
      );
      expect(GardenDraft(name: 'x' * 60).validate(), isEmpty);
    });

    test('rejects zero, negative and absurd dimensions', () {
      for (final bad in [0.0, -10.0, 20000.1]) {
        final errors = GardenDraft(
          name: 'Roof',
          length: Length.cm(bad),
          width: Length.cm(bad),
        ).validate();
        expect(errors, contains(GardenDraftError.lengthOutOfRange));
        expect(errors, contains(GardenDraftError.widthOutOfRange));
      }
    });

    test('accepts dimensions up to 200 m', () {
      expect(
        GardenDraft(
          name: 'Roof',
          length: Length.metres(200),
          width: Length.metres(0.5),
        ).validate(),
        isEmpty,
      );
    });

    test('round-trips through a Garden', () {
      final garden = Garden(
        id: 'g1',
        name: 'Roof',
        spaceType: SpaceType.rooftop,
        createdAt: DateTime.utc(2026),
        updatedAt: DateTime.utc(2026),
        length: Length.metres(3),
        width: Length.metres(1.2),
        goals: {GardenGoal.herbs},
        sun: SunExposure.moreThan6Hours,
      );
      final draft = GardenDraft.fromGarden(garden);
      expect(draft.name, 'Roof');
      expect(draft.goals, {GardenGoal.herbs});
      expect(garden.area!.m2, closeTo(3.6, 1e-9));
      expect(garden.hasDimensions, isTrue);
    });
  });

  group('regions', () {
    test('cities map only to sourced regions', () {
      expect(cityByName('Hyderabad')!.region, GrowingRegion.telangana);
      expect(cityByName('Chennai')!.region, GrowingRegion.tamilNadu);
      expect(cityByName('Kochi')!.region, GrowingRegion.kerala);
      expect(cityByName('Bengaluru')!.region, GrowingRegion.southIndia);
      expect(cityByName('Delhi')!.region, GrowingRegion.northIndia);
      // No sourced regional table yet: no region rather than a guess.
      expect(cityByName('Mumbai')!.region, isNull);
      expect(cityByName('Atlantis'), isNull);
    });

    test('state regions fall back to South India', () {
      expect(GrowingRegion.kerala.macroRegion, GrowingRegion.southIndia);
      expect(GrowingRegion.northIndia.macroRegion, GrowingRegion.northIndia);
    });

    test('search matches city or state, case-insensitively, sorted', () {
      final results = searchCities('tamil');
      expect(results.map((c) => c.state).toSet(), {'Tamil Nadu'});
      expect(results.first.name, 'Chennai');
      expect(searchCities('PUNE').single.name, 'Pune');
      expect(searchCities(''), hasLength(indianCities.length));
    });
  });
}
