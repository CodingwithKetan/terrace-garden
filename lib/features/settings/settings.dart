/// Public API of the settings feature: what other features may import
/// (ADR-023). Everything else in `features/settings/` is internal, apart from
/// `domain/`, which is always shared.
library;

export 'application/settings_controller.dart';
