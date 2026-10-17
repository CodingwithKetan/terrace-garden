# CLAUDE.md

Guidance for Claude Code sessions in this repository.

## Project

**Terrace Garden** (working name) is a Flutter app for terrace, balcony and container gardening, India-first. Core loop: **space → plan → plant → care → progress**. It is local-first and works offline with a bundled, cited plant catalogue and deterministic rules. AI, weather and sync come later behind interfaces.

## Session protocol (mandatory)

**At the start of every session:**
1. Read this file, `TODO.md` and `docs/progress/current-status.md`.
2. Read the docs relevant to the task (see the index below).
3. Run `git status` and `git log --oneline -10`.
4. Identify the last completed task and the next actionable one. Continue from there; never start over.

**At the end of every meaningful session:**
1. Update `TODO.md`. Only mark `[x]` when the acceptance criteria are met and the checks have run.
2. Update `docs/progress/current-status.md` and add an entry to `docs/progress/session-log.md`.
3. Record decisions in `docs/architecture/technical-decisions.md` (new ADR) or the product docs.
4. Record issues and blockers in `docs/quality/known-issues.md`.
5. Record the exact checks run and their results, including failures.

## Docs index

| Need | File |
|---|---|
| What we're building and why | `docs/product/opportunity-analysis.md`, `docs/product/product-requirements.md`, `docs/product/roadmap.md` |
| Competitors | `docs/research/competitor-analysis.md` |
| Horticultural facts and sources (the provenance register) | `docs/research/gardening-references.md` |
| Visual and interaction rules | `docs/design/design-system.md`, `docs/design/screen-inventory.md` |
| Architecture, decisions, schema | `docs/architecture/system-architecture.md`, `technical-decisions.md`, `data-model.md`, `reusable-components.md` |
| Testing and quality gates | `docs/quality/testing-strategy.md`, `docs/quality/known-issues.md` |

## Commands

```bash
flutter pub get
dart run build_runner build -d          # codegen (riverpod, freezed, drift, json)
dart run build_runner watch -d          # during development
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter test integration_test           # needs a running Android emulator
flutter emulators --launch <id>         # list emulators with: flutter emulators
flutter build apk --debug
```

Project SDK: **Flutter 3.44.8 / Dart 3.12.2** (ADR-001). In a Claude Code **cloud** session, Flutter is installed by the environment setup script at `/opt/flutter` (see `docs/progress/current-status.md` → "Working in a Claude Code cloud session"). Use `/opt/flutter/bin/flutter`. Android builds and integration tests run locally only.

## Architecture rules (summary; details in system-architecture.md)

- Feature-first modules: `lib/features/<f>/{domain,data,application,presentation}`, plus `lib/app` (router, theme, DI) and `lib/core` (cross-cutting).
- `domain` is pure Dart: no Flutter, drift or plugins.
- Features never import another feature's `data` or `presentation`.
- State and DI use Riverpod 3 with codegen. The canvas uses a `ChangeNotifier` controller. Routing uses go_router. Persistence uses drift, plus SharedPreferencesAsync for settings.
- Widgets render and forward intents; business rules live in domain and application code.
- Repositories return `Result<T>`. Never call `DateTime.now()` in domain code; inject `Clock`. IDs come from `IdGenerator`.
- Theme tokens only: no raw colours, font sizes or magic spacing numbers.
- All UI strings go in ARB files (`lib/l10n`).
- No secrets in the client, ever.

## Product rules (non-negotiable)

- **Never invent horticultural facts.** Every catalogue or care value needs a source ID from `gardening-references.md`; otherwise set it to `null` and flag it unverified.
- Watering tasks are *check* reminders ("check the soil 2–3 cm down"), never "water every X days" stated as fact.
- Never claim a layout is structurally safe. Recommend a structural engineer for heavy installations.
- Photos are not measurements. AI images (future) are labelled concepts, "not to scale".
- Fertiliser and pesticide guidance is conservative. Show doses only where a source supports them.

## Working style

- Small, testable increments; finish one vertical slice before starting another.
- Inspect files before editing; preserve conventions; avoid unnecessary rewrites.
- Ask the user only for decisions that materially affect product or architecture; otherwise choose, document and proceed.
- Commit only when the user asks. Never skip hooks, weaken tests or disable lints to get a green build.
