# TODO

Single source of truth for implementation progress. Last updated: 2026-10-18 (Living Terrace redesign).

Legend: `[ ]` not started · `[~]` in progress · `[x]` completed (acceptance criteria met and checks run) · `[!]` blocked (reason given).
Priority: **P0** must (MVP-critical) · **P1** should · **P2** could.
Every phase ends with the **gate**: `dart format --output=none --set-exit-if-changed .` · `flutter analyze` · `flutter test` (+ integration tests and `flutter build apk --debug` at phase end), then update `docs/progress/*`.

---

## Phase 0: Discovery and research ✅

- [x] **P0-01** Inspect workspace and toolchain. *Done:* empty directory; Flutter 3.44.8 / Dart 3.12.2; Android SDK 36 + emulator; licences not accepted (KI-002); git repo initialised.
- [x] **P0-02** Competitor research → `docs/research/competitor-analysis.md`
- [x] **P0-03** Gardening-domain research and source register → `docs/research/gardening-references.md`
- [x] **P0-04** Opportunity analysis, personas, MVP scope → `docs/product/opportunity-analysis.md`
- [x] **P0-05** PRD and roadmap → `docs/product/product-requirements.md`, `docs/product/roadmap.md`
- [x] **P0-06** Design system and screen inventory → `docs/design/*`
- [x] **P0-07** Architecture, technical decisions, data model, reusable components plan → `docs/architecture/*`
- [x] **P0-08** Testing strategy and known issues → `docs/quality/*`
- [x] **P0-09** CLAUDE.md, README.md, TODO.md, progress docs

---

## Phase 1: Foundation and design system

- [x] **P1-01 · P0 · SDK decision.** *Done 2026-10-18:* user chose the local Flutter 3.44.8 / Dart 3.12.2; ADR-001 accepted with fallback package pins.
- [!] **P1-02 · P1 · Accept Android licences.** *User action:* `flutter doctor --android-licenses`. Not blocking: builds work because the needed SDK components are installed, but licences are required to install or update SDK packages.
  - Acceptance: `flutter doctor` shows no Android toolchain issues.
- [x] **P1-03 · P0 · Create Flutter project.** *Done:* project created (`com.terracegarden`), template replaced by `ProviderScope` + `MaterialApp.router` bootstrap; pubspec cleaned and pinned. App smoke tests in `test/app/app_test.dart`. Android launch not yet verified (see P1-11, KI-007).
  - Deps: P1-01.
  - Steps: `flutter create --org <org> --platforms android,ios --project-name terrace_garden .`, preserving existing docs. Remove counter boilerplate. Apply the `material_ui` migration if the 3.47 template needs it.
  - Acceptance: app launches on an Android emulator; `.gitignore` correct; first commit made (with user approval).
  - Tests: default widget test replaced with an app smoke test.
- [x] **P1-04 · P0 · Lints and codegen config.** *Done:* very_good_analysis 10.3.0 (+2 documented rule changes); `build.yaml` generate_for globs verified with build_runner. **riverpod_lint deferred** (incompatible plugin API on Dart 3.12; KI-008, ADR-011).
  - Work: `analysis_options.yaml` (very_good_analysis + riverpod_lint; exclusions for generated files); `build.yaml` generate_for globs.
  - Acceptance: `flutter analyze` clean.
- [x] **P1-05 · P0 · Core primitives.** *Done:* `Result`/`AppFailure`, `AppLogger`, `Clock`, `IdGenerator`, `LocalDate`, `Length`/`Area`/`Volume` + `MeasurementFormatter`; unit tests incl. round-trips and DST case.
  - Work: `Result<T>`/`AppFailure`, `AppLogger`, `Clock`, `IdGenerator`, `LocalDate`, `Length`/`Area`/`UnitSystem` with formatting.
  - Files: `lib/core/{errors,logging,time,ids,units}`.
  - Tests: unit tests incl. unit round-trips (1e-6 tolerance) and display rounding.
- [x] **P1-06 · P0 · Theme.** *Done:* tokens, light/dark schemes, `CareColors` extension, component themes; 77 contrast checks pass. Fixed two palette contrast failures (marigold → tertiary `marigoldDeep`; harvest colour).
  - Work: tokens (`AppColors`, `AppSpacing`, `AppRadii`, `AppMotion`), light/dark `ThemeData`, `ThemeExtension`s (care colours, canvas colours).
  - Files: `lib/app/theme/`.
  - Acceptance: matches design-system §2–5.
  - Tests: contrast test for all text/background token pairs (≥ 4.5:1 body, ≥ 3:1 large/UI).
- [x] **P1-07 · P0 · Fonts.** *Done:* static Inter 18pt (400/400i/500/600) and Fraunces 72pt (400/600) bundled; OFL licences registered.
  - Work: bundle Fraunces and Inter (OFL) and register their licences.
  - Acceptance: fonts render offline; licences visible in the Flutter licences page.
- [x] **P1-08 · P0 · Localisation.** *Done:* gen-l10n with `lib/l10n/app_en.arb`; all shell strings localised.
  - Work: gen-l10n setup (`l10n.yaml`, `lib/l10n/app_en.arb`).
  - Acceptance: all shell strings come from ARB.
- [x] **P1-09 · P0 · Core widgets (first set).** *Done:* AppButton, AppCard, ImageCard, StatusChip, SelectableChipGroup, SectionHeader, EmptyState, ErrorState, Skeleton, AsyncStateView, dialogs; widget tests + alchemist CI goldens (light/dark).
  - Components: AppButton, AppCard, ImageCard, StatusChip, SelectableChipGroup, SectionHeader, EmptyState, ErrorState, Skeleton, AsyncStateView, ConfirmDialog, AppBottomSheet (see `reusable-components.md`).
  - Tests: widget tests (states, semantics, ≥48dp targets, text scale 2.0); goldens for buttons/cards/chips in light and dark.
- [x] **P1-10 · P0 · Router and app shell.** *Done:* go_router `StatefulShellRoute` with 4 tabs, adaptive NavigationBar/Rail, settings route; empty states without dead buttons; tests at 360/700/1200 widths and 200% text.
  - Work: go_router with `StatefulShellRoute` (Today, Garden, Plants, Journal); responsive NavigationBar/NavigationRail; each tab shows its designed empty state with a real next action (no dead buttons); Settings route.
  - Tests: widget tests for navigation and layout at 360/700/1200 widths.
- [x] **P1-11 · P0 · Database foundation.** *Done:* drift `AppDatabase` v1, provider, FK pragma, schema snapshot (`drift_schemas/`); in-memory test passes on the Windows host; `flutter build apk --debug` succeeds and the app runs on the Android 16 emulator.
  - Work: drift `AppDatabase` (empty schema v1 + migration test harness + schema dump); provider wiring.
  - Acceptance: an in-memory DB test passes on Windows host (verifies sqlite3 build hooks, KI-005); Android debug build succeeds.
- [x] **P1-12 · P1 · Settings skeleton.** *Done:* SettingsRepository (SharedPreferencesAsync), optimistic controller with rollback, theme + units working end to end, licences page.
  - Work: SettingsRepository (SharedPreferencesAsync), theme mode and unit system working end to end; About screen listing licences.
  - Tests: repository and view-model tests.
- [x] **P1-13 · P1 · Developer tooling.** *Done:* `tool/check.sh` and `tool/check.ps1`. CI workflow deferred until CI is wanted.
  - Work: `tool/check.ps1` / `tool/check.sh` running the gate; README run/test instructions; optional GitHub Actions workflow file (not activated until a remote exists).
- [x] **P1-GATE** Phase 1 quality gate (2026-10-18). Format, `flutter analyze`, `dart analyze` and 149 tests pass. Debug APK built (502s first build) and verified on the emulator: Today screen, Settings dark theme, setting kept after a cold start, two clean cold starts open on Today. No integration tests yet (the first is P2-08).

## Phase 2: Garden setup and profile

- [x] **P2-01 · P0 · Garden domain and data.** *Done:* `Garden`, `GardenDraft` (validation), enums with explicit unknowns; drift `gardens` + `garden_photos` tables, schema v2 with generated migration test; `DriftGardenRepository` (+ `find`), cascade deletes.
  - Work: `Garden` entity and enums (data-model §3), `GardenRepository` interface + drift implementation (tables, DAO, migration v2), validation (`GardenDraft`).
  - Tests: repository tests (create/read/update/delete/cascade), validation tests.
- [x] **P2-02 · P0 · Region mapping.** *Done:* `GrowingRegion` (North/South India, Telangana, Tamil Nadu, Kerala) per sourced tables; 49 cities offline; west/central/east cities have no region yet (KI-017).
  - Work: offline Indian city list → `regionKey` (ADR-015); "Other / not listed" fallback.
  - Tests: mapping tests.
- [x] **P2-03 · P0 · Onboarding flow (ONB-01..05).** *Done:* welcome over photo, 3 steps (only name required, steps skippable), ready summary; "explore first"; first-run routing via `onboardingCompleted` setting.
  - Work: progressive and skippable; first-run redirect; "explore first".
  - Acceptance: PRD FR-A.
  - Tests: view-model tests; widget tests for validation.
- [x] **P2-04 · P0 · Garden overview (GDN-02) and edit profile (GDN-03).** *Done:* cover photo header, "Not set · Add" rows, delete with confirm; shared form sections; unsaved-changes guard (tested with system back).
  - Work: "Not set · Add" pattern; unsaved-changes prompt.
  - Tests: widget tests.
- [x] **P2-05 · P0 · Photo storage service.** *Done:* `PhotoPicker` (image_picker) and `PhotoStorage` (compress, EXIF/GPS stripped, thumbnails, relative paths, cleanup on failure); `GardenPhotoRepository`; `GardenService.deleteGarden` removes files.
  - Work: pick (image_picker) → compress/strip EXIF → thumbnail → relative paths; delete files; `retrieveLostData`; `PhotoStorage` interface + fake.
  - Tests: unit tests with a temp-dir fake; missing-file handling.
- [x] **P2-06 · P0 · Photo gallery and viewer (GDN-04/05).** *Done:* grid, add (camera/gallery), zoomable viewer with caption, cover, replace, delete; missing-file placeholder.
  - Work: add/view/replace/delete/caption/tag/cover; permission-denied state.
  - Acceptance: PRD FR-B.
- [x] **P2-07 · P1 · Environment notes and terrace checklist (GDN-06, FR-I).** *Done:* wind and water fields in the profile; checklist of 6 items citing only verified sources (S2, S4–S6, S11, S12, S42); never claims structural safety.
  - Work: content only from `gardening-references.md` §3c, §4, §8, with source IDs.
- [x] **P2-08 · P0 · Integration test: onboarding → garden created → restart → garden visible.** *Done:* `integration_test/garden_setup_test.dart` passes on the Android 16 emulator (run after `adb shell pm clear com.terracegarden.terrace_garden`).
- [x] **P2-GATE** (2026-10-18). Format clean, analyze clean, 200 host tests, integration test on emulator.

## Phase 3: Garden designer MVP

- [x] **P3-01 · P0 · Geometry domain.** *Done:* `Vec2`, `RectShape` (oriented), `CircleShape`, SAT overlap with touch tolerance, containment, edge distances, grid/edge/angle snapping; 19 tests incl. rotated cases.
  - Work: Vec2, Size2, oriented rect, circle, polygon footprint, containment, overlap (SAT; circle/rect), distance to boundary, grid/edge snapping, rotation snapping.
  - Tests: ≥ 90% coverage, incl. rotated cases.
- [x] **P3-02 · P0 · CanvasTransform.** *Done:* fit, focal zoom with clamps, pan, world↔screen round-trip tests.
  - Work: fit-to-viewport, zoom about focal point, pan clamp, world↔screen.
  - Tests: round-trip tests at multiple zoom levels and offsets.
- [x] **P3-03 · P0 · Layout document model.** *Done:* `ElementKind` (role, defaults, round), `LayoutElement` (shape, soil litres), `LayoutDocument` (boundary from garden size), `LayoutSummary`.
  - Work: element kinds, container presets (grow bag sizes 12×12, 15×15, 18×9, 24×18, 24×24 in; pot diameters), derived area/volume.
  - Tests: unit tests.
- [x] **P3-04 · P0 · LayoutValidator.** *Done:* out of bounds and solid overlaps = error; container on path = warning; markers ignored.
  - Work: errors (out of bounds, container overlap); warnings (crowding, shallow container placeholder hook for Phase 4).
  - Tests: unit tests.
- [x] **P3-05 · P0 · Command stack.** *Done:* `LayoutHistory` (snapshots, 50 max) and `LayoutEditorController` (one undo point per gesture, duplicate, delete, inspector edits).
  - Work: add/move/resize/rotate/delete/duplicate commands; undo/redo (≥ 50); redo cleared on new command.
  - Tests: unit tests.
- [x] **P3-06 · P0 · Layout persistence.** *Done:* `layout_elements` table, schema v3 + migration test, `DriftLayoutRepository` (+ live `watchElements`), debounced autosave with status and flush on exit.
  - Work: tables `layouts`, `layout_elements`; repository; debounced autosave in a transaction; save status.
  - Tests: repository tests + autosave controller tests (fake clock).
- [x] **P3-07 · P0 · Canvas rendering.** *Done:* `GardenCanvasPainter` (grid by unit system, styles by role, error/warning outlines + badges, handles, size and edge-distance labels, light/dark `CanvasColors`); golden `designer_canvas.png`.
  - Work: painter for grid, boundary, elements, labels, selection, invalid states; cached static layer.
  - Tests: golden tests for fixed layouts.
- [x] **P3-08 · P0 · Gestures.** *Done:* tap select, drag move, corner resize, rotate handle, pan, pinch zoom; hit-tests the touch-down point (gesture slop fix); body beats handles on small objects; no double-tap delay.
  - Work: pan/zoom, tap-select, drag-move, handle resize/rotate, haptics, snapping toggle.
  - Tests: widget tests driving gestures.
- [x] **P3-09 · P0 · Palette (DSN-02) and inspector (DSN-03).** *Done:* grouped palette; inspector with size (cm/in), soil depth, rotation slider, label; live edits.
  - Work: precise numeric edits via DimensionField; bottom sheet on compact, side panel on expanded.
- [x] **P3-10 · P0 · Objects list (DSN-04).** *Done:* list with sizes and problems, edit (opens inspector) and delete without dragging.
- [x] **P3-11 · P0 · Space summary (DSN-05).** *Done:* garden area, container area and share, paths, soil litres, counts by kind, sourced note.
- [x] **P3-12 · P0 · FR-C acceptance scenario.** *Done (host widget test, real gestures):* 3 m × 1.2 m balcony, 3 pots + grow bag, overlap error and fix by drag, rotate, undo/redo, autosave, reopen intact. Verified on the emulator (handles, labels, persistence across app restart).
- [x] **P3-GATE** (2026-10-18). Format clean, analyze clean, 257 host tests.

## Phase 4: Plant catalogue and recommendations

- [x] **P4-DATA-01 · P0 · Catalogue schema.** *Done:* `CatalogueParser` (strict) + `catalogue_test` on the real assets: unique ids, ranges, every citation in `sources.json` and in the provenance register with fetch status F, unverified records carry no figures, no fact without a source.
- [x] **P4-DATA-02 · P0 · Author species.** *Done (25 of ~30):* `assets/catalogue/plants.json` from gardening-references §2b/§2c/§7, verified (F) sources only. 5 records "verified", 19 "partial", 1 "unverified"; proxies and gaps flagged (KI-010..KI-012 still apply). Chilli propagation left null (its transplant age is SS-only).
- [ ] **P4-DATA-03 · P1 · Resolve research gaps** KI-010..KI-013 (IIHR/KVK bulletins, TN kit manual, ASPCA checks, SS re-verification). *Blocks public release, not MVP development.*
- [ ] **P4-DATA-04 · P1 · Licensed plant images.**
  - Work: CC0/CC BY or own photos, WebP ≤ 150KB, `assets/images/ATTRIBUTION.md`; fallback illustrations. *Interim:* category icons and the terrace header photo.
- [x] **P4-01 · P0 · Catalogue loading.** *Done differently (ADR-021):* bundled JSON parsed into memory; no drift import or FTS5 for 25 species. Revisit at a few hundred species or for Hindi search.
- [x] **P4-02 · P0 · Catalogue UI (PLT-01) + plant detail (PLT-02).** *Done:* search by common/local/scientific name, category chips, "Ideas for <garden>" entries; detail with sun, container (evidence badge), harvest, 12-month sowing strips per region, propagation, care notes, pets (ASPCA scope note), sources list, "Not documented" states.
- [x] **P4-03 · P0 · RecommendationEngine (pure).** *Done:* sun, season (state → macro fallback, wraps December), container fit against layout containers, goals; structured reasons and caveats; unknown never counts for or against. *Not used:* effort/experience and style, because no source supports a per-species effort rating.
- [x] **P4-04 · P0 · Recommendations UI (REC-01) + shortlist (REC-03).** *Done:* grouped (good now / sow later / not a good fit), reasons with fit icons, caveat chips, profile-completion prompt, shortlist toggle and filter.
- [ ] **P4-05 · P1 · Compare (REC-02).** Deferred: the reasons on each card cover the MVP need.
- [x] **P4-06 · P0 · Plantings.** *Done:* `plantings` and `shortlist_entries` tables (schema v4, migration tests), add/edit sheet (garden, container from the layout or "not placed", quantity, planted on, started from, notes) with live fit warnings (`PlantingFit`: volume, depth, rough capacity, shared container); My plants on the garden overview with edit/remove. Planting detail (PLT-04) is the plant page plus the edit sheet.
- [x] **P4-GATE** (2026-10-18). Format clean, analyze clean, 323 host tests.

## Phase 5: Care tracking

- [x] **P5-01 · P0 · Recurrence engine.** *Done:* sealed `Recurrence` (`FromCompletion`, `FixedInterval`, `Weekly`, `Yearly`, `Once`) on `LocalDate` (no DST shifts), with tests for month ends, leap days, 29 Feb in common years and year rollover. A separate seasonal-window type wasn't needed; `Yearly` covers the sourced seasonal job.
- [x] **P5-02 · P0 · CarePlanner.** *Done (ADR-022):* sourced defaults only, as listed below. Every task guide shows its sources. Not done: stage-based and container-material modifiers, since there are no numeric sources for them (gardening-references §4c is qualitative).
  - Daily soil check, adapted to the species' `watering` mode (S40).
  - Pest check every 3 days (S32).
  - Feed every 28 days for edibles and flowers (S3, S4).
  - Transplant after the nursery days (S11).
  - Harvest may start at the minimum days to harvest.
  - Jasmine pruning in Tamil Nadu (S18).
- [x] **P5-03 · P0 · Task materialiser.** *Done:* 30-day horizon for fixed rules, one pending task for completion-based rules (counted from the last finished task), unique (ruleId, dueOn), idempotent. `CareSync.reconcile` back-fills plans for existing plantings.
- [x] **P5-04 · P0 · Task actions.** *Done:* complete (with note), skip (reason), reschedule. Completion-based rules recalculate from the finish date; disabling or changing a rule replaces its pending tasks. Not done: a photo on completion, which moves to the Phase 6 journal.
- [x] **P5-05 · P0 · Today agenda (HOME-01).** *Done:* overdue, today (grouped by type with "Mark all done"), done today, next 7 days; skip reasons; move to tomorrow or a date; how-to guide; refresh on resume.
- [x] **P5-06 · P1 · Calendar view (CARE-02)** and per-planting care plan editor (CARE-04). *Done:* the care plan editor from My plants, and a month calendar from Today (task counts per day, the day's tasks, at least 48 dp day cells on phones).
- [x] **P5-07 · P0 · NotificationPlanner (pure) + scheduler adapter.** *Done:* daily digest only (14-day horizon, cap 50, stable ids per day), a diff against `scheduled_notifications`, and `LocalNotificationScheduler` (inexact, no exact-alarm permission). Not done: per-task reminders and quiet hours; the single digest time covers the MVP.
- [x] **P5-08 · P0 · Notification permission flow (CARE-05).** *Done:* Settings → Reminders. Permission is asked when the user turns the digest on; a denial is explained; there is a time picker. Android channel `care_digest`, plus manifest receivers and desugaring. A notification tap opens the app on Today (no per-task deep link, KI-028).
- [x] **P5-09 · P0 · Integration test:** add plant → care plan → complete task → next task recalculated → notification planned. *Done:* host (`today_flows_test`, `care_sync_test`) and device (`integration_test/garden_setup_test.dart`: soil check on Today, mark done, digest pending with the platform via `pendingNotificationRequests`, restart).
- [x] **P5-GATE** (2026-10-18). Format clean, analyze clean, 388 host tests, device integration test passed (after an emulator cold boot).

## Phase 6: Progress and refinement

- [x] **P6-01 · P0 · Journal entries (JRN-01/02).** *Done:* entries with up to 6 photos (stored in the garden's photo folder), note, plant, milestone and harvest amount (schema v6). The timeline merges entries with completed care by day and filters by garden and plant. Entries can be deleted with their files and added from My plants. Not done: editing an entry, and a photo on task completion.
- [x] **P6-02 · P1 · Photo comparison (JRN-03) and stats (JRN-04).** *Done:* a stats panel on the journal (care tasks done, day streak that survives the morning, entries, photos, harvest totals per unit) and a compare screen (pick two photos; side by side, oldest first, dated). *Not done:* achievements; plain counts only, so nothing feels like judgement.
- [x] **P6-03 · P1 · Data export** (ZIP JSON + photos) and **P0** delete all data. *Done:* Settings → Your data → Export my data builds `data.json` (every user table) plus the photos into a ZIP and opens the share sheet (ADR-024). *Delete all data (P0):* Settings → Your data → Delete all data. It cancels notifications, deletes all rows and photo files, resets settings and returns to onboarding.
- [ ] **P6-04 · P1 · "Start from a kit" preset** (S1). Requires KI-014 verification.
- [x] **P6-05 · P0 · Accessibility audit.** *Done:* `test/a11y/accessibility_test.dart` runs Flutter's guidelines on every main screen with realistic data, in light and dark: Android and iOS tap targets, labelled tap targets, text contrast. There is also a 200%-text overflow walk on a 360 dp phone. It found two contrast issues, both fixed: journal date headers on the photo, and the garden title over a shorter header. Canvas parity: the objects list (P3-10).
- [ ] **P6-10 · P1 · Branding.** App name, launcher icon and splash screen (the default Flutter splash still shows at launch). Needs PD-001 (name).
- [x] **P6-06 · P0 · Responsive pass.** *Done:* `test/app/responsive_test.dart` at 840×1180, 1280×800 and 800×360: navigation rail, no layout errors, and list content centred at a readable width (`AppSpacing.contentInsetFor`). Photo headers are capped at 40% of the height, a fix for landscape phones found by the test. No custom motion exists beyond Material defaults, so reduced motion follows the platform.
- [~] **P6-07 · P0 · Performance profiling.** *Done (host):* budget tests in `test/perf/` with the numbers recorded in KI-029. *Open:* a profile-mode run on a real device.
- [x] **P6-08 · P0 · End-to-end integration suite.** *Done:* `integration_test/garden_setup_test.dart` runs one journey on the Android 16 emulator: onboarding → garden → plant from ideas → restart → soil check on Today, done → daily digest scheduled with the platform → plant still listed → designer (size prompt, add a pot, autosave) → journal entry next to completed care. Passed (21 s) after an emulator cold boot.
- [x] **P6-09 · P1 · User-testing kit.** *Done:* `docs/product/user-testing-kit.md` (recruiting, tasks mapped to assumptions A1–A6 and risks, debrief, measures). Distribution is a debug APK until signing and branding exist (P6-10).
- [x] **P6-11 · P0 · Import boundaries (KI-025).** *Done (ADR-023):* per-feature public API files, with an architecture test that also checks domain purity.
- [ ] **P6-GATE** MVP ready for user feedback. *Status 2026-10-18:* every P0 is done except the device half of P6-07 (profile-mode run on a real phone). The build is ready for **moderated** testing with the kit; the gate stays open until P6-07 is complete.

## Redesign: Living Terrace (2026-10, ADR-025, ADR-026)

User feedback on the photo-and-glass look: "looks like an AI generated app". Direction C, "Living Terrace", was chosen from mockups (`docs/design/redesign-living-terrace.pdf`) and built in steps.

- [x] **R-01 · Foundation.** Palette (limestone, neem, leaf, terracotta, haldi, water, dusk), Young Serif + Schibsted Grotesk (bundled OFL), solid paper surfaces, solid navigation bar. Contrast tests updated. (`004e2af`)
- [x] **R-02 · Plant art.** `PlantArtSpec` for all 25 species (top and side views, terracotta or grow-bag pot), with a golden. (`ce5833d`)
- [x] **R-03 · Terrace plan.** `TerracePlan` draws the real layout to scale with plants, due/done badges, tags, fit states and a dusk mode; each container is a labelled 48 dp button. (`ce5833d`)
- [x] **R-04 · Navigation, Today, soil check, Seasons.** Tabs Today · Plants · Seasons · Journal; gardens from Today with a switcher. Today: job headline, plan with pins, tasks grouped by kind. Soil-check sheet with "dry, I watered" / "still moist" answers. Seasons tab with sow-now card and almanac. (`6111502`)
- [x] **R-05 · Plant detail, ideas, add plant.** Illustrated hero, sourced journey (`PlantJourney`), care rhythm; ideas shelf with a featured best match; "Which container?" picker on the plan (`ContainerVerdict`). ARB duplicate-key test added. (`2e58558`)
- [x] **R-06 · Journal, welcome, garden overview.** Then-and-now photos, timeline rail; welcome with a sample terrace (fixed invisible title); garden overview with its own plan as hero (fixed collapsed white title). (`0525b90`)
- [x] **R-07 · Docs.** ADR-025, ADR-026, design-system v0.3, screen inventory, known issues KI-030..KI-033.
- [ ] **R-08 · Follow-ups (P1).** Persist the selected garden (KI-030); evening headline naming the plant still waiting; vertical current-month band in the Seasons almanac; plant names in TerracePlan tags for long names; moderated user test of the new design.

## Phase 7: Advanced (each needs value, cost and plan before starting)

- [ ] P7-01 Weather-aware care via `WeatherService` (Open-Meteo; licence/commercial check, ADR-020)
- [ ] P7-02 Hindi localisation (UI + catalogue names)
- [ ] P7-03 Cloud sync and accounts (Supabase, optional PowerSync; tombstones/owner migration; ADR-013)
- [ ] P7-04 AI diagnosis/identification via server proxy (ADR-019)
- [ ] P7-05 Photo-assisted layout (trace over photo, user calibration); AI concept renders labelled "not to scale"
- [ ] P7-06 Shopping list / bill of materials, partner nurseries
- [ ] P7-07 Non-rectangular boundaries; companion-planting hints (sourced)
- [ ] P7-08 Household sharing; Care Share-style plant-sitter mode
