import 'package:meta/meta.dart';
import 'package:terrace_garden/core/time/local_date.dart';

/// Moments worth marking on a plant's timeline (JRN-02).
enum Milestone {
  germinated,
  transplanted,
  flowering,
  firstFruit,
  harvest,
  other,
}

enum HarvestUnit { grams, pieces, bunches }

@immutable
final class JournalPhoto {
  const JournalPhoto({
    required this.id,
    required this.relativePath,
    required this.thumbnailPath,
  });

  final String id;

  /// Relative to the app documents directory (ADR-007).
  final String relativePath;
  final String thumbnailPath;
}

/// A dated note, with optional photos, milestone and harvest amount
/// (data-model.md §3 JournalEntry).
@immutable
final class JournalEntry {
  const JournalEntry({
    required this.id,
    required this.gardenId,
    required this.date,
    required this.createdAt,
    this.plantingId,
    this.note,
    this.milestone,
    this.harvestQuantity,
    this.harvestUnit,
    this.photos = const [],
  });

  final String id;
  final String gardenId;

  /// Null for garden-wide entries, or when the planting was removed.
  final String? plantingId;
  final LocalDate date;
  final String? note;
  final Milestone? milestone;
  final double? harvestQuantity;
  final HarvestUnit? harvestUnit;
  final List<JournalPhoto> photos;
  final DateTime createdAt;
}

@immutable
final class JournalDraft {
  const JournalDraft({
    required this.gardenId,
    required this.date,
    this.plantingId,
    this.note,
    this.milestone,
    this.harvestQuantity,
    this.harvestUnit,
  });

  final String gardenId;
  final String? plantingId;
  final LocalDate date;
  final String? note;
  final Milestone? milestone;
  final double? harvestQuantity;
  final HarvestUnit? harvestUnit;

  static const maxNoteLength = 1000;

  /// Field names of invalid inputs; empty when valid. An entry needs at
  /// least a note, a milestone or a photo ([photoCount]).
  List<String> validate({required LocalDate today, required int photoCount}) {
    final hasNote = note?.trim().isNotEmpty ?? false;
    final quantity = harvestQuantity;
    return [
      if (!hasNote && milestone == null && photoCount == 0) 'empty',
      if (date.isAfter(today)) 'date',
      if ((note?.length ?? 0) > maxNoteLength) 'note',
      if (quantity != null && (quantity <= 0 || quantity > 100000)) 'quantity',
      if ((quantity == null) != (harvestUnit == null)) 'quantity',
      if (quantity != null && milestone != Milestone.harvest) 'quantity',
    ];
  }
}
