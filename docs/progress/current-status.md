# Current Status

Last updated: 2026-10-18

## Phase

**Phase 0 (discovery and research): complete.** Phase 1 (foundation) in progress. SDK decided: local Flutter 3.44.8 (ADR-001).

## State of the repository (handoff point, 2026-10-18)

- Flutter project created (`flutter create --org com.terracegarden --project-name terrace_garden --platforms android,ios`). The **template counter app is still in `lib/main.dart` and `test/widget_test.dart`**; P1-03 replaces it.
- Phase 1 dependencies added and resolved for Flutter 3.44.8 (see `pubspec.yaml` / `pubspec.lock`): flutter_riverpod 3.2.1, riverpod_annotation 4.0.2, go_router 18.1.0, drift 2.31.0, drift_flutter 0.2.8, shared_preferences, freezed_annotation 3.1.0, json_annotation 4.11.0, path_provider, path, uuid, intl, material_symbols_icons, flutter_localizations. Dev: build_runner 2.15.1, riverpod_generator 4.0.3, riverpod_lint 3.1.3, drift_dev 2.31.0, freezed 3.2.5, json_serializable 6.13.0, mocktail 1.0.5, very_good_analysis 10.3.0, alchemist 0.14.0. `cupertino_icons` from the template remains.
- `analysis_options.yaml` uses very_good_analysis; riverpod_lint plugin config is still a TODO (P1-04).
- Git: repository on `main`. See the session log for commit status.

## Working in a Claude Code cloud session

Cloud sessions start from the repo only; conversation history does not carry over, so this file, `TODO.md` and `CLAUDE.md` are the handoff. The environment is Ubuntu with no Flutter or Android SDK preinstalled. Add this as the environment **setup script** at claude.ai/code. It pins the project SDK per ADR-001:

```bash
#!/bin/bash
set -e
if [ ! -x /opt/flutter/bin/flutter ]; then
  git clone --depth 1 --branch 3.44.8 https://github.com/flutter/flutter.git /opt/flutter
fi
/opt/flutter/bin/flutter --version
/opt/flutter/bin/flutter precache --universal --no-android --no-ios || true
```

In the session, use `/opt/flutter/bin/flutter` (or prepend `/opt/flutter/bin` to `PATH`). Format, analyse, unit, widget and golden tests work there. **Android builds, emulator and integration tests do not** (no Android SDK); run those locally on Windows.

## Toolchain (verified 2026-10-18)

| Item | Value |
|---|---|
| Flutter (installed, global) | 3.44.8 stable, Dart 3.12.2 (`C:\src\flutter`) |
| Project SDK | **3.44.8 (local, chosen by user)**; latest stable 3.47.7 noted for a future upgrade |
| Android | SDK 36 (platform android-37), build-tools 36, emulator `gsrtc_emulator` available; **licences not accepted** |
| Java | OpenJDK 25 (Android Studio JBR) |
| iOS | Not buildable on this Windows machine |

## Last completed task

P1-01: SDK decision (local 3.44.8). P1-03 and P1-04 are partly done: project created, dependencies resolved, base lints configured.

## Exact next steps

1. P1-03: replace the template counter app with a minimal `App` bootstrap (`ProviderScope` + `MaterialApp.router`) and an app smoke test; sort pubspec dependencies (lint `sort_pub_dependencies`).
2. P1-04: configure the riverpod_lint 3.1.3 plugin and `build.yaml` generate_for globs; make `flutter analyze` report zero issues.
3. Continue P1-05 → P1-11 in TODO order.

## Next actionable tasks

1. **P1-02:** user runs `flutter doctor --android-licenses` (needed for Android builds only).
2. **P1-03 → P1-11:** create the project, lints, core primitives, theme, fonts, l10n, core widgets, router shell, DB foundation.

## Checks run this phase

- `flutter --version`, `flutter doctor -v`, `flutter devices`, `flutter emulators`: results recorded above.
- Dependency resolution experiments (research agent, scratch projects): the full candidate set resolves on 3.44.8 only with older pins; the 3.47.7 resolution was still being confirmed when Phase 0 closed (see ADR-001).
- After project creation and dependency setup (Flutter 3.44.8, Windows):
  - `dart format --output=none --set-exit-if-changed .`: pass (0 changed).
  - `flutter test`: pass (1 template smoke test).
  - `flutter analyze`: **3 infos** (template `lib/main.dart` required-param order, `test/widget_test.dart` closure type, `pubspec.yaml` dependency sort order). To be fixed in P1-03/P1-04.
