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
- **Decision:** `very_good_analysis ^10.3.0` (11.x needs a newer SDK), with `public_member_api_docs` disabled for app code. Generated files are excluded. `riverpod_lint` is enabled as an analysis-server plugin. Any `// ignore:` needs a justification comment.

## ADR-012: Typography and icons: bundled fonts, Material Symbols
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
