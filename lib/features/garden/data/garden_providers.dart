import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/core/database/database_provider.dart';
import 'package:terrace_garden/core/storage/storage_providers.dart';
import 'package:terrace_garden/features/garden/application/garden_service.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_photo_repository.dart';
import 'package:terrace_garden/features/garden/data/drift_garden_repository.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';
import 'package:terrace_garden/features/garden/domain/garden_photo.dart';
import 'package:terrace_garden/features/garden/domain/garden_repository.dart';

part 'garden_providers.g.dart';

@Riverpod(keepAlive: true)
GardenRepository gardenRepository(Ref ref) => DriftGardenRepository(
  ref.watch(appDatabaseProvider),
  ref.watch(clockProvider),
  ref.watch(idGeneratorProvider),
  ref.watch(appLoggerProvider),
);

@Riverpod(keepAlive: true)
GardenPhotoRepository gardenPhotoRepository(Ref ref) =>
    DriftGardenPhotoRepository(
      ref.watch(appDatabaseProvider),
      ref.watch(photoStorageProvider),
      ref.watch(clockProvider),
      ref.watch(idGeneratorProvider),
      ref.watch(appLoggerProvider),
    );

@Riverpod(keepAlive: true)
GardenService gardenService(Ref ref) => GardenService(
  ref.watch(gardenRepositoryProvider),
  ref.watch(photoStorageProvider),
  ref.watch(appLoggerProvider),
);

@riverpod
Stream<List<Garden>> gardens(Ref ref) =>
    ref.watch(gardenRepositoryProvider).watchAll();

@riverpod
Stream<Garden?> garden(Ref ref, String id) =>
    ref.watch(gardenRepositoryProvider).watch(id);

@riverpod
Stream<List<GardenPhoto>> gardenPhotos(Ref ref, String gardenId) =>
    ref.watch(gardenPhotoRepositoryProvider).watchForGarden(gardenId);
