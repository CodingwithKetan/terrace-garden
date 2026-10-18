/// Public API of the garden_designer feature: what other features may import
/// (ADR-023). Everything else in `features/garden_designer/` is internal, apart from
/// `domain/`, which is always shared.
library;

export 'data/designer_providers.dart';
export 'presentation/designer_labels.dart';
export 'presentation/terrace_plan.dart';
