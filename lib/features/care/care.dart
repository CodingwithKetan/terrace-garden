/// Public API of the care feature: what other features may import
/// (ADR-023). Everything else in `features/care/` is internal, apart from
/// `domain/`, which is always shared.
library;

export 'data/care_providers.dart';
export 'presentation/care_labels.dart';
export 'presentation/care_sheets.dart';
export 'presentation/reminder_settings.dart';
export 'presentation/soil_check_sheet.dart';
