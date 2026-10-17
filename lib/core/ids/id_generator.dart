import 'package:uuid/uuid.dart';

/// Generates entity IDs. Client-side UUIDs let records sync later without
/// remapping (ADR-013); injecting the generator keeps tests deterministic.
abstract interface class IdGenerator {
  String newId();
}

final class UuidIdGenerator implements IdGenerator {
  const UuidIdGenerator();

  static const _uuid = Uuid();

  @override
  String newId() => _uuid.v4();
}

/// Produces `prefix-1`, `prefix-2`, … for tests.
final class SequentialIdGenerator implements IdGenerator {
  SequentialIdGenerator([this.prefix = 'id']);

  final String prefix;
  int _next = 1;

  @override
  String newId() => '$prefix-${_next++}';
}
