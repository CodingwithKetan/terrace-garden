/// Catalogue vocabularies (data-model.md §3 PlantSpecies). Every fact in a
/// species record cites source IDs from `gardening-references.md` §1; a value
/// no verified source supports is null and shown as "Not documented".
library;

import 'package:meta/meta.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';

enum PlantCategory { vegetable, leafyGreen, herb, climber, flower, ornamental }

enum PlantLifecycle { annual, perennial }

/// How much direct sun a species needs, as the sources phrase it.
enum SunLevel {
  /// "Full sun": at least about 6 hours of direct sun.
  full,

  /// Tolerates partial shade (about 2–6 hours).
  partial,

  /// Prefers bright indirect light.
  indirect,
}

/// How well a container figure is supported.
enum EvidenceStatus {
  /// Directly stated for this crop by a verified source.
  verified,

  /// Taken from a similar crop or a size class (e.g. pepper data for chilli).
  proxy,

  /// No verified figure.
  unverified,
}

enum PropagationMethod { transplant, direct, seed, division, cutting }

enum PetSafetyStatus { toxic, nonToxic, notAssessed }

/// Overall completeness of a species record.
enum DataStatus { verified, partial, unverified }

@immutable
final class SunNeed {
  const SunNeed({required this.level, required this.sources, this.minHours});

  final SunLevel level;

  /// Minimum direct-sun hours when a source states a number.
  final int? minHours;
  final List<String> sources;
}

@immutable
final class ContainerNeed {
  const ContainerNeed({
    required this.status,
    required this.sources,
    this.minVolumeL,
    this.recommendedVolumeL,
    this.minDepthCm,
    this.recommendedDepthCm,
    this.plantsPerContainer,
    this.note,
  });

  final EvidenceStatus status;
  final double? minVolumeL;
  final double? recommendedVolumeL;
  final double? minDepthCm;
  final double? recommendedDepthCm;

  /// Plants per container of [minVolumeL] when a source states it.
  final int? plantsPerContainer;
  final String? note;
  final List<String> sources;

  bool get hasSize => minVolumeL != null || minDepthCm != null;
}

@immutable
final class HarvestWindow {
  const HarvestWindow({
    required this.minDays,
    required this.maxDays,
    required this.sources,
    this.note,
  });

  final int minDays;
  final int maxDays;
  final String? note;
  final List<String> sources;
}

/// Months (1–12) in which a source recommends sowing or planting in a region.
@immutable
final class SowingWindow {
  const SowingWindow({
    required this.region,
    required this.months,
    required this.source,
  });

  final GrowingRegion region;
  final Set<int> months;
  final String source;

  bool get yearRound => months.length == 12;
}

@immutable
final class Propagation {
  const Propagation({
    required this.method,
    required this.sources,
    this.nurseryDaysMin,
    this.nurseryDaysMax,
  });

  final PropagationMethod method;

  /// Days in a nursery tray before transplanting, when stated.
  final int? nurseryDaysMin;
  final int? nurseryDaysMax;
  final List<String> sources;
}

@immutable
final class PetSafety {
  const PetSafety({required this.status, required this.sources, this.note});

  final PetSafetyStatus status;
  final String? note;
  final List<String> sources;
}

@immutable
final class CareNote {
  const CareNote({required this.text, required this.sources});

  final String text;
  final List<String> sources;
}

/// A published source a catalogue fact cites.
@immutable
final class SourceRef {
  const SourceRef({
    required this.id,
    required this.title,
    required this.publisher,
    required this.url,
  });

  final String id;
  final String title;
  final String publisher;
  final String url;
}

/// The sowing data that applies to a region, and whether it came from the
/// macro region because no state-level table covers the species.
@immutable
final class RegionalSowing {
  const RegionalSowing({required this.window, required this.isFallback});

  final SowingWindow window;
  final bool isFallback;
}

@immutable
final class PlantSpecies {
  const PlantSpecies({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.category,
    required this.lifecycle,
    required this.container,
    required this.petSafety,
    required this.dataStatus,
    this.localNames = const [],
    this.sun,
    this.daysToHarvest,
    this.sowing = const [],
    this.propagation,
    this.careNotes = const [],
  });

  final String id;
  final String commonName;
  final List<String> localNames;
  final String scientificName;
  final PlantCategory category;
  final PlantLifecycle lifecycle;
  final SunNeed? sun;
  final ContainerNeed container;
  final HarvestWindow? daysToHarvest;
  final List<SowingWindow> sowing;
  final Propagation? propagation;
  final List<CareNote> careNotes;
  final PetSafety petSafety;
  final DataStatus dataStatus;

  /// Sowing data for [region]: the state's own window when a source gives
  /// one, otherwise the macro region's (flagged as a fallback), otherwise
  /// null.
  RegionalSowing? sowingFor(GrowingRegion region) {
    for (final w in sowing) {
      if (w.region == region) {
        return RegionalSowing(window: w, isFallback: false);
      }
    }
    final macro = region.macroRegion;
    if (macro == region) return null;
    for (final w in sowing) {
      if (w.region == macro) {
        return RegionalSowing(window: w, isFallback: true);
      }
    }
    return null;
  }

  /// Every source ID this record cites, in first-cited order.
  Set<String> get citedSources => {
    ...?sun?.sources,
    ...container.sources,
    ...?daysToHarvest?.sources,
    for (final w in sowing) w.source,
    ...?propagation?.sources,
    for (final n in careNotes) ...n.sources,
    ...petSafety.sources,
  };

  /// Matches the common, local or scientific name (case-insensitive).
  bool matches(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return commonName.toLowerCase().contains(q) ||
        scientificName.toLowerCase().contains(q) ||
        localNames.any((n) => n.toLowerCase().contains(q));
  }
}

/// The bundled, versioned catalogue (ADR-021).
@immutable
final class PlantCatalogue {
  PlantCatalogue({
    required this.version,
    required List<PlantSpecies> species,
    required Map<String, SourceRef> sources,
  }) : species = List.unmodifiable(species),
       sources = Map.unmodifiable(sources);

  final int version;
  final List<PlantSpecies> species;
  final Map<String, SourceRef> sources;

  PlantSpecies? byId(String id) => species.where((s) => s.id == id).firstOrNull;

  /// Species matching [query] and, when given, [category], by common name.
  List<PlantSpecies> search({String query = '', PlantCategory? category}) =>
      species
          .where((s) => category == null || s.category == category)
          .where((s) => s.matches(query))
          .toList()
        ..sort((a, b) => a.commonName.compareTo(b.commonName));
}
