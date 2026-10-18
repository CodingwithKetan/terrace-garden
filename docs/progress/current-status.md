# Current Status

Last updated: 2026-10-18

## Phase

**Phase 4 (plant catalogue and recommendations): complete (2026-10-18).** Phases 0–3 are complete, plus the v0.2 visual refresh. Next: Phase 5 (care tracking).

## State of the repository

- **App:** runs on the local Flutter 3.44.8 (ADR-001). Phase 2 added onboarding, gardens, photos and the terrace checklist. Phase 3 added the dimension-aware layout designer. Phase 4 added the sourced 25-species catalogue (bundled JSON, ADR-021), plant detail, recommendations with reasons and a shortlist, and plantings in containers with fit warnings (drift schema v4).
  - Riverpod 3 bootstrap, go_router shell with four tabs (Today, Garden, Plants, Journal) and an adaptive NavigationBar/NavigationRail.
  - A working Settings screen: theme and units, persisted; licences page.
  - Tabs show honest empty states; features arrive in Phases 2–6.
- **Design system in code** (`lib/app/theme/`): tokens, light/dark colour schemes, `CareColors` and `GlassTheme` extensions, component themes, bundled Inter + Fraunces fonts. **Visual direction v0.2 "real, modern, translucent"**: photo backdrops, glass panels, floating glass navigation (design-system §2.4).
- **Core** (`lib/core/`):
  - `Result`/`AppFailure`, `AppLogger`, `Clock`, `IdGenerator`, `LocalDate`, `Length`/`Area`/`Volume` + formatter;
  - 11 shared widgets (`lib/core/widgets/`);
  - drift `AppDatabase` v4 (gardens, garden_photos, layout_elements, plantings, shortlist_entries) with schema snapshots and migration tests.
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

P4-DATA-01, P4-DATA-02, P4-01 (as ADR-021), P4-02, P4-03, P4-04, P4-06 and the Phase 4 gate. Deferred: P4-05 compare (P1), P4-DATA-03 research gaps and P4-DATA-04 plant images (P1, block public release only). Still open from earlier: P1-02 (Android licences; non-blocking).

## Exact next steps

1. **Phase 5 (care tracking):**
   - P5-01: recurrence engine (pure, exhaustive tests).
   - P5-02: CarePlanner from sourced rules only (check-the-soil watering, conservative feeding, pest checks; gardening-references §4–§6).
   - P5-03 → P5-05: task tables (schema v5), materialiser, task actions, Today agenda.
   - P5-07/P5-08: notifications (needs a notifications plugin; daily digest per ADR-008).

## Checks run (latest, 2026-10-18, Windows host)

- Quality gate (Phase 4):
  - `dart format --set-exit-if-changed`: 0 changed.
  - `flutter analyze`: **no issues**.
  - `flutter test`: **324 passed**. New tests cover:
    - catalogue validation on the real assets, plus parser rejection cases;
    - the recommendation engine and the planting fit check;
    - the plantings repository and the v3→v4 migration with data;
    - 5 plant journeys;
    - a bottom-sheet keyboard regression test.
  - Integration test `integration_test/garden_setup_test.dart` on the Android 16 emulator, extended to add a plant from the ideas screen and check it after a restart:
    - **First run failed.** The log wasn't captured; most likely an old install with onboarding already done.
    - **The next two runs passed.**
  - Manual check on the emulator:
    - **Bug found:** the keyboard covered bottom-sheet content, so city search results couldn't be tapped. Fixed in `showAppBottomSheet`, covered by a test, and confirmed on the device.
    - **Stopped early:** the emulator became overloaded (load average ~22, ANR dialog; KI-009), so the ideas, detail and planting screens were not reviewed visually on the device.
- `flutter build apk --debug`: **passed** (about 38 s, incremental).
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
