# Product Requirements (MVP)

Status: v1.0 (Phase 0, 2026-10-18). Working name: **Terrace Garden** (placeholder; final name and brand TBD and must not resemble any competitor's).
Scope and priorities come from `opportunity-analysis.md`. Screen IDs refer to `docs/design/screen-inventory.md`. Entities refer to `docs/architecture/data-model.md`.

## 1. Product summary

A mobile app (Android first, iOS supported) that helps urban gardeners turn a terrace or balcony into a practical, season-aware container garden. It runs a single loop: **space → plan → plant → care → progress**. The MVP works fully offline with bundled, sourced plant data and deterministic rules. No paid services.

## 2. Principles and non-negotiables

1. **Honesty:** photos are not measurements; AI images (later) are concepts; schedules are guides; data without a source is labelled "not documented" or "unverified".
2. **Progressive:** every profile field is optional except the garden name. The app is useful within 60 seconds of first launch.
3. **Local-first:** all MVP features work offline; user data stays on the device until sync exists.
4. **Safety:** terrace load and waterproofing advice always recommends a qualified structural engineer for heavy installations; pesticide and fertiliser guidance is conservative, organic-first where sourced, with safety caveats.
5. **Accessibility:** WCAG 2.2 AA contrast, 48dp touch targets, 200% text scale, and the canvas has a list alternative.

## 3. Functional requirements

### FR-A Onboarding and garden profile (ONB-*, GDN-03)
- A1. First run shows welcome → space → light and location → goals and style → ready. Every step after ONB-02 is skippable; the user can also "explore first" without creating a garden.
- A2. Fields: name, space type, length/width + unit, sun hours bucket, facing direction, city/region (offline list mapped to a region profile), experience, style, goals, weekly time, budget band, language (English in MVP), notification preferences.
- A3. "Not sure" is a valid answer for sun, facing and dimensions. Unknown values show as "Not set · Add" in the garden overview.
- A4. The profile can be edited at any time; edits re-run recommendations but never silently change existing plantings or tasks.
- **Acceptance:** a user can create a garden with only a name and reopen it after an app restart; all other fields persist when provided; invalid dimensions (≤0, > 200 m, non-numeric) are rejected with inline messages.

### FR-B Photos (GDN-04, GDN-05)
- B1. Capture with the camera or pick one or more photos from the gallery; photos are compressed and copied into app storage; thumbnails are generated.
- B2. Organise per garden; caption and tag; set cover photo; view full-screen with zoom; replace; delete (with confirmation; deletes the file).
- B3. Permission denied (camera) → gallery still works; explanation plus "Open settings".
- B4. Record environmental observations (GDN-06) as structured fields plus notes.
- B5. Photos are never used to derive dimensions in the MVP. Future estimation must be labelled and confirmed by the user.
- **Acceptance:** add, view, replace and delete work offline and survive restarts; deleting a garden deletes its photo files; missing files show a placeholder rather than crashing.

### FR-C Garden designer (DSN-*)
- C1. Canvas shows the garden boundary at true proportions from the profile dimensions (prompt if unknown); grid with minor/major lines; pan and pinch-zoom; north indicator if facing is known.
- C2. Object palette: wall/railing, path, water point, round pot (diameter, depth), rectangular planter/trough, grow bag (standard size presets, e.g. 12×12, 15×15, 18×9, 24×18, 24×24 in; custom), raised bed, vertical planter. Plants are placed into containers (FR-E) and shown as spread circles.
- C3. Select, move (drag), resize (handles; precise values in the inspector), rotate (handle; 15° snap), duplicate, delete.
- C4. Snapping to grid and edges (toggle). Dimension labels for the selected object and its distances to the nearest walls.
- C5. Validation:
  - **Error** for an object outside the boundary or overlapping containers.
  - **Warning** for crowded plantings or a container too shallow for its plant.
  - Each warning has an icon, a text explanation, and a highlighted object.
- C6. Undo/redo (≥ 50 steps per session); autosave (debounced) with a visible save status; reopening restores the exact layout.
- C7. Space summary: total area, footprint used/free (%), container counts by type, total soil volume (litres, derived), warning count.
- C8. Accessible objects list (DSN-04) offers the same edit capabilities as the canvas.
- **Acceptance:** geometry and conversion functions have unit tests (see testing strategy); a user can create a 3 m × 1.2 m balcony, add three pots and a grow bag, rotate one, undo/redo, see an overlap error when dragging one pot onto another, save, restart the app and see the same layout; works on a 360dp-wide phone.

### FR-D Plant catalogue (PLT-01, PLT-02)
- D1. Bundled, versioned dataset (~30 species in the MVP) with: common names (English + Hindi where sourced), scientific name, category, sun needs, water need (qualitative), minimum container depth/volume, spacing or plants per container, days to harvest, sowing windows per region, care rule templates, safety (pets/children), image + attribution, sources and data status.
- D2. Search (common, local or scientific name) and filters (category, sun, container depth, difficulty, sow-now for my region).
- D3. Plant detail shows a "Sources" section and data confidence; missing values say "Not documented".
- **Acceptance:** every species record passes a dataset validation test (required fields, source IDs resolve to `gardening-references.md` entries, ranges sane).

### FR-E Recommendations and plantings (REC-*, PLT-03..05)
- E1. Rule-based scoring per species against the garden profile and current month: sun fit, season/region fit (sow now / soon / out of season), container availability and depth, goals/style match, effort vs available time and experience.
- E2. Each recommendation lists **reasons** ("Suits 6+ hours of sun", "Sow now in South India: Oct–Nov") and **caveats** ("Needs a container ≥ 30 cm deep", "Your sun level is unknown, so we assumed partial sun").
- E3. Shortlist, remove, replace with a similar plant, and compare (S2).
- E4. Add planting: species → container on the layout (or unassigned) → quantity → date → stage. Container-too-small and overcrowding warnings come from the same rules as the designer.
- **Acceptance:** the recommendation engine is deterministic and fully unit-tested; changing sun from "unknown" to "6+ hours" re-ranks results predictably; reasons are always present.

### FR-F Care calendar (HOME-01, CARE-*)
- F1. When a planting is created, care rules are instantiated from species templates, adjusted by stage and container (e.g. small containers and grow bags are flagged for more frequent checks in hot months, only as sourced).
- F2. Tasks: water (check-first guidance), fertilise, prune/pinch, repot, inspect (pests/disease), sow, harvest, support/stake. Each task shows why, how, check-first guidance and sources.
- F3. Complete (optional note/photo), skip (reason: rained, soil still moist, not needed, other), reschedule (date picker). Completion recalculates the next occurrence per the rule's anchor; skip/reschedule never creates duplicates.
- F4. Today agenda: overdue, today, upcoming; grouped by garden and container; bulk "watered all in this garden".
- F5. Calendar month view (CARE-02); per-planting care plan editing (CARE-04): change interval, pause, reset to recommended.
- F6. Persistent guidance: "This is a guide. Check the soil about 2–3 cm deep before watering." (Exact wording to be sourced.)
- **Acceptance:** scheduling tests cover early/late completion, skip, reschedule, pause, deletion and idempotent regeneration; no duplicate tasks for the same rule and date.

### FR-G Notifications (CARE-05, SET-01)
- G1. Permission requested in context (first care plan), with a rationale screen; the app is fully usable without it.
- G2. Daily digest at a user-chosen time (default 7:30 local) summarising today's tasks; optional per-task reminders; quiet hours.
- G3. Notifications are derived from pending tasks by an idempotent planner (cancel stale, schedule missing); never more than the platform limit (iOS 64 pending), rolling forward on app open.
- G4. Tapping a notification opens the task or the Today screen.
- **Acceptance:** the planner is unit-tested; completing or deleting a task cancels its notification; changing digest time reschedules without duplicates.

### FR-H Progress journal (JRN-*)
- H1. Entries with date, photos, note, linked planting, milestone (germinated, transplanted, flowering, first fruit, harvest + quantity).
- H2. Timeline filterable by garden and planting; completed care tasks appear in the timeline.
- H3. (Should) Before/after comparison; simple stats (tasks completed, harvests, active plants).

### FR-I Terrace guidance (GDN-06, SET-02)
- I1. Checklist content: drainage and outlet clearance, waterproofing check, weight awareness (wet soil is heavy; distribute load near beams/columns; consult a structural engineer for raised beds and large planters), wind and railing safety for balconies, monsoon prep, heat protection (shade net, mulching) — all sourced in `gardening-references.md`.
- I2. No specific load numbers are presented unless an authoritative source is recorded.

### FR-J Settings and data (SET-*)
- Units (metric/imperial), theme (system/light/dark), notifications, about & sources, licences, image attributions, delete all data (with confirmation). (Should) Export.

## 4. Non-functional requirements

| Area | Requirement |
|---|---|
| Performance | Cold start < 2.5s on a mid-range Android phone (2022+); canvas at 60fps with ≤ 100 objects; lists virtualised |
| Offline | 100% of MVP features work offline |
| Storage | Photos compressed (≤ ~1600px long edge, quality ~80); app shows storage used |
| Reliability | No data loss on crash: transactional writes; autosave in the designer |
| Security & privacy | No accounts or analytics SDKs in the MVP; no secrets in the client; location stored at city precision; delete all data supported |
| Accessibility | See design system §10 |
| Localisation | All UI strings in ARB files from Phase 1; English (India) in the MVP; Hindi as Could-have |
| Platforms | Android 8.0+ (API 26+; confirm against plugin minimums in Phase 1); iOS 15+ (verified via CI or Mac before release) |
| Quality | Format, analyse and test gates per `docs/quality/testing-strategy.md` |

## 5. Out of scope for the MVP

Accounts, sync, AI identification/diagnosis, AI renders, photo-to-layout, weather APIs, commerce, community, non-rectangular boundaries, multiple languages beyond English (Hindi is Could-have), and temperate region profiles. See `opportunity-analysis.md` §6.

## 6. Success metrics (for user testing / beta)

- ≥ 70% of testers create a garden and add at least one planting in the first session.
- ≥ 50% of testers who open the designer place at least two containers.
- ≥ 40% of testers complete at least one care task in week 1.
- Qualitative: testers can explain *why* a plant was recommended; no tester believes a schedule is a rigid rule.
