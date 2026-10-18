# Known Issues, Risks and Blockers

Last updated: 2026-10-18 (Phase 4).

## Blockers

| ID | Issue | Impact | Resolution |
|---|---|---|---|
| ~~KI-001~~ | **Resolved 2026-10-18:** stay on local Flutter 3.44.8 with fallback pins (ADR-001) | Some packages are a few minor versions behind | Plan an SDK upgrade with 3.50 |
| KI-006 | **Pushing to GitHub fails on this machine:** `git push` to `github.com/CodingwithKetan/terrace-garden` gets "curl 55 Connection was reset" (reads such as `ls-remote` work; the pack is only 178 KB). Likely a corporate network/security control (Axis Security client present) | Can't push or use cloud sessions from this machine | Push from a network/machine where personal GitHub uploads are allowed, or check with IT. Remote `origin` is already configured |
| KI-002 | **Android SDK licences not accepted** (`flutter doctor`) | Android builds will fail | User runs `flutter doctor --android-licenses` (interactive) |

## Environment limitations

| ID | Issue | Impact | Mitigation |
|---|---|---|---|
| KI-003 | iOS cannot be built or tested on this Windows machine | iOS-specific bugs found late | Android-first verification; macOS CI runner or a Mac before release |
| KI-004 | Golden image rendering differs between Windows and Linux | Flaky golden tests | alchemist CI goldens; generate goldens in one environment (ADR-010) |
| KI-005 | SQLite on host and devices. On Flutter 3.44, drift resolved to sqlite3 2.9.4 (no build hooks) | **Host part resolved 2026-10-18:** the in-memory DB test passes on Windows. Android not yet verified (KI-007) | Verify on the emulator once Android builds work |
| ~~KI-007~~ | **Resolved 2026-10-18.** The Gradle wrapper failed with "PKIX path building failed". The user's existing trust store (`%USERPROFILE%\.android-jbr-truststore\cacerts`, contains `emr-root-ca`) was only applied to the Gradle daemon via `org.gradle.jvmargs`, not to the wrapper JVM that downloads Gradle | | With user approval, set the user environment variable `GRADLE_OPTS=-Djavax.net.ssl.trustStore=C:/Users/ketan.ghori/.android-jbr-truststore/cacerts -Djavax.net.ssl.trustStorePassword=changeit`. Terminals opened before this change need restarting |
| KI-009 | **Emulator Play Services overlays.** `gsrtc_emulator` repeatedly opens Google "add account / Something went wrong" screens (it can't reach google.com through the proxy), covering the app under test. Once the app opened on the Journal tab, and later the stored theme was "system" instead of "dark"; neither reproduced in controlled runs. Most likely manual taps in the visible emulator window  2026-10-18 (Phase 4): during a manual check the emulator reached a load average of ~22 and showed an ANR dialog; system_server itself skipped frames, so the slowdown was emulator-wide. In the same session the onboarding state changed without a garden being created during a long idle gap (again likely stray input). | Unreliable manual and screenshot checks on this emulator | For UI verification, check the top activity and accessibility tree, or create an AVD without Google Play (AOSP image). Revisit the Journal start if it ever recurs |
| KI-008 | **riverpod_lint not active.** 3.1.3 can't load as an analysis-server plugin on Dart 3.12 (needs `analysis_server_plugin ^0.3.8`); newer versions need a newer riverpod than the Flutter 3.44 codegen pins allow | Riverpod-specific mistakes aren't caught by lint | Re-enable with the SDK upgrade (ADR-011). Until then, rely on code review and tests |

## Data and content gaps (must resolve before public release)

| ID | Issue | Source |
|---|---|---|
| KI-010 | Container sizes UNVERIFIED for okra, bitter/bottle gourd, curry leaf, lemongrass, jasmine, hibiscus; proxies for amaranth, methi, tulsi | gardening-references §2b, §11 |
| KI-011 | Snippet-only (SS) facts need re-verification (IIHR nutrient dose, RHS pages, TNAU tomato/brinjal/amaranth, wet-soil weight) | gardening-references §11 |
| KI-012 | Pet toxicity not documented for *Tagetes*, *H. rosa-sinensis*, tulsi, curry leaf | gardening-references §7, §11 |
| KI-013 | Organic fertiliser dosage evidence is weak; show only frequency guidance with a "limited evidence" badge | gardening-references §5 |
| KI-014 | TN DIY kit contents/price vary by source; verify before shipping a kit preset | competitor-analysis Part D |
| KI-015 | Content licensing: RHS non-commercial; UC IPM educational reproduction only; state facts with attribution, never copy text | gardening-references §11 |
| KI-016 | Plant images: no licensed image set yet | design-system §11 |
| KI-017 | No sourced sowing-window region for west, central and east Indian cities (Mumbai, Pune, Ahmedabad, Indore, Kolkata, etc.). They are selectable but have no `GrowingRegion`, so season fit will be reported as unknown | `lib/features/garden/domain/region.dart`; gardening-references §2c |
| KI-018 | Inspector edits record one undo step per keystroke (typing "60" creates two steps). Harmless but noisy | `designer_sheets.dart`; coalesce edits per field focus in a later polish task |
| KI-019 | Catalogue has 25 species (plan: ~30), no water-need, difficulty or spacing fields, and no plant photos. Recommendations therefore ignore experience, weekly time and style; no source gives a per-species effort rating | `assets/catalogue/plants.json`; ADR-021 |
| KI-024 | Planting crowding is an estimate: the source's "N plants per minimum container" scaled by how many minimum volumes fit. The UI labels it "rough guide" | `planting_fit.dart`; S1 |

## Code and design debt

| ID | Issue | Plan |
|---|---|---|
| KI-025 | **Cross-feature imports break the CLAUDE.md rule** ("features never import another feature's data or presentation"). The garden overview embeds designer and plantings widgets; the catalogue, plantings and care screens import each other's providers and sheets; care tables reference the plantings table. This began in Phase 3 | Phase 6: give each feature a small public API file, move composition into `lib/app`, and add an import-boundary check to `tool/check` |
| KI-026 | The Android notification channel name and description are hardcoded in English | Localise when Hindi ships (PD-003) |
| KI-027 | Editing a planting (date or start type) doesn't re-plan its existing care rules; only new plantings get plans, so transplant and harvest dates can go stale | Re-plan on edit, keeping rules the user has customised |
| KI-028 | No month calendar (CARE-02) yet; Today lists the next 7 days. Notification taps open the app on Today (no deep link to a specific task) | P1 polish |

## Research evidence gaps

| ID | Issue |
|---|---|
| KI-020 | No Reddit sentiment data (blocked); limited Google Play data for Android-only rivals |
| KI-021 | No authoritative Indian terrace-gardening market-size data |
| KI-022 | Indian (INR) plan prices for competitors not exactly verifiable (Play shows ranges) |
| KI-023 | Google Play exact-alarm policy page not fetched; ADR-008 avoids exact alarms regardless |

## Open product decisions (defaults chosen; revisit with user feedback)

| ID | Decision | Default |
|---|---|---|
| PD-001 | Product name and application ID | Working name "Terrace Garden"; final name and app ID to be confirmed before first store upload |
| PD-002 | Monetisation | MVP free; explore commerce/partnerships and premium weather/AI later |
| PD-003 | First non-English language | Hindi |
