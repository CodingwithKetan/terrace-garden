import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// ADR-023 and the CLAUDE.md architecture rules, enforced in CI:
///
/// - A feature may import another feature only through its public API file
///   (`features/x/x.dart`) or its `domain/`. Drift table files may reference
///   other features' table files (foreign keys).
/// - `domain/` code is pure Dart: no Flutter, drift, Riverpod or plugins.
void main() {
  final files = Directory('lib/features')
      .listSync(recursive: true)
      .whereType<File>()
      .where(
        (f) =>
            f.path.endsWith('.dart') &&
            !f.path.endsWith('.g.dart') &&
            !f.path.endsWith('.freezed.dart'),
      )
      .toList();
  final importPattern = RegExp(
    "^import 'package:terrace_garden/features/([a-z_]+)/(.+)';",
    multiLine: true,
  );

  String featureOf(File f) =>
      f.path.replaceAll(r'\', '/').split('lib/features/')[1].split('/')[0];

  test('features only use each other through public APIs or domain', () {
    final violations = <String>[];
    for (final file in files) {
      final own = featureOf(file);
      final path = file.path.replaceAll(r'\', '/');
      final isTables = path.endsWith('_tables.dart');
      for (final m in importPattern.allMatches(file.readAsStringSync())) {
        final other = m.group(1)!;
        final rest = m.group(2)!;
        if (other == own) continue;
        final allowed =
            rest == '$other.dart' ||
            rest.startsWith('domain/') ||
            (isTables &&
                rest.startsWith('data/') &&
                rest.endsWith('_tables.dart'));
        if (!allowed) violations.add('$path → features/$other/$rest');
      }
    }
    expect(violations, isEmpty, reason: violations.join('\n'));
  });

  test('domain code is pure Dart', () {
    const forbidden = [
      'package:flutter/',
      'package:drift',
      'package:riverpod',
      'package:flutter_riverpod',
      'package:shared_preferences',
      'package:image_picker',
      'package:flutter_local_notifications',
    ];
    final violations = <String>[];
    for (final file in files.where(
      (f) => f.path.replaceAll(r'\', '/').contains('/domain/'),
    )) {
      final source = file.readAsStringSync();
      for (final banned in forbidden) {
        if (source.contains("import '$banned")) {
          violations.add('${file.path} imports $banned');
        }
      }
    }
    expect(violations, isEmpty, reason: violations.join('\n'));
  });
}
