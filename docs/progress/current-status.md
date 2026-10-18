# Current Status

Last updated: 2026-10-18

## Phase

**Phase 5 (care tracking): complete (2026-10-18).** Phases 0–4 are complete, plus the v0.2 visual refresh. Next: Phase 6 (progress and refinement).

## State of the repository

- **App:** runs on the local Flutter 3.44.8 (ADR-001). Phase 2 added onboarding, gardens, photos and the terrace checklist. Phase 3 added the dimension-aware layout designer. Phase 4 added the sourced 25-species catalogue (bundled JSON, ADR-021), plant detail, recommendations with reasons and a shortlist, and plantings in containers with fit warnings (drift schema v4). Phase 5 added sourced care plans (ADR-022), the Today agenda with task actions, per-planting care plan editing, and an opt-in daily digest notification (drift schema v5).
  - Riverpod 3 bootstrap, go_router shell with four tabs (Today, Garden, Plants, Journal) and an adaptive NavigationBar/NavigationRail.
  - A working Settings screen: theme and units, persisted; licences page.
  - Tabs show honest empty states; features arrive in Phases 2–6.
- **Design system in code** (`lib/app/theme/`): tokens, light/dark colour schemes, `CareColors` and `GlassTheme` extensions, component themes, bundled Inter + Fraunces fonts. **Visual direction v0.2 "real, modern, translucent"**: photo backdrops, glass panels, floating glass navigation (design-system §2.4).
- **Core** (`lib/core/`):
  - `Result`/`AppFailure`, `AppLogger`, `Clock`, `IdGenerator`, `LocalDate`, `Length`/`Area`/`Volume` + formatter;
  - 11 shared widgets (`lib/core/widgets/`);
  - drift `AppDatabase` v5 (gardens, garden_photos, layout_elements, plantings, shortlist_entries, care_rules, care_tasks, scheduled_notifications) with schema snapshots and migration tests.
- **Localisation:** gen-l10n, `lib/l10n/app_en.arb`.
- **Git:** `main`. Phase 0 is on GitHub (`CodingwithKetan/terrace-garden`). **Later commits are local only**: pushes fail on this network (KI-006), so push from another network.

## Toolchain (verified 2026-10-18)

| Item | Value |
|---|---|
| Project SDK | Flutter 3.44.8 / Dart 3.12.2 (local, chosen by user). Latest stable 3.47.7 noted for a future upgrade |
| Android | SDK 36, emulator `gsrtc_emulator` (Android 16). Debug builds work (KI-007 resolved via `GRADLE_OPTS`). Licences still not accepted (KI-002; only needed to install SDK packages). Play Services overlays on this emulator (KI-009) |
| iOS | Not buildable on this Windows machine |
| Network | Corporate TLS inspection: curl revocation checks and Java trust fail; PowerShell downloads work; GitHub pushes from this network fail (KI-006) |

## Last completed tasks

P5-01 → P5-05, P5-07 → P5-09 and the Phase 5 gate; P5-06 partly (care plan editor done, month calendar deferred, KI-028). Deferred from Phase 4: P4-05 compare, P4-DATA-03 research gaps, P4-DATA-04 plant images (P1). Still open from earlier: P1-02 (Android licences; non-blocking).

## Exact next steps

1. **Phase 6 (progress and refinement):**
   - P6-01 journal entries with photos and milestones; completed tasks in the timeline.
   - P6-03 delete all data (P0) and export (P1).
   - P6-05 accessibility audit, P6-06 responsive pass, P6-07 performance profiling, P6-08 end-to-end suite.
   - KI-025: per-feature public APIs and an import-boundary check.

## Checks run (latest, 2026-10-18, Windows host)

- Quality gate (Phase 5):
  - `dart format --set-exit-if-changed`: 0 changed.
  - `flutter analyze`: **no issues**.
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
