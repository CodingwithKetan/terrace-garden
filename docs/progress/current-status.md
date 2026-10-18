# Current Status

Last updated: 2026-10-18

## Phase

**Phase 6 (progress and refinement): all P0 tasks done except a device profile run (P6-07); ready for moderated user testing (2026-10-18).** Phases 0–5 are complete. Open: P6-07 device profiling, and P1 items (export, photo comparison and stats, kit preset, branding).

## State of the repository

- **App:** runs on the local Flutter 3.44.8 (ADR-001). Phase 2 added onboarding, gardens, photos and the terrace checklist. Phase 3 added the dimension-aware layout designer. Phase 4 added the sourced 25-species catalogue (bundled JSON, ADR-021), plant detail, recommendations with reasons and a shortlist, and plantings in containers with fit warnings (drift schema v4). Phase 5 added sourced care plans (ADR-022), the Today agenda with task actions, per-planting care plan editing, and an opt-in daily digest notification (drift schema v5). Phase 6 added the journal (entries with photos, milestones and harvests, plus a timeline with completed care; schema v6), delete all data, accessibility and responsive fixes, performance budgets, and enforced feature boundaries (ADR-023).
  - Riverpod 3 bootstrap, go_router shell with four tabs (Today, Garden, Plants, Journal) and an adaptive NavigationBar/NavigationRail.
  - Settings: theme, units, daily reminder, delete all data, image credits, licences.
- **Design system in code** (`lib/app/theme/`): tokens, light/dark colour schemes, `CareColors` and `GlassTheme` extensions, component themes, bundled Inter + Fraunces fonts. **Visual direction v0.2 "real, modern, translucent"**: photo backdrops, glass panels, floating glass navigation (design-system §2.4).
- **Core** (`lib/core/`):
  - `Result`/`AppFailure`, `AppLogger`, `Clock`, `IdGenerator`, `LocalDate`, `Length`/`Area`/`Volume` + formatter;
  - 11 shared widgets (`lib/core/widgets/`);
  - drift `AppDatabase` v6 (gardens, garden_photos, layout_elements, plantings, shortlist_entries, care_rules, care_tasks, scheduled_notifications, journal_entries, journal_photos) with schema snapshots and migration tests.
- **Localisation:** gen-l10n, `lib/l10n/app_en.arb`.
- **Git:** `main`. Phase 0 is on GitHub (`CodingwithKetan/terrace-garden`). Pushed to GitHub up to `57ef65a` (2026-10-18).

## Toolchain (verified 2026-10-18)

| Item | Value |
|---|---|
| Project SDK | Flutter 3.44.8 / Dart 3.12.2 (local, chosen by user). Latest stable 3.47.7 noted for a future upgrade |
| Android | SDK 36, emulator `gsrtc_emulator` (Android 16). Debug builds work (KI-007 resolved via `GRADLE_OPTS`). Licences still not accepted (KI-002; only needed to install SDK packages). Play Services overlays on this emulator (KI-009) |
| iOS | Not buildable on this Windows machine |
| Network | Corporate TLS inspection: curl revocation checks and Java trust fail; PowerShell downloads work; GitHub pushes from this network fail (KI-006) |

## Last completed tasks

P6-01, P6-03 (delete all data), P6-05, P6-06, P6-07 (host part), P6-08, P6-09 and P6-11 (import boundaries, ADR-023). Earlier deferrals: P4-05, P4-DATA-03, P4-DATA-04, P5-06 calendar. Still open from earlier: P1-02 (Android licences; non-blocking).

## Exact next steps

1. **Run moderated user tests** with `docs/product/user-testing-kit.md` (5–8 participants).
2. **P6-07:** profile on a real Android phone (`flutter run --profile`): cold start, designer fps with 100 objects, journal image grid.
3. **Before public release:** horticulturist review (R2), research gaps KI-010..KI-013, plant images (KI-016), product name and branding (PD-001, P6-10), signing, iOS build (KI-003).
4. **P1 backlog:** data export (P6-03), photo comparison and stats (P6-02), month calendar (KI-028), re-plan on planting edit (KI-027).
5. **Push** the local commits from a network that allows GitHub (KI-006).

## Checks run (latest, 2026-10-18, Windows host)

- Quality gate (Phase 6):
  - `dart format --set-exit-if-changed`: 0 changed.
  - `flutter analyze`: **no issues**.
  - `flutter test`: **424 passed**. Phase 6 added tests for:
    - the journal repository, timeline and flows;
    - delete all data;
    - accessibility guidelines on every main screen (light and dark) and a 200%-text walk;
    - responsive layouts at three sizes;
    - performance budgets;
    - architecture boundaries.
  - End-to-end device test (Android 16 emulator, after a cold boot): **passed** (21 s) through onboarding, plant, restart, care, notification, designer and journal. Two earlier runs failed because of test assumptions: no garden size, and the first idea not being Tomato. The test was corrected.
- Phase 5 gate (earlier):
  - `flutter test`: **388 passed**. New tests cover:
    - the recurrence engine (month ends, leap days, rollover);
    - the care planner on the real catalogue, and the materialiser;
    - the notification planner and diff;
    - the care repository, including the v4→v5 migration;
    - `CareSync` and `NotificationSync`;
    - 6 Today, care-plan and reminder journeys.
  - Integration test on the Android 16 emulator, extended for P5-09 (soil check on Today, mark done, digest pending with the platform):
    - **Run 1 failed:** the app didn't appear within 15 s on an overloaded emulator (load ~13–27).
    - **Run 2 hung** for more than 80 minutes; the emulator stopped responding.
    - **Run 3 passed** in 18 s, after a cold boot (`emulator -no-snapshot-load`) and with a 2-minute first-launch timeout. POST_NOTIFICATIONS was granted with `adb shell pm grant` while the test ran.
  - The Phase 4 screens still haven't been reviewed by eye on the device (KI-009).
- `flutter build apk --debug`: **passed** with flutter_local_notifications and core library desugaring (391 s, including first-time Gradle downloads).
- `dart analyze`: no issues (riverpod_lint removed, KI-008).

## Working in a Claude Code cloud session (optional)

The user has paused the cloud move. If it's resumed, add this as the environment setup script at claude.ai/code:

```bash
#!/bin/bash
set -e
if [ ! -x /opt/flutter/bin/flutter ]; then
  git clone --depth 1 --branch 3.44.8 https://github.com/flutter/flutter.git /opt/flutter
fi
/opt/flutter/bin/flutter --version
/opt/flutter/bin/flutter precache --universal --no-android --no-ios || true
```

Use `/opt/flutter/bin/flutter`. Android builds and integration tests stay local.
