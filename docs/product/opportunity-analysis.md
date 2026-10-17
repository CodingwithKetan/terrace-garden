# Opportunity Analysis

Status: v1.0 (Phase 0, 2026-10-18). Based on `docs/research/competitor-analysis.md`. Sections are referenced as CA-A2, CA-D §2 and so on. Claims about competitors are in that document with sources. Items marked *(assumption)* need validation.

## 1. Hypothesis verdict

> *Original hypothesis:* our advantage is the combination of a usable, dimension-aware terrace garden planner and locally relevant plant-care guidance.

**Verdict: partially supported (medium confidence).**

- **Supported:**
  - No product we found combines a dimensioned container/terrace planner with India-relevant care and seasons (CA-A1, CA-D §3).
  - Global planners rely on frost dates and USDA zones, which structurally do not fit frost-free, monsoon-driven Indian seasons.
  - Care apps have no spatial model at all.
- **Challenged:**
  1. Layout is *not* the top pain Indian terrace gardeners report. Pest and disease identification, fertilising and sowing time rank higher, followed by space and time, monkeys, roof leakage and waterlogging (CA-D §2.1).
  2. Each half is copyable on its own. Fryd already supports cm dimensions; Plantix is free and vernacular.
  3. Willingness to pay is unproven, because diagnosis, content and community help are all free elsewhere.

**Refined position:** the planner is the *mechanism*, not the headline. The headline is **local, practical outcomes for a specific terrace**:

> "Tell us about your terrace or balcony: a photo, its rough size, the sun. We'll tell you what fits (how many pots or grow bags, of what size), what to sow *this season where you live*, and how to look after each plant, with reminders that tell you to check the soil before you water."

The moat comes from the *depth of the local layer*: Indian seasons and regions, container-scale crop data with sources, terrace realities, kit presets, and later languages and weather. The planner is what *uses* that layer, because every recommendation and task knows which container, how much soil, and how much sun.

## 2. The most important user problems

Ranked by evidence strength and fit with our product.

| # | Problem | Evidence | How the MVP addresses it |
|---|---|---|---|
| P1 | "I don't know what to grow here, now." Sowing time and variety knowledge | Survey technical constraint #3 (CA-D §2.1); frost-date tools don't fit India (CA-A1) | Region- and season-aware recommendations with reasons and sources |
| P2 | "My plants die. I overwater, underwater, or the pot is wrong." | Overwatering is the most common beginner mistake; heat dries small pots within hours (CA-D §2.2) | Container-aware care plan, "check soil first" guidance, container depth/volume checks per crop |
| P3 | Pests and disease | Survey technical constraint #1 (CA-D §2.1); Cochin study | MVP: scheduled pest-inspection tasks with sourced, plain-language checklists of common pests per crop, plus organic-first guidance with safety caveats. Later: AI diagnosis via a partner API |
| P4 | Fertiliser and manure: what, when, how much | Survey technical constraint #2 | Cautious per-crop feeding guidance with sources; dosage shown only where a source supports it |
| P5 | Space: "how much can I fit?" | Survey general constraint #1 (space and time) | Dimension-aware canvas with container primitives, area-used summary and "fits N grow bags" |
| P6 | Time: "I can't keep track" | Survey general constraint #1 | Today agenda, grouped notifications, low-effort plant filters |
| P7 | Terrace risks: leakage, waterlogging in monsoon, load | Survey general constraints; Mumbai SWOT; retrofit costs (CA-D §2.2) | Terrace safety checklist and monsoon-prep tasks. Advise consulting a structural engineer; no load numbers we can't source |
| P8 | Distrust of paywalls and trial traps | Dominant complaint theme (CA-A1 #6) | Core planning and care are free and work offline |

## 3. Unique value proposition

**For** urban Indian households growing food and flowers on terraces and balconies, **who** struggle to know what to grow, in what containers and how to care for it in Indian conditions, **our app** is a terrace garden planner and care companion **that** turns your actual space into a practical, season-aware plan, telling you what fits, what to sow now and what to do each day. **Unlike** global planners built on frost dates, or care apps that treat plants as a list, **we** connect your real containers, local seasons and every care reminder in one place, with sources for every recommendation, and free core features.

Pillars:
1. **Your real space:** a dimension-aware container canvas (pots, grow bags, troughs, vertical planters) with capacity summaries. Photos document the space but aren't treated as measurements.
2. **Your season and region:** Indian seasons and regions first (summer, monsoon, winter, with kharif/rabi/zaid labels), with sourced sowing windows. The model works globally later via region profiles.
3. **Care with judgement:** schedules as guides ("check the soil first"), adapted to container and stage, with every rule sourced.
4. **Trust:** transparent sources and confidence labels, offline-first, no paywall before value.

## 4. Target personas

Personas draw on the Hyderabad terrace-gardener survey demographics: 58.9% female, 32% over 50, 48.9% homemakers, mostly independent houses with 750–1,500 sq ft roofs (CA-D §2.1). Plus urban apartment balcony growers *(assumption: no survey found)*.

### P-A: The established terrace grower (primary)
- **Profile:** aged 40–65, independent house in Hyderabad, Chennai, Bengaluru or Kochi, with a large flat roof. Already grows mint, chilli, spinach, tomato and brinjal in grow bags. Learns in WhatsApp and Facebook groups.
- **Goals:** more reliable harvests, knowing what to sow when, fewer pest losses, keeping track of many bags.
- **Frustrations:** generic or foreign advice, guesswork on pests and fertiliser, monsoon waterlogging, monkeys.
- **Needs from us:** simple, large-type UX; sowing calendar for their region; per-bag tracking; later, a regional language.
- **Tech comfort:** moderate. The canvas must be optional; a list view of containers must be a first-class alternative.

### P-B: The balcony beginner (primary)
- **Profile:** aged 25–40, apartment in Bengaluru, Pune, Mumbai or Delhi NCR. Small balcony (e.g. 3 m × 1.2 m) facing one direction, partial sun. Time-poor.
- **Goals:** herbs and a few vegetables, a balcony that looks good, not killing plants.
- **Frustrations:** doesn't know what survives on their balcony; overwaters; doesn't know which pot size to buy.
- **Needs from us:** quick onboarding, "what fits my balcony" recommendations, a visual plan, a shopping-style list of containers and soil volume (later), gentle reminders.

### P-C: The kit starter (secondary, partnership channel)
- **Profile:** received a government or retail terrace kit, such as Tamil Nadu's DIY kit with 20 grow bags (24×18 in) and seeds. Beginner.
- **Goals:** make the kit succeed.
- **Needs from us:** "Start from a kit" preset that places the bags and pre-schedules the included crops. Step-by-step first month.

### P-D: The global small-space gardener (later)
- **Profile:** a balcony or container gardener outside India.
- **Treatment:** the architecture supports other regions (region profiles, units, languages) but MVP content is India-first. The temperate region profile is deferred.

## 5. MVP feature priorities

The MVP is a vertical slice that delivers the core loop end to end:
**space → plan → plant → care → progress**.

### Must have (MVP)
| ID | Feature | Rationale |
|---|---|---|
| M1 | Progressive onboarding and garden profile (space type, optional dimensions, sun, facing, city/region, goals, experience); "Not sure" allowed | Personalisation without friction |
| M2 | Garden photos: capture/import, organise, view, replace, delete (local) | Documents the space; journal foundation |
| M3 | Dimension-aware 2D designer: rectangle boundary, containers (round pot, rectangular planter/trough, grow bag in standard sizes, raised bed, vertical planter), structures (wall/railing, path, water point); move/resize/rotate/delete; snapping; dimension labels; validation (bounds, overlap); undo/redo; autosave; accessible list alternative | Core differentiator mechanism |
| M4 | Space summary: area used/free, container count, total soil volume | Answers "what fits" (P5) |
| M5 | Curated, sourced plant catalogue: ~30 India-relevant container crops and ornamentals, with sun, container depth, spacing, season windows by region, care rules and safety where documented | Trustworthy foundation |
| M6 | Rule-based recommendations with "why" and "watch out" (sun, season and region, container depth, goals, effort); shortlist | P1 |
| M7 | Plantings: add a species to a container on the layout (or unassigned), with date and stage; container-fit warning | Connects layout and care |
| M8 | Care plan generation: water (guidance + check-first), fertilise (cautious), pest inspection, prune/pinch where sourced, sow/harvest windows; complete/skip/reschedule with notes | P2, P3, P4, P6 |
| M9 | Local notifications: daily digest + task reminders, permission in context, quiet hours, no duplicates | Retention and P6 |
| M10 | Progress journal: dated photos, notes, milestones (germinated, flowering, harvest) | Motivation; feedback loop |
| M11 | Terrace care and safety guidance: load/drainage/waterproofing checklist with "consult a structural engineer"; monsoon and heat-prep tips | P7, responsible product |
| M12 | Settings: units, theme, notifications, about & sources, delete all data | Trust and control |

### Should have (MVP if time allows, otherwise first post-MVP)
- S1 "Start from a kit" presets (e.g. TN DIY kit layout + seeds). *(Validate the kit contents before shipping.)*
- S2 Compare 2–3 plants side by side.
- S3 Journal photo comparison (before/after) and simple stats.
- S4 Data export (JSON + photos ZIP).
- S5 Share plan as image (WhatsApp-friendly).

### Could have
- C1 Hindi UI translation (i18n infrastructure is built from Phase 1, so this is a content task).
- C2 Additional boundary shapes (L-shape, polygon).
- C3 Companion-planting hints (only where sourced).

## 6. Features to postpone (Phase 7+, each needs value and cost assessment)

| Feature | Why postpone | Notes |
|---|---|---|
| Weather-aware care (heat, rain skip, ET-based watering) | Needs network + API; core must work offline first | **Highest-value post-MVP item.** Open-Meteo is a candidate (licence check in technical decisions) |
| AI pest/disease diagnosis and plant ID | Commoditised; costly; needs server-side keys | Partner/API route (e.g. Plantix-style or Plant.id) behind a server |
| Photo-to-layout (calibrated) | Hard computer vision; validate demand first | Start with "trace over photo" manual assist |
| AI concept renders | Cost per image; risk of being mistaken for a blueprint | Always labelled "concept, not to scale" |
| Cloud sync, accounts, household sharing | Adds backend, auth, privacy work | Supabase recommended (see technical decisions) |
| Shopping list / commerce / affiliates | Monetisation exploration | Partner with Indian D2C nurseries (Ugaoo-type) rather than compete |
| Regional languages beyond Hindi | Content and QA cost | Tamil, Telugu, Kannada, Malayalam, Marathi by user demand |
| Community / expert Q&A | Moderation cost; WhatsApp groups exist | Consider sharing into existing groups instead |
| Temperate/global region profile | India-first focus | The architecture supports it |

## 7. Product risks and assumptions to validate

| Risk / assumption | Impact | Mitigation / validation |
|---|---|---|
| R1 Users won't measure or draw their space | Canvas unused | Dimensions are optional. Presets for common balcony sizes and kits. List view of containers works without a canvas. Measure onboarding completion |
| R2 Horticultural guidance is wrong or unsafe | Plant loss, trust, liability | Curated data with sources and confidence. Conservative fertiliser and pesticide guidance. Disclaimers. Review by a horticulturist before public release |
| R3 Canvas complexity balloons the schedule | Delays MVP | Rectangles and circles only. A fixed set of object types. Pure-Dart geometry with tests. Strict scope in TODO |
| R4 Notifications unreliable on Android OEMs (battery optimisation) | Missed tasks | Use inexact scheduling plus a daily digest. In-app agenda is the source of truth. Document OEM battery settings in help |
| R5 Willingness to pay unproven | Business viability | Keep the MVP free. Explore commerce/partnership and premium weather or AI later. Validate with users |
| R6 Older and less tech-savvy users struggle | Primary persona churn | Large touch targets, 200% text scale, simple language, regional language later, usability testing with P-A users |
| R7 Image licensing for the catalogue | Legal risk | Only CC0/CC BY or own photos, tracked in ATTRIBUTION.md. Illustrated fallbacks |
| R8 Regional season data is coarse | Wrong sowing advice | Start with broad regions (e.g. North plains, South/peninsular, hills, coastal) only where sourced. Label as guidance |
| R9 Photo storage grows large | Device storage complaints | Compress on import, thumbnails, storage usage shown in settings |
| R10 iOS cannot be built or tested from this Windows machine | iOS quality | Android-first verification. iOS via CI (macOS runner) or a Mac before release |

**Assumptions to validate with users** (interviews with 5–8 people from Hyderabad/Chennai/Bengaluru gardening groups and balcony beginners):
1. Do users think in grow bags and pots rather than square metres? (Affects whether the canvas leads or the container list leads.)
2. Will users enter dimensions if prompted in context?
3. Are season-aware "sow now" recommendations the top reason to open the app?
4. Do care reminders help, or feel like nagging? What frequency is acceptable?
5. Which language would they use the app in?
6. Would they pay, and for what (weather intelligence, diagnosis, expert help), or prefer commerce?
