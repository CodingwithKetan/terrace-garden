import 'package:meta/meta.dart';
import 'package:terrace_garden/core/time/local_date.dart';

/// What the user started the planting from; drives early care in Phase 5.
enum PlantingStart { seed, seedling, cutting, plant }

/// A species growing in a garden (data-model.md §3 Planting): optionally in
/// one container on the layout, otherwise "not placed yet".
@immutable
final class Planting {
  const Planting({
    required this.id,
    required this.gardenId,
    required this.speciesId,
    required this.quantity,
    required this.plantedOn,
    required this.startedFrom,
    required this.createdAt,
    required this.updatedAt,
    this.elementId,
    this.notes,
  });

  final String id;
  final String gardenId;

  /// Catalogue species id (the catalogue is bundled, so no foreign key).
  final String speciesId;

  /// Layout element (container) id. May point at an element the user has
  /// since deleted; the UI then treats the planting as not placed.
  final String? elementId;
  final int quantity;
  final LocalDate plantedOn;
  final PlantingStart startedFrom;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
}

/// Input for creating or editing a planting.
@immutable
final class PlantingDraft {
  const PlantingDraft({
    required this.gardenId,
    required this.speciesId,
    required this.plantedOn,
    this.elementId,
    this.quantity = 1,
    this.startedFrom = PlantingStart.seed,
    this.notes,
  });

  factory PlantingDraft.of(Planting p) => PlantingDraft(
    gardenId: p.gardenId,
    speciesId: p.speciesId,
    plantedOn: p.plantedOn,
    elementId: p.elementId,
    quantity: p.quantity,
    startedFrom: p.startedFrom,
    notes: p.notes,
  );

  static const maxQuantity = 999;

  final String gardenId;
  final String speciesId;
  final String? elementId;
  final int quantity;
  final LocalDate plantedOn;
  final PlantingStart startedFrom;
  final String? notes;

  PlantingDraft copyWith({
    String? Function()? elementId,
    int? quantity,
    LocalDate? plantedOn,
    PlantingStart? startedFrom,
    String? Function()? notes,
  }) => PlantingDraft(
    gardenId: gardenId,
    speciesId: speciesId,
    elementId: elementId == null ? this.elementId : elementId(),
    quantity: quantity ?? this.quantity,
    plantedOn: plantedOn ?? this.plantedOn,
    startedFrom: startedFrom ?? this.startedFrom,
    notes: notes == null ? this.notes : notes(),
  );

  /// Field names of invalid inputs; empty when valid.
  List<String> validate({required LocalDate today}) => [
    if (quantity < 1 || quantity > maxQuantity) 'quantity',
    if (plantedOn.isAfter(today)) 'plantedOn',
    if ((notes?.length ?? 0) > 500) 'notes',
  ];
}
