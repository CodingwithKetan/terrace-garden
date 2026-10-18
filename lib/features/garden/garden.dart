/// Public API of the garden feature: what other features may import
/// (ADR-023). Everything else in `features/garden/` is internal, apart from
/// `domain/`, which is always shared.
library;

export 'application/current_garden.dart';
export 'data/garden_providers.dart';
export 'presentation/garden_labels.dart';
export 'presentation/photo_actions.dart';
export 'presentation/widgets/garden_form_sections.dart';
