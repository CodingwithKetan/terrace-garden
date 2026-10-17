import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/core/database/database_provider.dart';
import 'package:terrace_garden/features/garden_designer/data/drift_layout_repository.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_repository.dart';

part 'designer_providers.g.dart';

@Riverpod(keepAlive: true)
LayoutRepository layoutRepository(Ref ref) => DriftLayoutRepository(
  ref.watch(appDatabaseProvider),
  ref.watch(appLoggerProvider),
);

/// The saved elements of a garden's layout, live (for previews and counts).
@riverpod
Stream<List<LayoutElement>> layoutElements(Ref ref, String gardenId) =>
    ref.watch(layoutRepositoryProvider).watchElements(gardenId);
