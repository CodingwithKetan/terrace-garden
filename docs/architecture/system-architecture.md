# System Architecture

Status: v1.0 (Phase 0, 2026-10-18). Decisions referenced as ADR-0xx are in `technical-decisions.md`.

## 1. Overview

A **local-first Flutter app**: all MVP data lives on the device in SQLite (drift) plus photo files. Domain logic (geometry, recommendations, scheduling, notification planning) is pure Dart and independent of Flutter, so it can be tested in isolation. External capabilities (AI, weather, sync) sit behind interfaces and are unavailable in the MVP.

```text
┌──────────────────────────────── Flutter app ────────────────────────────────┐
│ presentation   Screens/Widgets ──watch──► ViewModels (Riverpod Notifiers)    │
│                 Designer canvas ◄──repaint── CanvasController (ChangeNotifier)│
│ application    Commands / use cases (only where logic spans repositories)    │
│ domain         Entities · value objects · rules (pure Dart, no Flutter)      │
│                 Geometry · RecommendationEngine · CarePlanner · Recurrence    │
│                 NotificationPlanner                                           │
│ data           Repositories (impl) ─► drift DAOs · PhotoStorage · Catalogue   │
│                                      importer · SharedPreferences             │
│ core           Result/AppFailure · AppLogger · Clock · IdGenerator · widgets  │
│ platform       flutter_local_notifications · image_picker · path_provider     │
└──────────────────────────────────────────────────────────────────────────────┘
         future: WeatherService / AI services ──HTTPS──► Supabase Edge Functions
                 SyncService ──► Supabase Postgres + Storage (optional PowerSync)
```

## 2. Source layout (planned; created incrementally, no empty folders)

```text
lib/
  main.dart                      # bootstrap: bindings, timezone init, ProviderScope
  app/
    app.dart                     # MaterialApp.router, theme, localisation
    router/                      # go_router config, route names, redirects
    theme/                       # tokens, ThemeData (light/dark), ThemeExtensions
    di/                          # top-level provider overrides (db, clock, storage)
  core/
    errors/                      # Result<T>, AppFailure
    logging/                     # AppLogger
    time/                        # Clock, LocalDate helpers
    ids/                         # IdGenerator
    database/                    # drift AppDatabase, migrations, schema versions
    storage/                     # PhotoStorage (files), paths
    notifications/               # NotificationScheduler adapter (plugin wrapper)
    units/                       # Length, Area, UnitSystem, formatting
    widgets/                     # design-system components (buttons, cards, states…)
  features/
    onboarding/      {application, presentation}
    garden/          {domain, data, application, presentation}   # profile + photos
    garden_designer/ {domain, data, application, presentation}   # geometry, layout
    plant_catalog/   {domain, data, presentation}                # bundled dataset
    recommendations/ {domain, application, presentation}
    care/            {domain, data, application, presentation}   # rules, tasks, agenda
    journal/         {domain, data, presentation}
    settings/        {data, presentation}
  l10n/                          # ARB files (app_en.arb …)
assets/
  catalogue/plants.v1.json       # curated dataset with sourceIds
  images/plants/…  ATTRIBUTION.md
  fonts/ (Fraunces, Inter + OFL licences)
test/ (mirrors lib/)   integration_test/   docs/
```

## 3. Dependency rules

1. `domain` imports nothing from Flutter, data or presentation. It depends only on Dart, `core` pure helpers (units, time, Result) and freezed annotations.
2. `data` implements domain repository interfaces; it may import drift, the file system and plugins. Drift row types never leak beyond `data` when a domain model exists.
3. `application` and `presentation` depend on domain interfaces via providers, never on concrete data classes.
4. Features do not import each other's `data` or `presentation`. Cross-feature needs go through domain interfaces or IDs. For example, care depends on the `PlantSpeciesRepository` interface from `plant_catalog/domain`.
5. Widgets render state and forward intents to ViewModels; no business rules in widgets.
6. Platform plugins are wrapped by adapters in `core` (e.g. `NotificationScheduler`, `PhotoPicker`), so they can be faked in tests.

## 4. Key flows

### 4.1 Create garden (Phase 2)
`OnboardingViewModel.submit()` → `GardenRepository.create(GardenDraft)` → drift transaction → returns `Result<Garden>` → router navigates to GDN-02. Watchers of `gardensProvider` update automatically via drift streams.

### 4.2 Designer edit cycle (Phase 3)
Gesture → `CanvasController` converts screen→world via `CanvasTransform.inverse` → applies a `LayoutCommand` (move, resize, rotate, add, delete) to an immutable `LayoutDocument` → validation (`LayoutValidator`, pure) → pushes onto the undo stack → `notifyListeners()` repaints → a debounced autosave writes the diff through `LayoutRepository.save(document)` in one transaction. The save status is exposed to the UI.

### 4.3 Plant → care plan (Phases 4–5)
`AddPlantingCommand` → `PlantingRepository.insert` → `CarePlanner.instantiateRules(species, planting, container, region, today)` (pure) → `CareRuleRepository.insertAll` → `TaskMaterializer.materialize(rules, window)` (unique on `ruleId + dueOn`) → `NotificationPlanner.plan(pendingTasks, prefs, now)` → `NotificationScheduler.apply(diff)`.

### 4.4 Complete / skip / reschedule task
`CareTaskRepository.complete(taskId, note)` → the rule's anchor computes `nextDueOn` → re-materialise that rule's window → re-plan notifications. Running it twice yields the same state (idempotent).

### 4.5 Catalogue import
On startup, `CatalogueImporter` compares the asset's `catalogueVersion` with the DB → (re)imports in a transaction → plantings keep stable species IDs (slugs). A removed species is marked `retired`, never deleted while referenced.

## 5. State management pattern

- **Provider types:** repositories and services are `@Riverpod(keepAlive: true)` providers returning interfaces. Screen ViewModels are `@riverpod` Notifiers (auto-dispose), with families keyed by IDs (`gardenId`, `layoutId`).
- **Async UI:** `AsyncValue` → shared `AsyncStateView` widget renders loading, error and data consistently.
- **Commands:** user intents return `Future<Result<T>>`; the UI shows progress and errors from the command state rather than ad hoc flags.
- **Canvas:** `CanvasController` (ChangeNotifier) holds transient interaction state; it is created per designer session and disposed with the route.

## 6. Persistence

- One drift `AppDatabase` with DAOs per feature, schema versions and step-by-step migrations (schema snapshots committed under `drift_schemas/` with migration tests).
- Tables (MVP): `gardens`, `garden_photos`, `layouts`, `layout_elements`, `plant_species`, `species_names`, `care_rule_templates`, `plantings`, `care_rules`, `care_tasks`, `scheduled_notifications`, `journal_entries`, `journal_photos`. Field details: `data-model.md`.
- Foreign keys are enabled (`PRAGMA foreign_keys = ON`) with `ON DELETE CASCADE` where the data model says so; photo files are deleted by the repository after the transaction commits.
- Settings live in `SharedPreferencesAsync` behind a `SettingsRepository`.

## 7. Notifications

- Android: a `daily_digest` channel and a `task_reminders` channel; inexact scheduling; boot re-registration via the plugin; the app re-plans on start and resume anyway.
- iOS: at most 50 pending; rolling-window planning.
- Payload: a route string (`/tasks/<id>` or `/today`) handled by go_router.

## 8. Security and privacy

- No secrets in the client, ever; future AI and weather calls go through our backend proxy.
- Photos are stored in the app sandbox; EXIF GPS is stripped on import.
- Location is stored at city precision only.
- No analytics or crash SDKs in the MVP; evaluate opt-in crash reporting before launch.
- "Delete all data" removes the DB, photo files and scheduled notifications.

## 9. Performance considerations

- Canvas: `CustomPainter` with `repaint: controller`; static layers (grid, boundary) cached in a separate `RepaintBoundary`/picture; hit testing is a pure geometry function over at most ~100 objects (linear scan is fine; add a spatial index only if profiling demands it).
- Lists virtualised; image grids decode with `cacheWidth`.
- Image compression and catalogue import run in background isolates.

## 10. Platforms and build

- Android first (emulator available on the dev machine). iOS needs macOS: verify via a CI macOS runner or a Mac before release.
- CI (when a remote exists): GitHub Actions with format, analyse and test on Linux; Android debug build.
