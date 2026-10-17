import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';

abstract interface class LayoutRepository {
  /// The garden's elements in drawing order (empty if none saved yet).
  Future<List<LayoutElement>> loadElements(String gardenId);

  /// Live view of the saved elements (emits after every save).
  Stream<List<LayoutElement>> watchElements(String gardenId);

  /// Replaces the garden's saved elements in one transaction.
  Future<Result<void>> saveElements(
    String gardenId,
    List<LayoutElement> elements,
  );
}
