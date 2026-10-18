import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/core/database/database_provider.dart';
import 'package:terrace_garden/features/plantings/data/drift_planting_repository.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';
import 'package:terrace_garden/features/plantings/domain/planting_repository.dart';

part 'planting_providers.g.dart';

@Riverpod(keepAlive: true)
PlantingRepository plantingRepository(Ref ref) => DriftPlantingRepository(
  ref.watch(appDatabaseProvider),
  ref.watch(clockProvider),
  ref.watch(idGeneratorProvider),
  ref.watch(appLoggerProvider),
);

@Riverpod(keepAlive: true)
ShortlistRepository shortlistRepository(Ref ref) => DriftShortlistRepository(
  ref.watch(appDatabaseProvider),
  ref.watch(clockProvider),
  ref.watch(appLoggerProvider),
);

@riverpod
Stream<List<Planting>> gardenPlantings(Ref ref, String gardenId) =>
    ref.watch(plantingRepositoryProvider).watchForGarden(gardenId);

@riverpod
Stream<List<Planting>> allPlantings(Ref ref) =>
    ref.watch(plantingRepositoryProvider).watchAll();

@riverpod
Stream<Set<String>> shortlist(Ref ref, String gardenId) =>
    ref.watch(shortlistRepositoryProvider).watch(gardenId);
