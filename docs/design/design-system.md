# Design System

Status: v0.1 (Phase 0 draft). This is the single source of truth for visual and interaction decisions. It will be implemented in `lib/app/theme/` (Phase 1) as a Material 3 `ThemeData` plus `ThemeExtension`s for garden-specific tokens. Screens must not use raw colours, font sizes or magic spacing numbers.

## 1. Design principles

1. **Calm and editorial.** Generous whitespace, a restrained palette, a serif display face and real plant photography. The product should feel like a good gardening magazine, not a dashboard.
2. **Practical first.** Every screen answers "what should I do next?" Decoration never competes with the task, the plant, or the garden canvas.
3. **Honest about certainty.** Estimates, AI concepts and schedules are visibly labelled as guidance ("Check the soil first"). Confidence and provenance are part of the UI, not hidden.
4. **Touch-native canvas.** The garden designer is a primary surface. It gets the most space, the clearest affordances and the largest touch targets.
5. **Progressive disclosure.** Sensible defaults up front, detail on demand (bottom sheets, expandable rows).

## 2. Colour

Nature-inspired, warm neutrals with a deep green primary. All text/background pairs must meet WCAG 2.2 AA (4.5:1 body text, 3:1 large text and UI components). Ratios below are computed from sRGB relative luminance and must be re-verified by a test in Phase 1 (`test/app/theme/contrast_test.dart`).

### 2.1 Brand palette (light)

| Token | Hex | Use |
|---|---|---|
| `fern` (primary) | `#2F5D3A` | Primary actions, selected nav, key accents |
| `fernContainer` | `#CFE6D2` | Selected chips, tonal buttons, highlights |
| `onFernContainer` | `#0F2A17` | Text on fernContainer |
| `terracotta` (secondary) | `#A4532F` | Containers/pots on canvas, secondary emphasis |
| `terracottaContainer` | `#F6DCCD` | Secondary tonal surfaces |
| `marigold` | `#C98A1C` | Decorative only: sun, harvest highlights, illustrations (≈2.9:1 on paper, so never text or icons) |
| `marigoldDeep` (tertiary) | `#855B00` | Tertiary role: text and icons on light surfaces (≈6:1 with white) |
| `marigoldContainer` | `#FBE7BF` | Tertiary tonal surfaces |
| `paper` (surface) | `#F7F5EF` | App background |
| `paperBright` | `#FFFFFF` | Cards, sheets |
| `paperDim` | `#ECE8DE` | Dividers' backgrounds, canvas outside garden bounds |
| `ink` (onSurface) | `#1C2420` | Primary text |
| `inkMuted` (onSurfaceVariant) | `#4E5A52` | Secondary text |
| `outline` | `#7C877F` | Borders, input outlines |
| `outlineVariant` | `#CBD1C9` | Hairlines, dividers |
| `error` | `#B3261E` | Errors, destructive actions |

Approximate contrast: `fern` on `paper` ≈ 7.0:1; white on `fern` ≈ 7.6:1; white on `terracotta` ≈ 5.2:1; `ink` on `paper` ≈ 15:1; `inkMuted` on `paper` ≈ 6.8:1.

### 2.2 Semantic / care colours

Care categories get a consistent colour + icon pair everywhere (calendar, task tiles, chips, notifications). Colour is never the only signal: an icon and label always accompany it.

| Category | Colour | Icon (Material Symbols Rounded) |
|---|---|---|
| Water | `#2F6F9F` | `water_drop` |
| Fertilise | `#6B7F2A` | `compost` |
| Prune | `#7A5C99` | `content_cut` |
| Repot | `#A4532F` | `potted_plant` |
| Inspect (pests/disease) | `#9A6B00` | `search` / `bug_report` |
| Sow | `#3F7D5B` | `grass` |
| Harvest | `#A8700F` | `nutrition` |
| Success | `#2E7D4F` | `check_circle` |
| Warning | `#9A6B00` | `warning` |

### 2.3 Dark theme

Dark theme is a first-class theme, not an inversion. Surfaces are deep forest tones rather than pure black, to keep photography warm.

| Token | Hex |
|---|---|
| `surface` | `#121815` |
| `surfaceContainer` | `#1B231F` |
| `surfaceContainerHigh` | `#242D28` |
| `onSurface` | `#E4EAE4` |
| `onSurfaceVariant` | `#B7C2BA` |
| `primary` | `#9CD3A7` |
| `onPrimary` | `#0F3A1D` |
| `secondary` | `#F0B394` |
| `tertiary` | `#F2C46B` |
| `outlineVariant` | `#3A453F` |

Strategy: `ThemeMode.system` by default, user override in Settings. Images get a subtle 8% scrim in dark mode only when text overlays them.

## 3. Typography

Two bundled font families (both SIL Open Font License, shipped as assets, so no runtime font download):

- **Display / headings:** *Fraunces* (static 72pt optical size; Regular 400 and SemiBold 600 bundled). Editorial character for screen titles, plant names, empty-state headlines.
- Static font files are bundled (Inter 18pt Regular, Italic, Medium, SemiBold; Fraunces 72pt Regular, SemiBold). Use only these weights. Contrast for every token pair is enforced by `test/app/theme/contrast_test.dart`.
- **UI / body:** *Inter* (variable sans). High legibility at small sizes, good numerals for dimensions.

Scientific names are rendered in Inter italic.

| Role (M3 TextTheme) | Family | Size / line height | Weight |
|---|---|---|---|
| displaySmall | Fraunces | 36 / 44 | 400 |
| headlineMedium | Fraunces | 28 / 36 | 400 |
| headlineSmall | Fraunces | 24 / 32 | 400 |
| titleLarge | Inter | 20 / 28 | 600 |
| titleMedium | Inter | 16 / 24 | 600 |
| titleSmall | Inter | 14 / 20 | 600 |
| bodyLarge | Inter | 16 / 24 | 400 |
| bodyMedium | Inter | 14 / 20 | 400 |
| bodySmall | Inter | 12 / 16 | 400 |
| labelLarge | Inter | 14 / 20 | 600 |
| labelMedium | Inter | 12 / 16 | 500 |
| labelSmall | Inter | 11 / 16 | 500 |

Rules: body text is never below 12sp. Layouts must survive text scaling to 200% (wrap rather than truncate on critical content). Measurement labels on the canvas use `labelMedium` with tabular figures (`FontFeature.tabularFigures()`).

## 4. Spacing, layout and responsiveness

- **Spacing scale (dp):** `xxs 2 · xs 4 · sm 8 · md 12 · lg 16 · xl 24 · xxl 32 · xxxl 48 · huge 64`. Exposed as `AppSpacing` constants.
- **Screen gutters:** 16dp on compact width, 24dp on medium, 32dp on expanded.
- **Width classes** (Material 3 window size classes): compact `< 600`, medium `600–839`, expanded `≥ 840`.
  - Compact: bottom `NavigationBar`, single column.
  - Medium: `NavigationRail`, two-column where useful (list + detail).
  - Expanded: `NavigationRail` (extended), designer canvas with a persistent side inspector instead of a bottom sheet.
- **Readable line length:** text blocks max ~640dp wide on large screens.
- **Vertical rhythm:** sections separated by 32dp; items within a section by 12–16dp.

## 5. Shape, border and elevation

| Token | Radius | Use |
|---|---|---|
| `shapeXs` | 4 | Canvas selection handles, small tags |
| `shapeSm` | 8 | Inputs, small buttons, thumbnails |
| `shapeMd` | 16 | Cards, image cards, dialogs |
| `shapeLg` | 24 | Bottom sheets (top corners), hero images |
| `shapeFull` | 999 | Chips, FABs, pill buttons |

Elevation: prefer **tonal elevation** (surface container tones) over shadows. Shadows are allowed only for floating elements over imagery or the canvas (FAB, canvas toolbar, dragged object) and use a single soft shadow token (`0 4 16 rgba(28,36,32,0.12)`). Borders are 1dp `outlineVariant` hairlines.

## 6. Iconography

- Base set: **Material Symbols Rounded** (built into Flutter's `Icons.*_rounded`, or the `material_symbols_icons` package if we need weight/fill axes; decided in Phase 1).
- 24dp default; 20dp inline with text; 32–48dp in empty states.
- Garden objects (pot, grow bag, raised bed, trellis, path, wall, water tap) are **custom-drawn** shapes in the canvas painter so they scale cleanly and look intentional, plus matching 24dp icons for palettes.
- Icons always have a semantic label when they convey meaning on their own.

## 7. Components (styles; behaviour lives in `reusable-components.md`)

| Component | Style rules |
|---|---|
| **Primary button** | Filled `fern`, white label, 52dp tall, `shapeFull`, full-width on compact forms. One primary action per screen. |
| **Secondary button** | Tonal (`fernContainer`) or outlined; same height. |
| **Text button** | For low-emphasis actions (Skip, Learn more). |
| **Destructive** | Outlined/filled `error`, always confirmed via dialog. |
| **Card** | `paperBright`, `shapeMd`, 1dp hairline or no border, 16dp padding. Image cards use a 4:3 or 3:4 image with a text block below; text over image only with a gradient scrim at the bottom 40%. |
| **Inputs** | Outlined, `shapeSm`, label above or floating, helper text always visible for units ("in cm"). Dimension inputs pair a numeric field with a unit segmented control. |
| **Chips** | Filter chips `shapeFull`, selected = `fernContainer` + check icon. Status chips use semantic colour at 12% tint + coloured icon + ink text. |
| **Bottom sheets** | `shapeLg` top corners, drag handle, max 90% height, used for pickers, object inspector (compact), quick task actions. |
| **Dialogs** | Only for confirmation/destructive actions and permission rationale. |
| **Navigation** | `NavigationBar` with 4 destinations, labels always shown, selected indicator `fernContainer`. |
| **Snackbars** | Floating, `ink` background, used for undo ("Task skipped · Undo"). |
| **Progress** | Linear for determinate (onboarding steps), circular for indeterminate. Prefer skeleton placeholders for content loading. |

## 8. States

Every data-driven screen implements all applicable states explicitly using shared widgets:

| State | Pattern |
|---|---|
| Loading | Skeleton placeholders that match final layout (no spinners for full screens after 300ms). |
| Empty | Illustration or photo, Fraunces headline, one sentence, one primary action ("Create your first garden"). |
| Error | Plain-language message, what the user can do, Retry action. No stack traces. Logged via core logger. |
| Success | Brief confirmation (snackbar or inline check animation); never a modal. |
| Permission denied | Explain the benefit, offer "Open settings", and keep the rest of the feature usable (e.g. pick from gallery when camera denied). |
| Offline | Local-first: most features keep working; network-only features show a non-blocking inline notice. |
| Partial / unknown data | Show "Not set" with an inline "Add" affordance rather than hiding the field (supports progressive onboarding). |

## 9. Motion

- **Durations:** short 150ms (state changes, chips), medium 250ms (sheets, cards, page transitions), long 400ms (hero/shared element, onboarding).
- **Easing:** Material 3 emphasized (`Curves.easeInOutCubicEmphasized`) for transitions; standard `easeOutCubic` for small changes.
- **Meaningful only:** motion explains spatial relationships (sheet rising from the tapped object, task checking off and collapsing). No looping decorative animation.
- **Canvas:** dragging is 1:1 with the finger (no easing); snapping animates in 100ms; invalid placement shows a brief error-tinted outline + haptic.
- **Reduced motion:** respect `MediaQuery.disableAnimationsOf(context)`; replace transitions with fades or instant changes.
- **Haptics:** light impact on snap, selection and task completion; never continuous.

## 10. Accessibility

- Minimum touch target **48×48dp**; canvas handles render at ~12–16dp but have a 44–48dp hit area.
- Contrast per §2; verified by automated test for theme token pairs.
- All interactive elements have semantic labels; canvas objects expose `Semantics` nodes (name, size, position) and an accessible list view alternative ("Objects in this layout") with edit actions, so the designer is usable without precise dragging.
- Supports text scale up to 200% on all non-canvas screens.
- Never rely on colour alone (care categories, validation errors, overlap warnings use icons/text too).
- Focus order and keyboard navigation work for tablets/desktop testing.

## 11. Imagery

- Real plant photography for catalogue and empty states, bundled at controlled resolution (WebP, ≤ 1200px long edge, ≤ ~150KB).
- **Licensing:** only images with a licence that permits bundling in an app (own photos, CC0, CC BY with attribution, or licences such as Unsplash/Pexels after review). Every bundled image has an entry in `assets/images/ATTRIBUTION.md` (source, author, licence). No competitor assets.
- Fallback: a tasteful category illustration/placeholder when a plant has no licensed photo.
- User photos are shown with `BoxFit.cover`, rounded `shapeMd`, and are never upscaled beyond their resolution.

## 12. Garden canvas visual language

| Element | Visual |
|---|---|
| Garden boundary | 2dp `ink` stroke, interior `paperBright`; outside area `paperDim` |
| Grid | Minor lines every 10cm (or 6in) at 6% ink, major every 1m (or 1ft) at 12% ink; minor lines hide below a zoom threshold |
| Walls/railings | Thick `ink` 70% stroke with hatch |
| Paths | `paperDim` fill, dashed outline |
| Containers / grow bags | `terracotta` 15% fill, `terracotta` outline; round or rectangular |
| Raised beds | `fern` 12% fill, `fern` outline, wood-tone border |
| Plants | Circle sized to expected mature spread, `fern` 20% fill, plant initial/icon |
| Selection | `fern` 2dp outline, 4 corner handles + rotation handle |
| Invalid | `error` outline + warning badge; never only colour |
| Labels | Dimension labels in `labelMedium` with a `paperBright` pill background |
| Sun direction (when known) | Compass rose/arrow in the corner (N indicator) |
