import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/database/app_database.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_repository.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/garden_designer/data/drift_layout_repository.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/plantings/data/drift_planting_repository.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';

void main() {
  late AppDatabase db;
  late FixedClock clock;
  late DriftPlantingRepository plantings;
  late DriftShortlistRepository shortlist;
  late String gardenId;

  final today = LocalDate(2026, 10, 18);

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    clock = FixedClock(DateTime(2026, 10, 18, 9));
    const logger = DeveloperLogger();
    plantings = DriftPlantingRepository(
      db,
      clock,
      SequentialIdGenerator('planting'),
      logger,
    );
    shortlist = DriftShortlistRepository(db, clock, logger);
    final gardens = DriftGardenRepository(
      db,
      clock,
      SequentialIdGenerator('garden'),
      logger,
    );
    gardenId = (await gardens.create(
      const GardenDraft(name: 'Terrace'),
    )).valueOrNull!.id;
  });

  tearDown(() => db.close());

  PlantingDraft draft({
    String? elementId,
    int quantity = 2,
    LocalDate? plantedOn,
  }) => PlantingDraft(
    gardenId: gardenId,
    speciesId: 'tomato',
    elementId: elementId,
    quantity: quantity,
    plantedOn: plantedOn ?? today,
    startedFrom: PlantingStart.seedling,
    notes: 'From the nursery',
  );

  test('creates, reads back and watches a planting', () async {
    final created = (await plantings.create(
      draft(elementId: 'pot'),
    )).valueOrNull!;
    expect(created.id, 'planting-1');
    expect(created.speciesId, 'tomato');
    expect(created.elementId, 'pot');
    expect(created.quantity, 2);
    expect(created.plantedOn, today);
    expect(created.startedFrom, PlantingStart.seedling);
    expect(created.notes, 'From the nursery');
    expect(await plantings.watchForGarden(gardenId).first, hasLength(1));
    expect(await plantings.watchAll().first, hasLength(1));
  });

  test('updates keep createdAt and change updatedAt', () async {
    final created = (await plantings.create(draft())).valueOrNull!;
    clock.advance(const Duration(hours: 1));
    final updated = (await plantings.update(
      created.id,
      PlantingDraft.of(created).copyWith(quantity: 5, elementId: () => 'bed'),
    )).valueOrNull!;
    expect(updated.quantity, 5);
    expect(updated.elementId, 'bed');
    expect(updated.createdAt, created.createdAt);
    expect(updated.updatedAt.isAfter(created.updatedAt), isTrue);
  });

  test('rejects invalid drafts without writing', () async {
    final zero = await plantings.create(draft(quantity: 0));
    expect((zero as Err).failure, isA<ValidationFailure>());
    final future = await plantings.create(draft(plantedOn: today.addDays(1)));
    expect(
      ((future as Err).failure as ValidationFailure).field,
      'plantedOn',
    );
    expect(await plantings.watchAll().first, isEmpty);
  });

  test('update and delete of a missing planting report not found', () async {
    expect(
      ((await plantings.update('nope', draft())) as Err).failure,
      isA<NotFoundFailure>(),
    );
    expect(
      ((await plantings.delete('nope')) as Err).failure,
      isA<NotFoundFailure>(),
    );
  });

  test('saving a layout does not delete plantings in its containers', () async {
    final layouts = DriftLayoutRepository(db, const DeveloperLogger());
    const pot = LayoutElement(
      id: 'pot',
      kind: ElementKind.roundPot,
      center: Vec2(50, 50),
      width: 30,
      height: 30,
    );
    await layouts.saveElements(gardenId, [pot]);
    await plantings.create(draft(elementId: 'pot'));
    await layouts.saveElements(gardenId, [
      pot.copyWith(center: const Vec2(80, 80)),
    ]);
    final list = await plantings.watchForGarden(gardenId).first;
    expect(list.single.elementId, 'pot');
  });

  test('plantings and shortlist are deleted with their garden', () async {
    await plantings.create(draft());
    await shortlist.setShortlisted(gardenId, 'okra', shortlisted: true);
    await (db.delete(db.gardens)..where((g) => g.id.equals(gardenId))).go();
    expect(await plantings.watchAll().first, isEmpty);
    expect(await shortlist.watch(gardenId).first, isEmpty);
  });

  test('shortlist adds idempotently and removes', () async {
    await shortlist.setShortlisted(gardenId, 'okra', shortlisted: true);
    await shortlist.setShortlisted(gardenId, 'okra', shortlisted: true);
    await shortlist.setShortlisted(gardenId, 'mint', shortlisted: true);
    expect(await shortlist.watch(gardenId).first, {'okra', 'mint'});
    await shortlist.setShortlisted(gardenId, 'okra', shortlisted: false);
    expect(await shortlist.watch(gardenId).first, {'mint'});
  });
}
