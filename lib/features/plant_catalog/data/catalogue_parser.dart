import 'dart:convert';

import 'package:terrace_garden/features/garden/domain/region.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';

/// Parses and validates the bundled catalogue (`assets/catalogue/`).
///
/// Parsing is strict: a malformed record, an unknown enum value, a citation
/// missing from `sources.json`, or a figure on a record that says it has no
/// evidence all throw a [FormatException] naming the record. The catalogue
/// validation test runs this on the real assets, so bad data fails CI rather
/// than reaching users.
abstract final class CatalogueParser {
  static PlantCatalogue parse({
    required String plantsJson,
    required String sourcesJson,
  }) {
    final sources = _parseSources(_object(jsonDecode(sourcesJson), 'sources'));
    final root = _object(jsonDecode(plantsJson), 'plants');
    final version = _int(root, 'catalogueVersion', 'plants');
    final ids = <String>{};
    final species = <PlantSpecies>[];
    for (final raw in _list(root, 'species', 'plants')) {
      final record = _object(raw, 'species');
      final id = _string(record, 'id', 'species');
      if (!ids.add(id)) throw FormatException('Duplicate species id', id);
      final parsed = _parseSpecies(record, id);
      for (final cited in parsed.citedSources) {
        if (!sources.containsKey(cited)) {
          throw FormatException('$id cites unknown source', cited);
        }
      }
      species.add(parsed);
    }
    return PlantCatalogue(version: version, species: species, sources: sources);
  }

  static Map<String, SourceRef> _parseSources(Map<String, Object?> root) => {
    for (final raw in _list(root, 'sources', 'sources'))
      if (_object(raw, 'source') case final s)
        _string(s, 'id', 'source'): SourceRef(
          id: _string(s, 'id', 'source'),
          title: _string(s, 'title', 'source'),
          publisher: _string(s, 'publisher', 'source'),
          url: _string(s, 'url', 'source'),
        ),
  };

  static PlantSpecies _parseSpecies(Map<String, Object?> r, String id) {
    return PlantSpecies(
      id: id,
      commonName: _string(r, 'commonName', id),
      localNames: _list(r, 'localNames', id).cast<String>(),
      names: _names(r, id),
      scientificName: _string(r, 'scientificName', id),
      category: _enum(PlantCategory.values, r, 'category', id),
      lifecycle: _enum(PlantLifecycle.values, r, 'lifecycle', id),
      sun: _optionalObject(r, 'sun', id, (o) {
        final hours = _optionalInt(o, 'minHours', id);
        if (hours != null && (hours < 0 || hours > 12)) {
          throw FormatException('$id: sun.minHours out of range', hours);
        }
        return SunNeed(
          level: _enum(SunLevel.values, o, 'level', id),
          minHours: hours,
          sources: _sources(o, id, required: true),
        );
      }),
      container: _container(_object(r['container'], '$id.container'), id),
      daysToHarvest: _optionalObject(r, 'daysToHarvest', id, (o) {
        final min = _int(o, 'min', id);
        final max = _int(o, 'max', id);
        if (min <= 0 || max < min || max > 400) {
          throw FormatException('$id: daysToHarvest range', '$min–$max');
        }
        return HarvestWindow(
          minDays: min,
          maxDays: max,
          note: _optionalString(o, 'note', id),
          sources: _sources(o, id, required: true),
        );
      }),
      sowing: [
        for (final raw in _list(r, 'sowing', id))
          if (_object(raw, '$id.sowing') case final o)
            SowingWindow(
              region: _enum(GrowingRegion.values, o, 'region', id),
              months: _months(o, id),
              source: _string(o, 'source', id),
            ),
      ],
      propagation: _optionalObject(r, 'propagation', id, (o) {
        final min = _optionalInt(o, 'nurseryDaysMin', id);
        final max = _optionalInt(o, 'nurseryDaysMax', id);
        if ((min == null) != (max == null) || (min != null && max! < min)) {
          throw FormatException('$id: nursery days range', '$min–$max');
        }
        return Propagation(
          method: _enum(PropagationMethod.values, o, 'method', id),
          nurseryDaysMin: min,
          nurseryDaysMax: max,
          sources: _sources(o, id, required: true),
        );
      }),
      careNotes: [
        for (final raw in _list(r, 'careNotes', id))
          if (_object(raw, '$id.careNotes') case final o)
            CareNote(
              text: _string(o, 'text', id),
              sources: _sources(o, id, required: true),
            ),
      ],
      petSafety: _petSafety(_object(r['petSafety'], '$id.petSafety'), id),
      watering: _optionalObject(
        r,
        'watering',
        id,
        (o) => WateringNeed(
          mode: _enum(WateringMode.values, o, 'mode', id),
          sources: _sources(o, id, required: true),
        ),
      ),
      dataStatus: _enum(DataStatus.values, r, 'dataStatus', id),
    );
  }

  static ContainerNeed _container(Map<String, Object?> o, String id) {
    final status = _enum(EvidenceStatus.values, o, 'status', id);
    final need = ContainerNeed(
      status: status,
      minVolumeL: _optionalDouble(o, 'minVolumeL', id),
      recommendedVolumeL: _optionalDouble(o, 'recommendedVolumeL', id),
      minDepthCm: _optionalDouble(o, 'minDepthCm', id),
      recommendedDepthCm: _optionalDouble(o, 'recommendedDepthCm', id),
      plantsPerContainer: _optionalInt(o, 'plantsPerContainer', id),
      note: _optionalString(o, 'note', id),
      sources: _sources(o, id, required: false),
    );
    if (status == EvidenceStatus.unverified && need.hasSize) {
      throw FormatException('$id: unverified container has sizes');
    }
    if (status != EvidenceStatus.unverified) {
      if (!need.hasSize || need.sources.isEmpty) {
        throw FormatException('$id: $status container needs size + source');
      }
    }
    void range(double? min, double? rec, String what) {
      if (min != null && min <= 0) throw FormatException('$id: $what <= 0');
      if (min != null && rec != null && rec < min) {
        throw FormatException('$id: recommended $what below minimum');
      }
    }

    range(need.minVolumeL, need.recommendedVolumeL, 'volume');
    range(need.minDepthCm, need.recommendedDepthCm, 'depth');
    return need;
  }

  static PetSafety _petSafety(Map<String, Object?> o, String id) {
    final status = _enum(PetSafetyStatus.values, o, 'status', id);
    final sources = _sources(o, id, required: false);
    if (status != PetSafetyStatus.notAssessed && sources.isEmpty) {
      throw FormatException('$id: pet safety $status needs a source');
    }
    return PetSafety(
      status: status,
      note: _optionalString(o, 'note', id),
      sources: sources,
    );
  }

  static Set<int> _months(Map<String, Object?> o, String id) {
    final months = _list(o, 'months', id).cast<int>().toSet();
    if (months.isEmpty || months.any((m) => m < 1 || m > 12)) {
      throw FormatException('$id: sowing months', months.toString());
    }
    return months;
  }

  static List<String> _sources(
    Map<String, Object?> o,
    String id, {
    required bool required,
  }) {
    final list = _list(o, 'sources', id).cast<String>();
    if (required && list.isEmpty) {
      throw FormatException('$id: a fact without sources');
    }
    return list;
  }

  // JSON helpers ------------------------------------------------------------

  static Map<String, Object?> _object(Object? value, String where) {
    if (value is Map<String, Object?>) return value;
    throw FormatException('$where: expected an object', value);
  }

  static T? _optionalObject<T>(
    Map<String, Object?> o,
    String key,
    String id,
    T Function(Map<String, Object?>) parse,
  ) {
    final value = o[key];
    return value == null ? null : parse(_object(value, '$id.$key'));
  }

  /// Optional `names`: language code to name, all non-empty strings.
  static Map<String, String> _names(Map<String, Object?> r, String id) {
    final raw = r['names'];
    if (raw == null) return const {};
    if (raw is! Map<String, Object?>) {
      throw FormatException('$id: names must be an object');
    }
    return {
      for (final MapEntry(:key, :value) in raw.entries)
        if (value is String && value.trim().isNotEmpty)
          key: value
        else
          key: throw FormatException('$id: names.$key must be text'),
    };
  }

  static List<Object?> _list(Map<String, Object?> o, String key, String id) {
    final value = o[key];
    if (value is List<Object?>) return value;
    throw FormatException('$id: "$key" must be a list', value);
  }

  static String _string(Map<String, Object?> o, String key, String id) {
    final value = o[key];
    if (value is String && value.trim().isNotEmpty) return value;
    throw FormatException('$id: "$key" must be a non-empty string', value);
  }

  static String? _optionalString(
    Map<String, Object?> o,
    String key,
    String id,
  ) => o[key] == null ? null : _string(o, key, id);

  static int _int(Map<String, Object?> o, String key, String id) {
    final value = o[key];
    if (value is int) return value;
    throw FormatException('$id: "$key" must be an integer', value);
  }

  static int? _optionalInt(Map<String, Object?> o, String key, String id) =>
      o[key] == null ? null : _int(o, key, id);

  static double? _optionalDouble(
    Map<String, Object?> o,
    String key,
    String id,
  ) {
    final value = o[key];
    if (value == null) return null;
    if (value is num) return value.toDouble();
    throw FormatException('$id: "$key" must be a number', value);
  }

  static T _enum<T extends Enum>(
    List<T> values,
    Map<String, Object?> o,
    String key,
    String id,
  ) {
    final name = _string(o, key, id);
    for (final v in values) {
      if (v.name == name) return v;
    }
    throw FormatException('$id: unknown $key', name);
  }
}
