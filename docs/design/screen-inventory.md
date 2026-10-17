# Screen Inventory

Status: v0.1 (Phase 0). Screen IDs are referenced from `TODO.md`. "Phase" is when the screen is first built; MVP = Phases 1–6.

## Information architecture

```text
App launch
 ├─ First run → Onboarding (ONB-*)      (skippable after step 1)
 └─ App shell (bottom NavigationBar / NavigationRail)
     ├─ Today        (HOME-01)          what to do now, garden snapshot
     ├─ Garden       (GDN-*)            gardens, photos, profile, designer
     ├─ Plants       (PLT-*, REC-*)     catalogue, recommendations, my plants
     └─ Journal      (JRN-*)            progress photos, notes, milestones, stats
     Settings (SET-*) is reached from the avatar/menu on Today.
```

Navigation decisions:
- Four top-level destinations keep the bar uncluttered; the care calendar lives inside **Today** (agenda) with a full calendar view (CARE-02) one tap away, because daily use is task-driven.
- The **designer** (DSN-01) is a full-screen route above the shell (no bottom bar) to maximise canvas space.
- Deep links / notification taps open the relevant task (CARE-03) on top of the Today stack.

## Screens

### Onboarding (Phase 2)

| ID | Screen | Purpose | Key content / actions | States |
|---|---|---|---|---|
| ONB-01 | Welcome | Set tone, value proposition | Hero photo, 3 benefit lines, "Start my garden", "I'll explore first" | n/a |
| ONB-02 | Your space | Minimal garden creation | Name (default "My terrace"), space type (terrace/balcony/rooftop/windowsill/other), optional length × width + unit | Validation (positive numbers, sane max) |
| ONB-03 | Light & location | Environment basics, all optional | City picker (offline list) or "Skip", sun hours (buckets: <3, 3–6, 6+ / Not sure), facing direction (8-point / Not sure) | "Not sure" is valid everywhere |
| ONB-04 | Goals & style | Personalisation | Goals (multi-select: vegetables, herbs, flowers, ornamental), style cards, experience level, weekly time, budget band | Skippable |
| ONB-05 | Ready | Summary and next step | What we'll do next; CTA "Design my layout" or "See plant ideas" | n/a |

Notification permission is **not** requested during onboarding; it's requested in context when the first care task is created (CARE-05).

### Today (Phase 1 shell, Phase 5 content)

| ID | Screen | Purpose | Key content / actions | States |
|---|---|---|---|---|
| HOME-01 | Today | Daily hub | Greeting + date, season banner (if location known), today's/overdue tasks grouped by garden, quick complete/skip, garden snapshot card, "Check the soil before watering" guidance | Empty (no garden → create CTA; garden but no plants → add plants CTA), loading, error |

### Garden (Phase 2–3)

| ID | Screen | Purpose | Key content / actions | States |
|---|---|---|---|---|
| GDN-01 | Gardens list | All garden projects (MVP: typically one) | Garden cards (cover photo, type, size, plant count), "New garden" | Empty, loading, error |
| GDN-02 | Garden overview | Hub for one garden | Cover photo, profile summary with "Not set" fields, layout preview thumbnail, plants list, photos strip, upcoming tasks | Partial data, loading, error |
| GDN-03 | Edit garden profile | Progressive profile editing | All ONB fields in one scrollable form, unknown values allowed | Validation errors, unsaved-changes prompt |
| GDN-04 | Photo gallery | Organise garden photos | Grid, add (camera/gallery), view, replace, delete, caption, tag (e.g. "north view") | Empty, permission denied, loading |
| GDN-05 | Photo viewer | View a single photo | Pinch zoom, caption, date, replace, delete | Missing file (file removed externally) |
| GDN-06 | Environment notes | Record observations | Sun hours by season, wind exposure, water access, drainage, load notes with "consult a structural engineer" guidance | Empty |

### Designer (Phase 3)

| ID | Screen | Purpose | Key content / actions | States |
|---|---|---|---|---|
| DSN-01 | Layout designer | Dimension-aware 2D editor | Canvas (pan/zoom, grid, boundary), toolbar (add, undo, redo, measure toggle, snap toggle), object palette sheet, selection handles, live dimension labels, validation badges, save state indicator | New layout (prompt for dimensions if unknown), invalid placement, unsaved changes, autosave error |
| DSN-02 | Object palette (sheet) | Add elements | Categories: structure (wall, railing, path, tap), containers (round pot, rectangular planter, grow bag, raised bed, vertical planter), plants | n/a |
| DSN-03 | Object inspector (sheet / side panel) | Precise edits | Name, exact size inputs, position, rotation, container volume (derived), assigned plants, duplicate, delete | Validation errors |
| DSN-04 | Layout objects list | Accessible alternative to dragging | List of all objects with size/position, edit/delete, warnings | Empty |
| DSN-05 | Space summary (sheet) | Understand capacity | Total area, area used/free, counts by type, warnings (overlaps, out of bounds, crowded plantings) | n/a |

### Plants & recommendations (Phase 4)

| ID | Screen | Purpose | Key content / actions | States |
|---|---|---|---|---|
| PLT-01 | Catalogue | Browse/search plants | Search, filter chips (category, sun, container size, difficulty, season), plant image cards | Empty search, loading, error |
| PLT-02 | Plant detail | Trustworthy plant info | Photo, names (common/local/scientific), quick facts (sun, water, container size, days to harvest), care summary, seasons for region, safety, **sources** section, "Add to garden"/"Shortlist" | Missing data shown as "Not documented" |
| REC-01 | Recommendations | Plants for this garden | Ranked list with "Why this plant" reasons and "Watch out" caveats, filters by goal/style, shortlist toggle | Not enough profile data → prompts to add sun/location, empty |
| REC-02 | Compare | Decide between shortlisted plants | 2–3 columns: sun, water, container, effort, harvest time, fit score breakdown | <2 items |
| REC-03 | Shortlist | Saved suggestions | List, remove, replace with alternative, add to layout | Empty |
| PLT-03 | My plants | Garden inventory | Plantings grouped by container/bed, planting date, stage, next task | Empty |
| PLT-04 | Planting detail | One planted instance | Species link, container, date planted, stage, care history, photos, edit/remove | n/a |
| PLT-05 | Add planting (flow) | Plant into garden | Choose species → container/bed (from layout or "unassigned") → date + stage (seed/seedling/established) → confirm & generate care plan | Validation (container too small warning) |

### Care (Phase 5)

| ID | Screen | Purpose | Key content / actions | States |
|---|---|---|---|---|
| CARE-01 | Agenda (part of HOME-01) | Upcoming tasks | Overdue/today/upcoming sections | Empty |
| CARE-02 | Calendar | Month/week view | Dots by category, day agenda | Empty |
| CARE-03 | Task detail | Do the task well | Instructions, "check first" guidance, why this task, source; actions: complete (with optional note/photo), skip (reason), reschedule | Already completed, deleted planting |
| CARE-04 | Care plan for a planting | Review/edit rules | Recurring rules with interval, next date, pause/edit, reset to recommended | n/a |
| CARE-05 | Notification permission rationale | Contextual ask | Benefit explanation, Allow / Not now; settings shortcut if permanently denied | Denied, permanently denied |

### Journal (Phase 6)

| ID | Screen | Purpose | Key content / actions | States |
|---|---|---|---|---|
| JRN-01 | Journal timeline | Progress over time | Dated entries (photos, notes, milestones, completed tasks), filter by plant/garden | Empty |
| JRN-02 | New entry | Capture progress | Photo(s), note, link planting, milestone type (germinated, flowered, first harvest, harvest qty) | Permission denied |
| JRN-03 | Compare photos | Before/after | Side-by-side or slider between two dated photos | <2 photos |
| JRN-04 | Stats & achievements | Motivation | Tasks completed, streaks, harvests, plants grown; gentle achievements | Empty |

### Settings (Phase 1 skeleton, filled progressively)

| ID | Screen | Purpose |
|---|---|---|
| SET-01 | Settings | Units (metric/imperial), theme, language, notification preferences (quiet hours, daily digest time), data export/delete, about & sources, licences |
| SET-02 | About & sources | Gardening references, image attributions, open-source licences, disclaimers |

## Shared overlays

- Confirmation dialog (destructive actions).
- Photo source sheet (camera / gallery).
- Unit picker, city picker.
- Undo snackbar.
