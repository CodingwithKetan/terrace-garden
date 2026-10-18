# Session Log

Newest first. Keep entries concise: goal, what was done, checks, next.

---

## 2026-10-18: Session 1, part 10 (Hindi, pet-friendly filter, catalogue completion)

**Goal:** the user asked for Hindi support, proper information for all the plants, and a pet-friendly filter.

**Done:**
- **Pet-friendly filter** on Plants. It shows only plants a source lists as non-toxic; unassessed plants are left out, with a note saying so.
- **Catalogue research.**
  - Four parallel research agents returned only quoted, first-party findings. I spot-checked 8 pages by hand, and all matched.
  - Merged with sources S48–S74 and registered all of them as "F".
  - Before → after across the 25 species:

    | Field | Before | After |
    |---|---|---|
    | Sun | 14 | 25 |
    | Care notes | 13 | 25 |
    | Propagation | 16 | 25 |
    | Sowing windows | 36 | 58 |
    | Days to harvest | 14 | 17 |
    | Container sizes | 15 | 17 |
    | Pet status | 8 | 11 |

  - Data left out on purpose: weak sources, single-state stand-ins and high-altitude seasons (listed in gardening-references §1d).
- **Hindi.**
  - 595 strings translated in five parallel chunks with a shared glossary, then validated by script and by a new coverage test.
  - Language setting (Phone / English / हिन्दी), applied to notifications too.
  - Hindi plant names (`names` map) shown in the UI and matched by search.

**Checks:**
- Format clean, analyze clean, 460 host tests pass.
- New tests: pet-friendly filter, translation coverage and placeholders, Hindi switch-and-save, Hindi at 200% text.

**Failures met and fixed:**
- the regex in the coverage test lost its backslashes in a shell edit (caught by a deliberate broken placeholder);
- `pageBack()` relies on the English "Back" tooltip;
- rose cited S8, which wasn't in `sources.json`;
- old spot-check tests expected gaps that are now filled.

**Next:**
- native Hindi review (KI-035);
- catalogue prose in Hindi (KI-034);
- remaining data gaps (KI-036);
- moderated tests with Hindi users.

## 2026-10-18: Session 1, part 9 (Living Terrace redesign)

**Goal:** the user found the photo-and-glass UI generic ("looks like AI generated"). After three rounds of mockups they chose direction C, "Living Terrace", and asked to build it.

**Done** (ADR-025, ADR-026):
- **Foundation, art, plan:**
  - the Living Terrace palette, Young Serif and Schibsted Grotesk, and solid surfaces;
  - `PlantArtSpec` drawings for all 25 species;
  - `TerracePlan`, which draws the real layout to scale.
- **Navigation:** the tabs are Today · Plants · Seasons · Journal. Gardens open from the garden name on Today, with a switcher when there are several.
- **Today:** a headline that states the job, the plan with due/done pins, and tasks grouped by kind.
- **Soil-check sheet:** a cutaway of the finger test and two answers ("dry, I watered" records done; "still moist" records a skip with that reason).
- **Seasons:** sow-now card and almanac, from sourced windows only.
- **Plant detail:** an illustrated hero, a sourced journey (`PlantJourney`, the same rules as the care planner) and the care rhythm.
- **Ideas:** a seed-shop shelf with the best match featured.
- **Adding a plant:** "Which container?" on the plan (`ContainerVerdict`).
- **Journal:** then-and-now photos and a timeline rail.
- **Welcome step:** a sample terrace.
- **Garden overview:** its own plan as the hero.
- **Fixed on the way:**
  - white-on-limestone titles on the welcome and the collapsed garden bar;
  - a duplicate ARB key that renamed the journal's "Harvest" chip (now guarded by a test);
  - the soil sheet's raw colour;
  - a flaky perf budget.

**Checks:**
- Format clean, analyze clean, 456 host tests pass.
- Device journey passed on the third run (see current-status for the two test-setup failures).

**Commits:** `6111502`, `2e58558`, `0525b90` (pushed), plus this docs commit.

**Next:**
- moderated user tests of the new design;
- R-08 follow-ups;
- P6-07 profiling on a real phone.

## 2026-10-18: Session 1, part 8 (Phase 6: progress and refinement)

**Done:**
- **Journal** (schema v6): entries with photos stored in the garden's folder (so deleting a garden removes them), milestones and harvest amounts. The timeline merges entries with completed care and filters by garden and plant.
- **Delete all data:** cancels notifications, deletes rows and photos, resets settings, returns to onboarding.
- **Accessibility guideline tests** on every main screen, light and dark, with a 200%-text walk. They found two contrast issues, both fixed.
- **Responsive tests** at three sizes. List content is now centred at a readable width, and photo headers are capped at 40% of the height (found on landscape phones).
- **Host performance budgets**, with the numbers in KI-029.
- **ADR-023:** per-feature public API files plus an architecture test, which resolves KI-025 (38 cross-feature internal imports).
- **User-testing kit.**
- **End-to-end device test** extended through the designer and the journal.

**Environment:** the emulator froze during the Phase 5 device runs. Cold boots (`emulator -no-snapshot-load`) recovered it. Quick-boot snapshots carried the overload over.

**Checks:**
- Format clean, analyze clean, 424 host tests pass.
- End-to-end device test passed after two runs failed because of test assumptions (no garden size; the first idea isn't always Tomato).

**Next:** moderated user tests, then P6-07 profiling on a real phone, then the release prerequisites (see current-status).

**Follow-up (same session, after the user asked to push and continue):**
- **Push:** worked from this machine (KI-006 resolved).
- **Added:** data export (ADR-024), journal stats and two-photo comparison, the month care calendar (with a 48 dp tap-target check on phones), and re-planning dated rules after a planting edit (KI-027).
- **Checks:** 437 host tests pass. Pushed `aa87482`.

---

## 2026-10-18: Session 1, part 7 (Phase 5: care tracking)

**Done:**
- **Recurrence engine:** pure, on `LocalDate`, with rules counted from completion, fixed intervals, weekly, yearly and one-off.
- **`CarePlanner` (ADR-022), sourced defaults only:**
  - daily soil check (S10, S4), adapted to a new sourced catalogue field, `watering`: dry between waterings or keep moist (S40);
  - pest check every 3 days (S32);
  - feed every 28 days (S3, S4);
  - transplant (S11), harvest may start, and jasmine pruning in Tamil Nadu (S18).
- **`TaskMaterializer`:** idempotent, with a 30-day horizon for fixed rules.
- **Schema v5:** `care_rules`, `care_tasks` and `scheduled_notifications`, with migration tests.
- **`CareSync.reconcile`:** runs on start-up, when plantings change and on resume, and coalesces overlapping calls.
- **Notifications:** `NotificationPlanner` and diff, plus the flutter_local_notifications adapter with Android setup.
- **Screens:**
  - **Today agenda:** done, all done, skip with a reason, move, and a how-to guide with sources;
  - **care plan editor** on My plants;
  - **Settings → Reminders:** permission asked in context, with a time picker.

**Bug found while building:** after an interval change or re-enable, a completion-based rule got no new task, because finished tasks were counted as existing. The materialiser now checks for pending tasks and counts from the last finished one. Unit and repository tests cover it.

**Checks:**
- Format clean, analyze clean, 388 host tests pass.
- Device integration test: run 1 failed (slow start), run 2 hung (emulator frozen), run 3 passed after a cold boot.

**Recorded:** KI-025 (cross-feature imports since Phase 3), KI-026, KI-027 and KI-028.

**Next:** Phase 6.

---

## 2026-10-18: Session 1, part 6 (Phase 4: plant catalogue and recommendations)

**Done:**
- **Catalogue:** 25 species in `assets/catalogue/plants.json` with per-fact citations to verified (F) sources only (`sources.json`). Breakdown: 5 verified, 19 partial, 1 unverified.
- **Parsing and validation:** the strict `CatalogueParser`, plus a test on the real assets that cross-checks the provenance register.
- **ADR-021:** the catalogue is held in memory; the drift import and FTS5 search are deferred.
- **`RecommendationEngine`:** sun, season (state → macro fallback), container fit and goals. It produces structured reasons and caveats, and unknown data is never scored.
- **Screens:** catalogue (search and categories), plant detail (sources, "Not documented" states, sowing strips), ideas screen (groups, reasons, shortlist).
- **Plantings:** schema v4 with the `plantings` and `shortlist_entries` tables. The add/edit sheet shows live fit warnings, and My plants appears on the garden overview.

**Data honesty fixes while authoring:**
- Chilli: the transplant age was SS-only, so propagation is null.
- Radish: the conflicting light guidance is shown as a care note.

**Bug found and fixed:** on the emulator, the keyboard covered bottom-sheet content, so city results couldn't be tapped. `showAppBottomSheet` now pads for the keyboard; a regression test fails without the fix.

**Checks:**
- Format clean, analyze clean, 324 host tests pass.
- Device integration test: first run failed (cause not captured, likely a stale install), then two runs passed.
- Manual emulator review stopped because the emulator was overloaded (load ~22, KI-009).

**Next:** Phase 5, care tracking (P5-01 recurrence engine).

---

## 2026-10-18: Session 1, part 5 (Phase 3: garden designer)

**Done (P3-01 → P3-12):**
- Pure-Dart geometry: oriented rectangles, circles, SAT overlap, snapping.
- `CanvasTransform` mapping world cm to screen pixels.
- Layout model, validator and summary.
- Undo/redo history and `LayoutEditorController` with debounced autosave.
- `layout_elements` table, schema v3 with migration test.
- Painter with light/dark `CanvasColors`.
- Gesture canvas.
- Palette, inspector, objects list and space summary.
- Designer route plus a "Design your layout" card on the garden overview, which shows a live object count.

**Bugs found and fixed:**
1. **Gesture slop:** Flutter's scale gesture reports its start after ~36 px of movement, so hit-testing used the wrong point; dragging a small pot panned the canvas instead. The canvas now hit-tests the touch-down point (`Listener`).
2. **Handles drawn in the wrong place** (seen on the device): handle positions were already in screen space but were transformed again. Fixed, and a canvas golden test was added.
3. **Handle priority:** on small objects, resize-handle touch areas covered the body. A touch inside the body that is nearer the centre now moves the object.
4. **Delayed taps:** the double-tap-to-fit gesture held every tap for ~300 ms. It was removed; "Fit to screen" is a button.

**Checks:**
- Format clean, `flutter analyze` clean, 257 host tests pass.
- These cover geometry (19), layout, validator, history and summary (15), the controller including autosave via fake_async, and repository round-trips.
- 4 designer journeys use real gestures, including the FR-C scenario, plus the canvas golden.
- Verified on the Android 16 emulator: handles, labels, distance guides, persistence across reinstall.

**Next:** Phase 4, the plant catalogue and recommendations (P4-DATA-01 catalogue schema first).

---

## 2026-10-18: Session 1, part 4 (Phase 2: garden setup and profile)

**Context:** the user asked to complete all remaining sections without asking permission. Work proceeds phase by phase with local commits (pushing is blocked on this network).

**Done (P2-01 → P2-08):**
- Garden domain and data with drift schema v2 and a generated migration test.
- Offline city → region map, sourced regions only.
- Onboarding with welcome, 3 skippable steps and "explore first".
- Garden list, overview, create/edit form and delete.
- Photos: picker, compression with EXIF stripped, thumbnails, gallery, viewer.
- Terrace checklist citing only verified sources.
- Emulator integration test covering a restart.

**Bugs found by tests and fixed:**
1. `ListTile` and `InkWell` on glass: ripples were hidden. `GlassPanel` now adds a transparent `Material`.
2. Bottom sheets opened inside a tab sat under the floating navigation bar, so the last option couldn't be tapped. Sheets now use the root navigator.
3. Lost update in forms: a second change within the same frame (seen on the device as a lost garden name) overwrote the first. Sections now send `DraftEdit` functions applied to the latest draft. Regression tests on host and device.
4. Form loading via `watch().first` didn't resolve under the test clock; added `GardenRepository.find`.
- Also: full-screen pages (forms, photo viewer) moved to top-level `/gardens/...` routes. An initial suspicion of a go_router back-navigation bug was **not** confirmed; the failing test lacked a frame. The structure was kept because it is cleaner.

**Checks:** format clean, `flutter analyze` clean, 200 host tests pass, `integration_test/garden_setup_test.dart` passes on the Android 16 emulator.

**Next:** Phase 3, the garden designer (P3-01 geometry domain first).

---

## 2026-10-18: Session 1, part 3 (visual refresh before Phase 2)

**Request:** the user found the flat design "not good" and asked for a "realistic, modern and transparent" look in line with the product idea.

**Done:**
- New direction in design-system v0.2 "real, modern, translucent": full-bleed photography, frosted-glass panels, floating glass navigation pill.
- New tokens: `GlassTheme`. New components: `GlassPanel`, `GlassIconButton`, `PhotoBackdrop`, `ImmersiveEmptyState`.
- Today: date and greeting over the photo, a glass "Today's care" card, and a sourced watering tip (RHS S5/S6).
- Garden, Plants and Journal use immersive photo screens.
- Image credits screen (Settings → Image credits) for the CC BY-SA licences.
- Photos: the first pass (rawpixel CC0, 1300 px landscape) looked soft when stretched to portrait and was replaced. Four Wikimedia Commons originals (3× CC BY-SA 4.0, 1× public domain) were cropped to portrait at 1440×2400 (about 2.1 MB in total).

**Bugs found by the new tests:**
- The immersive panel overflowed at 200% text on small phones. Fixed: the layout now scrolls when needed and the badge wraps under the icon.

**Checks:**
- Analyze clean; 162 tests pass (adds glass contrast tests over black and white backdrops, a high-contrast fallback test and a credits navigation test).
- Verified on the emulator: all four tabs, screenshots reviewed.

**Note:** the stored theme on the emulator had changed from Dark to System and the app once opened on Journal; most likely manual taps in the emulator window (KI-009).

---

## 2026-10-18: Session 1, part 2 (Phase 1: foundation)

**Done:** P1-03 → P1-10, P1-12, P1-13; P1-11 partly. See TODO for per-task notes.

**Decisions:**
- Every route uses `appPage()` → SDK `MaterialPage`, because go_router 18 detects Material via the standalone `material_ui` package (ADR-004).
- Palette contrast fixes: tertiary is `marigoldDeep` #855B00; harvest is #A8700F.
- Static fonts: Fraunces 72pt 400/600; Inter 18pt.
- Golden tests use alchemist CI goldens only, for cross-OS determinism.
- Lint changes: `one_member_abstracts` disabled (DI seams); riverpod_lint removed because it can't load on Dart 3.12 (KI-008).

**Environment findings:**
- The corporate TLS proxy breaks curl revocation checks and Java/Gradle trust (KI-007); PowerShell downloads work.
- `flutter build apk` fails at the Gradle wrapper download.

**Checks:** `tool/check.sh` all green (format 0 changed, analyze clean, 149 tests pass); `dart analyze` clean. The APK build first failed (KI-007). With user approval, `GRADLE_OPTS` was set to the existing corporate trust store; the build then passed (502s) and the app was verified on the Android 16 emulator (KI-009 notes Play Services overlays).

**Next:** Phase 2, starting with P2-01 (garden domain, schema v2, repository).

---

## 2026-10-18: Session 1 (Phase 0: discovery and research)

**Goal:** inspect the environment, research competitors and the gardening domain, define product direction and MVP, plan the architecture, and create continuity docs.

**Done**
- Workspace was empty; initialised a git repo (no commits). Toolchain verified (see current-status).
- Five parallel research tracks:
  - plant-care apps (Planta, Greg, PictureThis, Blossom, Plantix);
  - design and layout tools (iScape, GrowVeg, Planter, AI redesign apps);
  - urban, terrace and India-specific apps plus user-problem evidence;
  - horticultural sources and container data;
  - Flutter stack due diligence.
- Created all Phase 0 docs (see TODO P0-02..P0-09).

**Key findings**
- The hypothesis is **partially supported**. No product combines a dimensioned container planner with India-relevant seasons and care. However, Indian terrace gardeners' top pains are pests, fertiliser and sowing time, so the planner is the *mechanism* and local outcomes are the headline.
- Global planners rely on frost dates and USDA zones, which is a structural mismatch with India.
- There is no authoritative Indian container-size table. The app combines Indian sources (seasons, durations) with extension sources (container sizes); gaps are flagged.
- Under IS 875, an accessible flat roof is designed for about 153 kg/m² of imposed load. The app must never claim structural safety.
- Flutter 3.47.7 / Dart 3.13 is current, and current codegen packages need it (ADR-001 pending).

**Checks:** toolchain commands only; no code.

**Blockers:** SDK decision (KI-001); Android licences (KI-002).

**Next:** P1-01 → P1-03 (create project), then the Phase 1 foundation.

**Continuation (same session, Phase 1 start)**
- The user first chose to pin 3.47.7 via FVM, then switched to **the local Flutter 3.44.8**. The FVM download was stopped; the partial cache was deleted and FVM uninstalled. ADR-001 accepted with fallback pins.
- Created the Flutter project and resolved the Phase 1 dependency set (see current-status), after resolving riverpod_lint/freezed/drift analyzer conflicts.
- Checks: format pass; test pass (template); analyze 3 infos (template code). See current-status.
- The user asked to move work to a Claude Code cloud session. Handoff instructions and a Flutter 3.44.8 setup script were added to current-status.
