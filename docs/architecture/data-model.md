# Data Model

Status: v0.1 (Phase 0). Domain entities are storage-agnostic; persistence mapping is described in `system-architecture.md` and `technical-decisions.md`. Field lists are indicative and will be refined per phase. All IDs are client-generated UUIDv4 strings, so records can later sync to a backend without ID remapping.

## 1. Conventions

- **Canonical length unit: centimetres, stored as `double`.** Units (metric/imperial) are a display preference only; conversion happens at the presentation boundary (`Length` value object). Area is stored/derived in cm².
- **Angles:** degrees, clockwise, normalised to `[0, 360)`.
- **Time:** instants stored as UTC; calendar dates for tasks (`LocalDate`, i.e. date without time) plus the garden's IANA time zone for notification times. "Every 3 days" is a calendar concept, not 72 hours.
- **Unknown values:** nullable fields + explicit `unknown` enum members where a "Not sure" answer is meaningful (sun hours, facing direction). Never fake a default that looks like real data.
- **Provenance:** facts in the plant catalogue and care rules carry `sourceIds` referencing `docs/research/gardening-references.md` entries.
- **Soft deletes** are not used in the MVP; deletes cascade (with confirmation in UI). Sync-era tombstones are a Phase 7 concern.

## 2. Coordinate system (garden designer)

```text
 world origin (0,0) = top-left corner of the garden's bounding rectangle
   +x → (east-ish only if user says so; x is "length" axis)
   +y ↓ ("width"/depth axis)
   ┌──────────────────────────── length (cm) ───┐
   │ (0,0)                                       │
   │        ┌─────┐  element.center = (cx, cy)   │
   │        │  ●  │  element.size   = (w, h)     │ width (cm)
   │        └─────┘  element.rotation = θ° (CW)  │
   │                                             │
   └─────────────────────────────────────────────┘
```

- World space is in **cm**, y-down, matching Flutter's screen convention so no axis flip is needed.
- Each element is defined by **center, size, rotation**. Rotation is about the center. Circles (round pots) use `size.w` as diameter; rotation is ignored.
- **North:** optional `northBearingDeg` on the layout (angle from +y-up/"top of canvas" to true north, clockwise). Used for sun-direction hints only, never for geometry.
- **World → screen:** `screen = T · world`, where `T` is a 2D affine (Matrix4) = `translate(pan) · scale(pxPerCm · zoom)`. The base `pxPerCm` is chosen so the whole garden fits the viewport with padding at zoom = 1. The inverse `T⁻¹` maps touch points to world cm. Owned by a pure-Dart `CanvasTransform` class with unit tests; widgets never compute coordinates ad hoc.
- **Snapping:** positions snap to a grid step (default 5cm metric / 2in imperial, stored in cm) and to boundary edges; rotations snap to 15° unless snapping is off.
- **Non-rectangular gardens (post-MVP):** `boundary` is a polygon (list of points in world cm). MVP creates a 4-point rectangle, so the model is already polygon-shaped and future shapes don't need a migration.

## 3. Entities

### Garden
| Field | Type | Notes |
|---|---|---|
| id | String | UUID |
| name | String | required |
| spaceType | enum `terrace, balcony, rooftop, windowsill, courtyard, other` | |
| location | `GardenLocation?` | city name, country code, lat/lon (rounded to ~1km for privacy), IANA timezone, `regionKey` (e.g. `south_india`, `tamil_nadu`; see ADR-015) |
| lengthCm / widthCm | double? | nullable until known |
| sunHours | enum `lessThan3, from3to6, moreThan6, unknown` | |
| facing | enum 8-point compass + `unknown` | |
| windExposure | enum `sheltered, moderate, exposed, unknown` | |
| waterAccess | enum `tapNearby, carried, unknown` | |
| goals | Set<enum `vegetables, herbs, flowers, ornamental, fruit`> | |
| style | enum? (styles list in PRD) | |
| experience | enum? `beginner, intermediate, experienced` | user-level, may move to `UserProfile` |
| maintenanceMinutesPerWeek | int? | |
| budgetBand | enum `low, medium, high, unknown` | |
| coverPhotoId | String? | |
| createdAt / updatedAt | DateTime (UTC) | |

### UserProfile / Settings (single row, local)
units (`metric`/`imperial`), themeMode, locale, experience, notification preferences (enabled, quiet hours, daily digest time), onboardingCompletedSteps.

### GardenPhoto
| Field | Type | Notes |
|---|---|---|
| id, gardenId | String | |
| relativePath | String | path inside app documents dir (never absolute; survives app container moves on iOS) |
| thumbnailPath | String? | |
| caption, tag | String? | tag e.g. "north view" |
| takenAt | DateTime? | from EXIF if available, else capture time |
| width, height | int | |
| kind | enum `setup, progress` | progress photos may also link to a planting |

### Layout (garden design)

> **As built (Phase 3, 2026-10-18):** one layout per garden, stored only as `layout_elements` rows (FK `gardenId`, cascade). There is no `layouts` table: the boundary is the garden's own `lengthCm × widthCm` (single source of truth), and the grid step follows the unit setting (5 cm metric, 2 in imperial). The fields below remain the target model for multiple layouts per garden.

| Field | Type | Notes |
|---|---|---|
| id, gardenId | String | MVP: one active layout per garden; model allows many (versions/alternatives) |
| name | String | |
| boundary | List<Point> (cm) | rectangle in MVP |
| gridStepCm | double | |
| northBearingDeg | double? | |
| elements | List<LayoutElement> | stored as child rows (queryable) |
| schemaVersion | int | for layout JSON migrations if serialised |
| updatedAt | DateTime | |

### LayoutElement
| Field | Type | Notes |
|---|---|---|
| id, layoutId | String | |
| kind | enum `wall, railing, path, waterPoint, roundPot, rectPlanter, growBag, raisedBed, verticalPlanter, trellis, plantMarker` | |
| center | Point (cm) | |
| size | Size (cm) | |
| rotationDeg | double | |
| heightCm / depthCm | double? | soil depth for containers → drives container volume & plant suitability |
| label | String? | |
| zIndex | int | draw order |
| parentId | String? | plant markers can belong to a container/bed |

Derived (not stored): footprint polygon, area, container volume (litres ≈ footprint area × soil depth / 1000).

### PlantSpecies (catalogue, bundled read-only data, versioned)

> **As built (Phase 4, 2026-10-18; ADR-021):** bundled JSON (`assets/catalogue/plants.json`, `sources.json`) parsed into memory; no drift tables. Fields per record: `id, commonName, localNames[], scientificName, category (vegetable, leafyGreen, herb, climber, flower, ornamental), lifecycle, sun {level full|partial|indirect, minHours?, sources}, container {status verified|proxy|unverified, minVolumeL?, recommendedVolumeL?, minDepthCm?, recommendedDepthCm?, plantsPerContainer?, note?, sources}, daysToHarvest {min, max, note?, sources}?, sowing [{region, months[], source}], propagation {method, nurseryDaysMin?, nurseryDaysMax?, sources}?, careNotes [{text, sources}], petSafety {status toxic|nonToxic|notAssessed, note?, sources}, dataStatus`. Sources are per fact. Not yet modelled: water need, difficulty, spacing, care templates (Phase 5), images (KI-016), localised names map.
| Field | Type | Notes |
|---|---|---|
| id | String | stable slug, e.g. `tomato` |
| commonNames | Map<locale, List<String>> | includes Indian regional names (e.g. hi: टमाटर) |
| scientificName | String | |
| category | enum `vegetable, herb, fruit, flower, ornamental, succulent, climber` | |
| sun | `{minHours, idealHours}` | |
| water | enum `low, moderate, high` | qualitative only |
| container | `{minDepthCm, minVolumeL?, recommendedDepthCm?}` | |
| spacingCm / matureSpreadCm / matureHeightCm | double? | |
| daysToHarvest | Range? | edible crops |
| sowingWindows | List<{regionKey, months}> | region-specific (e.g. India: plains / hills / south) |
| difficulty | enum `easy, moderate, challenging` | |
| careProfile | List<CareRuleTemplate> | see below |
| safety | `{toxicToPets?, toxicToChildren?, notes, sourceIds}` | null = not documented |
| imageAssets | List<{path, attributionId}> | |
| sourceIds | List<String> | provenance per record; per-field where values differ in source |
| dataStatus | enum `verified, partial, unverified` | surfaced in UI |

### CareRuleTemplate (part of species data)
taskType (`water, fertilise, prune, repot, inspect, sow, harvest, support/stake`), stage applicability (`seed, seedling, vegetative, flowering, fruiting, established`), baseIntervalDays (nullable for one-off/seasonal), seasonal window, modifiers (container material, size, season/monsoon), instructions text key, `checkFirst` guidance (e.g. "Water when the top 2–3cm of soil is dry"), sourceIds.

### Planting (an instance of a species in a garden)

> **As built (Phase 4):** table `plantings` (id, gardenId FK cascade, speciesId text, elementId text nullable and deliberately not a FK because layout saves replace element rows, quantity, plantedOn `yyyy-MM-dd`, startedFrom `seed|seedling|cutting|plant`, notes, createdAt, updatedAt). No status or stage yet; removing deletes the row. Table `shortlist_entries` (gardenId FK cascade, speciesId; PK both). Schema v4.
| Field | Type | Notes |
|---|---|---|
| id, gardenId, speciesId | String | |
| elementId | String? | container/bed it's in; null = unassigned |
| quantity | int | |
| plantedOn | LocalDate | |
| startStage | enum `seed, seedling, established` | |
| currentStage | enum | user-updated or derived from dates |
| status | enum `active, harvested, removed, died` | |
| nickname, notes | String? | |

### CareRule (instantiated, per planting, user-editable)
id, plantingId, taskType, intervalDays?, anchor (`fromCompletion` | `fixedCalendar`), seasonal window, enabled, isCustomised (vs template), nextDueOn (LocalDate), templateRef.

### CareTask (concrete occurrence)
| Field | Type | Notes |
|---|---|---|
| id, ruleId, plantingId, gardenId | String | |
| taskType | enum | |
| dueOn | LocalDate | unique (ruleId, dueOn) → prevents duplicates |
| status | enum `pending, done, skipped` | |
| completedAt | DateTime? | |
| note | String? | |
| skipReason | enum `rained, soilStillMoist, notNeeded, other`? | feeds future adjustments |
| rescheduledFrom | LocalDate? | |

Only a rolling window of future tasks is materialised (e.g. next 30 days); further occurrences are computed from rules on demand.

### ScheduledNotification (bookkeeping)
id (int, platform notification id), taskId or digest key, fireAt (UTC). Recalculated idempotently from pending tasks; stale entries are cancelled. Lets us honour the iOS 64-pending limit.

### JournalEntry
id, gardenId, plantingId?, date, note, photoIds, milestone (`germinated, transplanted, flowering, firstFruit, harvest, other`)?, harvestQuantity?, harvestUnit?.

## 4. Relationships

```text
UserProfile (1)
Garden 1─* GardenPhoto
Garden 1─* Layout 1─* LayoutElement (self-ref parentId)
Garden 1─* Planting *─1 PlantSpecies (bundled)
Planting *─0..1 LayoutElement
Planting 1─* CareRule 1─* CareTask
CareTask 0..1─0..1 ScheduledNotification
Garden 1─* JournalEntry *─0..1 Planting
```

## 5. Data lifecycle & privacy

- All user data is local in the MVP. Photos live in the app's documents directory; DB stores relative paths.
- Deleting a garden deletes its photos (files + rows), layouts, plantings, tasks, notifications and journal entries.
- Export (Phase 6): ZIP of JSON + photos. Delete-all-data in Settings.
- Location is stored at city-level precision unless a future feature needs more.
