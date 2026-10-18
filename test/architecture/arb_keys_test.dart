import 'dart:convert';
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

  test(
    'translations cover every English string with the same placeholders',
    () {
      Map<String, dynamic> read(String path) =>
          jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
      final en = read('lib/l10n/app_en.arb');
      final names = RegExp(r'\{([A-Za-z_]\w*)(?=[,}])');
      Set<String> placeholders(Object? s) => {
        for (final m in names.allMatches(s! as String)) m.group(1)!,
      };
      for (final file in Directory('lib/l10n').listSync().whereType<File>()) {
        if (!file.path.endsWith('.arb') || file.path.endsWith('app_en.arb')) {
          continue;
        }
        final other = read(file.path);
        for (final key in en.keys.where((k) => !k.startsWith('@'))) {
          expect(other, contains(key), reason: '${file.path} lacks $key');
          expect(
            placeholders(other[key]),
            placeholders(en[key]),
            reason: '${file.path} $key',
          );
        }
      }
    },
  );
}
