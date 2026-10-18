/// Public API of the plant_catalog feature: what other features may import
/// (ADR-023). Everything else in `features/plant_catalog/` is internal, apart from
/// `domain/`, which is always shared.
library;

export 'data/catalogue_providers.dart';
export 'presentation/art/plant_art.dart';
export 'presentation/plant_labels.dart';
