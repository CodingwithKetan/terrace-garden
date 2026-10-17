import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_repository.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';

void main() {
  late AppDatabase db;
  late FixedClock clock;
  late DriftGardenRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    clock = FixedClock(DateTime.utc(2026, 10, 18, 9));
    repository = DriftGardenRepository(
      db,
      clock,
      SequentialIdGenerator('garden'),
      const DeveloperLogger(),
    );
  });

  tearDown(() => db.close());

  const fullDraft = GardenDraft(
    name: '  Rooftop  ',
    spaceType: SpaceType.rooftop,
    cityName: 'Chennai',
    region: GrowingRegion.tamilNadu,
    length: Length.cm(600),
    width: Length.cm(450),
    sun: SunExposure.moreThan6Hours,
    facing: Facing.southWest,
    wind: WindExposure.exposed,
    water: WaterAccess.tapNearby,
    goals: {GardenGoal.vegetables, GardenGoal.herbs},
    style: GardenStyle.indianTerraceVegetable,
    experience: ExperienceLevel.beginner,
    weeklyTime: WeeklyTime.oneToThreeHours,
    budget: BudgetBand.low,
    notes: 'Water tank on the north side',
  );

  test('creates and reads back every field', () async {
    final garden = (await repository.create(fullDraft)).valueOrNull!;
    expect(garden.id, 'garden-1');
    expect(garden.name, 'Rooftop', reason: 'name is trimmed');
    expect(garden.region, GrowingRegion.tamilNadu);
    expect(garden.length, const Length.cm(600));
    expect(garden.goals, {GardenGoal.vegetables, GardenGoal.herbs});
    expect(garden.style, GardenStyle.indianTerraceVegetable);
    expect(garden.notes, 'Water tank on the north side');
    expect(garden.createdAt, DateTime.utc(2026, 10, 18, 9));
  });

  test('stores unknown answers as unknown, not defaults', () async {
    final garden = (await repository.create(
      const GardenDraft(name: 'Balcony', spaceType: SpaceType.balcony),
    )).valueOrNull!;
    expect(garden.sun, SunExposure.unknown);
    expect(garden.facing, Facing.unknown);
    expect(garden.length, isNull);
    expect(garden.region, isNull);
    expect(garden.goals, isEmpty);
  });

  test('rejects invalid drafts without writing', () async {
    final result = await repository.create(const GardenDraft());
    expect(result.failureOrNull, isA<ValidationFailure>());
    expect(await repository.watchAll().first, isEmpty);
  });

  test('updates fields, keeps createdAt and cover photo', () async {
    final created = (await repository.create(fullDraft)).valueOrNull!;
    await db
        .into(db.gardenPhotos)
        .insert(
          GardenPhotosCompanion.insert(
            id: 'p1',
            gardenId: created.id,
            relativePath: 'photos/a.jpg',
            thumbnailPath: 'photos/a_t.jpg',
            width: 10,
            height: 10,
            takenAt: DateTime.utc(2026),
            createdAt: DateTime.utc(2026),
          ),
        );
    expect((await repository.setCoverPhoto(created.id, 'p1')).isOk, isTrue);

    clock.advance(const Duration(hours: 1));
    final updated = (await repository.update(
      created.id,
      fullDraft.copyWith(name: 'Terrace', sun: SunExposure.from3To6Hours),
    )).valueOrNull!;

    expect(updated.name, 'Terrace');
    expect(updated.sun, SunExposure.from3To6Hours);
    expect(updated.createdAt, created.createdAt);
    expect(updated.updatedAt, DateTime.utc(2026, 10, 18, 10));
    expect(updated.coverPhotoId, 'p1');
  });

  test('update and delete of a missing garden fail with NotFound', () async {
    expect(
      (await repository.update('nope', fullDraft)).failureOrNull,
      isA<NotFoundFailure>(),
    );
    expect(
      (await repository.delete('nope')).failureOrNull,
      isA<NotFoundFailure>(),
    );
  });

  test('deleting a garden cascades to its photo rows', () async {
    final garden = (await repository.create(fullDraft)).valueOrNull!;
    await db
        .into(db.gardenPhotos)
        .insert(
          GardenPhotosCompanion.insert(
            id: 'p1',
            gardenId: garden.id,
            relativePath: 'photos/a.jpg',
            thumbnailPath: 'photos/a_t.jpg',
            width: 10,
            height: 10,
            takenAt: DateTime.utc(2026),
            createdAt: DateTime.utc(2026),
          ),
        );
    expect((await repository.delete(garden.id)).isOk, isTrue);
    expect(await db.select(db.gardenPhotos).get(), isEmpty);
  });

  test('watchAll emits changes in creation order', () async {
    final seen = <List<String>>[];
    final subscription = repository.watchAll().listen(
      (gardens) => seen.add(gardens.map((g) => g.name).toList()),
    );
    addTearDown(subscription.cancel);

    await pumpEventQueue();
    await repository.create(const GardenDraft(name: 'A'));
    await pumpEventQueue();
    clock.advance(const Duration(minutes: 1));
    await repository.create(const GardenDraft(name: 'B'));
    await pumpEventQueue();

    // Drift may emit the same result more than once; compare distinct states.
    final distinct = <List<String>>[];
    for (final state in seen) {
      if (distinct.isEmpty || distinct.last.join('|') != state.join('|')) {
        distinct.add(state);
      }
    }
    expect(distinct, [
      <String>[],
      ['A'],
      ['A', 'B'],
    ]);
  });

  test('ignores unknown goal names written by a newer version', () async {
    final garden = (await repository.create(fullDraft)).valueOrNull!;
    await (db.update(db.gardens)..where((g) => g.id.equals(garden.id))).write(
      const GardensCompanion(goals: Value('herbs,mushrooms')),
    );
    final reloaded = await repository.watch(garden.id).first;
    expect(reloaded!.goals, {GardenGoal.herbs});
  });
}
