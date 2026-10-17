# Reusable Components

Status: v0.2 (2026-10-18). **Phase 1 components are built** in `lib/core/widgets/` and tested in `test/core/widgets/` and `test/goldens/`. Later rows are still a plan.

## Built (Phase 1): public APIs

| Component | File | API summary |
|---|---|---|
| `AppButton` | `app_button.dart` | `AppButton(label:, onPressed:, icon?, isLoading, expand)` plus `.secondary`, `.text`, `.destructive`. `onPressed: null` disables. Loading ignores taps but keeps the label |
| `AppCard` | `app_card.dart` | `AppCard(child:, onTap?, padding, semanticLabel?)` |
| `ImageCard` | `image_card.dart` | `ImageCard(title:, image?, subtitle?, onTap?, aspectRatio = 4/3, placeholderIcon, imageSemanticLabel?)`. Placeholder when the image is null or fails |
| `StatusChip` | `status_chip.dart` | `StatusChip(label:, icon:, color:)`. 12% tint, coloured icon, onSurface text |
| `SelectableChipGroup<T>` | `selectable_chip_group.dart` | `options: List<ChipOption<T>>, selected: Set<T>, onChanged, multiSelect = true, allowEmpty = true` |
| `SectionHeader` | `section_header.dart` | `SectionHeader(title:, actionLabel?, onAction?)`. Semantic header |
| `EmptyState` | `empty_state.dart` | `EmptyState(icon:, title:, body:, actionLabel?, onAction?, badge?)`. Action only when it works |
| `ErrorState` | `error_state.dart` | `ErrorState(failure?, onRetry?)`. `ErrorState.messageFor(l10n, failure)` maps `AppFailure` to copy |
| `SkeletonBox` / `SkeletonList` | `skeleton.dart` | Pulse disabled under reduced motion. The list announces `semanticLabel` once |
| `AsyncStateView<T>` | `async_state_view.dart` | `AsyncStateView(value: AsyncValue<T>, data:, loading?, onRetry?)`. Keeps previous data during refresh |
| Dialogs | `dialogs.dart` | `showConfirmDialog(...) → Future<bool>` (dismiss = false). `showAppBottomSheet<T>(title:, builder:)` (max 90% height) |
| `GlassPanel` | `glass_panel.dart` | `GlassPanel(child:, padding = 20, borderRadius = 28)`. Frosted surface; opaque under high contrast. Use only over photos (design-system §2.4) |
| `GlassIconButton` | `glass_icon_button.dart` | `GlassIconButton(icon:, tooltip:, onPressed:)`. Round glass action over photos, 48dp target |
| `PhotoBackdrop` | `photo_backdrop.dart` | `PhotoBackdrop(image:, child:, alignment)`. Full-bleed decorative photo, top scrim, light status bar |
| `ImmersiveEmptyState` | `immersive_empty_state.dart` | `ImmersiveEmptyState(screenTitle:, image:, icon:, title:, body:, badge?, actionLabel?, onAction?, photoAlignment)`. Photo + title + glass message panel. Scrolls at large text sizes |

Theme access helpers: `context.careColors` (`app/theme/care_colors.dart`) and `context.l10n` (`l10n/l10n.dart`). Styles come from `docs/design/design-system.md`; components must use theme tokens only (no raw colours or sizes).

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
