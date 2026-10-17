import 'package:flutter/widgets.dart';
import 'package:terrace_garden/l10n/app_localizations.dart';

export 'package:terrace_garden/l10n/app_localizations.dart';

extension AppLocalizationsContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
