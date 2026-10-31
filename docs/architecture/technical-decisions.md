# Technical Decisions (ADR log)

Status: v1.0 (Phase 0, 2026-10-18). Each decision lists context, decision, alternatives and consequences. Package versions were verified on pub.dev on 2026-10-18, and dependency resolution was tested locally on Flutter 3.44.8 and on a scratch Flutter 3.47.7. Full due-diligence notes, with sources, are in the Phase 0 research report, summarised here.

Change process: add a new ADR (or mark one *Superseded by ADR-0xx*) instead of silently editing past decisions.

---

## ADR-001: Flutter SDK version — **ACCEPTED 2026-10-18: use the locally installed Flutter 3.44.8 / Dart 3.12.2**
- **Outcome:** the user chose the installed global SDK (`C:\src\flutter`, 3.44.8 stable). A brief FVM/3.47.7 attempt was cancelled and fully cleaned up. Dependencies use the **fallback pins below**, verified to resolve on 3.44.8. Revisit when upgrading to 3.47+/3.50; at that point, migrate to the `material_ui` package and bump the codegen packages together.
- *Original analysis retained below for the future upgrade.*
- **Context:** Flutter 3.44.8 / Dart 3.12.2 is installed (global, `C:\src\flutter`). Flutter **3.47** (Dart 3.13) shipped 2026-08-12; the latest patch is **3.47.7**. 3.50 is due in November 2026. The current releases of freezed (4.x), drift_dev (2.35), riverpod_lint (3.1.9), very_good_analysis (11) and google_fonts (9) require Dart 3.13. On 3.44 the solver falls back to drift 2.31, freezed 3.2.5 and riverpod 3.2, about four drift minor releases behind.
- **Decision (proposed):** target **Flutter 3.47.7 / Dart 3.13**, pinned per project. Preferred mechanism: a project-pinned SDK (FVM `.fvmrc`, or a documented `flutter --version` check in CI) so other projects on this machine keep using 3.44.8. Plan a move to 3.50 after its first hotfix.
- **Notable 3.47 changes:**
  - iOS minimum 15; Android minSdk 24, compile/target SDK 36, AGP 9.1, Gradle 9.3.1, Java 17.
  - Material/Cupertino are moving to the standalone `material_ui` / `cupertino_ui` packages (migration: `dart fix --apply --code=migrate_design_widgets`).
  - UIScene lifecycle on iOS; prefer Swift Package Manager plugins.
- **Fallback:** if the upgrade is declined, use these verified pins for 3.44.8: freezed 3.2.5 (exact), riverpod 3.2.x, riverpod_generator 4.0.3, riverpod_lint 3.1.3, drift/drift_dev 2.31.0, json_serializable 6.13.0, very_good_analysis 10.3.0.

## ADR-002: Architecture style: feature-first, layered, MVVM-shaped
- **Decision:** organise feature-first modules (`lib/features/<feature>/{domain,data,application,presentation}`) plus `lib/app` (composition: router, theme, DI) and `lib/core` (cross-cutting). This follows the official Flutter app-architecture guide: a data layer with repositories, ViewModels for UI logic, unidirectional data flow, immutable models, and fakes for tests. The domain layer is used because our rules (geometry, recommendations, scheduling) are complex enough to justify one.
- **Rules:** see `system-architecture.md` §3 (dependency rules).
- **Alternatives:** layer-first folders (scale poorly); a full Clean Architecture use-case class per action (too much ceremony; use-case classes are added only where logic spans repositories).

## ADR-003: State management and DI: Riverpod 3 (+ codegen); ChangeNotifier for the canvas
- **Decision:** `flutter_riverpod` 3.x, `riverpod_annotation`, `riverpod_generator`, `riverpod_lint` (versions as resolved on Flutter 3.44: roughly riverpod 3.2, generator 4.0.3, lint 3.1.3).
  - Notifiers/AsyncNotifiers act as ViewModels.
  - Providers expose abstract repositories and services (compile-safe DI, `overrideWith` for tests, auto-dispose, families keyed by IDs).
  - Drift `watch()` streams feed `StreamProvider`s.
- **Canvas exception:** the designer's interactive state (selection, drag, undo/redo) lives in a plain `ChangeNotifier` controller that drives `CustomPainter(repaint:)`, for 60fps without provider rebuilds. The controller itself is provided via Riverpod.
- **Not used:** Riverpod *experimental* offline persistence and mutations. Drift is the source of truth; user actions use our own small `Command` pattern.
- **Alternatives:**
  - provider + ChangeNotifier: officially recommended, but we would hand-roll async, error and scoping.
  - Bloc: solid but more boilerplate, and it still needs DI.
  - signals: smaller ecosystem.
  - get_it: a service locator, avoided per project rules.
- **Consequences:** analyzer-major lockstep with other generators (see ADR-006); upgrade codegen packages together.

## ADR-004: Routing: go_router 18
- **Decision:** `go_router ^18.1.0`.
  - `StatefulShellRoute.indexedStack` for the four tabs (Today, Garden, Plants, Journal).
  - Full-screen routes for the designer and the onboarding flow.
  - A `redirect` for first-run onboarding.
  - Route constants and path params; no codegen initially.
  - Notification taps deep-link (e.g. `/tasks/:taskId`).
- **Notes:** go_router is first-party and "feature-complete" (bug-fix mode), which we treat as stability.
- **Material page caveat (Flutter 3.44):** go_router 18 depends on the standalone `material_ui` package and detects Material apps by *that* package's `MaterialApp` type. Our app uses the SDK's `package:flutter/material.dart`, so go_router's default `builder:` would fall back to pages with no transitions. **Rule:** every route uses `pageBuilder` via our `appPage()` helper, which returns the SDK `MaterialPage`. Revisit when migrating to `material_ui` with the SDK upgrade.
- **Alternative:** auto_route (actively developed, but adds another code generator).

## ADR-005: Local persistence: drift (SQLite) + shared_preferences for settings
- **Decision:**
  - `drift` + `drift_flutter` (dev: `drift_dev`), version as resolved on Flutter 3.44 (about 2.31 with freezed 3.2.5), for all domain data: relational, transactional, reactive streams, versioned migrations with schema snapshots, FTS5 for catalogue search.
  - `shared_preferences` (`SharedPreferencesAsync`) only for small UI settings and onboarding flags.
- **Tests:** `NativeDatabase.memory()`, with the executor injected.
- **Risk:** sqlite3 3.x now builds or downloads SQLite through Dart build hooks. Verify Android builds and Windows host tests in Phase 1, week 1.
- **Rejected:**
  - Isar: the original is unmaintained.
  - Hive/hive_ce and sembast: not relational.
  - ObjectBox: native binary; sync is a paid add-on.
  - sqflite: no typed queries or streams.

## ADR-006: Models and codegen: freezed + json_serializable; drift data classes where sufficient
- **Decision:** `freezed 3.2.5` (exact pin on Flutter 3.44, per ADR-001; 4.x after the SDK upgrade) + `freezed_annotation ^3.1.0` + `json_serializable ^6.13.0`, used for:
  - domain entities and value objects that need `copyWith` and equality;
  - sealed unions (layout element kinds, recurrence, recommendation reasons).
  Use Dart `switch` pattern matching (not legacy `when`/`map`). Use drift-generated data classes directly where the domain model would be identical. `build.yaml` `generate_for` globs keep builds fast.
- **Context:** Dart macros were cancelled (January 2025); augmentations have not shipped. Dart 3.13 primary constructors reduce boilerplate for simple classes.
- **Consequence:** freezed 4.x needs Dart 3.13, so stay on 3.2.5 until the SDK upgrade. If build times hurt, simple value objects can move to hand-written classes with primary constructors.

## ADR-007: Photos: image_picker + flutter_image_compress, files on disk, relative paths
- **Decision:**
  - `image_picker ^1.2.4` (Android Photo Picker, iOS PHPicker), `path_provider`, `flutter_image_compress ^2.5.1`, `uuid`.
  - Pipeline: pick → compress to JPEG (~2048px long edge, q80, orientation applied, **EXIF/GPS stripped** for privacy) → 400px thumbnail. Compression runs in a background isolate.
  - Files go in `<appDocs>/photos/<gardenId>/<uuid>.jpg`; the DB stores **relative** paths only.
  - Handle `retrieveLostData()` on Android.
- **Later:** the `camera` package only for a progress-photo "ghost overlay".

## ADR-008: Notifications: flutter_local_notifications, inexact, rolling-window planner
- **Decision:** `flutter_local_notifications ^22.3.2`, `timezone`, `flutter_timezone`.
  - **Inexact** scheduling (`inexactAllowWhileIdle`). We do **not** declare `USE_EXACT_ALARM`; Play policy restricts it to alarm and calendar apps. An optional user-granted `SCHEDULE_EXACT_ALARM` can be added later.
  - **Daily digest first.** Per-task reminders are optional.
  - A pure-Dart `NotificationPlanner` computes the desired set from pending tasks, then diffs it against the `scheduled_notifications` table (cancel stale, schedule missing). It is idempotent, capped at about 50 pending to stay under iOS's 64-notification limit, and re-runs on app start, resume, task change and timezone change.
  - The notification permission (Android 13+) is requested in context.
- **Risks:** OEM battery optimisers. Mitigation: the in-app agenda is the source of truth, plus a help screen.

## ADR-009: Recurrence: hand-rolled domain engine
- **Decision:** a sealed `Recurrence` model (every N days *from completion* or *fixed calendar*, weekly, seasonal window, one-off) with a pure `nextOccurrence` / `occurrencesBetween` function. Tasks are materialised for a rolling window (~30–60 days).
- **Why:** RRULE cannot express completion-relative intervals (watering), and the `rrule` package is UTC-only with a single maintainer.
- **Later:** an RRULE string export may be added for iCal interop.

## ADR-010: Testing stack
- **Decision:** `flutter_test`; fakes first; `mocktail ^1.0.5` when needed (no codegen); drift in-memory DB; `alchemist ^0.14.1` for goldens (CI-stable goldens, because rendering differs between Windows and Linux); `integration_test` for journeys; `patrol` later for native dialogs and notifications. A `Clock` abstraction (or `package:clock`) and an ID generator make tests deterministic. Details: `docs/quality/testing-strategy.md`.

## ADR-011: Lints: very_good_analysis + riverpod_lint
- **Decision:** `very_good_analysis ^10.3.0` (11.x needs a newer SDK), with `public_member_api_docs` disabled for app code and `one_member_abstracts` disabled (deliberate single-method DI interfaces, ADR-018). Generated files are excluded. Any `// ignore:` needs a justification comment.
- **riverpod_lint: deferred.** On Flutter 3.44 the analysis server needs `analysis_server_plugin ^0.3.8`, which riverpod_lint 3.1.3 (the newest compatible with the pinned codegen set) cannot satisfy. The plugin failed to load, so it was removed on 2026-10-18 rather than left silently inactive. Re-add it (`plugins: riverpod_lint: <version>`) with the SDK upgrade, and verify it with a deliberate violation (e.g. `runApp` without `ProviderScope`).

## ADR-012: Typography and icons: bundled fonts, Material Symbols
- **Superseded in part by ADR-025 (2026-10):** the bundled fonts are now YoungSerif and Schibsted Grotesk; the "bundle, no runtime fetching" rule stands.
- **Decision:**
  - Bundle *Fraunces* and *Inter* (OFL) as assets, declared in `pubspec.yaml` `fonts:`. No runtime font fetching, and no `google_fonts` dependency.
  - Register the font licences with `LicenseRegistry`.
  - Icons come from the built-in Material icons plus `material_symbols_icons` for garden glyphs (`potted_plant`, `water_drop`, `compost`, `grass`) with fill variation.
  - Canvas objects are painted, not icon glyphs.
- **Rejected:** phosphor_flutter (stale).

## ADR-013: Backend: none in the MVP; sync-ready design; Supabase later
- **Decision:**
  - **MVP is fully local.** Sync-readiness rules: client-generated UUIDs; `createdAt`/`updatedAt` (UTC) on every user table; photos referenced by UUID.
  - Tombstones (`deletedAt`), `ownerId` and an outbox are added by migration when sync starts (decision revisited then).
- **Later (Phase 7):** **Supabase** (Postgres + Auth + Storage + Edge Functions).
  - Why Supabase: relational parity with drift, RLS for per-user and household access, SQL portability and self-hosting (lowest lock-in), and Edge Functions as the **server-side proxy for AI and weather keys** (secrets never ship in the app).
  - Optionally **PowerSync** for bidirectional offline sync into drift (its drift integration is beta).
  - Upgrade to Supabase Pro before launch: free projects pause after a week of inactivity and have no backups.
- **Alternatives:**
  - Firebase: offline cache built in, but its document model mismatches our relational data, Storage needs the Blaze plan, and lock-in is higher.
  - ElectricSQL: no first-party Dart client.
- **Data rights:** export (ZIP of JSON + photos) and delete-all are built locally in the MVP. Server-side deletion uses cascade deletes plus Storage cleanup via an Edge Function.

## ADR-014: Plant catalogue: bundled, curated, cited dataset
- **Decision:**
  - A hand-authored, versioned JSON catalogue (~30 species in the MVP) is imported into drift on first run and on catalogue version bump.
  - Every field carries `sourceIds` from `docs/research/gardening-references.md`. Unsourced values are `null` and flagged as unverified.
  - Wikidata (CC0) and POWO/WCVP IDs are used for taxonomy and vernacular names only.
  - A validation test enforces the schema and that every source ID resolves.
- **Rejected:**
  - Perenual: no citations; commercial use requires a paid plan.
  - Trefle: beta, no data licence.
  - OpenFarm: shut down in April 2025.
  - USDA: US-only.

## ADR-015: Region and season model
- **Decision:** a `RegionProfile` (key, display name, sowing-window table) chosen from the garden's city via an offline city→region map.
  - MVP regions follow the sources we have: `north_india`, `south_india` (ICAR terrace table), with state-level overrides where sourced (`telangana`, `tamil_nadu`, `kerala`).
  - A fallback from state to macro region shows a lower-confidence badge.
  - The season vocabulary (summer, monsoon, winter, plus kharif/rabi/zaid labels) is presentation; the data is month windows.
  - Non-Indian regions are a later profile with the same interface.

## ADR-016: Localisation: gen-l10n with ARB from day one
- **Decision:** `flutter_localizations` + `intl` + gen-l10n (`l10n.yaml`, `lib/l10n/app_en.arb`, source import, not `package:flutter_gen`).
  - All UI strings go through ARB from Phase 1.
  - Catalogue content is localised in the dataset (`names: {en, hi, …}`), not in ARB.
  - The MVP ships English (India); Hindi is next.

## ADR-017: Designer coordinate system
- **Decision:** world space in centimetres (double), y-down, origin at the garden's top-left. Elements are defined as center + size + rotation (degrees clockwise). A pure-Dart `CanvasTransform` (affine Matrix4) maps world↔screen. Units are converted only at the UI boundary. Full spec: `data-model.md` §2.

## ADR-018: Cross-cutting: errors, logging, time, IDs
- **Errors:** repositories return a sealed `Result<T>` (`Ok` / `Err(AppFailure)`) for expected failures; unexpected exceptions are caught at boundaries and logged. The UI maps failures to user-friendly messages.
- **Logging:** a thin `AppLogger` interface over `dart:developer` `log` (debug) with levels; no third-party crash reporting in the MVP (privacy). Crashlytics or Sentry can be evaluated pre-launch.
- **Time:** an injectable `Clock`; tasks use date-only values plus the garden's IANA zone.
- **IDs:** an injectable `IdGenerator` (UUID v4).

## ADR-019: AI integrations (future): replaceable services, server-side keys
- **Decision:** define interfaces such as `PlantIdentificationService`, `SymptomAnalysisService`, `GardenConceptService` and `WeatherService`. The MVP binds them to "unavailable" or no-op implementations, and the UI hides those features.
  - Real implementations call **our** backend (Supabase Edge Function), never a vendor directly with an embedded key.
  - All results carry a confidence value and an "AI-generated" label.
  - Failures degrade gracefully to the deterministic baseline.

## ADR-020: Weather (future): Open-Meteo behind `WeatherService`
- **Decision:** use Open-Meteo for development and any free, ad-free distribution, with CC BY 4.0 attribution. Its free API terms forbid commercial use (subscriptions or ads), so budget for its paid plan or proxy it through an Edge Function with caching before monetising. Coarse, city-level location only.

## ADR-021: Plant catalogue bundled as validated JSON, read into memory (Phase 4)
- **Context:** the plan (P4-01) was a versioned import into drift with an FTS5 index. The MVP catalogue has 25 species (~40 KB), is read-only, and every fact must cite a verified source.
- **Decision:** ship the catalogue as `assets/catalogue/plants.json` and `sources.json`, parse it with a strict `CatalogueParser`, and hold it in memory (`plantCatalogueProvider`, keep-alive). Search is a case-insensitive match on common, local and scientific names.
  - Strict parsing rejects: unknown enum values, duplicate ids, citations missing from `sources.json`, facts without sources, figures on records marked unverified, months outside 1–12 and reversed ranges.
  - `catalogue_test` validates the real assets in CI. Every cited source must be in the provenance register (`gardening-references.md` §1) with fetch status F.
  - User data that refers to species (`plantings`, `shortlist_entries`) stores the species id as plain text; there is no catalogue table to join.
- **Consequences:** no import, versioning or migration code for catalogue content; an update is an app release. Revisit with the drift import plus FTS5 when the catalogue exceeds a few hundred species, needs remote updates, or needs localised name search (Hindi names).
- **Unknown data:** null values mean "Not documented" in the UI and "unknown" in recommendations, never a default.

## ADR-022: Care plans from sourced defaults, kept in step by an idempotent reconcile (Phase 5)
- **Defaults** (`CarePlanner`; every interval cites gardening-references):
  - **Soil check, daily from completion.** "Monitor container gardens daily" (S10); daily checks in warm or windy weather (S4). The task is a check: water only if the finger test says dry (S5, S6). The guide adapts to a species' sourced `watering` mode: dry between waterings or keep moist (S40).
  - **Pest check every 3 days from completion.** Aphids "at least twice a week when plants are growing rapidly" (S32).
  - **Feed every 28 days from completion** for vegetables, leafy greens, climbers, herbs and flowers. This is the conservative end of "every 2–4 weeks" (S3, S4), because excess nitrogen favours aphids (S32). No dose is shown; the guide defers to the product label.
  - **One-offs:**
    - transplant after the documented nursery days, for seed-raised transplant crops (S11);
    - "harvest may start" at the documented minimum days to harvest, for edibles.
  - **Seasonal:** jasmine pruning on 24 November, in Tamil Nadu only (S18).
  - The user can switch any rule off and change repeating intervals (CARE-04).
- **Reconcile instead of hooks:** `CareSync.reconcile()` gives every planting without rules its default plan, then materialises tasks (30-day horizon for fixed schedules; one pending task for completion-based rules). It runs at start-up, on every plantings change and on app resume. Concurrent calls coalesce into one follow-up run.
  - This keeps the plantings feature unaware of care.
  - It also back-fills plantings created before Phase 5.
  - Editing a planting's date does not re-plan existing rules (KI-027).
- **Notifications:** a daily digest only, at a user-chosen time (default 07:00), and off until the user turns it on. `NotificationPlanner` is pure. `NotificationSync` diffs against the `scheduled_notifications` table and applies the changes through `NotificationScheduler`, implemented by `LocalNotificationScheduler` (flutter_local_notifications 22, inexact, no exact-alarm permission). Per-task reminders and quiet hours are not built; the digest time is the only notification time.

## ADR-023: Feature public APIs and an enforced import boundary (Phase 6)
- **Context:** from Phase 3 onwards, features imported each other's `data`, `application` and `presentation` files directly (38 imports; KI-025), against the CLAUDE.md rule. Features genuinely compose: the garden overview shows My plants, Today needs plant names, and the catalogue opens the add-planting sheet.
- **Decision:** each feature that others use has a public API file, `lib/features/<f>/<f>.dart`, exporting its providers, label extensions and shared widgets or sheets.
  - Other features may import only that file or the feature's `domain/`.
  - Drift table files may reference other features' table files, for foreign keys.
  - `lib/app` is the composition root and may import anything.
  - `test/architecture/import_boundaries_test.dart` enforces this. It also enforces "domain is pure Dart" (no Flutter, drift, Riverpod or plugins).
- **Consequences:** cross-feature dependencies are explicit and reviewable in six small files. Internal files can move freely. The dependency graph still has cycles at the API level (e.g. garden ↔ plantings via the overview); they are acceptable in Dart and visible in the API files.

## ADR-024: Data export format (Phase 6)
- **Decision:** "Export my data" writes `terrace-garden-export-<timestamp>.zip` containing:
  - `data.json`: `{format: "terrace-garden-export", formatVersion: 1, schemaVersion, exportedAt, tables: {gardens, gardenPhotos, layoutElements, plantings, shortlistEntries, careRules, careTasks, journalEntries, journalPhotos}}`;
  - the `photos/` folder with its paths unchanged.
- Rows use drift's default JSON serialisation:
  - enum columns as names;
  - calendar dates as `yyyy-MM-dd` text;
  - timestamps as epoch milliseconds.
- Scheduled-notification bookkeeping is device-specific and left out.
- The file goes to the system share sheet (`share_plus`), so the user chooses where it goes. The app uploads nothing.
- **Not yet:** importing an export. `formatVersion` and `schemaVersion` are there so an importer can migrate older files later.

## ADR-025: Living Terrace visual system (redesign, 2026-10)
- **Context:** user testing of the photo-and-glass look ("looks like an AI-generated app") asked for a distinctive, crafted design. Direction C, "Living Terrace", was chosen from three mockups (`docs/design/redesign-living-terrace.pdf`).
- **Decision:**
  - **Palette** (`AppPalette`): limestone/paper/stone grounds, neem green text, leaf primary, terracotta and haldi accents, water blue for soil checks, dusk greens for dark mode. Text colours are checked by `contrast_test.dart`.
  - **Type:** YoungSerif for headlines and plant names, Schibsted Grotesk for UI. Both are bundled OFL fonts with licences registered at start-up; Inter and Fraunces were removed. This replaces ADR-012's font choice.
  - **Surfaces:** solid paper cards. `GlassPanel` blurs only when a theme asks for it (`blurSigma > 0`); `PhotoBackdrop` is a plain surface. Stock photos remain only as the garden cover until a layout exists, and in empty states.
  - **Illustration in code:** `PlantArtSpec` maps every catalogue species to a drawn form (top and side views). `TerracePlan` draws the user's real layout to scale and is reused on Today, the garden overview, the add-plant picker and the welcome step. Illustrations are decorative or carry semantic labels; they never show unsourced facts.
- **Consequences:** no network images or icon packs; the art is testable with CI goldens (`living_terrace_art_golden_test.dart`). New screens should compose `TerracePlan`, `PlantTopArt` and `PlantSideArt` rather than photos.

## ADR-026: Living Terrace navigation (redesign, 2026-10)
- **Decision:** the tabs are **Today · Plants · Seasons · Journal**. Gardens are no longer a tab: `/gardens`, `/gardens/:id` and their sub-routes are top-level routes, opened from the garden name on Today. A switcher appears there when the user has more than one garden.
  - `SelectedGardenId` (keep-alive, in memory) and `currentGarden` (the selected garden or the first) decide which garden Today and Seasons show.
  - Seasons is a new tab: what can be sown this month in the current garden's region, and an almanac for the user's plants and shortlist, from sourced windows only.
  - Deleting a garden returns to Today.
- **Why:** most visits are "what does my terrace need today", which Today now answers with the plan itself. The garden's details are a step away, not a tab.
- **Consequences:** the selected garden is not persisted across restarts (first garden by default). Tests reach gardens through Today or `TestApp.open`.

## ADR-027: Hindi and per-language plant names (2026-10-18)
- **Decision:** the app ships in English and Hindi (PD-003).
  - `lib/l10n/app_hi.arb` translates every UI string into simple, everyday Devanagari Hindi, using a fixed glossary (बगीचा, गमला, मिट्टी की जाँच, देखभाल, डायरी…). Brand and organisation names, units and Western digits stay as they are.
  - Settings → Language offers Phone / English / हिन्दी (`AppLanguage`, saved with the other settings). "Phone" follows the device and falls back to English. The language names are written in their own script.
  - Notifications use the same choice (`appLocaleFor`).
  - Plant names: the catalogue has an optional `names` map (`{"hi": "टमाटर"}`). The UI shows `species.name(l10n)`, and search matches names in every language.
  - `test/architecture/arb_keys_test.dart` fails if a translation misses a key or changes a placeholder, and if any ARB file repeats a key.
- **Not translated yet:** catalogue prose (care notes, container, harvest and pet notes) is still English inside the Hindi UI (KI-034). The translations need a native-speaker review before release (KI-035).
- **Why a map, not a `hindiName` field:** further languages (Tamil, Telugu, Kannada…) can be added as data without a schema change.

## ADR-028: Terrace Garden Plus and Google Play billing (2026-10-29)
- **Context:** the user asked for an affordable paid tier, with some services free and others paid (PD-002). Competitors charge ₹500–1,000/month and lock care features. Users complain most about trials that convert, constant prompts and free features moved behind a paywall (competitor-analysis Part E).
- **Decision:**
  - **Free:** care, catalogue, pest guide, pet and skin safety, one garden with its layout, 60 journal photos, export/delete, Hindi.
  - **Plus:** unlimited gardens, unlimited journal photos, photo comparison, the garden report.
  - **Prices:** ₹49/month, ₹399/year, ₹999 lifetime (planned; Play sets the displayed price). No trial, no weekly plan. Details and rationale in `docs/product/monetisation.md`.
  - **Code:**
    - a new `subscription` feature with public API `subscription.dart`;
    - `Plan`, `PlusFeature`, `PlanLimits` and `Entitlements` are pure domain policy;
    - the `PurchaseService` interface has a `PlayPurchaseService` (`in_app_purchase`) implementation;
    - subscriptions and the lifetime product are both bought as non-consumables;
    - the cached plan lives in SharedPreferencesAsync;
    - gates go through `requirePlus()`, which shows an upgrade sheet and never interrupts a task half-done.
  - **Binding rule:** a feature that has shipped free is never moved behind Plus. Safety information, data export/deletion and languages are never paywalled.
- **Consequences:**
  - Entitlements are checked on the device only, with no server receipt verification (KI-037).
  - Selling needs Play Console products and a signed release build (KI-038).
  - Tests use `FakePurchaseService`; `TestApp(plan:)` sets the plan.

## ADR-029: Skin-use information only from health authorities (2026-10-29)
- **Context:** the user asked for skin-care plants and their research. Skin use is a health claim, and claims online range from traditional use to unsupported marketing.
- **Decision:**
  - The catalogue has an optional `skinUse {evidence[], cautions[]}`. Each note is `{text, sources}`, and `evidence` must not be empty.
  - Skin notes cite only WHO monographs, the EU's EMA (HMPC) or the US NCCIH. `catalogue_test` fails on any other publisher. Gardening sources stay for growing facts.
  - The notes report what an authority accepts (e.g. EMA's traditional-use indications), what it found, and where it found no evidence or no skin use (turmeric, tulsi). They report reactions and who should not use the plant.
  - They give no recipes, doses or treatment instructions.
  - The plant page shows the section "On the skin" with a fixed note: not medical advice, ask a doctor or pharmacist, and stop if your skin reacts. A "Skin use" filter on Plants lists these plants and says some entries record weak or missing evidence.
  - Plants without authority coverage get no skin entry (vetiver), even when folk use is common.
- **Consequences:**
  - Some popular plants show "no evidence" rather than benefits. This is intended.
  - MedlinePlus withdrew its herb pages on 2025-07-29, so it is not used.
  - The notes are English inside the Hindi UI, as for other catalogue prose (KI-034).

## ADR-030: One illustrated map, edited directly (Designer 2.0, 2026-10-30)
- **Context:** the user found the map layout weak. The designer was a plain grid of outlined boxes with no plants, while the illustrated `TerracePlan` could only be viewed. You built the terrace in one tool and saw it in another. Indian terraces also have features the designer couldn't show (overhead tank, door, drain, stairs), and containers are sold in inch sizes the designer didn't offer. The user chose to merge the two views (2026-10-30).
- **Decision:**
  - **One renderer.** `TerraceArtist` draws the floor, objects and plants at any scale. `TerracePlanPainter` (read-only plans on Today, the garden overview, the report and onboarding) and the designer's `GardenCanvasPainter` both use it. The designer has two styles: **Garden** (default; the illustrated terrace with the garden's plantings in their containers, and a dusk tint in dark mode) and **Blueprint** (the earlier white grid for measuring).
  - **New kinds:** round grow bag, hanging pot, trellis, water tank, stairs or room, seating, door, drain. Kinds are stored by name (`textEnum`), so there is no migration.
  - **Validation:** solids where a door opens (`blocksDoor`) or over a drain (`coversDrain`) are warnings, like a container on a path. Hanging pots (`ElementKind.overhead`) only collide with each other.
  - **Layers:** `ElementKind.drawLayer` puts paths and doors at the back, then structures, markers, containers and hanging pots. Drawing and hit testing share `LayoutDocument.drawOrder`, so what looks on top is what a tap selects.
  - **Shop sizes:** `elementPresets` lists grow bags, pots and raised beds the way Indian shops label them (inches; diameter × height for round bags, L × W × H for rectangular ones). The size sheet shows centimetres and soil litres for each. These are product sizes the user edits, not horticultural advice. A pot's depth varies by maker, so it starts equal to its diameter.
  - **Interaction:** a quick-add tray (tap for a size, or drag onto the terrace at the last size used); a More sheet with every kind drawn as it looks; a toolbar that floats by the selection (rotate, duplicate, repeat in a row, delete); a bottom bar naming the selection and its size, with Edit; floating Snap and Fit buttons. "Repeat in a row" adds N copies with a set gap as one undo step.
- **Consequences:**
  - The designer and every plan look the same, and the plan golden was unchanged by the refactor.
  - Problem badges now draw above all objects, so a covered drain still shows its badge (blueprint golden updated).
  - Not yet (next slices): marking sun and shade areas, a north arrow, L-shaped boundaries and cut-outs, templates, and choosing plants by tapping a container (roadmap slices B–C).

## ADR-031: Sun areas, cut-outs and a north arrow as layout objects (2026-10-30)
- **Context:** the plan needs to know where sun falls, which way is north, and what shape the terrace is. The user decided that sun is marked by the user from what they see, never computed (2026-10-30), in line with "never invent horticultural facts". Indian terraces are often L-shaped or have a stairwell, but the boundary is a rectangle from the garden profile.
- **Decision:**
  - **Sun areas** are layout elements of kinds `sunFull`, `sunPart` and `shade` (role `zone`). They map to the garden profile's own bands (`SunExposure`: 6+ hours, 3–6, under 3) through `sunExposureOf`. `sunAt(doc, point)` returns the topmost area covering a point, or null when unmarked; `sunFor` uses a container's centre. Slice C will rank plants with it. Sun areas never conflict and may overhang the edge. They are drawn as soft tints with a sun, cloud or umbrella glyph, and only in the designer; read-only plans leave them out.
  - **Cut-outs** (`cutOut`, role `cutOut`) mark parts of the rectangle that are not usable floor. Anything standing on one is `outOfBounds` (an error), and the space summary deducts them from the floor area. They are drawn hatched, the usual plan convention, which works on any background.
  - **North arrow** (`northArrow`, a marker) is rotated by the user; a layout has at most one, and adding another selects the existing one.
  - All are ordinary rows in `layout_elements` (kinds stored by name), so there is **no schema change**. Layers: sun areas, cut-outs, then the rest; the north arrow draws on top.
  - **Gestures:** sun areas and cut-outs are "background". A tap selects one only when no object (or near miss within the tap tolerance) is there. A drag that starts on one pans the view unless it is the selected object, so large areas never trap the user.
  - **Templates** (`buildTemplate`): planters along the railing; rows of 15 × 15 in grow bags with a path; 4 × 2 ft raised beds and grow bags. They are generated for the garden's own size with 10 cm gaps and a 45–75 cm walkway, and are offered only while the layout is empty and only when they fit. They arrange containers and make no claim about what grows well. A template is one undo step.
- **Consequences:** no migration and no change to export (ADR-024: the elements are exported as before). A true polygon boundary is still possible later. Cut-outs cover L, U and notched shapes made of rectangles, but not diagonal walls (P7-07 remains for those).

## ADR-032: "What to grow here" ranks plants for one container (2026-10-30)
- **Context:** recommendations ranked plants for the whole garden. On the plan, the useful question is narrower: what suits *this* pot, where it stands, now.
- **Decision:** `RecommendationEngine.rankForSpot` reuses `rank` and its explained checks, with two changes: the only container is the selected one, and the sun is the one the user marked at its spot (`sunFor`, ADR-031). When no sun area covers the spot it uses the garden profile's sun and reports `SunSource.garden`, which the sheet states ("Sun isn't marked here, so your garden's sun is used"). A container with no soil depth gives "unknown" for size, never a guess. The sheet (`showGrowHereSheet`, plantings feature) opens from the designer's selection bar for containers. It groups plants as good now, later in the year, and not for this spot (collapsed). Each plant shows its sun, size and season reasons, plus a pets note where a source says it is toxic. Choosing one opens the add-plant sheet with the container already chosen (`showPlantingSheet(elementId:)`). It reads the designer's live document, so unsaved edits count.
- **Consequences:** no new data or rules; every reason comes from catalogue figures that are already sourced. Spacing-based crowding is still limited to `PlantingFit`'s capacity estimate, since the catalogue has no sourced spacing yet (U-D).

## ADR-033: Catalogue depth: width, spacing, longer harvests and four regions (2026-10-30)
- **Context:** the user asked for a much better plant database; the decision was depth before breadth (2026-10-30). Key fields were thin (container size for 35 of 73 species, harvest 37, watering 5, no spacing), and no sowing calendar covered West, Central or East India. Many sources state a pot's **width or diameter** rather than its volume or depth, and fruit trees take years to bear.
- **Decision:**
  - Research ran as seven parallel agents with one brief: first-party sources only, every page fetched, a verbatim quote for every figure, "not found" preferred to a guess. Results were reviewed fact by fact and merged by a script that lists each accepted value; everything else was rejected. Rules applied: no "inferred" facts; no sizes that describe how plants are sold; proxies only where marked `proxy`; where sources differ, the range spans both and cites both; a source's own "same as X" counts. An independent fetch spot-checked 10 quotes (6 matched word for word, 4 pages could not be re-read; KI-043).
  - Schema: `container.minWidthCm` (narrowest side or diameter), checked by recommendations, "What to grow here" and the add-plant fit warnings (`PlantingIssueKind.narrow`); `spacing {minCm, maxCm, rowCm?}`, shown on the plant page and used for a rough grid capacity (`PlantingFit.spacingCapacity`, `tightSpacing` warning); harvest windows up to 1500 days, shown in years from a year up.
  - Spacing prefers NC State's intensive raised-bed table (the app plans beds and bags), with RHS as the upper end, then Indian field spacing with row distance.
  - Regions are named for what the source covers: `westernMaharashtra` (MPKV Rahuri; Pune, Nashik, Kolhapur, Satara, Sangli, Solapur, Ahilyanagar), `gujarat` (state horticulture directorate), `goa` (ICAR-CCARI) and `assam` (AAU 2023 package, with its rooftop table). None falls back to another region. Mumbai, Thane and Nagpur stay without a region: no Konkan or Vidarbha calendar was found. Odisha, West Bengal, Madhya Pradesh and Chhattisgarh sources were too thin (a district bulletin, a seed-production date) or unreachable.
  - New sources S155–S182 are registered in gardening-references §1j as "F". Two regional sources carry English display names (the Gujarati title rendered as empty boxes without a Gujarati font).
- **Consequences:** coverage of 73 species: container size 35 → 51, harvest 37 → 52, spacing 0 → 36, watering 5 → 38; 99 new sowing windows in four regions. Several tests that used a species as an example of "no data" were moved to species that still lack it.

## ADR-034: UI polish: a trait per plant drawing, folded task groups, plan tags (2026-11-01)
- **Context:** a by-eye review of every screen in light and dark with the real fonts (U-E) found that 73 species shared 9 drawn forms, so tomato, chilli and brinjal, or cabbage and broccoli, differed only by a colour; that plan tags were truncated or clipped by the plan's edge; and that Today listed every plant once per task kind, so a 7-plant garden scrolled for several screens.
- **Decision:**
  - `PlantArtSpec` gains an `ArtTrait` (`plant_traits.dart`, a part of the art library): the fruit, head, flower or leaf shape that identifies the plant (long chilli, oblong brinjal, bell capsicum, cabbage head, cauliflower curd, broccoli florets, lacy coriander, pinnate curry leaf, tubular onion, banana paddles, snake-plant swords, pompom marigold, spiral rose, gourd shapes and more). Traits draw in both the top and side views; some replace the form's drawing. Nine species stay plain on purpose, one per form. `plant_art_test` requires every catalogue species to have its own drawing and no two to look the same.
  - Plan tags use the short name (`shortName`, the name without a trailing gloss), stay inside the plan, and move above a container when below would leave the plan or cover another tag. Screen readers still get the full name.
  - On Today the first task group stays open; later groups with more than 4 tasks show 3 and a "Show N more" button.
  - The plant page shows the garden's own sowing calendar first and folds the others; the source line names three publishers and a count; ranges write a shared unit once (`MeasurementFormatter.lengthRange`).
  - Motion follows design-system §9: task cards ease to their new height (`AppMotion.medium`, instant under reduced motion), with a light haptic on completion.
- **Consequences:** drawings are still code illustrations, not photos (KI-016 stays open). Adding a species now needs a trait or a deliberate addition to the plain list, or `plant_art_test` fails.
