import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terrace_garden/app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _registerFontLicenses();
  runApp(const ProviderScope(child: TerraceGardenApp()));
}

/// Bundled fonts are OFL-licensed; their licences appear on the licences page.
void _registerFontLicenses() {
  LicenseRegistry.addLicense(() async* {
    for (final family in ['SchibstedGrotesk', 'YoungSerif']) {
      final text = await rootBundle.loadString(
        'assets/fonts/$family-OFL.txt',
      );
      yield LicenseEntryWithLineBreaks([family], text);
    }
  });
}
