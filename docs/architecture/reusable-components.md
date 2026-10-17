# Reusable Components

Status: v0.1 (Phase 0): a **plan**. Components are built in the phase listed, and this document is updated with each component's actual public API when it ships. Styles come from `docs/design/design-system.md`; components must use theme tokens only (no raw colours or sizes).

## Guidelines

- **When to extract:** extract a widget when it is reused in two or more places *or* has independent behaviour or state worth testing. Do not wrap trivial layouts.
- **API shape:**
  - required data first, optional configuration with sensible defaults;
  - callbacks named `onX`;
  - no business logic, no repositories, no providers inside `core/widgets` (they take plain data and callbacks).
- **States:** components that can be loading, empty or disabled expose that explicitly (e.g. `isLoading`) rather than callers swapping widgets ad hoc.
- **Accessibility:** every interactive component guarantees a ≥48dp hit area and a semantic label (required parameter when there is no visible text).
- **Testing:** each component has widget tests for its states, semantics and tap-target size. Key components get golden tests in light and dark themes.
- **Location:** generic components in `lib/core/widgets/`. Feature-specific but reused widgets in `lib/features/<feature>/presentation/widgets/`.

## Planned inventory

| Component | Responsibility | Phase | Location |
|---|---|---|---|
| `AppButton` (primary / secondary / text / destructive variants, `isLoading`, leading icon) | Consistent actions | 1 | core/widgets |
| `AppCard` | Surface with tokenised padding, shape and optional tap | 1 | core/widgets |
| `ImageCard` | Photo + title/subtitle block, scrim when text overlays the image, fallback placeholder | 1 | core/widgets |
| `StatusChip` | Semantic status (care category, data confidence, warnings): colour + icon + label | 1 | core/widgets |
| `SelectableChipGroup<T>` | Single/multi select chips (goals, filters) | 1 | core/widgets |
| `SectionHeader` | Title + optional action | 1 | core/widgets |
| `EmptyState` | Illustration/photo, headline, body, primary action | 1 | core/widgets |
| `ErrorState` | Failure message mapped from `AppFailure`, retry | 1 | core/widgets |
| `SkeletonBox` / `SkeletonList` | Loading placeholders | 1 | core/widgets |
| `AsyncStateView<T>` | Renders `AsyncValue` → loading/error/data using the above | 1 | core/widgets |
| `ConfirmDialog` | Destructive confirmation with consistent copy pattern | 1 | core/widgets |
| `AppBottomSheet` | Drag handle, max height, title, scrollable content | 1 | core/widgets |
| `PermissionRationale` | Benefit explanation, allow/not now, open settings when permanently denied | 2 | core/widgets |
| `DimensionField` | Numeric input bound to `Length` + unit display; validation; locale-aware decimal | 2 | core/widgets |
| `UnitToggle` | Metric/imperial segmented control | 2 | core/widgets |
| `StepProgress` | Onboarding step indicator | 2 | features/onboarding |
| `PhotoSourceSheet` | Camera / gallery chooser with permission handling | 2 | features/garden |
| `PhotoGrid` / `PhotoThumb` | Thumbnails with selection, missing-file placeholder | 2 | features/garden (promote to core if the journal reuses it) |
| `GardenCard` | Garden summary card | 2 | features/garden |
| `NotSetField` | "Not set · Add" row for progressive profiles | 2 | core/widgets |
| `GardenCanvas` | CustomPaint + gesture layer for the designer | 3 | features/garden_designer |
| `SelectionHandles` | Resize/rotate handles with large hit areas | 3 | features/garden_designer |
| `MeasurementLabel` | Pill label for dimensions on the canvas | 3 | features/garden_designer |
| `ObjectPalette` | Categorised element picker | 3 | features/garden_designer |
| `ObjectInspector` | Precise edit form for the selected element | 3 | features/garden_designer |
| `PlantCard` | Species image card with quick facts | 4 | features/plant_catalog |
| `QuickFactRow` | Icon + label + value (sun, water, container) with "Not documented" state | 4 | core/widgets |
| `SourceList` | Renders provenance (source titles, links, confidence) | 4 | core/widgets |
| `ReasonList` | "Why" and "Watch out" bullets for recommendations | 4 | features/recommendations |
| `CareTaskTile` | Task row with category, plant/container, due state, complete/skip actions, swipe | 5 | features/care |
| `CategoryIcon` | Care category colour + icon pairing | 5 | core/widgets |
| `MilestoneBadge` | Journal milestone marker | 6 | features/journal |

## Extending components

Add a variant through an enum or a named constructor rather than a boolean explosion (e.g. `AppButton.secondary(...)`). If a screen needs a one-off variation, compose rather than adding parameters, until a second usage justifies a variant.
