import 'package:flutter/widgets.dart';
import 'package:terrace_garden/l10n/app_localizations.dart';

export 'package:terrace_garden/l10n/app_localizations.dart';

extension AppLocalizationsContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

/// The locale to use for a chosen language [code], or, when null, for the
/// phone's [device] locale if the app supports it; English otherwise.
Locale appLocaleFor(String? code, Locale device) {
  final wanted = code ?? device.languageCode;
  return AppLocalizations.supportedLocales.firstWhere(
    (l) => l.languageCode == wanted,
    orElse: () => const Locale('en'),
  );
}
