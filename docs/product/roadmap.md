# Roadmap

Status: v1.0 (2026-10-18). Phases run in order; each ends with the quality gates and a doc update. Detailed tasks live in `TODO.md`.

| Phase | Theme | Deliverable | Exit criteria |
|---|---|---|---|
| 0 | Discovery & research | Research, product direction, architecture plan, TODO | Docs in place: competitor analysis, opportunity analysis, PRD, design system, screen inventory, architecture, testing strategy, TODO (**complete when this file ships**) |
| 1 | Foundation & design system | Flutter project, theme, shell navigation, core widgets, DB setup, lint & CI-ready tests | App runs on an Android emulator with themed shell, 4 tabs, settings skeleton; format/analyse/test green; contrast tests pass |
| 2 | Garden setup & profile | Onboarding, garden CRUD, photos | User can create, edit, reopen a garden and manage photos offline |
| 3 | Garden designer MVP | Canvas, objects, validation, undo/redo, autosave, space summary, list alternative | Acceptance scenario in PRD FR-C passes; geometry tests ≥ 90% coverage |
| 4 | Catalogue & recommendations | ~30 sourced species, catalogue UI, rule engine, plantings | User finds suitable plants with reasons and plants them into containers |
| 5 | Care tracking | Care rules, tasks, Today agenda, calendar, notifications | Scheduling and notification planner tests pass; reminders fire on emulator |
| 6 | Progress & refinement | Journal, stats, accessibility pass, empty states, integration tests, export | MVP ready for user testing (5–8 users) |
| 7 | Advanced (gated) | Evaluated individually | Each feature has value hypothesis, cost estimate and plan before build |

## Phase 7 candidate order (to be re-evaluated after user testing)

1. **Weather-aware care** (heatwave and rain adjustments; Open-Meteo or similar, behind a `WeatherService` abstraction).
2. **Hindi localisation**, then regional languages by demand.
3. **Kit presets and partnerships** (if not done as a Should in the MVP).
4. **Cloud sync and accounts** (Supabase; see technical decisions), multi-device, household sharing.
5. **AI diagnosis / identification** via a server-side proxy to a partner API.
6. **Photo-assisted layout** (trace-over-photo with user calibration), then AI concept renders, clearly labelled.
7. **Shopping list / bill of materials** with partner nurseries.

## Milestones

- **M1 (end Phase 3):** internal demo: create a garden and design it.
- **M2 (end Phase 5):** core loop works: plan → plant → care.
- **M3 (end Phase 6):** MVP beta for user testing; validate assumptions in `opportunity-analysis.md` §7.
