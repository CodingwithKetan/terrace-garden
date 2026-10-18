import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plant_catalog/domain/recommendation_engine.dart';

Garden _garden({
  SunExposure sun = SunExposure.moreThan6Hours,
  GrowingRegion? region = GrowingRegion.northIndia,
  Set<GardenGoal> goals = const {},
}) => Garden(
  id: 'g',
  name: 'Terrace',
  spaceType: SpaceType.terrace,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
  sun: sun,
  region: region,
  goals: goals,
);

PlantSpecies _species({
  String id = 'p',
  PlantCategory category = PlantCategory.vegetable,
  SunNeed? sun = const SunNeed(level: SunLevel.full, sources: ['S3']),
  ContainerNeed container = const ContainerNeed(
    status: EvidenceStatus.verified,
    minVolumeL: 19,
    minDepthCm: 30,
    sources: ['S1'],
  ),
  List<SowingWindow> sowing = const [
    SowingWindow(
      region: GrowingRegion.northIndia,
      months: {6, 7, 8},
      source: 'S11',
    ),
  ],
  PetSafetyStatus pet = PetSafetyStatus.notAssessed,
  DataStatus dataStatus = DataStatus.verified,
}) => PlantSpecies(
  id: id,
  commonName: id,
  scientificName: id,
  category: category,
  lifecycle: PlantLifecycle.annual,
  sun: sun,
  container: container,
  sowing: sowing,
  petSafety: PetSafety(
    status: pet,
    sources: pet == PetSafetyStatus.notAssessed ? const [] : const ['S39'],
  ),
  dataStatus: dataStatus,
);

const _bigPot = ContainerSpace(id: 'big', soilLitres: 40, depthCm: 35);
const _smallPot = ContainerSpace(id: 'small', soilLitres: 8, depthCm: 20);

void main() {
  group('sun', () {
    const full = SunNeed(level: SunLevel.full, sources: ['S3']);
    const partial = SunNeed(level: SunLevel.partial, sources: ['S1']);
    const partial2h = SunNeed(
      level: SunLevel.partial,
      minHours: 2,
      sources: ['S40'],
    );
    const indirect = SunNeed(level: SunLevel.indirect, sources: ['S40']);

    final cases = <(SunNeed?, SunExposure, Fit, SunReason)>[
      (full, SunExposure.moreThan6Hours, Fit.good, SunReason.matches),
      (full, SunExposure.from3To6Hours, Fit.limited, SunReason.needsMoreSun),
      (full, SunExposure.lessThan3Hours, Fit.poor, SunReason.tooShady),
      (partial, SunExposure.moreThan6Hours, Fit.good, SunReason.matches),
      (partial, SunExposure.from3To6Hours, Fit.good, SunReason.matches),
      (partial, SunExposure.lessThan3Hours, Fit.poor, SunReason.tooShady),
      (partial2h, SunExposure.lessThan3Hours, Fit.limited, SunReason.tooShady),
      (indirect, SunExposure.lessThan3Hours, Fit.good, SunReason.matches),
      (indirect, SunExposure.from3To6Hours, Fit.good, SunReason.matches),
      (
        indirect,
        SunExposure.moreThan6Hours,
        Fit.limited,
        SunReason.prefersIndirect,
      ),
      (full, SunExposure.unknown, Fit.unknown, SunReason.gardenUnknown),
      (null, SunExposure.moreThan6Hours, Fit.unknown, SunReason.speciesUnknown),
    ];
    for (final (need, garden, fit, reason) in cases) {
      test('${need?.level} in $garden → $fit ($reason)', () {
        final check = RecommendationEngine.checkSun(garden, need);
        expect(check.fit, fit);
        expect(check.reason, reason);
      });
    }
  });

  group('season', () {
    test('sow now inside the window', () {
      final c = RecommendationEngine.checkSeason(_garden(), _species(), 7);
      expect(c.reason, SeasonReason.sowNow);
      expect(c.fit, Fit.good);
    });

    test('sow soon when the window opens next month', () {
      final c = RecommendationEngine.checkSeason(_garden(), _species(), 5);
      expect(c.reason, SeasonReason.sowSoon);
      expect(c.nextMonth, 6);
    });

    test('later, with the next month wrapping past December', () {
      final c = RecommendationEngine.checkSeason(_garden(), _species(), 9);
      expect(c.reason, SeasonReason.later);
      expect(c.fit, Fit.limited);
      expect(c.nextMonth, 6);
      expect(RecommendationEngine.nextMonthIn({1, 2}, after: 12), 1);
      expect(RecommendationEngine.nextMonthIn({12}, after: 11), 12);
    });

    test('December → January counts as soon', () {
      final s = _species(
        sowing: const [
          SowingWindow(
            region: GrowingRegion.northIndia,
            months: {1},
            source: 'S11',
          ),
        ],
      );
      final c = RecommendationEngine.checkSeason(_garden(), s, 12);
      expect(c.reason, SeasonReason.sowSoon);
    });

    test('unknown when the garden has no region (KI-017)', () {
      final c = RecommendationEngine.checkSeason(
        _garden(region: null),
        _species(),
        7,
      );
      expect(c.reason, SeasonReason.noRegion);
      expect(c.fit, Fit.unknown);
    });

    test('unknown when the species has no data for the region', () {
      final c = RecommendationEngine.checkSeason(
        _garden(region: GrowingRegion.tamilNadu),
        _species(),
        7,
      );
      expect(c.reason, SeasonReason.noData);
    });

    test('macro-region fallback is flagged as a caveat', () {
      final s = _species(
        sowing: const [
          SowingWindow(
            region: GrowingRegion.southIndia,
            months: {7},
            source: 'S11',
          ),
        ],
      );
      final r = RecommendationEngine.evaluate(
        garden: _garden(region: GrowingRegion.kerala),
        species: s,
        containers: const [],
        month: 7,
      );
      expect(r.season.reason, SeasonReason.sowNow);
      expect(r.season.window!.isFallback, isTrue);
      expect(r.caveats, contains(Caveat.regionFallback));
    });
  });

  group('container', () {
    test('fits when any container meets volume and depth', () {
      final c = RecommendationEngine.checkContainer(_species().container, [
        _smallPot,
        _bigPot,
      ]);
      expect(c.reason, ContainerReason.fits);
      expect(c.fittingCount, 1);
    });

    test('too small when none does; depth alone can fail', () {
      const deepNarrow = ContainerSpace(id: 'x', soilLitres: 40, depthCm: 20);
      final c = RecommendationEngine.checkContainer(_species().container, [
        _smallPot,
        deepNarrow,
      ]);
      expect(c.reason, ContainerReason.tooSmall);
      expect(c.fit, Fit.poor);
    });

    test('unknown without containers or without species data', () {
      expect(
        RecommendationEngine.checkContainer(_species().container, []).reason,
        ContainerReason.noContainers,
      );
      const none = ContainerNeed(
        status: EvidenceStatus.unverified,
        sources: [],
      );
      expect(
        RecommendationEngine.checkContainer(none, [_bigPot]).reason,
        ContainerReason.speciesUnknown,
      );
    });
  });

  group('evaluate and rank', () {
    test('a good match in every factor lands in goodNow', () {
      final r = RecommendationEngine.evaluate(
        garden: _garden(goals: {GardenGoal.vegetables}),
        species: _species(),
        containers: [_bigPot],
        month: 7,
      );
      expect(r.group, RecommendationGroup.goodNow);
      expect(r.goalMatch, isTrue);
      expect(r.caveats, isEmpty);
    });

    test('a poor known factor means notSuited regardless of season', () {
      final shady = RecommendationEngine.evaluate(
        garden: _garden(sun: SunExposure.lessThan3Hours),
        species: _species(),
        containers: const [],
        month: 7,
      );
      expect(shady.group, RecommendationGroup.notSuited);
      final cramped = RecommendationEngine.evaluate(
        garden: _garden(),
        species: _species(),
        containers: [_smallPot],
        month: 7,
      );
      expect(cramped.group, RecommendationGroup.notSuited);
    });

    test('everything unknown is not penalised', () {
      final r = RecommendationEngine.evaluate(
        garden: _garden(sun: SunExposure.unknown, region: null),
        species: _species(
          sun: null,
          container: const ContainerNeed(
            status: EvidenceStatus.unverified,
            sources: [],
          ),
          sowing: const [],
          dataStatus: DataStatus.partial,
        ),
        containers: const [],
        month: 7,
      );
      expect(r.group, RecommendationGroup.goodNow);
      expect(r.score, 0);
      expect(r.goalMatch, isNull);
      expect(r.caveats, [Caveat.incompleteData]);
    });

    test('caveats: proxy container and pet toxicity', () {
      final r = RecommendationEngine.evaluate(
        garden: _garden(),
        species: _species(
          container: const ContainerNeed(
            status: EvidenceStatus.proxy,
            minVolumeL: 19,
            sources: ['S2'],
          ),
          pet: PetSafetyStatus.toxic,
        ),
        containers: const [],
        month: 7,
      );
      expect(r.caveats, [Caveat.containerProxy, Caveat.petToxic]);
    });

    test('goal mismatch ranks below a match; groups order the list', () {
      final list = RecommendationEngine.rank(
        garden: _garden(goals: {GardenGoal.herbs}),
        species: [
          _species(id: 'tomato'),
          _species(id: 'basil', category: PlantCategory.herb),
          _species(
            id: 'winter',
            sowing: const [
              SowingWindow(
                region: GrowingRegion.northIndia,
                months: {11},
                source: 'S11',
              ),
            ],
          ),
          _species(
            id: 'shadeLover',
            sun: const SunNeed(level: SunLevel.indirect, sources: ['S40']),
          ),
        ],
        containers: const [],
        month: 7,
      );
      expect(list.map((r) => r.species.id), [
        'basil',
        'tomato',
        'shadeLover',
        'winter',
      ]);
      expect(list.last.group, RecommendationGroup.later);
    });

    test('goal mapping covers every category', () {
      expect(
        RecommendationEngine.goalFor(PlantCategory.climber),
        GardenGoal.vegetables,
      );
      expect(
        RecommendationEngine.goalFor(PlantCategory.ornamental),
        GardenGoal.ornamental,
      );
      expect(
        RecommendationEngine.goalFor(PlantCategory.flower),
        GardenGoal.flowers,
      );
    });
  });
}
