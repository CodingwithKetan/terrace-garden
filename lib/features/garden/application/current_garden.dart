import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:terrace_garden/features/garden/data/garden_providers.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';

part 'current_garden.g.dart';

/// The garden Today and Seasons show. Null until the user picks one, which
/// means "the first garden".
@Riverpod(keepAlive: true)
class SelectedGardenId extends _$SelectedGardenId {
  @override
  String? build() => null;

  String? get selected => state;

  set selected(String? id) => state = id;
}

/// The garden to show: the selected one if it still exists, otherwise the
/// first. Null when there are no gardens (or while they load).
@riverpod
Garden? currentGarden(Ref ref) {
  final gardens = ref.watch(gardensProvider).value ?? const <Garden>[];
  final selected = ref.watch(selectedGardenIdProvider);
  return gardens.where((g) => g.id == selected).firstOrNull ??
      gardens.firstOrNull;
}
