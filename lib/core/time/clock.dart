/// Source of the current time. Domain code depends on this instead of
/// calling `DateTime.now()`, so schedules and validation can be tested
/// deterministically.
abstract interface class Clock {
  /// The current local time.
  DateTime now();
}

final class SystemClock implements Clock {
  const SystemClock();

  @override
  DateTime now() => DateTime.now();
}

/// A clock that always returns [current]; tests may advance it.
final class FixedClock implements Clock {
  FixedClock(this.current);

  DateTime current;

  @override
  DateTime now() => current;

  void advance(Duration duration) => current = current.add(duration);
}
