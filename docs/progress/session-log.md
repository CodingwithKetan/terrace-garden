# Session Log

Newest first. Keep entries concise: goal, what was done, checks, next.

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
