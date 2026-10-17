# Terrace Garden (working name)

A Flutter app that helps urban gardeners, starting in India, turn a terrace or balcony into a practical, season-aware container garden.

**Plan your real space → get plants that suit it this season → follow a care plan that knows each container → track progress.**

## Status

**Phase 0 (discovery and research) is complete.** No application code exists yet. Phase 1 (foundation and design system) is in progress on the local Flutter 3.44.8 SDK (ADR-001).

| | |
|---|---|
| Current status | `docs/progress/current-status.md` |
| Task list | `TODO.md` |
| Roadmap | `docs/product/roadmap.md` |

## What makes it different

- A **dimension-aware container canvas** with pots, grow bags, troughs and vertical planters. It calculates area used and soil volume, and checks whether each plant fits its container.
- **Indian seasons and regions** instead of frost dates. Sowing windows come from ICAR, TNAU, KAU and state horticulture sources.
- **Care with judgement.** Reminders say "check the soil first", adapted to the container and plant stage, and every rule is sourced.
- **Free and offline core**, with no paywall before the app has shown its value.

## Documentation

- Product: [opportunity analysis](docs/product/opportunity-analysis.md), [requirements](docs/product/product-requirements.md), [roadmap](docs/product/roadmap.md)
- Research: [competitors](docs/research/competitor-analysis.md), [gardening references](docs/research/gardening-references.md)
- Design: [design system](docs/design/design-system.md), [screen inventory](docs/design/screen-inventory.md)
- Architecture: [system](docs/architecture/system-architecture.md), [decisions](docs/architecture/technical-decisions.md), [data model](docs/architecture/data-model.md), [components](docs/architecture/reusable-components.md)
- Quality: [testing strategy](docs/quality/testing-strategy.md), [known issues](docs/quality/known-issues.md)

## Development setup (from Phase 1)

Prerequisites: Flutter 3.44.8 stable (ADR-001), Android SDK with licences accepted (`flutter doctor --android-licenses`), and an Android emulator.

Run, test and quality-gate commands are listed in [CLAUDE.md](CLAUDE.md#commands). Per-feature run and configuration notes will be added as features ship.
