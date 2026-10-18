# Design System

Status: v0.3 "Living Terrace" (2026-10-18; ADR-025). Implemented in `lib/app/theme/` as a Material 3 `ThemeData` plus `ThemeExtension`s (`CareColors`, `GlassTheme`). Screens must not use raw colours, font sizes or magic spacing numbers. Mockups: `docs/design/redesign-living-terrace.pdf` (source `.html` alongside).

**Visual direction (v0.3): "Living Terrace."**
- The user's **own terrace, drawn to scale from above**, is the hero: Today, the garden overview, the add-plant picker and the welcome step all use `TerracePlan`.
- Plants are **botanical drawings in code** (`PlantTopArt`, `PlantSideArt`), one form per catalogue species, not photos or emoji.
- Colours come from a terrace: limestone floor, neem leaves, terracotta pots, haldi, water. Content sits on **solid paper cards**; there is no glass or photo backdrop on top-level screens.
- Serif headlines and plant names (like herbarium labels) over a clean grotesque UI face.
- This replaces v0.2 "real, modern, translucent" (photo backdrops and glass), which user feedback found generic.

## 1. Design principles

1. **Your terrace, not a template.** Show the user's real space and plants wherever a decision is made: which plant needs a check, which container a new plant fits. It should feel like a gardener's notebook, not a dashboard.
2. **Practical first.** Every screen answers "what should I do next?" Decoration never competes with the task, the plant, or the garden canvas.
3. **Honest about certainty.** Estimates, AI concepts and schedules are visibly labelled as guidance ("Check the soil first"). Confidence and provenance are part of the UI, not hidden.
4. **Touch-native canvas.** The garden designer is a primary surface. It gets the most space, the clearest affordances and the largest touch targets.
5. **Progressive disclosure.** Sensible defaults up front, detail on demand (bottom sheets, expandable rows).

## 2. Colour

Warm limestone neutrals with neem-green text and a leaf-green primary. All text/background pairs must meet WCAG 2.2 AA (4.5:1 body text, 3:1 large text and UI components), enforced by `test/app/theme/contrast_test.dart`.

### 2.1 Brand palette (light, `AppPalette`)

| Token | Hex | Use |
|---|---|---|
| `limestone` (surface) | `#F2F0EA` | App background |
| `paper` (surfaceContainerLowest) | `#FBFAF7` | Cards, sheets, nav bar |
| `stone` / `stoneDeep` | `#E7E4DA` / `#DDD8CC` | Chips, thumbnails, hairlines |
| `neem` (onSurface) | `#17301F` | Primary text; inverse surfaces (the "this month" card) |
| `neemMuted` (onSurfaceVariant) | `#4E5D52` | Secondary text (4.5:1 on `stoneDeep`) |
| `leaf` (primary) | `#2B6530` | Primary actions, selected states, sowing windows |
| `leafContainer` | `#D6E8D2` | Tonal surfaces |
| `terracotta` | `#C2592B` | Decorative only: pots, accents |
| `terracottaDeep` (secondary) | `#A4471F` | Secondary text and icons ("Best match") |
| `haldi` | `#E3A21A` | Decorative only: sun, harvest band |
| `haldiDeep` (tertiary) | `#855B00` | Tertiary text and icons; current month |
| `water` | `#2E6FB0` | Soil checks, due pins, the "I watered" button |
| `outline` | `#8C8472` | Input outlines |
| `error` | `#B3261E` | Errors, destructive actions |

### 2.2 Semantic / care colours

Care categories get a consistent colour + icon pair everywhere (calendar, task tiles, chips, notifications). Colour is never the only signal: an icon and label always accompany it.

| Category | Light | Dark |
|---|---|---|
| Water / soil check | `#2E6FB0` | `#8EC1E8` |
| Fertilise | `#855B00` | `#BCD07A` |
| Prune | `#7A5C99` | `#CDB3E8` |
| Repot | `#A4471F` | `#F0B394` |
| Inspect (pests) | `#A4471F` | `#E9C46A` |
| Sow | `#2B6530` | `#92D1AE` |
| Harvest | `#A8700F` | `#F2C46B` |
| Success | `#2B6530` | `#8FD4A8` |
| Warning | `#855B00` | `#E9C46A` |

### 2.3 Dark theme ("evening")

Dark theme is a first-class theme, not an inversion: deep neem greens rather than black, and the terrace plan gets a dusk overlay.

| Token | Hex |
|---|---|
| `surface` (`dusk`) | `#0F2017` |
| `surfaceContainerLowest` / `surfaceContainer` (`duskHigh`) | `#18301F` |
| `surfaceContainerHigh` | `#1F3627` |
| `surfaceContainerHighest` (`duskHighest`) | `#24402D` |
| `onSurface` | `#ECE8DE` |
| `onSurfaceVariant` | `#A9B7AD` |
| `primary` | `#93CE8C` |
| `secondary` | `#F0B394` |
| `tertiary` | `#F2C46B` |

Strategy: `ThemeMode.system` by default, user override in Settings.

### 2.4 Surfaces (`GlassTheme`, `GlassPanel`, `PhotoBackdrop`)

| Token | Light | Dark |
|---|---|---|
| `tint` | `#FBFAF7` (paper) | `#18301F` |
| `border` | `#E5E1D6` | `#24402D` |
| `blurSigma` | 0 | 0 |
| `onPhoto` | `#17301F` | `#ECE8DE` |

Rules:
1. **Solid paper by default.** `GlassPanel` draws a solid card; it only blurs when a theme sets `blurSigma > 0` (kept for possible future photo screens). `PhotoBackdrop` is a plain surface with the right status-bar style.
2. **Photos are content, not backdrops:** garden cover (until a layout exists), journal entries and the then-and-now card.
3. **High contrast:** `GlassPanel` never blurs when the platform requests high contrast.
4. **Radii:** cards 22–24, the plan 26, pills full.
5. **Illustrations give way** on short screens (capped at about 30–35% of the height) so actions stay in reach, and layouts scroll at 200% text.

## 3. Typography

Two bundled font families (both SIL Open Font License, shipped as assets with licences registered at start-up, so no runtime font download):

- **Display, headings and plant names:** *Young Serif* (Regular 400). Screen titles, headlines, plant names in lists and cards.
- **UI / body:** *Schibsted Grotesk* (Regular, Italic, Medium, SemiBold, Bold). High legibility at small sizes, good numerals for dimensions.

Scientific names are rendered in Schibsted Grotesk italic.

| Role (M3 TextTheme) | Family | Size / line height | Weight |
|---|---|---|---|
| displaySmall | Young Serif | 36 / 44 | 400 |
| headlineLarge | Young Serif | 32 / 40 | 400 |
| headlineMedium | Young Serif | 28 / 36 | 400 |
| headlineSmall | Young Serif | 24 / 32 | 400 |
| titleLarge | Schibsted Grotesk | 20 / 28 | 600 |
| titleMedium | Schibsted Grotesk | 16 / 24 | 600 |
| titleSmall | Schibsted Grotesk | 14 / 20 | 600 |
| bodyLarge | Schibsted Grotesk | 16 / 24 | 400 |
| bodyMedium | Schibsted Grotesk | 14 / 20 | 400 |
| bodySmall | Schibsted Grotesk | 12 / 16 | 400 |
| labelLarge | Schibsted Grotesk | 14 / 20 | 600 |
| labelMedium | Schibsted Grotesk | 12 / 16 | 500 |
| labelSmall | Schibsted Grotesk | 11 / 16 | 500 |

Plant names in rows and cards use the display family at title sizes (weight 400).

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

- **Plants are drawn, not photographed** (v0.3): `PlantArtSpec.of(speciesId)` gives each catalogue species a form (fruiting, palmate, rosette, root, cluster, grass, flowering, succulent, trailing) and colours; a new species needs an entry there or falls back to its category. Locked by the `plant_art` golden.
- **Bundled photos** (garden cover fallback, empty states): ≤ 1440 px long edge, JPEG quality ~78. Never stretched or upscaled. They are no longer full-screen backdrops.
- **Cards and catalogue thumbnails:** ≤ 1200px long edge, ≤ ~150 KB (WebP or JPEG).
- **Subjects:** real terraces, balconies, containers and edible plants. Prefer scenes that resemble Indian terraces (grow bags, terracotta, concrete parapets) as the library grows. No people in backdrops.
- **Licensing:** own photos, CC0/public domain, CC BY, or CC BY-SA (crops of BY-SA images are BY-SA). Every bundled image has an entry in `assets/images/ATTRIBUTION.md` **and** in `photoCredits` (shown in Settings → Image credits). No competitor assets. Openverse and Wikimedia Commons are the sourcing tools used so far.
- Fallback: the category drawing when a species has no specific art.
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
