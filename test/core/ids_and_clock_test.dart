import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/ids/id_generator.dart';
import 'package:terrace_garden/core/time/clock.dart';

void main() {
  test('UuidIdGenerator produces unique v4 UUIDs', () {
    const generator = UuidIdGenerator();
    final ids = {for (var i = 0; i < 100; i++) generator.newId()};
    expect(ids, hasLength(100));
    expect(
      ids.first,
      matches(
        RegExp(
          '^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-'
          r'[0-9a-f]{12}$',
        ),
      ),
    );
  });

  test('SequentialIdGenerator is deterministic', () {
    final generator = SequentialIdGenerator('garden');
    expect(generator.newId(), 'garden-1');
    expect(generator.newId(), 'garden-2');
  });

  test('FixedClock returns and advances its time', () {
    final clock = FixedClock(DateTime(2026, 10, 18, 7, 30));
    expect(clock.now(), DateTime(2026, 10, 18, 7, 30));
    clock.advance(const Duration(days: 1));
    expect(clock.now(), DateTime(2026, 10, 19, 7, 30));
  });
}
