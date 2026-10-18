import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// JSON allows a repeated key and gen-l10n keeps the last one, so a new
/// string can silently replace an existing one elsewhere in the app.
void main() {
  test('ARB files have no duplicate keys', () {
    final key = RegExp(r'^  "([^"]+)"\s*:', multiLine: true);
    for (final file in Directory('lib/l10n').listSync().whereType<File>()) {
      if (!file.path.endsWith('.arb')) continue;
      final seen = <String>{};
      final duplicates = <String>[
        for (final m in key.allMatches(file.readAsStringSync()))
          if (!seen.add(m.group(1)!)) m.group(1)!,
      ];
      expect(duplicates, isEmpty, reason: file.path);
    }
  });
}
