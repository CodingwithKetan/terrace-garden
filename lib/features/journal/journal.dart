/// Public API of the journal feature: what other features may import
/// (ADR-023). Everything else in `features/journal/` is internal, apart from
/// `domain/`, which is always shared.
library;

export 'data/journal_providers.dart';
