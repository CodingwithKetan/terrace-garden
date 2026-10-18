# Current Status

Last updated: 2026-10-18

## Phase

**Phase 6 done except a device profile run (P6-07). Living Terrace redesign built (R-01..R-07, ADR-025/026; 2026-10-18); ready for moderated user testing of the new design.** Phases 0–5 are complete. Open: P6-07 device profiling; P6-04 kit preset (needs KI-014 verification); P6-10 branding (needs the app name, PD-001).

## State of the repository

- **App:** runs on the local Flutter 3.44.8 (ADR-001). Phase 2 added onboarding, gardens, photos and the terrace checklist. Phase 3 added the dimension-aware layout designer. Phase 4 added the sourced 25-species catalogue (bundled JSON, ADR-021), plant detail, recommendations with reasons and a shortlist, and plantings in containers with fit warnings (drift schema v4). Phase 5 added sourced care plans (ADR-022), the Today agenda with task actions, per-planting care plan editing, and an opt-in daily digest notification (drift schema v5). Phase 6 added the journal (entries with photos, milestones and harvests, plus a timeline with completed care; schema v6), delete all data, accessibility and responsive fixes, performance budgets, and enforced feature boundaries (ADR-023).
  - Riverpod 3 bootstrap, go_router shell with four tabs (Today, Plants, Seasons, Journal; gardens open from Today, ADR-026) and an adaptive NavigationBar/NavigationRail.
  - Settings: theme, units, daily reminder, delete all data, image credits, licences.
- **Design system in code** (`lib/app/theme/`): tokens, Living Terrace light/dark colour schemes, `CareColors` and `GlassTheme` extensions, bundled Young Serif + Schibsted Grotesk. **Visual direction v0.3 "Living Terrace"** (ADR-025, design-system.md): the user's terrace drawn to scale (`TerracePlan`), plant drawings in code (`PlantArtSpec`), solid paper surfaces.
- **Core** (`lib/core/`):
  - `Result`/`AppFailure`, `AppLogger`, `Clock`, `IdGenerator`, `LocalDate`, `Length`/`Area`/`Volume` + formatter;
  - 11 shared widgets (`lib/core/widgets/`);
  - drift `AppDatabase` v6 (gardens, garden_photos, layout_elements, plantings, shortlist_entries, care_rules, care_tasks, scheduled_notifications, journal_entries, journal_photos) with schema snapshots and migration tests.
- **Localisation:** gen-l10n, `lib/l10n/app_en.arb`.
- **Git:** `main`. Phase 0 is on GitHub (`CodingwithKetan/terrace-garden`). Pushed to GitHub through the redesign docs commit (2026-10-18).

## Toolchain (verified 2026-10-18)

| Item | Value |
|---|---|
| Project SDK | Flutter 3.44.8 / Dart 3.12.2 (local, chosen by user). Latest stable 3.47.7 noted for a future upgrade |
| Android | SDK 36, emulator `gsrtc_emulator` (Android 16). Debug builds work (KI-007 resolved via `GRADLE_OPTS`). Licences still not accepted (KI-002; only needed to install SDK packages). Play Services overlays on this emulator (KI-009) |
| iOS | Not buildable on this Windows machine |
| Network | Corporate TLS inspection: curl revocation checks and Java trust fail; PowerShell downloads work; GitHub pushes from this network fail (KI-006) |

## Last completed tasks

**Living Terrace redesign (R-01..R-07):** foundation, plant art, terrace plan, navigation + Today + soil-check sheet + Seasons, plant detail with sourced journey, ideas shelf, container picker on the plan, journal, welcome and garden overview. Before that: P6-01, P6-03 (delete all data), P6-05, P6-06, P6-07 (host part), P6-08, P6-09 and P6-11 (import boundaries, ADR-023). Earlier deferrals: P4-05, P4-DATA-03, P4-DATA-04, P5-06 calendar. Still open from earlier: P1-02 (Android licences; non-blocking).

## Exact next steps

1. **Run moderated user tests of the new design** with `docs/product/user-testing-kit.md` (5–8 participants). Watch whether people find their gardens from Today and use the soil-check answers.
   - R-08 follow-ups (P1): persist the selected garden (KI-030), an evening headline naming the plant still waiting, a current-month band in Seasons, long names in plan tags.
2. **P6-07:** profile on a real Android phone (`flutter run --profile`): cold start, designer fps with 100 objects, journal image grid.
3. **Before public release:** horticulturist review (R2), research gaps KI-010..KI-013, plant images (KI-016), product name and branding (PD-001, P6-10), signing, iOS build (KI-003).
4. **P1 backlog:** plant comparison (P4-05), importing an export (ADR-024), notification deep links (KI-028), photo on task completion.

## Checks run (latest, 2026-10-18, Windows host)

- **Living Terrace redesign gate (2026-10-18):**
  - `dart format --set-exit-if-changed`: 0 changed. `flutter analyze`: no issues.
  - `flutter test`: **456 passed**. New tests: `living_today_test`, `plant_journey_test`, `ContainerVerdict` tests and an ARB duplicate-key test. Navigation tests were updated, and the `terrace_plan` golden was regenerated after the tags got wider.
  - Failures along the way, all fixed:
    - 28 tests broken by the tab change;
    - a duplicate ARB key (`milestoneHarvest`) that silently renamed the journal's "Harvest" chip;
    - a flaky perf budget under parallel load, now measured as the median (KI-031);
    - onboarding and overview tests pushed below the 800×600 fold by the new illustrations.
  - **Device test** (`flutter test integration_test -d emulator-5554`, Android 16): **passed** in 32 s on the third run. Runs 1 and 2 failed for these reasons:
    - `flutter test` uninstalls the app after each run, so `pm grant POST_NOTIFICATIONS` found no package and the digest switch stayed off. Fix: `adb install -r` the debug APK, then `pm clear`, then `pm grant`, then run.
    - The test tapped the Journal tab from the garden overview, which now sits above the tabs. Fixed with a `pageBack`.
    - A non-fatal hit-test warning on the onboarding "Rooftop" chip remains. It predates the redesign.
  - Visual checks: Today, the soil sheet, Seasons, plant detail, ideas, the add-plant picker, the journal, the welcome step and the garden overview were rendered to PNG with the real fonts, in light and dark, by a throwaway test that is not committed.
- Earlier, Phase 6:
- Quality gate (Phase 6):
  - `dart format --set-exit-if-changed`: 0 changed.
  - `flutter analyze`: **no issues**.
  - `flutter test`: **437 passed** (after the export, stats, comparison, calendar and re-plan additions; earlier 424). Phase 6 added tests for:
    - the journal repository, timeline and flows;
    - delete all data;
    - accessibility guidelines on every main screen (light and dark) and a 200%-text walk;
    - responsive layouts at three sizes;
    - performance budgets;
    - architecture boundaries.
  - End-to-end device test (Android 16 emulator, after a cold boot): **passed** (21 s) through onboarding, plant, restart, care, notification, designer and journal. Two earlier runs failed because of test assumptions: no garden size, and the first idea not being Tomato. The test was corrected.
  - The device test was **not re-run** after the last batch (export, stats, calendar, re-plan); the host suite covers those changes. Re-run at the next device session.
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
