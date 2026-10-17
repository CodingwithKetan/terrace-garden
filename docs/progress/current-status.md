# Current Status

Last updated: 2026-10-18

## Phase

**Phase 3 (garden designer): complete (2026-10-18).** Phases 0–2 are complete, plus the v0.2 visual refresh. Next: Phase 4 (plant catalogue and recommendations).

## State of the repository

- **App:** runs on the local Flutter 3.44.8 (ADR-001). Phase 2 added onboarding, gardens, photos and the terrace checklist. Phase 3 added the dimension-aware layout designer (drift schema v3).
  - Riverpod 3 bootstrap, go_router shell with four tabs (Today, Garden, Plants, Journal) and an adaptive NavigationBar/NavigationRail.
  - A working Settings screen: theme and units, persisted; licences page.
  - Tabs show honest empty states; features arrive in Phases 2–6.
- **Design system in code** (`lib/app/theme/`): tokens, light/dark colour schemes, `CareColors` and `GlassTheme` extensions, component themes, bundled Inter + Fraunces fonts. **Visual direction v0.2 "real, modern, translucent"**: photo backdrops, glass panels, floating glass navigation (design-system §2.4).
- **Core** (`lib/core/`):
  - `Result`/`AppFailure`, `AppLogger`, `Clock`, `IdGenerator`, `LocalDate`, `Length`/`Area`/`Volume` + formatter;
  - 11 shared widgets (`lib/core/widgets/`);
  - drift `AppDatabase` v1 (no tables yet) with schema snapshot.
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

P3-01 → P3-12 and the Phase 3 gate. Still open from earlier: P1-02 (Android licences; non-blocking).

## Exact next steps

1. **Phase 4 (catalogue and recommendations):**
   - P4-DATA-01: catalogue JSON schema and validation test (every sourceId resolves).
   - P4-DATA-02: author ~30 species from gardening-references §2.
   - P4-01 → P4-06: import, catalogue UI, recommendation engine, plantings.

## Checks run (latest, 2026-10-18, Windows host)

- Quality gate (Phase 3):
  - `dart format --set-exit-if-changed`: 0 changed.
  - `flutter analyze`: **no issues**.
  - `flutter test`: **257 passed** (adds designer geometry, layout, history, controller, repository, 4 designer journeys with real gestures, and a canvas golden).
  - Phase 2 integration test on the emulator: passed at the end of Phase 2; **not re-run** after the Phase 3 changes (run it again at the next device session).
  - Designer verified manually on the emulator.
- `dart analyze`: no issues (after removing the non-loading riverpod_lint plugin, KI-008).
- `flutter build apk --debug`: **passed** (after the KI-007 fix; first build 502s, 185 MB debug APK).
- Emulator (Android 16): installed and launched. Verified Today screen, Settings dark theme, setting kept after a cold start, two cold starts open on Today. Integration tests: none exist yet (P2-08).

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
