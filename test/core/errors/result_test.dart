import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';

void main() {
  group('Result', () {
    const Result<int> ok = Ok(2);
    const Result<int> err = Err(NotFoundFailure());

    test('exposes value or failure', () {
      expect(ok.isOk, isTrue);
      expect(ok.valueOrNull, 2);
      expect(ok.failureOrNull, isNull);
      expect(err.isOk, isFalse);
      expect(err.valueOrNull, isNull);
      expect(err.failureOrNull, isA<NotFoundFailure>());
    });

    test('fold picks the matching branch', () {
      expect(ok.fold((v) => 'ok $v', (_) => 'err'), 'ok 2');
      expect(
        err.fold((v) => 'ok $v', (f) => 'err ${f.runtimeType}'),
        'err NotFoundFailure',
      );
    });

    test('map transforms only successful values', () {
      expect(ok.map((v) => v * 10).valueOrNull, 20);
      expect(err.map((v) => v * 10).failureOrNull, isA<NotFoundFailure>());
    });
  });
}
