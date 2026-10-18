import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/features/plantings/domain/plant_journey.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';

PlantSpecies _species({
  PlantCategory category = PlantCategory.vegetable,
  HarvestWindow? harvest = const HarvestWindow(
    minDays: 90,
    maxDays: 130,
    sources: ['S20'],
  ),
  Propagation? propagation = const Propagation(
    method: PropagationMethod.transplant,
    nurseryDaysMin: 25,
    nurseryDaysMax: 30,
    sources: ['S30'],
  ),
}) => PlantSpecies(
  id: 'tomato',
  commonName: 'Tomato',
  scientificName: 'Solanum lycopersicum',
  category: category,
  lifecycle: PlantLifecycle.annual,
  container: const ContainerNeed(
    status: EvidenceStatus.unverified,
    sources: [],
  ),
  petSafety: const PetSafety(
    status: PetSafetyStatus.notAssessed,
    sources: [],
  ),
  dataStatus: DataStatus.verified,
  daysToHarvest: harvest,
  propagation: propagation,
);

Planting _planting(PlantingStart start) => Planting(
  id: 'p',
  gardenId: 'g',
  speciesId: 'tomato',
  quantity: 1,
  plantedOn: LocalDate(2026, 9, 18),
  startedFrom: start,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

void main() {
  final today = LocalDate(2026, 10, 17);

  test('from seed: sown, a sourced transplant window, then harvest', () {
    final j = PlantJourney.of(
      planting: _planting(PlantingStart.seed),
      species: _species(),
      today: today,
    );
    expect(j.milestones.map((m) => m.kind), [
      MilestoneKind.sown,
      MilestoneKind.transplant,
      MilestoneKind.harvest,
    ]);
    expect(j.milestones[1].from, LocalDate(2026, 10, 13));
    expect(j.milestones[1].to, LocalDate(2026, 10, 18));
    expect(j.milestones[2].from, LocalDate(2026, 12, 17));
    expect(j.milestones[2].to, LocalDate(2027, 1, 26));
    expect(j.day, 30);
    expect(j.sources, {'S20', 'S30'});
    expect(j.progress, closeTo(29 / 130, 1e-9));
  });

  test('a seedling skips the nursery step', () {
    final j = PlantJourney.of(
      planting: _planting(PlantingStart.seedling),
      species: _species(),
      today: today,
    );
    expect(j.milestones.map((m) => m.kind), [
      MilestoneKind.planted,
      MilestoneKind.harvest,
    ]);
  });

  test('flowers and undocumented species show only the planting date', () {
    for (final species in [
      _species(category: PlantCategory.flower),
      _species(harvest: null, propagation: null),
    ]) {
      final j = PlantJourney.of(
        planting: _planting(PlantingStart.seedling),
        species: species,
        today: today,
      );
      expect(j.milestones, hasLength(1));
      expect(j.hasSourcedSteps, isFalse);
      expect(j.progress, 1);
    }
  });

  test('no day number before the planting date', () {
    final j = PlantJourney.of(
      planting: _planting(PlantingStart.seed),
      species: _species(),
      today: LocalDate(2026, 9, 1),
    );
    expect(j.day, isNull);
    expect(j.progress, 0);
  });
}
