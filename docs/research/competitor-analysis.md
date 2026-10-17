# Competitor Analysis

**Research date:** 2026-10-18 · **Method:** live web research covering official sites, Apple App Store (US) and Google Play (India) listings, help centres and release notes, credible third-party reviews, FAO/ICRISAT profiles and Indian academic surveys. · **Status:** Phase 0 baseline. Re-verify prices and features before any public claims.

**How to read this document**
- Part A is the synthesis: summary, comparison matrix and gaps.
- Parts B–D hold the detailed per-product profiles. Each claim is tagged **[Verified]** (with source) or **[Assumption]**, every product has a confidence level, and every section ends with its source URLs (all accessed 2026-10-18).
- **Prices:** US App Store prices are in USD. Google Play India shows only an in-app purchase *range per item* (₹), not per-plan prices.

**Known evidence gaps**
- Reddit blocked automated access, so there is no Reddit sentiment.
- Some Google Play pages would not render, so Android-only install counts are partly unverified.
- greg.app returned HTTP 403.
- The GrowVeg price page returned HTTP 500 for one researcher. Its prices are verified separately in Part C.
- No authoritative Indian market-size data was found. Do not use unsourced "adoption %" figures from trend articles.

---

# Part A: Synthesis

## A1. Executive summary

1. **The market splits three ways, and no product bridges them:**
   - **Care and identification apps** (Planta, Greg, PictureThis, Blossom, Plantix) model plants as a *list*. None has drawing, dimensions or a spatial garden.
   - **Layout planners** (GrowVeg, Planter, Fryd, Seedtime, Garden Pro Planner) offer scaled, gridded beds and sowing calendars, but care beyond sowing reminders is thin.
   - **Photo/AI visualisers** (iScape, Garden AI, Neighborbrite, DreamzAR) produce attractive renders with no real dimensions and no care loop.
2. **Every planner's seasonal engine is built on frost dates and USDA zones.** That model fails in most of India, which is frost-free and where monsoon and heat set the seasons. Fryd covers 45 cities, and Bangalore is its only Indian one. GrowVeg's regional sites exclude India. Fixing this means re-architecting the calendar logic, not translating it. **This is the most structural gap we found.**
3. **Containers and terraces are not served as a category of their own.**
   - Only GrowVeg, Seedtime and Garden Pro Planner treat containers as plan objects, and all three are ground-bed planners first.
   - MacetoHuerto treats containers as first-class objects ("digital twin") but has no spatial layout.
   - No product addresses terrace-specific concerns: pot volume per crop, saturated weight and load, drainage and waterproofing, heat from concrete, wind, parapet shade, monkeys.
4. **Indian users' top pains are not layout.** A Hyderabad terrace-gardener survey (n=90) ranks the main technical gaps as pest and disease identification, fertiliser and manure knowledge, and sowing time and varieties. The main general constraints are space and time, monkeys and rodents, roof leakage and rainy-season waterlogging.
5. **Identification and diagnosis are commoditised.**
   - PictureThis claims 400k+ species.
   - Plantix is free, covers 10 Indian languages and has about 10M users, around 80% of them in India.
   - We should integrate an existing ID or diagnosis service later rather than compete on it.
6. **Trust is a differentiator.** Billing and trial-trap complaints are the dominant negative theme across consumer plant apps and AI design apps. Western care apps rate notably lower on Play India (Planta 3.1★, Greg 3.9★) than on US iOS (4.8★ and about 4.6★).
7. **No reputable tool presents AI renders as to-scale plans, and none converts a photo into an editable, dimensioned layout.** A clearly labelled concept image combined with a user-calibrated structured layout would be novel.

## A2. Comparison matrix

Legend: ● strong · ◐ partial · ○ none/not found. Detail and sources are in Parts B–D.

| Product | Primary job | Real dimensions / layout | Containers as objects | Photo of own space | Care reminders | Weather / location logic | India fit (seasons, crops, languages) | Pricing model |
|---|---|---|---|---|---|---|---|---|
| Planta | Houseplant care | ○ (rooms as "sites") | ◐ pot size/material input | ○ (ID/diagnosis only) | ● multi-task, 13 inputs | ● live weather, rain/heat alerts | ○ hardiness zones | Freemium sub ($47.99/yr US) |
| Greg | Precision watering | ○ | ◐ camera pot-size estimate | ○ | ● ET-based watering (FAO Penman–Monteith) | ● | ○ | Freemium sub ($29.99/yr US) |
| PictureThis | Plant ID | ○ | ○ | ○ | ◐ logic undocumented | ○ | ◐ regional encyclopedia | Freemium sub |
| Blossom | ID + reminders | ○ | ◐ pot-size water calculator | ○ | ◐ | ○ | ○ | Freemium sub, heavy paywall |
| Plantix | Crop disease diagnosis | ○ (plot area only) | ○ | ○ | ◐ farm activity scheduling | ● | ● 10 Indian languages, farm crops | Free + ads + marketplace |
| GrowVeg / Almanac | Veg garden planner | ● scaled, metric/imperial, SFG mode | ● pots, grow bags, baskets | ○ | ◐ sowing/planting emails | ◐ 5,000+ stations, frost dates | ○ no India region | Annual ($35/yr), web only |
| Planter | Mobile SFG planner | ● grid, new bed shapes | ○ | ○ | ◐ user-made tasks | ◐ frost-date map | ○ | Freemium ($24.99/yr, $99.99 lifetime) |
| Fryd | Bed planner + guides | ● beds in cm | ○ | ○ | ◐ sowing/task reminders, pest alerts | ◐ 45 city guides | ◐ Bangalore only | Freemium (£49.99/yr per 2025 PR) |
| Seedtime | Calendar-first planner | ● beds, containers, vertical | ● | ○ | ◐ weekly task list | ◐ frost dates worldwide | ○ | Free / $84 / $168 per yr |
| MacetoHuerto | Balcony veg | ○ | ● virtual containers (list) | ◐ pest scanner | ◐ monthly planner | ○ | ○ Mediterranean | Free (Android) |
| iScape | Landscape photo collage | ○ no measurement tools | ○ | ● overlay on photo, AR | ○ | ○ | ○ | $29.99/mo, $299.99/yr |
| AI redesign apps (Garden AI, Neighborbrite, DreamzAR…) | AI renders | ○ (DreamzAR: AR area measure) | ○ | ● generative | ○ | ◐ US zones (Neighborbrite) | ○ "tropical" as style only | Weekly subs ($4.99–7.99/wk) |
| Ugaoo / Kyari | D2C plant commerce | ○ | ○ | ○ | ○ (blog content) | ○ | ● Indian brand, N/S sowing blog | Commerce |
| Govt kits (TN, Kerala, IIHR) | Physical grow-bag kits | n/a | standard 24×18in bags | n/a | booklet only | n/a | ● | Subsidised kits, **no app** |

## A3. Gaps we can credibly target

| Gap | Evidence | Our response |
|---|---|---|
| No India-native seasonal engine | All planners use frost dates; Fryd has one Indian city; GrowVeg has no India region (Parts C, D) | Season and region model based on Indian seasons (summer/monsoon/winter; kharif/rabi/zaid labels) and agro-climatic regions, with sourced sowing windows |
| Containers are second-class objects | Only ground-bed planners model containers; none model volume, depth per crop or weight (Parts C, D) | Container-first canvas: pots by diameter and depth, grow bags by standard size, troughs, vertical planters, with derived soil volume and fit checks |
| No link between layout and care | Planners stop at sowing; care apps have no space model (Parts B, C) | Every planting lives in a container on the layout; care tasks are generated from species, stage and container |
| Terrace realities ignored | Survey: leakage, waterlogging, monkeys, heat (Part D §2) | Terrace checklist (load, drainage, waterproofing: advise consulting an engineer), heat/monsoon guidance, netting zones |
| Govt kits without digital follow-through | TN DIY kit: 20 grow bags (24×18in) + seeds + booklet (Part D) | "Start from a kit" presets that auto-place the containers and schedule the seeds |
| Paywall and billing distrust | Repeated complaints (Parts B, C) | Planner and core care free and offline. Transparent INR pricing for any future premium |
| Renders vs reality | No tool turns photos into editable layouts (Part C §6) | Photo-assisted, user-calibrated layout later. AI concepts always labelled "not to scale" |

## A4. Features worth learning from (not copying)

- **Planta:** many-input care model, rain and heat alerts, Care Share for plant-sitters.
- **Greg:** evapotranspiration-based watering and learning from snoozes and early waterings.
- **GrowVeg / Seedtime:** automatic spacing, plants-per-bed estimates, calendar ↔ layout integration.
- **MacetoHuerto:** containers as the user's mental model.
- **Plantix:** vernacular languages, weather-based activity timing, fertiliser calculator (re-scaled from plot to container).
- **gardenplanner.net:** structured AI layouts imported as JSON, a useful pattern for a later "AI suggests, user edits" flow.

---

# Part B: Plant care and identification apps

**Apps covered:** Planta, Greg, PictureThis, Blossom, Plantix
**Research date:** 2026-10-18 (live web research)
**Context:** Benchmarking for a Flutter app for terrace, balcony and container gardening (India-first, usable globally) that combines a dimension-aware planner with locally relevant care guidance.

**Tagging:**
- **[Verified]** means a source was checked. The source number refers to that app's Sources list.
- **[Assumption]** means inference or analysis that has not been confirmed.
- **Store metrics:** Google Play figures (downloads, rating, INR price range, last update) were read from the India storefront (`hl=en_IN&gl=IN`) on 2026-10-18. Apple App Store figures come from the US storefront unless noted.
- **Prices:** Play shows an in-app purchase range "per item", not a per-plan price. App Store listings show unlabeled or duplicated SKUs, so exact plan prices for India could not be confirmed unless stated.

---

## Quick comparison

| | Planta | Greg | PictureThis | Blossom | Plantix |
|---|---|---|---|---|---|
| Primary job | Houseplant care scheduler | Watering precision for houseplants | Plant ID (400k+ species) | ID + reminders | Crop disease diagnosis for farmers |
| Schedule logic | Multi-factor algorithm (13 listed inputs, live weather) | Evapotranspiration-based (FAO Penman-Monteith) + ML | Reminders, logic undocumented | Plant type + pot size water calculator | Weather-based farm activity scheduling |
| Measures space? | Light meter only | Camera estimates pot size, window distance | Light meter | Light meter | Fertilizer calculator by plot size |
| Layout or planner | None | None | None | None | None |
| Play IN (Oct 2026) | 3.1 stars, 21.1K reviews, 10L+ downloads | 3.9 stars, 8.52K reviews, 5L+ | 4.5 stars, 8.05L reviews, 5Cr+ | 4.4 stars, 1.86L reviews, 50L+ | 4.1 stars, 1.38L reviews, 1Cr+ |
| Play IN IAP range | ₹720–₹7,500 | ₹650–₹27,500 | ₹140–₹4,500 | ₹90–₹8,184.99 | None listed (contains ads) |
| Model | Freemium subscription | Freemium subscription (5-plant cap historically) | Freemium subscription | Freemium subscription | Free, ads, India marketplace, B2B API |

---

## 1. Planta (Planta AB, Stockholm)

**Overall confidence:** High for features and scheduling inputs. Medium for pricing and outdoor or vegetable depth.

### Target audience and use cases
- **Audience:** Indoor plant owners ("plant parents"), increasingly marketed for indoors and outdoors. Play describes it as "Grow thriving plants indoors and outdoors" and claims "10 million plant lovers and 40 million thriving plants". [Verified, S3]. The website says "Used by over 7M plant lovers". [Verified, S1]
- **Main uses:** Never missing care tasks, diagnosing sick plants, and choosing plants for a room's light. [Verified, S1, S3]

### Core features and user journey
- **Reminders:** Water, fertilize, mist, repot, clean, prune and overwinter. Also a plant journal, Care Share (share a schedule with family or plant-sitters), community, light meter, AI identification, Dr. Planta diagnosis, and support from in-house experts who "review complex cases". [Verified, S2, S3]
- **Journey:** Add a plant (identify by photo or search), assign it to a "site" (a room or location with light conditions), receive a schedule, then mark tasks done. [Verified, S4]. A third-party teardown says the paywall appears soon after initial setup. [Verified, S8, third-party]

### Photo upload and garden visualisation
- **Photos:** Used for plant identification, Dr. Planta diagnosis and journal entries. [Verified, S3]
- **Visualisation:** No garden or space visualisation found. Plants are listed by site. [Assumption: no visual map exists, based on the absence of any such feature in listings and help docs]

### Manual drawing, measurements, layout editing
- **Drawing and layout:** None found. [Assumption, based on absence in listings]
- **Measurements:** Only light (camera light meter) and user-entered pot size, pot material and window distance are captured. [Verified, S2, S4]

### Plant identification and recommendations
- **Identification:** AI photo identification of flowers, trees, herbs, succulents and houseplants. [Verified, S3]
- **Recommendations:** The light meter suggests plants that suit each room's light. [Verified, S1]
- **Paywall:** Identification, care schedules other than watering, Dr. Planta, the light meter and plant recommendations are all premium. [Verified, S5, article updated 07.08.2024]

### Watering, fertilising and care reminders
- **Inputs:** The help center lists 13 inputs to its "designated algorithms": plant type and hardiness zone, location and local climate, season, live weather, site temperature, daily sunlight duration, pot material and drainage holes, pot size, soil type, site humidity, light conditions per site, grow-light setting, and heating or air conditioning. [Verified, S4]. The website says "over 30 parameters, along with local climate and weather data". [Verified, S1]
- **Weather alerts:** Rain notifications, with a "mark all plants in a site as watered" option. Alerts for extreme heat or cold, storms, heavy rain and low light. [Verified, S4]
- **Custom schedules:** Users can set their own interval in days. [Verified, S6]
- **Not self-learning:** A 2021 developer reply on the App Store says the algorithm is not self-learning yet. [Verified, S2, may be outdated]
- **Vegetables:** An App Store in-app event promotes tracking "veggies" through to harvest. A Play promotion describes a "Seeds" feature for veggies, herbs and summer flowers, with growth stages and harvest alerts. [Verified, S2. Seeds feature known only from a search snippet of a Play event page that could not be opened. Medium confidence]

### Personalisation, weather, location
- **Personalisation:** Strong. Per-site light, temperature, humidity and HVAC inputs, live local weather, and hardiness zone. [Verified, S4]
- **India and tropics:** Planta launched in India in its 2020–21 expansion to more than 45 countries. [Verified, S9, third-party]. No evidence was found that Planta models Indian monsoon or seasons specifically. [Assumption]

### Pricing
- **US App Store:** "12 months Premium Plant Care" costs **$47.99** with a free trial. Other SKUs are listed: 1 month at $7.99 or $9.99, 3 months at $17.99 or $19.99, and 12 months at $17.99, $35.99 or $47.99. [Verified, S2]
- **Play India:** In-app purchases range from **₹720 to ₹7,500 per item**. The exact INR plan price was not confirmed. [Verified, S3]
- **Free tier:** "Limited access". Watering reminders appear to be the main free schedule. [Verified, S5]

### Strengths, weaknesses, complaints
- **Strengths:**
  - The most detailed documented scheduling model, with live weather, rain alerts, and site-level environment settings. [Verified, S4]
  - Polished UX, a 4.8-star rating from 114K US iOS ratings, and active development (v3.123.0 released "5d ago" at access time). [Verified, S2]
- **Weaknesses and complaints:**
  - Play India rating is only **3.1 stars** (21.1K reviews), well below iOS US. [Verified, S3]
  - Aggregators report a restrictive free tier (identification and scanning paywalled), overwatering recommendations, reminders that don't adjust for early or late watering, misidentification, and billing or cancellation and support issues. [Verified, S7, S8. Third-party sentiment aggregators, so treat any percentages as rough]
- **Gaps:**
  - No spatial planning and no container-capacity planning.
  - The site concept is room-based. Nothing found on balcony or terrace dimensions, sun-hour mapping by direction, or wind exposure.
  - Vegetables are a newer add-on. [Assumption, partly Verified, S2]

### Differentiation opportunities
- **Sites to real space:** Planta's "site" (room plus light) is the closest analogue to a terrace zone. A planner can go further, with real dimensions, orientation (N/S/E/W), sun hours per zone, parapet shading and wind. [Assumption]
- **Indian seasons:** Match Planta-grade rain and heat alerts while tuning for Indian seasons (summer heat over 40°C, monsoon, winter vegetable season) and terrace-specific stresses such as heat reflected from concrete. [Assumption]
- **Pricing:** INR-friendly pricing. Planta's Play IN ceiling is ₹7,500 and its rating in India is weak. [Verified, S3, plus Assumption]

### Sources (accessed 2026-10-18)
- S1: https://getplanta.com/
- S2: https://apps.apple.com/us/app/planta-care-for-your-plants/id1410126781
- S3: https://play.google.com/store/apps/details?id=com.stromming.planta&hl=en_IN&gl=IN
- S4: https://support.getplanta.com/about-plantas-watering-schedule/
- S5: https://support.getplanta.com/do-planta-offer-a-free-trial-of-premium
- S6: https://support.getplanta.com/how-do-i-create-a-custom-care-schedule-for-a-plant/
- S7: https://kimola.com/reports/in-depth-planta-app-review-analysis-for-enhanced-user-satisfaction-google-play-156460
- S8: https://screensdesign.com/showcase/planta-plant-garden-care
- S9: https://gardencentermag.com/news/how-this-swedish-plant-care-app-planta-can-help-plant-parents-at-any-stage

---

## 2. Greg (Gregarious, Inc., US public benefit corporation)

**Overall confidence:** Medium. The scheduling method is well sourced. Current free-tier limits and some pricing come from 2021 sources, and greg.app returned HTTP 403.

### Target audience and use cases
- **Audience:** Indoor houseplant owners who want "zero-guesswork" watering. Play says: "We make growing indoor plants super easy and fun." [Verified, S2]
- **Main uses:** How much and when to water, plant identification, and a community Q&A that promises answers "in 24 hours, or less". [Verified, S2]

### Core features and user journey
- **Features:**
  - Plant identification (PlantVision).
  - A custom watering plan "based on each plant's species, size, plus the actual details of your home environment".
  - Exact water amounts with reminders.
  - Indoor Light Gauge.
  - Seasonal updates "as the weather in your area changes".
  - Community with #Communities, a social feed and leaderboards.
  - Referral rewards.
  - [Verified, S1, S2, S6]
- **Journey:** Onboarding quiz (number of plants, experience, goals), then a paywall with a 7-day trial, then add a plant via photo ID, then detailed setup with a gamified progress bar (light, pot size), then a dashboard with a water-level graph. [Verified, S6, third-party teardown]

### Photo upload and garden visualisation
- **PlantVision:** The camera identifies the species and "estimate[s] pot size, distance + window orientation automatically". [Verified, S1]. A 2022 update added augmented-reality plant identification. [Verified, S8, press listing]
- **Visualisation:** No garden or space visualisation beyond per-plant cards and graphs. [Assumption]

### Manual drawing, measurements, layout editing
- **Drawing and layout:** None found. [Assumption]
- **Measurements:** Greg is notable for camera-estimated pot size and window distance, the most "dimension-aware" of the five, but only per plant. [Verified, S1]

### Plant identification and recommendations
- **Identification:** Photo identification. Third-party reviewers report misidentification of rare or complex plants, including some succulents. [Verified, S1, S4]

### Watering, fertilising and care reminders
- **Method:** Based on the UN FAO crop-water-use algorithm, which TechCrunch describes and House Plant Journal calls "rooted in the UN's FAO Penman–Monteith method for modeling plant evapotranspiration". "Original machine-learning models" adapt the plan to plant, location and user. [Verified, S3, S5]
- **Inputs:** Species, size, pot size and material, soil, window distance and orientation, light, geographic location and local weather or season. [Verified, S1, S3, S4]
- **Learning:** The model learns from interactions, including waterings and snoozes. [Verified, S3]. A user review on the App Store says "The algorithm updates as you water more frequently or less frequently." [Verified, S1]
- **Paywall:** Precision Watering (exact volume per plant) is listed under the paid tier. [Verified, S1]
- **Fertilising:** A teardown mentions fertilising schedules. [Verified, S6, third-party, low confidence]

### Personalisation, weather, location
- **Weather:** Location- and weather-adaptive seasonal plans. [Verified, S1, S5]
- **Outdoor:** The app positions itself as indoor-first. Some outdoor use is possible, since a user review mentions an indoor/outdoor setting and an outdoor bush. [Verified, S1, S2]

### Pricing
- **US App Store:** "For $29.99 a year". SUPER Greg SKUs are listed at $1.99 to $39.99, periods unlabeled. 7-day trial. [Verified, S1]
- **Play India:** In-app purchases range from **₹650 to ₹27,500 per item**. INR plan price not confirmed. [Verified, S2]
- **Free tier (2021):** Up to **5 plants**. The paid tier was $6.50 per month, $2.50 per month billed annually, or $49.99 lifetime. [Verified, S3, May 2021, possibly outdated]. The current free cap is unverified.

### Strengths, weaknesses, complaints
- **Strengths:**
  - The most scientifically framed watering model (evapotranspiration).
  - Camera-based pot and window measurement.
  - Exact water volumes.
  - Strong community features.
  - [Verified, S1, S3, S5]
- **Weaknesses:**
  - Play India rating **3.9 stars** (8.52K reviews), 5L+ downloads, last updated 26 Sept 2026. [Verified, S2]
  - Third-party review: some experienced users found watering amounts excessive, advice is generic for specialist species, and the app may miss home microclimates. [Verified, S4]
  - The teardown describes a paywall shown before the first plant is added. [Verified, S6]
  - Little press since 2022, and only a small single-app team. [Verified, S8, Assumption on team size]
- **Gaps:** Indoor houseplant focus. No vegetables or edible-crop model surfaced, no spatial layout, no multi-plant container or bed logic. [Assumption, based on absence in listings]

### Differentiation opportunities
- **Evapotranspiration for terraces:** Greg proves an ET-based (FAO-56) watering model is marketable. Applying the same method outdoors on terraces is a strong fit, because Indian terraces have high radiation, wind and heat from concrete. Real weather data and container volume would make it more accurate than an indoor model. [Assumption]
- **Measurement:** Extend Greg-style camera measurement from "pot size" to "balcony or terrace dimensions plus container volumes", which feed watering litres per container. [Assumption]

### Sources (accessed 2026-10-18)
- S1: https://apps.apple.com/us/app/greg-plant-identifier-care/id1512912236
- S2: https://play.google.com/store/apps/details?id=greg.io.care_app_android&hl=en_IN&gl=IN
- S3: https://techcrunch.com/2021/05/27/greg-an-app-for-plant-lovers-grows-5-4-million-in-seed-funding
- S4: https://scienceinsights.org/greg-plant-app-reviews-should-you-trust-it-with-your-plants/
- S5: https://www.houseplantjournal.com/?p=1835
- S6: https://screensdesign.com/showcase/greg-plant-identifier-care
- S7: https://greg.app/ (returned HTTP 403, not readable)
- S8: https://www.owler.com/company/gregariousinc (via search summary)

---

## 3. PictureThis (Glority)

**Overall confidence:** High for identification features and store data. Low or Medium for how reminders are computed and for free-tier limits.

### Target audience and use cases
- **Audience:** A broad consumer audience: hikers, gardeners and houseplant owners.
- **Main uses:** Instant identification of any plant, disease diagnosis, toxicity checks for pets and children, and weed identification. [Verified, S1, S2]
- **Scale:** The largest of the five. 1.1M ratings on US iOS (4.8 stars). Play India shows 50M+ downloads (5Cr+), 4.5 stars, 8.05L reviews, updated 13 Oct 2026. [Verified, S1, S2]

### Core features and user journey
- **Identification:** "Identify over 400,000+ plant species with over 98% accuracy" (developer claim, not independently tested). [Verified, S1, S2]
- **Other features:**
  - Disease auto-diagnosis with step-by-step treatment.
  - "Personalized Care Plans" covering watering frequency, fertilising and light.
  - Toxic plant warnings and weed identification.
  - Water tracker and reminders, plus a light meter.
  - Collection and wishlist.
  - 24/7 expert chat.
  - [Verified, S2]
- **Website:** Care guides cover Houseplants, Garden Plants, Flowers and Fruits & Vegetables, alongside "Plants by Region". [Verified, S3]
- **Journey:** Snap a photo, get an identification result, save the plant to your collection, and get care tips and reminders. [Assumption, based on listing structure]

### Photo upload and garden visualisation
- **Photos:** Photo and gallery identification and diagnosis. The collection stores photos and notes. [Verified, S2]
- **Visualisation:** No layout or visual garden. "Fingertip garden" is a list or catalogue. [Verified wording, S2. Assumption that it is not spatial]

### Manual drawing, measurements, layout editing
- **Drawing and layout:** None found. [Assumption]
- **Measurements:** The light meter is the only measurement tool. [Verified, S2]

### Plant identification and recommendations
- **Identification:** Best-in-class breadth (400k+ species claimed). [Verified, S1]
- **Recommendations:** Plant recommendations for a space were not found. Weed control tips are offered. [Verified, S2]

### Watering, fertilising and care reminders
- **Reminders:** Watering reminders with "timely notifications". Care plans state watering and fertilising frequency. [Verified, S2]
- **Logic:** No official documentation was found on how schedules are computed (location, weather, pot size). [Unverified, flagged as a gap]

### Personalisation, weather, location
- **Region:** A "Plants by Region" encyclopedia exists on the web. [Verified, S3]
- **Weather:** No verified weather-adaptive scheduling. [Unverified]

### Pricing
- **US App Store:** In-app purchases include "PictureThis Pro" at $39.99 (most common SKU), $7.99 and $3.99, and a "Family Plan" at $49.99. Periods are unlabeled. [Verified, S1]
- **Play India:** **₹140 to ₹4,500 per item**. [Verified, S2]
- **Free tier:** A limited number of identifications. Third-party reports range from "1–2 free IDs before prompt" to "a certain number daily". The exact cap is unverified. [Verified that a cap exists, third-party sources S5, S6]

### Strengths, weaknesses, complaints
- **Strengths:**
  - Identification accuracy and breadth, plus a huge user base and brand.
  - Diagnosis, toxicity and weed features.
  - Content covers fruits and vegetables.
  - [Verified, S1–S3]
- **Weaknesses and complaints:**
  - The dominant complaint is billing: unclear trial terms, unexpected charges and double billing, plus customer service issues. [Verified, S4, S5, third-party aggregators]
  - Some reports of misidentification.
  - Accuracy figures are self-reported. [Verified, S5]
- **Gaps:** Identification-first, with shallow care scheduling (logic undocumented). No space or container planning, and no climate-season calendar for growing edibles. [Assumption]

### Differentiation opportunities
- **Identification as a commodity:** PictureThis dominates identification, so a new app should not compete on identification breadth. It could license a plant-ID API (e.g. Plant.id, PlantNet) or keep identification minimal, and win on planning plus local, season-aware guidance. [Assumption]
- **Trust:** Transparent pricing and no "trial trap" is a credible trust differentiator, given the volume of billing complaints. [Assumption, supported by S4, S5]

### Sources (accessed 2026-10-18)
- S1: https://apps.apple.com/us/app/picturethis-plant-identifier/id1252497129
- S2: https://play.google.com/store/apps/details?id=cn.danatech.xingseus&hl=en_IN&gl=IN
- S3: https://www.picturethisai.com/
- S4: https://www.commonsensemedia.org/app-reviews/picturethis-plant-identifier/user-reviews/adult
- S5: https://unstar.app/blog/plant-identification-apps-ranked-picturethis-plantin-plantnet-2026
- S6: https://localsinsider.com/apps/how-to-identify-any-plant-on-a-walk-picturethis-app-reviewed/

---

## 4. Blossom (Mosaic S.r.l. / Bending Spoons; Android package `com.conceptivapps.blossom`)

**Overall confidence:** Medium-High for features and store data. Medium for free-tier limits.

### Target audience and use cases
- **Audience:** Beginner to intermediate houseplant and garden-plant owners.
- **Main uses:** Identification, reminders, diagnosis, and a care content blog. [Verified, S1, S2]
- **Scale:** Play India shows 5M+ downloads (50L+), 4.4 stars, 1.86L reviews, updated 6 Oct 2026. US iOS shows 4.6 stars from 69K ratings. [Verified, S1, S2]
- **Publisher:** iOS seller Mosaic S.r.l., copyright Bending Spoons Operations S.p.A. [Verified, S1]

### Core features and user journey
- **Features:**
  - Identification of more than 30,000 plants, flowers, succulents and trees.
  - Disease identification.
  - "AI Botanist" custom treatment plans.
  - Reminders (water, fertilize, mist, clean, repot, plus custom reminders).
  - Notes and journal, a "My garden" collection, a light meter, and the "Green Blog" with articles and videos.
  - [Verified, S2]
- **Journey:** A third-party review describes a soft paywall: add the first plant, then get asked to subscribe to activate reminders. [Verified, S4, third-party]

### Photo upload and garden visualisation
- **Photos:** Camera or gallery, with multiple images to improve accuracy. [Verified, S2, S4]
- **Visualisation:** "My garden" is a collection list, not a spatial view. [Assumption]

### Manual drawing, measurements, layout editing
- **Drawing and layout:** None found. [Assumption]
- **Measurements:** Light meter (premium) and pot size as an input to the water calculator. [Verified, S1, S2]

### Plant identification and recommendations
- **Identification:** 30,000+ species (narrower than PictureThis). [Verified, S2]
- **Content:** Database search plus blog content. [Verified, S2]

### Watering, fertilising and care reminders
- **Water calculator:** "Customized watering recommendations, based on your plant type and the size of a pot". [Verified, S1]
- **Automatic reminders:** A search-snippet listing says reminders are created "based on each specific plant's needs, light conditions and the time of year". [Verified via search summary of App Store regional listing. Medium confidence]
- **Weather:** No live-weather input found. [Assumption]

### Personalisation, weather, location
- **Personalisation:** Limited to plant type, pot size, light and season. No verified weather or location awareness. [Assumption, based on absence]

### Pricing
- **US App Store:**
  - Premium 1 Year: **$59.99, $69.99 and $79.99** SKUs.
  - 1 Month: **$5.99**.
  - "Weekly Bundle": **$7.99** (with or without free trial).
  - [Verified, S1]
- **Play India:** **₹90 to ₹8,184.99 per item**. Plans are 1-month and 1-year, with an auto-renewing free trial. [Verified, S2]
- **Premium includes:**
  - Disease identification.
  - Unlimited identification, unlimited plants in the garden, and unlimited water calculations.
  - AI botanist and light meter.
  - [Verified, S2]
- **Free-tier plant cap:** Reviews cite "2" or "5" plants. Exact figure unverified. [Verified that a cap exists, S2. Number from S5, S6, third-party]

### Strengths, weaknesses, complaints
- **Strengths:** Simple UX, a broad content blog, an all-in-one feature set, and strong Play India adoption. [Verified, S2]
- **Weaknesses and complaints:**
  - Billing: deceptive trials, double charges, a reported annual price increase from $19.99 to up to $79.99 (aggregator claim).
  - Inconsistent reminders and crashes, and slow support.
  - [Verified, S4, S5, S6, third-party, low-medium reliability]
  - The heavily paywalled free tier also blocks the light meter and diagnosis. [Verified, S2]
- **Gaps:** No weather or location, no space planning, and houseplant or ornamental focus. [Assumption]

### Differentiation opportunities
- **Pot-size watering to terrace scale:** Blossom's pot-size water calculator is a primitive version of what a terrace planner can do natively. Each container in the layout carries volume, sun exposure and plant, so watering can be computed per container and summed as "litres today" for the whole terrace. [Assumption]

### Sources (accessed 2026-10-18)
- S1: https://apps.apple.com/us/app/blossom-plant-care-guide/id1487453649
- S2: https://play.google.com/store/apps/details?id=com.conceptivapps.blossom&hl=en_IN&gl=IN
- S3: https://www.appbrain.com/app/blossom-plant-identifier/com.conceptivapps.blossom
- S4: https://screensdesign.com/showcase/blossom-plant-care-guide
- S5: https://grand-screen.com/apps/blossom-plant-identifier/reviews/
- S6: https://www.pissedconsumer.com/blossom-plant-app/RT-F.html
- S7: https://kimola.com/reports/unlock-insights-blossom-app-user-feedback-report-app-store-us-155862 (returned HTTP 410 at access time, cited via search summary only)

---

## 5. Plantix (originally PEAT GmbH, Berlin; acquired by HELM AG in 2023)

**Overall confidence:** High that it is free and has these features. Medium for scale figures, which vary by source and date.

### Target audience and use cases
- **Audience:** Smallholder farmers, mainly in India, plus agri-input retailers through Plantix Partner. Play India describes it as "the most prominent digital kheti badi platform for farmers". [Verified, S2]
- **India focus:**
  - About **80% of users are in India**, with 10M users and 6.3M active between Feb 2022 and Feb 2023. [Verified, S3, FAO profile]
  - Offices in Berlin and Indore. [Verified via search summary of engineeringforchange.org, S6, Medium]
- **Main uses:**
  - Photo diagnosis of disease, pest or nutrient deficiency, with treatment.
  - Crop advisory, fertilizer calculation, weather-based activity scheduling.
  - Farmer community and expert Q&A.
  - [Verified, S2]

### Core features and user journey
- **Features listed on Play:**
  - Free crop diagnosis and treatment, plus cultivation tips and preventive measures.
  - **Fertilizer calculator based on plot size.**
  - Community and expert guidance.
  - **Weather forecast, and scheduling of sowing, spraying, weeding and harvesting according to weather.**
  - Crop advisory across "thirty major crops" with packages of practices.
  - Automated diagnosis of "more than 500" crop diseases.
  - [Verified, S2]
- **Crop calendar:** A crop calendar with stage-wise advisories, plus an offline library. [Verified, S4, ICRISAT]
- **India marketplace:** An integrated marketplace for sourcing inputs (market.plantix.net). [Verified, S1, S3]
- **Scale figures differ by source:**
  - FAO: 50 crops, 500+ threats, 60M-image database, 18 languages including 10 Indian. [Verified, S3]
  - ICRISAT: 60 crops, about 700 classifications, 18 languages, 45M+ downloads, 1.2M MAU, ">93% accuracy in farmers' fields". [Verified, S4]
  - Play India: 10M+ downloads (1Cr+), 4.1 stars, 1.38L reviews, updated 16 Oct 2026, released 4 Jun 2015. [Verified, S2]

### Photo upload and garden visualisation
- **Photos:** Photo upload for diagnosis is core. [Verified, S1, S2]
- **Visualisation:** No garden visualisation. [Assumption]

### Manual drawing, measurements, layout editing
- **Drawing and layout:** None found.
- **Measurements:** Plot size is the only spatial input (for the fertilizer calculator), and it is a field-scale area, not container geometry. [Verified, S2]

### Plant identification and recommendations
- **Identification:** Diagnosis-focused. It "identifies the plant and its status, and suggests remedies". [Verified, S3]
- **Treatments:** Biological and chemical control recommendations. [Verified, S4]

### Watering, fertilising and care reminders
- **Fertilising:** Calculated by crop and plot size. [Verified, S2]
- **Activity scheduling:** Weather-based (spraying, weeding, harvesting). A third-party summary says localized forecasts cover at least 5 days. [Verified, S2. Forecast horizon via search summary, Medium]
- **Watering:** No per-plant container watering reminders found. [Assumption]

### Personalisation, weather, location
- **Location:** GPS-based, with crop selection and growth stage. [Verified, S2, S3]
- **Languages:** Multilingual, including Indian languages. [Verified, S3]

### Pricing
- **Cost:** Free for farmers. Play India lists "Contains ads", and no in-app purchase range was shown for the app itself. [Verified, S2]
- **Revenue:** Comes from B2B image-recognition API and "Plantix Intelligence" products, plus the input marketplace. FAO states no commission is taken on pesticide sales. [Verified, S1, S3]
- **Copycat warning:** The iOS "Plantix- Plant Leaf Identifier" (id6450135619) is by a different developer (Ajay Gorasiya), with subscriptions and a 3.0-star rating. It is **not** the official Plantix. [Verified, S5]

### Strengths, weaknesses, complaints
- **Strengths:**
  - Free, deep India penetration, and Indian languages.
  - Vegetable and crop disease focus, weather-linked scheduling, and a fertilizer calculator.
  - A large image dataset.
  - [Verified, S2, S3, S4]
- **Weaknesses:**
  - Critics argue the business model encourages pesticide sales, although FAO says no commission is taken. [Verified, S3 plus a third-party summary]
  - Farm-scale framing (plot, field, "kheti badi"), so not tailored to containers, terraces or ornamentals. [Verified, S2, plus Assumption]
  - Contains ads. [Verified, S2]
  - Android-first. No official iOS app was found. [Assumption, only a copycat surfaced on iOS]
- **Gaps:**
  - No container-scale guidance, such as potting mix, pot depth per crop or plants per grow bag.
  - No houseplants and no space planning.
  - [Assumption]

### Differentiation opportunities
- **Bring Plantix-style guidance to the terrace:** Plantix validates Indian demand for vegetable disease diagnosis, weather-aware activity scheduling and multilingual support. A terrace app can bring this "farm intelligence" down to grow-bag scale:
  - Grow-bag size per crop and plant count per container.
  - Organic or low-chemical treatments, which suit urban home growers (organic preference is an [Assumption]).
  - Sowing calendars by Indian region and season (Kharif, Rabi, Zaid; summer, monsoon, winter).
  - [Assumption]
- **Diagnosis partnership:** A Plantix-style diagnosis API could be a partnership or licensing route ("Plantix Intelligence: API Toolkit"). [Verified that the product exists, S1. Feasibility is an Assumption]

### Sources (accessed 2026-10-18)
- S1: https://plantix.net/en/ and https://plantix.net/en/about-us/
- S2: https://play.google.com/store/apps/details?id=com.peat.GartenBank&hl=en_IN&gl=IN
- S3: https://agritechobservatory.review.fao.org/en/plantix-crop-doctor
- S4: https://issca.icrisat.org/scalable-solutions/plant-protection-application-app-plantix
- S5: https://apps.apple.com/us/app/id6450135619 (copycat listing, for reference)
- S6: https://www.engineeringforchange.org/?p=67262 (via search summary)
- S7: https://futurefarming.com/smart-farming/plantix-more-than-a-crop-doctor-driven-by-ai (22 Feb 2024: HELM AG acquisition in 2023, 45 crops, 500+ damages)

---

## Cross-cutting observations

1. **No app plans space.** None of the five offers manual drawing, dimensions, layout editing or a visual garden map. Their "garden" or "site" is always a list. [Assumption, based on the absence of any such feature across all listings reviewed]
   - The closest analogues are Planta's room-based "sites" with light settings, Greg's camera-estimated pot size and window distance, and Plantix's plot-size input to its fertilizer calculator.
   - **A dimension-aware terrace or balcony planner is an uncontested niche among these leaders.**
2. **Measurements stop at light and the pot.** Light meters are universal (Planta, PictureThis, Blossom, Greg). Pot size feeds watering in Planta, Greg and Blossom.
   - Nobody models terrace-level factors: orientation, sun hours per zone, parapet or neighbour shading, wind, heat reflected from concrete, load or weight limits, drainage, or available floor area versus container footprint. [Assumption]
3. **Weather awareness splits the field.**
   - Planta (live weather, rain and heat alerts) and Greg (location and seasonal evapotranspiration) are weather-aware.
   - PictureThis and Blossom show no verified weather input.
   - Plantix uses weather for farm activity timing.
   - An ET-based container watering model driven by live Indian weather, giving litres per container per day and skipping watering after rain, combines the best of Greg, Planta and Plantix. [Assumption]
4. **The split between houseplants and vegetables:**
   - Planta, Greg and Blossom are houseplant-first, with vegetables a recent add-on at best (Planta's veggie and seed tracking).
   - Plantix is vegetable- and crop-first but farm-scale.
   - **Container vegetables, herbs and fruit on Indian terraces fall in the gap between them.** Examples are tomato, chilli, brinjal, okra, leafy greens, curry leaf, tulsi, lemon and gourds on trellises. [Assumption]
5. **Indian climate and seasons:**
   - No consumer care app documents tuning for monsoon, pre-monsoon heat above 40°C, Rabi/Kharif sowing windows or regional calendars. Planta uses hardiness zones, a temperate-world framing that is weakly suited to India. [Verified for Planta's zone input, S4. Rest Assumption]
   - Only Plantix offers Indian languages.
6. **Monetisation and trust:**
   - Every consumer app (Planta, Greg, PictureThis, Blossom) uses aggressive trial-to-subscription paywalls.
   - Billing and trial complaints are the most common negative theme across aggregators.
   - Western apps rate notably lower on Play India: Planta 3.1 and Greg 3.9, versus 4.8 and 4.6 on US iOS. [Verified from listings]
   - INR-native, transparent pricing with a genuinely useful free planner is a plausible wedge. [Assumption]
7. **Identification and diagnosis are commoditised.** PictureThis (400k+ species claimed) and Plantix (crop diseases) set the bar.
   - A new entrant should integrate an identification or diagnosis API rather than build one, and differentiate on planning, container-scale agronomy and Indian seasonality. [Assumption]
8. **Features to borrow:**
   - Planta's Care Share for plant-sitters (useful during Indian travel or festival seasons).
   - Greg's community Q&A and camera measurement.
   - Plantix's weather-based activity scheduling and fertilizer calculator, re-scaled from field plot to container volume.
   - [Verified features. Applicability is an Assumption]

---

# Part C: Garden design, layout and AI-redesign tools

**Prepared:** 2026-10-18 | **Context:** Flutter app for terrace, balcony and container gardening (India-first, usable globally). It combines a dimension-aware 2D planner with locally relevant care guidance.

**Method:** Live web research using official websites, Apple App Store listings, help docs and release notes, plus third-party roundups, which are flagged where they come from vendors.

**Tags:**
- **[Verified]** means a source was read during this research. The source is named inline and listed at the end of each section.
- **[Assumption]** means inference or analysis, not confirmed by a source.

**Prices:** Store prices are the USD figures shown on the US App Store unless noted. Indian (INR) storefront prices were **not** checked.

**Caveats:**
- Most "best AI garden app" roundups in 2026 are written by competing vendors such as Gardenly, RemodelAI, GenRoom and OutdoorBrite. They are used only for discovery and never as proof of a feature.
- App Store pages show dates without the year (for example "Sep 30"). Where the year is not shown, this document says so.

---

## 1. iScape (iScape Holdings Inc.)

**Overall confidence: High** for features and pricing, **Medium** for complaints, because some come from aggregators.

### Target audience and use cases
- The audience is homeowners and hobbyists, DIY users, landscape professionals, and companies that need multiple licences. [Verified: iscapeit.com]
- The main use case is seeing a landscape project on your own property before spending money: "visualize the finished landscape project right from your mobile device." [Verified: iscapeit.com]
- Pro features are clearly aimed at landscapers: client proposals, pricing and PDF quotes. [Verified: App Store listing]
- iScape claims "nearly 4 million users" and calls itself the "#1 landscape design app". These are self-reported marketing claims. [Verified as a claim: iscapeit.com]

### Core features and user journey
1. The user takes or imports a photo of a yard (Street View import also exists). [Verified: App Store release notes]
2. They overlay plants, pavers, hardscape and furniture by drag, drop and resize. A virtual pen, a "magic eraser" and texture tools are available. [Verified: iscapeit.com, App Store]
3. They share the design with clients or family. [Verified: iscapeit.com]
4. They generate a materials list. Pro users can also create a PDF proposal with pricing. [Verified: iscapeit.com, App Store]
5. 2D or 3D AR placement is available. The site's plan comparison marks 2D and 3D design as iOS-only. [Verified: iscapeit.com]
6. Platforms are iOS, Android and a Mac app. The latest iOS version noted was 4.40.6, shown as "2d ago" relative to the access date. [Verified: App Store]

### Photo upload and visualisation
- Photo-overlay compositing is the core of the product. The user places items manually; nothing is generated. [Verified]
- An AI concept feature that starts from a photo of your own yard is announced as **beta / "will be launching"** on the FAQ page. [Verified: iscapeit.com/faqs-page]
- An iScape blog post describes AI that suggests a first concept (planting, lawn, paths, patios, furniture) from a photo. That URL returned 404 on re-fetch, so the description is known only from a search snippet. [Verified as a snippet only; treat as Medium]

### Manual drawing, measurements and layout
- Neither the official website nor the App Store listing mentions measurement or scale tools. [Verified: absence on both pages]
- A third-party roundup rates iScape's measured layout as "Partial". [Verified as a third-party claim: gardenly.app, a vendor-written roundup]
- Layout is a perspective photo collage, not a top-down plan drawn to scale. There is no grid, no square-foot gardening mode and no notion of container volume. [Assumption, consistent with all sources read]
- App Store reviews say plants are "hard to move precisely" and that overlapping items are hard to select. [Verified: App Store reviews]

### Plant identification and recommendations
- A catalogue of "thousands of plants" is available, but the full database requires Pro. [Verified: iscapeit.com]
- There is no plant identification. The homepage claims AI "optimization for climate and soil", but this could not be verified independently. [Verified as a claim; Assumption that it is not yet substantive]
- A professional reviewer asked for a better plant database with common and botanical names. The developer replied that an expanded database is in progress. [Verified: App Store reviews]

### Care reminders
- None found. The product is design-only. [Verified: absence]

### Personalisation, weather and location
- No zones, frost dates or climate settings were found. There is nothing for India or tropical climates. [Verified: absence on site and FAQ]

### Pricing [Verified: iscapeit.com, FAQ, App Store]
- **Free:** limited features, database and access. The developer says the free version includes unlimited-access products, one texture per category and **two saved designs**.
- **Pro:** $29.99/month or $299.99/year. A weekly plan costs $7.99.
- **Plus:** $14.99/month, listed in the App Store.
- **"Lite":** mentioned on the FAQ page as "being tested".
- **Enterprise:** contact sales.

### Strengths
- Mature product with strong brand recognition. [Verified]
- High rating: 4.6 from about 29K ratings on iOS. [Verified: App Store]
- Fast and intuitive "point-and-place" on a real photo. [Verified via review themes]
- Proposals and materials lists for professionals. [Verified]

### Weaknesses and complaints [Verified: App Store reviews; Justuseapp/Marlvel aggregators, Medium confidence]
- The paywall prevents meaningful testing before subscribing.
- Cancelling and billing are confusing. The App Store listing says the current subscription cannot be cancelled during the active period.
- Price is high for hobbyists (about $300/year).
- Crashes and slow loading of the image library.
- Imprecise object placement.
- Android is reportedly 2D-only. [Verified: site plan table]

### Gaps
- No scaled plan, no vegetables or edible focus, no care guidance, no climate localisation, and nothing specific to containers or balconies. [Assumption based on verified absences]

### Differentiation opportunities [Assumption]
- Keep the familiar idea of "see it on my photo", but tie it to a **measured top-down plan**.
- Price for Indian hobbyists rather than US landscapers.
- Add edible and container planting logic, such as pot volume, spacing and sun hours.

### Sources (accessed 2026-10-18)
- https://www.iscapeit.com/
- https://iscapeit.com/faqs-page
- https://apps.apple.com/app/id439688430
- https://iscapeit.com/blog/no-ideas-for-your-yard-try-iscapes-ai-feature (search snippet only; 404 on fetch)
- https://justuseapp.com/en/app/439688430/iscape/reviews (aggregator)
- https://marlvel.ai/apps/com-patrick-iscapefree/vs (aggregator; AI-generated audit)
- https://gardenly.app/blog/garden-design-apps-ranked (vendor-written roundup)

---

## 2. GrowVeg Garden Planner (Growing Interactive; also white-labelled as the Almanac Garden Planner and others)

**Overall confidence: High** for features and pricing, **Medium** for tropical support, because detailed docs are from an older guide.

### Target audience and use cases
- The audience is vegetable, herb and fruit gardeners in temperate countries, from allotments to backyards. [Verified: growveg.com]
- Main use cases are laying out beds, knowing how many plants fit, working out when to sow, plant and harvest, and planning crop rotation and succession. [Verified]
- The same engine is white-labelled for other brands: The Old Farmer's Almanac (gardenplanner.almanac.com), Mother Earth News "Grow Planner", and seed companies. [Verified: user guide v2.5; seed-company planner subdomains seen in search results]

### Core features and user journey [Verified: growveg.com/garden-planner-intro.aspx, /grow-planner/]
1. Set your location. Frost dates are pulled from 5,000+ weather stations.
2. Create a plan, choosing metric or feet and inches.
3. Draw beds and objects, then drag in plants. Automatic spacing shows how many plants fit.
4. The planner produces a Plant List with sow, plant and harvest dates, plus a shopping list.
5. Email reminders arrive every two weeks, and a Garden Journal shows jobs due in the next two weeks.
6. Follow-on plans for next year include crop-rotation warnings.

Other features:
- Companion planting described as "evidence-based".
- Structures (greenhouse, cold frame, row cover) shift the planting dates.
- Content: 21,657 varieties across 408 crops (the site also gives 21,400 elsewhere), custom varieties, 441 videos and 1,527 grow guides.

### Photo upload and visualisation
- None. There is no photo upload, AR or AI rendering. The visual is a top-down, icon-based plan. [Verified: no mention on any page; no AI features listed]

### Manual drawing, measurements and layout
- Plans have real dimensions. You set plan size and units in a "Plan Size & Grid" dialog, metric or imperial, with an optional background grid and snap-to-grid. [Verified: user guide v2.5, which is old and Flash-era; the current HTML5 version likely retains this; Medium]
- Drawing tools are line, rectangle, circle and triangle, solid or open. Non-rectangular gardens are drawn with lines or fences inside a rectangular plan. [Verified: guide]
- Some objects have fixed widths, for example raised beds of 4, 5, 6, 8 or 10 ft. [Verified: guide]
- **Square Foot Gardening mode** shows plant icons as 1 ft squares, each labelled with a plants-per-square count. [Verified: guide, intro page]
- **Containers, grow bags and hanging baskets** can be placed as items. [Verified: grow-planner page]
- Whether container volume or depth affects recommendations is not documented. [Assumption: probably not]
- Mobile: "Works on ANY device – no download required" and "phone compatibility now supports the full planner features". There is no native app in the stores. [Verified: growveg.com; AlternativeTo and a third-party roundup also list it as online-only]
- The old guide mentions iOS companion apps (Garden Plan Pro and others). These are not prominent in 2026 searches. [Verified as historical only]

### Plant identification and recommendations
- There is no photo identification. [Verified: absence]
- Recommendations come from filters (easy to grow, frost tolerant, suitable for SFG and similar), companion planting and rotation. [Verified: guide, site]
- "Many tropical plants" are listed. [Verified: grow-planner page]

### Watering, fertilising and care reminders
- Email reminders cover **sowing and planting only**, every two weeks. [Verified: subscribeinfo, intro page]
- There is no evidence of reminders for watering or fertilising. [Assumption, based on absence]

### Personalisation, weather and location
- Frost dates come from the nearest weather station. Where no station exists, the user enters dates manually. [Verified]
- The old guide lists station coverage only for the US, Canada, the UK, Ireland, Australia, New Zealand, much of western Europe and South Africa. **India is not listed.** [Verified: guide v2.5, older] The current site says it covers "all major regions globally". [Verified as a claim]
- For hot climates, there are options for "My area does not experience frost" and "Split growing season into two", where cool-season crops are planted in spring and autumn. [Verified: guide]
- This is a temperate, frost-date model. It does not model **monsoon (kharif), winter (rabi) or summer (zaid) seasons**, heat stress or rainfall. [Assumption; partial support only]

### Pricing [Verified: growveg.com/subscribeinfo.aspx]
- **7-day free trial**, with no card needed.
- Then **$35/year** recurring, **$50** for one year, or **$85** for two years.
- Up to 5 plans per year; more with an upgraded annual account.
- There is **no permanent free tier**. [Verified: only a trial is described]

### Strengths
- The deepest edible-garden planning logic in this set: spacing, SFG, rotation, succession and structure-adjusted dates. [Verified]
- Large content library. [Verified]
- Works on the web on any device. [Verified]
- Long track record, with white-label partnerships showing it is trusted. [Verified]

### Weaknesses and complaints
- Few recent independent reviews were found. An old 2009 blog called some editing clumsy. [Verified: bolandbol.com, 2009]
- Paid-only after the trial, and in USD. [Verified]
- Desktop-first UX on the web. Mobile usability is claimed, but no native app exists. [Verified as a claim; quality of the phone experience is an Assumption]
- No photo or visualisation layer, no care reminders beyond sow and plant, and weak on Indian climate. [Partly Verified, partly Assumption]

### Gaps
- No terrace or balcony modelling: walls, parapet height, load, drainage, or sun and shade from surrounding buildings.
- No pot-size logic.
- No Indian seasons, no Indian crops by local name (for example methi, palak, bhindi), and no Indian units or languages.
- [Assumption]

### Differentiation opportunities [Assumption]
- A native, mobile-first, touch-friendly scaled planner (GrowVeg is desktop-centric).
- Container-first objects (grow bags by size, for example 12×12 inches or 15×15 inches), weight per square metre, and sun-hours by terrace orientation.
- Indian crop calendars by agro-climatic zone and season.
- Freemium pricing in INR.

### Sources (accessed 2026-10-18)
- https://www.growveg.com/garden-planner-intro.aspx
- https://www.growveg.com/grow-planner/
- https://www.growveg.com/subscribeinfo.aspx
- https://www.growveg.co.uk/downloads/gardenplanneruserguide.pdf (User Guide v2.5, older Flash-era document)
- https://gardenplanner.almanac.com/
- https://www.growveg.com.au/garden-planner-reviews.aspx (vendor testimonials)
- https://blog.bolandbol.com/2009/04/08/designing-the-garden-with-growveg/ (2009 review)
- https://alternativeto.net/software/veggie-stats (platform listing)

---

## 3. Planter: Garden Planner (Percula LLC, planter.garden)

**Overall confidence: High** for features and pricing, **Medium** for container and metric handling.

### Target audience and use cases
- The audience is beginner to intermediate home vegetable gardeners who use raised beds and square-foot methods. [Verified: App Store reviews praising beginner-friendliness]
- Main use cases are laying out beds, checking companion and antagonist plants, and knowing when to start seeds and transplant. [Verified]

### Core features and user journey [Verified: planter.garden, App Store, release notes]
1. Create a garden: size it and outline raised beds.
2. Drag plants onto the square-foot grid.
3. See companion and antagonist indicators.
4. The planting calendar works from frost dates chosen on a map. Map-based selection arrived in v3.6.21 (Aug 2025) and place search in v4.0.06 (Aug 2026).
5. Tasks with notifications were introduced in v3.6.01 (Feb 2025).
6. Other features: notes, a SeedBox seed inventory, and custom plants and varieties. AI icon generation for custom plants is a Premium feature (v3.6.31, Oct 2025).
7. **Gardens 2.0 (beta, v4.0.05, 22 Jul 2026)** adds round, oval and tower shapes, intercropping, multiple gardens in one layout, and row planting.
8. Recent updates: embedded beds can be resized and rotated, and garden sizes now respect the unit preference (v4.0.07, 25 Aug 2026).

Platforms are iOS, iPadOS, macOS, visionOS, Android, Amazon Fire and web. The web app is Premium only. [Verified]

### Photo upload and visualisation
- No photo-to-design or AR features. The output is a top-down plot map, and "custom backgrounds" are a Premium feature. [Verified: planter.garden; RemodelAI roundup calls it "a bird's-eye plot map, not a photorealistic yard transformation"]

### Manual drawing, measurements and layout
- A **square-foot grid** is the core layout model. [Verified]
- A metric setting exists. A "Metric setting fix" appeared in v3.6.09, and "Garden sizes and areas now respect your unit preference" in v4.0.07. [Verified: release notes] Whether the grid cell can be set to, say, 30 cm instead of 1 ft was not confirmed. [Unverified]
- Tower shapes are in beta. Tower shapes **could** represent vertical planters. [Verified feature; container use is an Assumption]
- No **pots, containers or grow bags** are mentioned in the release notes, App Store listing or website. [Verified: absence]
- It is a native mobile app with a touch UI, and reviews praise its ease of use. [Verified]

### Plant identification and recommendations
- No photo identification. [Verified: absence]
- Covers 100+ fruits and vegetables with thousands of varieties. The website says "80+ plants with over 1,000 varieties", so the counts are inconsistent. [Verified]
- Companion planting logic is included. [Verified]

### Watering, fertilising and care reminders
- Tasks linked to plants come with notifications. [Verified] They appear to be created by the user; no automatic watering or fertilising schedules were found. [Assumption]
- No weather integration was found. [Verified: absence in release notes]

### Personalisation, weather and location
- A frost-date map handles location, and frost dates can be removed (v3.6.25), which may help frost-free regions. [Verified]
- Germination temperatures are shown. [Verified: App Store]
- No India-specific or monsoon season logic was found. [Assumption, based on absence]

### Pricing [Verified: planter.garden; App Store]
- **Free:** 1 garden, growing calendar, custom plants and seed box, with ads.
- **Premium:** $24.99/year. A discounted annual price of $19.99 is also listed. Premium adds unlimited gardens, no ads, notes and events, custom backgrounds and the web app.
- **Lifetime:** $99.99. Legacy tiers ($4.99/month, $11.99/year, $49.99 lifetime) still appear in the App Store.

### Strengths
- Simple and well liked: 4.7 from about 2.3K iOS ratings. [Verified]
- Affordable, with a lifetime option. [Verified]
- Cross-platform including web. [Verified]
- Developed actively in 2025–2026. [Verified]

### Weaknesses and complaints [Verified: App Store reviews]
- Garden creation is "kind of limited without a subscription".
- Larger gardens were still in beta at the time of one review.
- Drip irrigation is hard to visualise.
- Background options for squares are confusing.
- Some seed brands are missing.

### Gaps
- No real container objects.
- No terrace constraints such as load, parapet, sun and shade from walls, or water outlets.
- No care automation based on weather.
- No Indian crops or seasons.
- [Assumption]

### Differentiation opportunities [Assumption]
- Planter shows a simple mobile-first planner can earn high ratings. The gap is **container-native layout**: pot diameter and depth, grow-bag sizes, plants per container, and mixed container types on a measured terrace floor.
- Care that is driven by weather and container size (pots dry out faster).

### Sources (accessed 2026-10-18)
- https://planter.garden/
- https://planter.garden/release-notes
- https://apps.apple.com/app/planter-garden-planner/id1542642210
- https://www.remodelai.io/blog/best-ai-landscape-design-apps (vendor-written roundup)
- https://www.houzz.com/discussions/4577779/try-my-app-planter-to-help-manage-your-vegetable-beds (old developer post)

---

## 4. AI photo-redesign garden tools (prominent in 2026)

Discovery came from 2026 roundups and store searches. Four tools were chosen because they show up most across roundups and store listings, and between them they cover different models.

### 4a. Garden AI: Landscape Design (FATE Yazılım ve Teknoloji Ltd. Şti., Turkey)

**Overall confidence: Medium-High**

- **Audience and use cases:** homeowners, DIY gardeners, landscapers and designers. The main use is a fast "makeover" render of a yard, patio or garden photo. [Verified: Google Play description via AppPricingLab]
- **Features and journey:**
  1. Upload a photo.
  2. Pick a style. iOS says 10+ styles and the Google Play description says 50+, for example zen, tropical, cottage and Mediterranean.
  3. The AI generates a redesign.
  4. Swap plants, paths, fences, furniture and décor.
  5. Exterior features include wall colours, pergolas and lighting.
  6. Save, compare and share.
  [Verified: App Store and Google Play descriptions]
- **Photo and visualisation:** a perspective image generated from the photo. An AR mode is mentioned in a third-party summary. [Verified: description] [AR mode Verified only via an aggregator snippet]
- **Measurements and layout:** none mentioned. "Customizable layouts" refers to editing the image, not dimensions. [Verified: absence; interpretation is an Assumption]
- **Plant recommendations:** plant suggestions "based on climate, sunlight, soil type, and maintenance level". [Verified as a store claim] How this works is not documented. [Assumption: prompt-level only]
- **Care reminders:** none. [Verified: absence]
- **Location and climate:** only the climate claim above; nothing India-specific. [Verified: absence]
- **Pricing (iOS US):** Pro costs $7.99/week, $59.99/year, or $39.99/year discounted. Credit packs cost $3.99 to $17.99. [Verified: App Store]
- **Traction:**
  - iOS: 4.5 from about 2.1K ratings, latest version 10.8 dated "Sep 30" (year not shown). [Verified]
  - Google Play: 4.6 from about 7.3K reviews, 100K+ installs, updated 2026-03-05. [Verified: AppPricingLab tracker]
- **Complaints** [Verified: App Store reviews]:
  - Unwanted objects rendered, such as a person or a bucket.
  - Edits that change nothing.
  - Failed generations that still say "ready".
  - It ignores slopes and terrain.
  - Weekly generation limits.
  - Output feels like a "resort" rather than the user's own style.
  - "Every item in the menu pushes you for subscription". [Verified as an aggregator snippet]
- **Gaps:** no plan, no dimensions, no plant care, and the render is not a reliable view of what will actually be planted. [Assumption]
- **Opportunity:** use AI renders only for **inspiration and mood** and say so clearly, then convert the chosen look into a measured plan the user can edit. [Assumption]

**Sources (accessed 2026-10-18)**
- https://apps.apple.com/us/app/-/id6738805390
- https://apppricinglab.com/app/google_play/com.fate.gardenAi2
- https://play.google.com/store/apps/details?id=com.fate.gardenAi2&hl=en (seen in search results; not fetched)
- https://marlvel.ai/api/llm/apps/graphics-design/com-fate-gardenai (aggregator)

### 4b. Neighborbrite (Neighborbrite Inc.)

**Overall confidence: Medium.** Feature coverage is good, but web pricing is unclear.

- **Audience and use cases:** homeowners wanting yard ideas, plus landscapers through the "Business" and "Landscaper Suite" tiers. [Verified: App Store IAP names, reviews from professionals]
- **Scale claims:** 800K+ registered users, 20M+ designs, and 170+ countries. These are self-reported. [Verified as claims: neighborbrite.com]
- **Features and journey** [Verified: neighborbrite.com, App Store]:
  1. Upload a photo.
  2. Pick a style or describe the yard in words.
  3. Edit with Magic Edit (text prompt on a selected region), Add Elements (5,000+ plants and features) and Erase.
  4. Finish with high-res output, auto-enhance, and Identify Plants / Plant Finder.
- **Plant identification and recommendations:** plant lists tailored to climate and sunlight. The example shows "Salt Lake City · Zone 7b · Full sun". In most US states, plants can be ordered through partner Nature Hills Nursery. [Verified] This is US hardiness-zone thinking, with no evidence of tropical or Indian modelling. [Assumption]
- **Measurements and layout:** the official site does not mention any. [Verified: absence] A vendor-written roundup says "Explicitly none; no top-down plans". [Verified as a third-party claim: gardenly.app] A "professional design packages" upsell exists, where a human creates construction-grade plans. [Verified: neighborbrite.com]
- **Care reminders:** none. [Verified: absence]
- **Platforms:** web (app.neighborbrite.com), iOS and Android (Play listing released 1 Feb 2026). Interface in 5 languages. [Verified]
- **Pricing:** described as free to use, with Pro and Business tiers. The iOS IAP list shows PRO $24.99, Business $49.99 and Landscaper Suite $149.00. The billing period is not shown on the listing. [Verified] A directory lists web pricing "from $19.99/month". [Verified as a third-party claim; conflicts with store prices; Low confidence]
- **Traction and complaints:** iOS rating 4.8 from 423 ratings, version 2.5.1 dated "Oct 5". [Verified] Futuretools.io shows a caution flag ("under review" for possible upvote gaming, poor reviews or shady practices). This is unconfirmed. [Verified as a flag only]
- **Strengths:** strong editing toolkit (region-level magic edit), plant identification on the generated image, and a commerce tie-in with a nursery. [Verified]
- **Gaps:** US-centric plant logic, and no plan, dimensions or care. [Assumption]
- **Opportunity:** a tie-in with **Indian nurseries and seed sellers** for a bill of materials (pots, potting mix, seeds and saplings) based on a measured plan rather than an image. [Assumption]

**Sources (accessed 2026-10-18)**
- https://neighborbrite.com/
- https://apps.apple.com/us/app/-/id6742585344
- https://apppricinglab.com/app/google_play/com.neighborbrite (search snippet)
- https://dataconomy.com/tools/neighborbrite/ (directory)
- https://futuretools.io/tools/neighborbrite (directory flag)
- https://www.producthunt.com/products/neighborbrite-vision

### 4c. DreamzAR AI Landscape Design (ImmEx Technologies, Inc.)

**Overall confidence: Medium**

- **Audience:** homeowners and DIY users who want AI ideas and an AR preview. [Verified: App Store]
- **Features and journey** [Verified: App Store]:
  1. Upload a photo.
  2. The AI generates designs in 20+ styles, including Tropical and Xeriscaping.
  3. Refine **by chat**, for example "add flowers near the fence".
  4. A 2D photo editor offers 2,000+ plants and features, works offline and saves projects.
  5. 3D AR places life-size plants in the real yard, **measures areas**, and gives cost estimates. A directory notes that cost estimates are USA-only. [Verified as a directory claim: goodfirms]
- **Measurements:** AR measurement of areas is the only measurement capability among these AI tools. It is not a persistent scaled plan. [Verified feature; plan absence is an Assumption]
- **Plant identification and care:** none found. [Verified: absence]
- **Climate:** none, apart from the style names. [Verified: absence]
- **Pricing (iOS US):** $19.99/month, $199.99/year, "Full version" $9.99, credits $9.99 to $14.99, and an asset pack $9.99. [Verified: App Store]
- **Rating:** 3.0 from 143 ratings, version 6.1 dated "Feb 1" (year not shown). [Verified]
- **Complaints:** 2D/3D assets look dated ("Looks truly awful… taking my subscription elsewhere"), and the plant library is thin. [Verified: App Store reviews]
- **Note:** dreamzar.com is now a parked domain for sale. The product appears to live at dreamzar.app. [Verified: redirect to GoDaddy for-sale page] This may suggest a small team. [Assumption]
- **Opportunity:** DreamzAR shows that people want **AR measuring plus AI ideas**. Nobody connects AR-measured dimensions to a structured planting plan. [Assumption]

**Sources (accessed 2026-10-18)**
- https://apps.apple.com/app/id1588977278
- https://dreamzar.app/ (seen in search results)
- https://www.goodfirms.co/software/dreamzar (directory)
- https://alternativeto.net/software/dreamzar-ai-landscape-design/about

### 4d. Yardzen (human design service, plus the "YardAI" inspiration tool) and look-alike apps

**Overall confidence: Medium**

- **Yardzen Inc.** sells online design by human designers:
  - Backyard packages: **Essential $995, Classic $1,395, Signature $1,995**.
  - Front Yard, Full Yard and Small Space tabs also exist; their prices are not shown.
  - The service promises photorealistic 3D designs and "build-ready plans", and the customer owns the design files.
  - It has a vetted contractor network in select US markets.
  [Verified: yardzen.com]
- **YardAI by Yardzen** (ai.yardzen.com) is titled a "Dream Yard Inspiration Tool". The page content was not readable through the fetch tool. [Verified: title only] Yardzen itself frames AI as **inspiration**, while precise plans come from human designers. [Assumption, supported by the page title and the "AI / DIY" vs packages comparison on yardzen.com]
- **Name-confusion risk:** the iOS app "Yardzen: AI Backyard Design" (id6747066573) is published by an individual developer (所怀 祝), **not Yardzen Inc.** Its description calls itself "Yardora". [Verified: App Store]
  - Pricing: weekly PRO $2.99 or $4.99, yearly $19.99. Rating 3.2 from 65 ratings. [Verified]
  - Complaints: "Trees in the sky", "Does not account for a reference image at all", a paywall before results, and difficulty cancelling. [Verified: reviews]
  - It explicitly supports **balcony and rooftop** photos and has a "custom layout planner". [Verified as a store claim]
- **Takeaway:** the AI-redesign category on the app stores is crowded with lookalike apps that are mostly weekly subscriptions. Quality and trust vary widely. [Assumption, based on multiple listings seen: "AI Garden Design", "AI Garden & Landscape Design", "Landscape AI", "Garden Ai" and others]

**Sources (accessed 2026-10-18)**
- https://yardzen.com/
- https://ai.yardzen.com/
- https://apps.apple.com/app/id6747066573

### 4e. Other AI tools noted briefly (not deeply profiled)

- **Gardenly** (web and iPhone):
  - Photo or sketch redesign in 27+ styles, plus a planting guide and shopping list "with exact quantities".
  - Plants chosen for hardiness zone, rainfall and sun.
  - The FAQ claims designs "adapt to your specific dimensions", but how you enter them is not described.
  - Starter $4.50/month and Pro $7/month, both billed annually ($54 and $84 a year). No free tier.
  - [Verified: gardenly.app] Its "best of" roundup ranks itself first. [Verified: author is the Gardenly builder]
- **GenRoom** (web): its balcony guide states that AI is useful for "style, layout, and proportions, but not for exact furniture dimensions, plant species, or material specs". It covers balcony load (about 200–400 kg/m²; a wet planter can weigh about 80 kg) and drainage. [Verified: genroom.io blog] This is the clearest statement found from an AI vendor that **renders are not blueprints**.
- **gardenplanner.net** (free web tool, maker not named):
  - Plans to exact scale, metric or imperial, with snap-to-grid, a measure tool, and **an outline traced from OpenStreetMap at true scale**.
  - Sun and shadow simulation, and a 3D walk mode.
  - **AI drafting through prompts you copy into ChatGPT, Gemini or Claude, which return JSON you import into the editor.**
  - Exports to SVG, PDF, CSV and JSON.
  - It says it is not optimised for mobile.
  - [Verified: gardenplanner.net] This is the only tool found that sends AI output into a **structured, editable layout**. Its input is text, not a photo.
- **Planner 5D:** a general 2D/3D home and garden planner with real dimensions, according to a third-party roundup. AI features are documented for interior rooms only. [Verified: search snippets of planner5d.com; garden page URL 404] Low confidence for garden specifics.

---

## 5. Optional: Seed to Spoon, VegPlotter, Gardenize (brief)

| Product | Relevance | Key verified facts | Confidence |
|---|---|---|---|
| **Seed to Spoon** | A grow-tracking and AI help app, not a design tool. | Free tier allows 10 plant kinds and 3 questions a day to "Growbot", an AI that identifies plants, diagnoses problems and answers questions from photos. Premium is reported at $4.99/month or $46.99/year (US, WhistleOut). The App Store listing showed no IAP, which conflicts. Weather alerts by location are a third-party claim. No container layout found. | Medium-Low |
| **VegPlotter** | Web planner with a to-scale base map. | Base map from exact measurements or paced estimates. Location-aware growing window. Works in mobile browsers. Free tier: unlimited layouts and 40 plantings a year. Paid price not shown on the homepage. Containers not mentioned. | Medium |
| **Gardenize** | A garden journal and care app, not a layout tool. | 45,000+ plant database, plant identification, reminders, notes and to-dos in a calendar, plants assigned to garden "areas". $6.99/month, $17.49 for 3 months, $34.99/year (US App Store). | Medium |

**Sources (accessed 2026-10-18)**
- https://www.whistleout.com/CellPhones/Apps/seed-to-spoon-app
- https://apppricinglab.com/app/apple/1312538762
- https://www.vegplotter.com/
- https://apps.apple.com/app/apple-store/id1118448120
- https://marlvel.ai/apps/gardenize-plant-care-gardening (aggregator)
- https://www.gardening.khetibuddy.com/about-us (Kheti Buddy, an India-focused garden guidance app for Android, noted in search; not deeply verified)

---

## 6. Specific assessments

### Q1. Do any of these tools treat AI redesign images as precise blueprints?
- **No reputable tool explicitly claims that its AI renders are to scale or buildable.** [Verified: no such claim found on iScape, Neighborbrite, Garden AI, DreamzAR, Gardenly or the Yardzen pages]
- Several vendors say the opposite:
  - GenRoom says AI is "not for exact furniture dimensions, plant species, or material specs".
  - Neighborbrite and Yardzen upsell **human** designers for construction-grade plans.
  - The RemodelAI roundup treats all outputs as "design previews".
  [Verified]
- Some marketing copy blurs the line:
  - Gardenly's "adapts to your specific dimensions" and "exact quantities".
  - Garden AI's "customizable layouts".
  - Store apps that say they "preserve your space's structure".
  Users may read these as precise. [Verified wording; the risk of user misreading is an Assumption]
- User reviews show renders often **don't respect the input photo**: "Trees in the sky", ignored reference images, ignored slopes, invented objects. [Verified: App Store reviews] So treating them as blueprints would be unsafe.

### Q2. Do any convert photos into structured, editable layouts?
- **None found.**
  - Every photo tool outputs either a raster image (Garden AI, Neighborbrite, Gardenly, DreamzAR's AI mode) or a photo collage (iScape, DreamzAR's 2D editor).
  - Edits are image-level operations (inpainting, swapping elements), not objects with real-world coordinates.
  [Verified: feature descriptions; Assumption that no hidden structured model exists]
- The closest partial steps:
  - DreamzAR's **AR area measurement**. [Verified]
  - gardenplanner.net's **map-outline tracing at true scale** and its **LLM-to-JSON layout import**, which starts from text, not a photo. [Verified]
  - Yardzen's human designers turning photos into CAD plans, at $995 and up. [Verified]
- **This is a clear gap and a plausible core differentiator:** go from a photo to a structured layout in which pots and beds are detected with estimated dimensions, the user corrects them, and the result is a measured plan. Even a semi-automatic version with user-assisted calibration (for example a known reference object, a tape measurement, or AR) would be novel in this category. [Assumption]

### Q3. Do any handle container, balcony or terrace gardening (not ground beds) well?
- **Partially at best.**
  - GrowVeg lets you place containers, grow bags and hanging baskets as plan objects, at scale, with square-foot gardening. It is the strongest, but it is temperate, desktop-oriented and paid only. [Verified]
  - Planter uses square-foot beds and is adding round, oval and tower shapes (beta), but has no container objects. [Verified]
  - AI apps (the "Yardzen"/Yardora knockoff, "AI Garden Design – Landscaping" with an "Urban Micro-garden" style, GenRoom) **accept balcony and rooftop photos** for renders. They do not model containers. [Verified as store claims]
- **No tool found models terrace-specific constraints:**
  - floor load (kg/m²)
  - drainage and outlet position
  - parapet and railing
  - waterproofing
  - wind exposure
  - sun hours blocked by walls and neighbouring buildings
  - pot volume and depth matched to the crop
  - watering frequency by pot size and weather
  Only GenRoom's blog article discusses load and drainage, as advice rather than as a feature. [Verified: absence in all product feature lists; GenRoom blog]

---

## Cross-cutting observations

1. **The market splits in two, and nothing bridges the halves.**
   - (a) *Planners* (GrowVeg, Planter, VegPlotter, gardenplanner.net) give top-down, scaled or gridded layouts with planting logic, but no photo or AI visuals.
   - (b) *AI/AR visualisers* (Garden AI, Neighborbrite, DreamzAR, Gardenly, iScape) give attractive perspective images with no dimensions and no care loop.
   - Nobody connects "what it could look like" to "what exactly to buy and plant, and where". [Assumption based on verified feature sets]

2. **Care after planning is weak everywhere in this set.**
   - GrowVeg reminds you only about sowing and planting.
   - Planter has user-created tasks.
   - The AI tools have nothing.
   - Weather-driven or container-size-aware watering and fertilising reminders are absent. [Verified absences]
   - Journal and care apps (Gardenize, Seed to Spoon) cover care but not design. [Verified]

3. **The climate model is temperate and US/EU-centric.**
   - Logic is built on frost dates and USDA zones: GrowVeg's station list in the old guide excludes India, Neighborbrite shows US zones, and Planter uses a frost-date map.
   - Indian seasons (kharif, rabi, zaid), monsoon rainfall, extreme summer heat (40°C+ on terraces) and local crop names are not modelled by any tool reviewed. [Partly Verified, partly Assumption]
   - "Tropical" appears only as an **aesthetic style** in AI apps. [Verified]

4. **Container and terrace gardening is not served as a category in its own right.**
   - At best, containers are generic objects in a ground-bed planner (GrowVeg).
   - Grow-bag sizes, pot volume, weight load, drainage and vertical or railing planters are unaddressed. [Verified absence]

5. **Monetisation norms and trust problems.**
   - AI apps lean on weekly subscriptions ($3–8/week) and credit packs. App Store reviews repeatedly complain about paywalls before any result, confusing cancellation, and poor generations. [Verified]
   - Planners use annual or lifetime pricing ($25–35/year; Planter lifetime $99.99). [Verified]
   - A transparent freemium model priced in INR, with no paywall before value, is a clear position to take. [Assumption]

6. **Lookalike apps and naming noise.**
   - Many near-identical "AI Garden Design" apps exist.
   - One trades on the Yardzen name without being Yardzen Inc.
   - A known AI landscape brand's main .com domain is parked (DreamzAR).
   - Brand trust is low and differentiation is about quality. [Verified listings; interpretation is an Assumption]

7. **The most defensible wedge for the new app:** a mobile-first, **dimension-true terrace canvas** with container primitives (grow bags by size, pots by diameter and depth, raised beds, vertical planters). Around it:
   - Optional **AI inspiration renders, clearly labelled "not to scale"**.
   - An optional **photo-to-layout assist with user calibration**, which no competitor offers.
   - **Care schedules for Indian conditions**, driven by container size and weather.
   - A bill of materials (soil volume, pots, seeds) a user can buy from local sellers.
   [Assumption]

8. **Reference architecture worth studying:** gardenplanner.net shows a pragmatic pattern. An LLM produces a **JSON layout schema** that the scaled editor imports and the user then corrects. This maps naturally onto a Flutter canvas with a typed layout model and keeps the AI's output editable rather than a static picture. [Verified feature; applicability is an Assumption]

---

# Part D: Urban, terrace and balcony gardening apps, Indian market and user problems

Research date: 2026-10-18. Method: live WebSearch + WebFetch.
Tagging: **[Verified]** = confirmed on a fetched page or search result, with source number in brackets, e.g. [S3]. **[Assumption]** = inference or not confirmable.

**Limits on what could be checked:**
- Reddit (r/IndianGardening, r/BalconyGardening, r/containergardening) blocks this crawler for both search and fetch. Reddit evidence is therefore **missing**. User-problem evidence comes from peer-reviewed or academic surveys, news and Indian gardening publishers.
- Google Play listing pages would not render (truncated or connection reset). Install counts and ratings for Android-only apps are mostly unverified. Where available, App Store and third-party listings were used instead.
- ResearchGate PDFs returned 403. Only abstracts quoted in search results were used for the Cochin and Mumbai studies.

---

## 0. Executive summary

- **I found no product that combines (a) dimension-aware terrace or container layout planning with (b) India-specific seasonal care guidance (kharif/rabi/zaid, monsoon, heatwaves, regional languages).** The specific combination appears to be open. [Verified by absence across ~40 searches. Absence of evidence is not proof: **Medium** confidence.]
- **Each half on its own is a commodity:**
  - Dimension-aware bed and container planners with location-based calendars already exist: Fryd (exact cm dimensions), Seedtime (containers, worldwide dates), GrowVeg/Almanac (5,000+ weather stations), Garden Pro Planner (beds down to "a single container or a balcony rail").
  - Indian care guidance and diagnosis exist too: Plantix is free and India-heavy with Indian languages, and Ugaoo publishes North/South India sowing calendars.
- **The global planners' seasonal engines are built on frost dates.** This is a poor fit for most Indian cities, which are frost-free and where seasons are set by monsoon and heat. Fryd has 45 city guides, and the only Indian one is Bangalore, with no mention of monsoon on its index page. The structural gap is a real wedge.
- **The strongest Indian user evidence (Hyderabad survey, n=90) puts the top technical pain at pest/disease identification and fertiliser knowledge.** Layout is not the main pain. General pains are time and space, monkeys and rodents, roof leakage, and rainy-season waterlogging. A planner therefore has to justify itself through concrete outputs: grow-bag counts and sizes, load and drainage checks, what to sow this month. Being a pretty canvas is not enough.

---

## 1. Competitors (per product)

Scope: 8 primary profiles (A–H), then a short table of adjacent or checked products and the government/academic bodies.

### A. Garden Planner by Fryd (Germany, global): closest to "planner + local guidance"
| Aspect | Findings |
|---|---|
| Target audience / use cases | Hobby vegetable growers planning beds over a season, with succession sowing. Billed as Germany's #1 gardening app in UK PR material [Verified S3, S4] |
| Core features / journey | Create a plan → draw beds → drag crops in → companion matches → seasonal calendar and reminders → community [Verified S1, S2] |
| Photo upload / visualisation | Community photo sharing [Verified S2]. No photo-of-your-space planning [Assumption: none found] |
| Manual drawing, measurements | Beds resized by handles, **or exact dimensions typed in centimetres** [Verified S5 search snippet of Fryd help article "How can I set up my garden beds"]. Balcony or pot-specific objects not mentioned [Assumption] |
| Plant ID / recommendations | Plant library, Companion Finder, pre-made planting plans, and a "magic wand" bed-fill on the paid tier [Verified S2, S3]. No photo plant ID found [Assumption] |
| Reminders | Sowing and task reminders, plus "pest alerts for your zone" [Verified S1, S2] |
| Location / weather / India | 45 location garden guides. **Bangalore is the only Indian city**, filed as Zone 12a, "two monsoon seasons", "practically no frost" [Verified S1, S6]. The guide index does not mention monsoon [Verified S6]. No Indian languages found [Assumption] |
| Pricing | Free core (bed planning, library, community). Super Fryd costs £9.99/mo, £49.99/yr or £179.99 lifetime per 2025 PR. 2024 PR gave £9/£35/£130. 7-day trial [Verified S3, S4; current price not confirmed on an official page] |
| Strengths | Polished bed planner with real dimensions. Companion logic. Content engine (magazine, podcast). Strong brand in DE/UK |
| Weaknesses / gaps | Built around European in-ground and raised-bed gardening. Calendar logic is zone/frost-style. Indian coverage is a single city. No terrace load or waterproofing logic, no grow-bag model, no Indian crops/languages focus [Assumption based on S1, S6] |
| Differentiation opportunity | Out-localise it: India-wide agro-climatic zones, monsoon/heat-driven calendars, grow-bag and terrace primitives, Hindi + regional languages |
| Confidence | **Medium-High** |

### B. Seedtime (USA, global): layout + calendar + AI
| Aspect | Findings |
|---|---|
| Target audience | Food gardeners who want a calendar-first planner and task list [Verified S7] |
| Core features / journey | Enter location → auto-generated seed-start, transplant and harvest dates → drag to adjust → weekly task list → journal [Verified S7] |
| Photo / visualisation | Journal with photos. No photo-based space planning [Verified S7] |
| Drawing & measurements | Layout planner covers **raised beds, containers, in-ground rows and GreenStalk-style vertical planters**. Spacing modes are row, intensive, square-foot or custom, in **inches or cm**. It estimates plants per bed. Free tier allows up to 8 rectangular beds; Basic allows unlimited shapes [Verified S7] |
| Plant ID / recommendations | Companion suggestions "tailored to your zone". AI credits for an assistant [Verified S7] |
| Reminders | Weekly task list generated from the calendar. Separate push reminders not described [Verified S7] |
| Location / weather / India | Dates generated from **local frost dates**, "anywhere in the whole world". Weather data on paid tiers. Used in 30+ countries [Verified S7]. No India-specific seasons or languages [Assumption] |
| Pricing | Free; Basic $7/mo annual ($84/yr); Unlimited $14/mo annual ($168/yr) [Verified S7] |
| Strengths | Strong calendar ↔ layout integration. Container support. Generous free tier |
| Weaknesses / gaps | The frost-date model breaks down in frost-free India. USD pricing well above Indian willingness to pay [Assumption] |
| Opportunity | Swap the season engine for monsoon/heat. INR pricing |
| Confidence | **High** (features), **Medium** (India fit) |

### C. GrowVeg Garden Planner / Almanac Garden Planner (UK/US, global; white-labelled on many seed-company sites)
| Aspect | Findings |
|---|---|
| Target audience | Allotment and backyard veg growers. Also licensed to seed companies (Almanac, Southern Exposure, etc.) [Verified S8, S9] |
| Core features | Drag plants onto a plan. Automatic spacing. Rows, **containers**, raised beds and square-foot mode. Structures such as cold frames shift sowing dates. Shopping list. Garden journal [Verified S8] |
| Drawing & measurements | Scaled plan with automatic spacing [Verified S8]. The intro page does not detail measurement entry [Verified S8] |
| Reminders | Email reminders for the next two weeks of sowing, planting and harvesting [Verified S8] |
| Location / India | Climate data from 5,000+ weather stations. "Covers all major regions globally; for other areas input your local frost dates." Regional sites exist for US/CA, UK/EU, AU/NZ and ZA, **not India** [Verified S8] |
| Pricing | 7-day free trial, no card required. Price page returned HTTP 500 [Verified S8; price unverified] |
| Strengths | Mature, scaled planner with B2B licensing |
| Weaknesses | Browser-first. Western crops and frost logic. No India localisation [Verified/Assumption mix] |
| Confidence | **Medium-High** |

### D. Urban Garden: MacetoHuerto (Spain; Josep L. Centelles): the closest *balcony/terrace-specific* global app
| Aspect | Findings |
|---|---|
| Target audience | Beginners growing vegetables on a **balcony, terrace or windowsill** [Verified S10, S11] |
| Core features | AI pest and disease scanner with organic treatments. **Month-by-month planner**. **"My Garden Digital Twin": virtual containers matching your real garden**. Journal, community chat, guide to soil and urban growing [Verified S10, S11] |
| Photo / visualisation | Photo-based pest scanner [Verified S11]. The digital twin is a list of containers, **not** a spatial or dimensioned layout [Assumption: no dimension features described] |
| Measurements / layout | Not described [Assumption: absent] |
| Location / India | No hemisphere or climate settings found [Verified absence in S11 search]. Spanish origin, localised to IT and EN [Verified S12] |
| Pricing | Free on Google Play. Originally paid €1.59 on iOS [Verified S11, S12] |
| Strengths | Exactly the container-gardener mental model (containers as first-class objects) plus pest AI |
| Weaknesses | No spatial planning. Mediterranean calendar. Small indie developer. Install count unverified |
| Opportunity | Shows that container-as-object plus a monthly planner is a validated UX pattern. Add space and dimension awareness and Indian seasons |
| Confidence | **Medium** |

### E. Niche balcony apps: "Balcony Garden Planner" (Android) and "Balcony Plants Care" (Product Hunt)
| Aspect | Findings |
|---|---|
| Balcony Garden Planner (Google Play id `fi.busydays.garden`) | Per-plant **sun needs, watering frequency, suggested container size**, companions and tips. Activity log. Data stored on device [Verified via search snippet S13; Play page would not render]. Unclear whether it sends reminders or has a layout canvas [Verified unclear]. Finnish developer domain [Assumption from package name] |
| Balcony Plants Care (maker Piklu Biswas) | Free, offline. 250 plants. **Recommends by sunlight, space, direction and wind**. Watering reminders and weekly checklist. Launched about 5 months before the page was captured; very low traction [Verified S14] |
| Relevance | Both target "what fits my balcony" with sun, direction and container size. That is close to the hypothesis on the guidance side, but neither has a dimensioned spatial planner or India seasons [Assumption] |
| Confidence | **Low-Medium** (small, unverified traction) |

### F. Plantix (PEAT GmbH, Germany/India): India's dominant plant-diagnosis app (farm-first)
| Aspect | Findings |
|---|---|
| Target audience | Farmers primarily. Gardeners secondarily: setup asks "garden or field" [Verified S15, S16] |
| Core features | Photo diagnosis of pests, diseases and nutrient deficiencies with treatments. Expert and community Q&A. Disease library. Marketplace link [Verified S16, S17] |
| Plant ID / recommendations | 350–400+ diseases and pests across 65+ crops (figures vary by source) [Verified S15] |
| Care / calendar / weather | Crop guide across the crop cycle and location-specific weather per CGIAR [Verified S18]. Current official site does not mention calendar or weather [Verified S17] |
| Languages / India | 8 Indian languages per CGIAR 2020, or 18 languages incl. 10 Indian per FAO profile; earliest launch in Hindi and Telugu [Verified S15, S18, conflicting counts]. ~10M users, ~80% from India (Feb 2022–23) [Verified S15] |
| Pricing | Free to farmers. Revenue from API, B2B and marketplace [Verified S15] |
| Strengths | Free, trusted, vernacular, huge Indian install base. Directly addresses the **#1 technical constraint** in Indian terrace-gardener surveys (pest/disease ID; see §2) |
| Weaknesses / gaps | Field-crop UX. No space or container planning. No terrace logic (load, grow bags, shade net) [Assumption] |
| Opportunity | Don't compete head-on on diagnosis. Integrate or link out, or deliver "terrace-context" diagnosis (grow-bag crops, pot-related causes such as waterlogging and heat) |
| Confidence | **High** (scale and India), **Medium** (current feature list) |

### G. Ugaoo and Kyari (Indian D2C plant brands)
| Aspect | Ugaoo | Kyari |
|---|---|---|
| What it is | "India's largest online plant nursery". App is in the **Shopping** category. 4.7★ from ~1.3k iOS ratings. Updated frequently [Verified S19]. ~211k Android downloads per aggregator [Verified S20, may be stale] | D2C indoor plants and **self-watering planters**. Founded 2022. Revenue ₹1.75 Cr (FY23) → ₹9.8 Cr (FY24) [Verified S21]. App built on Appbrew (Shopify app builder), Shopping category, too few ratings to show [Verified S22] |
| Care guidance | Rich blog content, e.g. a **North vs South India sowing calendar** with spacing and depth for ~20 Indian vegetables, grouped summer/rainy/autumn/winter. **No kharif/rabi terms, no app tool** [Verified S23]. Paid garden-maintenance services (balcony maintenance, pest control, vertical garden installation) [Verified S24] | Care info on product pages (light, water frequency) [Verified S21] |
| Planner / reminders / photo | None found in the app listing [Verified S19] | None found [Verified S22] |
| Strengths | Brand trust, logistics, SEO content, Indian seeds and inputs | Self-watering hardware addresses the overwatering/underwatering pain |
| Gaps | Commerce-first. Care knowledge locked in blogs, not personalised | Indoor ornamental focus, not edible terrace gardens |
| Opportunity | **Partner channel rather than competitor**: affiliate or "buy this plan's bill of materials" (grow bags, cocopeat, seeds) | Same: planter catalogue as plan objects |
| Confidence | **High** | **Medium** |

Nurserylive was not separately verified in this session [Assumption: similar commerce-first model]. Homecrop is a **Hyderabad** (not Bangalore) startup selling modular 15 sq ft rooftop kits (trough, trellis, shade net, drainage mat) with optional setup and maintenance. No app found [Verified S25, S26].

### H. Photo/AR visualisers: iScape, "Garden AI: Design Planner" and similar AI landscape apps
| Aspect | Findings |
|---|---|
| Target | Homeowners and landscapers visualising a yard redesign [Verified S27, S28] |
| Photo / visualisation | iScape: AR placement at true scale, or layering plants onto an uploaded photo. 4M downloads; on the market since 2012 [Verified S27]. Garden AI (PENIDA): upload a photo and get AI redesigns in 10+ styles; elements can be moved and resized; claims to match "dimensions, style, climate" [Verified S28] |
| Care / reminders / India | None for care. Garden AI has no plant-care features [Verified S28] |
| Pricing | iScape Pro ~$29.99/mo or $299.99/yr; free tier allows 2 designs with watermark [Verified S27, figures vary]. Garden AI: $4.99/wk or $49.99/yr; 3 ratings [Verified S28] |
| Gaps | Aesthetic renders, not horticulture. AR crash complaints. Expensive for homeowners [Verified S27] |
| Opportunity | Users like "see it on my space" (photo upload). Pair a light photo overlay with real horticultural constraints |
| Confidence | **Medium** |

### Adjacent / checked products (summary)
| Product | Status / relevance | Tag |
|---|---|---|
| Garden Pro Planner (iOS/Android) | Square-foot grid with any bed size, "down to a single container or a balcony rail". 440+ plants. Frost-date calendar. USDA zones. Watering reminders. 9 languages. Free to start. No India mention | [Verified S29] |
| Planter (garden planner) | Square-foot planner; frost-date calendar; companion info | [Verified S30; site down at fetch time] |
| Seed to Spoon (Park Seed) | Free: 150+ plant guides, layout for 10 plants. Premium $4.99/mo or $46.99/yr; AI "Growbot" with photo ID; zone calendar. US-centric | [Verified S31] |
| Gardenize | Garden journal; 45,000-plant DB; reminders; $6.99/mo or $34.99/yr | [Verified S32] |
| Smart Gardener | Still online (©2025); personalised plan, to-dos, journal; US-centric | [Verified S33] |
| Garden Tags, "MyGardenPal" | Garden Tags status not found. "MyGardenPal" not found (similar names: MyGrowPal, MyGardener) | [Verified absence S34] |
| Moestuin app, Agrio, Plantum | Not researched in depth. Agrio and Plantum are diagnosis/ID apps similar in role to Plantix/PictureThis | [Assumption] |
| CARE Garden Planner (web, 2026 hackathon entry) | India-focused sowing planner covering 9 cities and 5 agro-climatic zones; AI assistant; **no layout tool**. Shows the idea is "in the air" | [Verified S35] |
| Balconize (2026 hackathon entry) | Balcony orientation + sun hours → 3-tier vertical planting blueprint. Not India-focused | [Verified S36] |
| Grow2Share (Bengaluru, 2016) | Step-by-step veg-growing guidance app. Current status unknown | [Verified S37 (2016 article); activity: Assumption] |
| Urban veggie garden / Gardroid | Generic veg calendars and spacing apps | [Verified S38] |

### Government / agricultural-university offerings (India)
- **Tamil Nadu: "Do It Yourself" terrace kit** for Chennai and Coimbatore at ₹1,325 per kit, up to 5 kits per registration. The kit holds 20 sealed grow bags (24×18 in) with 2 kg cocopeat each, a 4×4 m sheet, bio-inputs, a sprayer, a rose can, tools, a 10-variety seed kit and a manual booklet. Applications online or at the Horticulture Dept [Verified S39]. Other sources cite ₹500 or local half-price sales, so current price is unconfirmed [Verified S40]. **No app found.**
- **Kerala:** grow bags sold at Krishi Bhavans. In 2010, 33,310 Thiruvananthapuram households got 25 bags each, and ~60% continued. ~20,000 rooftop cultivators per district (2015 estimate) [Verified S41]. Grow-bag subsidies of 50–75% (2022) [Verified S42 snippet]. Arka Vertical Garden unit costs ₹22,100 with a ₹15,525 subsidy [Verified S43]. 2025 "Onathinoru Muram Pachakkari" distributed 25 lakh seed packets and 100 lakh seedlings via 1,076 Krishi Bhavans [Verified S44]. Kerala's AIMS platform is a general farmer system (~40 lakh farmers, regional languages), **not terrace-specific** [Verified search snippet].
- **Telangana:** urban vegetable scheme under RKVY since 2012-13 (seed and mini-kits). 2018-19 terrace scheme application at 50% subsidy [Verified S45, S46]. Current status unconfirmed.
- **IIHR (Bengaluru):** sells the Arka Urban Horti-Kit, Arka fermented cocopeat and seeds via a portal. Its app (Arka Vyapar) is for market linkage. **No kitchen/terrace-garden app found** [Verified S47].
- **TNAU / KAU:** content portals (TNAU Agritech) and models (KAU 3-cent integrated terrace garden). **No dedicated terrace app found** [Verified absence].

**Implication:** governments distribute standardised physical kits (e.g. 20 × 24×18 in grow bags) and booklets but have no digital follow-through. That is an opening for "kit presets" and partnerships [Assumption].

---

## 2. User problems & market evidence

### 2.1 Quantitative Indian evidence
- **Hyderabad terrace gardeners (n=90, ≥5 years' practice, interviews 2021-22, Garrett ranking)** [Verified S48, IJECC manuscript 86950]:
  - **Technical constraints, top to bottom:** pest and disease identification and management (score 53.8), fertiliser and manure application, improved varieties / seed rate / **sowing time**, seed treatment, lack of expert guidance.
  - **General constraints:** time and space (66.4), **rodent and monkey attack**, **leakage from roof**, **inundation during the rainy season**, maintenance, untimely input availability.
  - **Input constraints:** suitable space, not knowing where to get quality seeds, availability of FYM and bio-inputs.
  - **Demographics:** 58.9% female; 32% aged over 50; 48.9% homemakers; 45.6% earn ₹5–10 lakh a year; most live in independent houses with 750–1,500 sq ft of roof.
  - **Top crops:** mint 95%, chillies 91%, spinach 90%; tomato, brinjal, gourds in summer.
- **Cochin rooftop gardeners:** more than half cite limited technical knowledge, seasonal water scarcity, high input costs and pest management difficulties. Leaf curl, dieback, viruses, mealybugs and ants are noted [Verified S49 abstract snippet].
- **Mumbai MMR balcony/terrace gardens (SWOT):** threats are high reinforcement cost, **leakage**, air pollution, rain and insects [Verified S50 snippet].
- **Pune (n=111, 2014):** 39% rooftop-terrace gardens; recruited via the INORA club and the "Pune Gardeners" Facebook group, so communities are where users are [Verified S51].

### 2.2 Qualitative / news evidence
- **Heat:** small pots heat fast and soil dries within hours. Watering more doesn't solve it. "Common in terrace and balcony gardens across cities" (The Better India, 28 May 2026) [Verified S52]. Guides recommend 30–50% shade net, grow bags or clay over plastic, mulch, and morning/evening watering [Verified S53].
- **Waterproofing and load:** flat Indian roofs make monsoon drainage a major issue. Leaks mean demolishing finishes to fix. Retrofitting a terrace for a heavy garden costs 3–5× more than planning it in at construction [Verified S54]. No authoritative saturated-load figures found [Verified absence].
- **Monkeys:** Bengaluru residents report monkeys on terraces and balconies, worse in summer in peri-urban areas [Verified S55].
- **Community and learning channels:** Hyderabad's Rythu Mitra started as a Facebook group and runs 20+ broadcast groups and a helpline. Early failures and impatience are cited as main barriers. Readers ask for low-cost terrace tips [Verified S56]. Kerala growers rely on social-media groups and workshops; trained service providers exist mainly in Thiruvananthapuram [Verified S41].
- **Generic container failure modes:** overwatering is the most common beginner mistake. Missing drainage holes, too-large pots (waterlogging) and too-small pots (root-bound) are frequent, as is overcrowding [Verified S57, garden media, not extension research].
- **Market growth:** coverage (IBEF blog, Better India, Kerala and Telangana schemes) shows growth driven by food-safety and "chemical-free" concerns, mental health and the COVID-era surge. **No authoritative market-size data was found.** Trend articles with adoption percentages are unsourced and should not be used [Verified S58; caution].

### 2.3 Problem → product mapping
| User problem (evidence) | Implication for the app |
|---|---|
| Pest/disease ID is the #1 technical gap [S48, S49] | Must-have. Partner with or link to Plantix-like diagnosis, or offer a terrace-context symptom guide |
| Sowing time and variety knowledge [S48] | Calendar driven by agro-climatic zone + monsoon onset + heat, not frost; kharif/rabi/zaid labels |
| Fertiliser and manure knowledge [S48] | Per-container feeding schedules for organic inputs (jeevamrutham, vermicompost) |
| Space and time constraints [S48] | Planner must answer "what fits and yields most in X sq ft", plus low-effort routines |
| Roof leakage, rainy-season inundation [S48, S50, S54] | Load and drainage checklist; warnings about saturated grow-bag weight; monsoon prep tasks |
| Heat and fast drying [S52, S53] | Heatwave-aware watering nudges (weather API); shade-net recommendations by sun exposure |
| Monkeys and rodents [S48, S55] | Netting/cage guidance in the layout (protected zones) |
| Govt kits are standardised [S39] | "I got the TN DIY kit" preset: 20 grow bags auto-placed, kit seeds pre-scheduled |
| Users live in FB/WhatsApp groups [S51, S56] | Shareable plan images and WhatsApp-first sharing; regional languages; older, homemaker-heavy users need simple UX |

---

## 3. Hypothesis assessment

**Hypothesis:** *"Our advantage is the combination of a usable, dimension-aware terrace garden planner and locally relevant plant-care guidance."*

**Verdict: PARTIALLY SUPPORTED.**

**Supporting evidence**
1. **No product combines the two for India.**
   - Global planners have real dimensions and containers (Fryd [S5], Seedtime [S7], GrowVeg [S8], Garden Pro Planner [S29]) but rely on frost-date or USDA-zone logic, and their Indian coverage is nil or one city (Fryd: Bangalore only, of 45 guides [S6]).
   - Indian players have local relevance (Plantix languages and diagnosis [S15]; Ugaoo North/South calendars [S23]; government kits [S39]) but **no planner**.
   - Balcony-specific apps (MacetoHuerto [S10], Balcony Garden Planner [S13], Balcony Plants Care [S14]) lack spatial dimensions and Indian seasons.
2. **Frost-free tropical seasonality is a structural barrier** for Western planners. Their calendar engines would need re-architecture rather than translation [Assumption, reasoned from S1, S7, S8].
3. **Demand signals exist:** government kit schemes in TN, Kerala and Telangana; large Kerala adoption numbers; active community groups.

**Challenges to the hypothesis**
1. **"Dimension-aware planner" is not the top user pain in India.** Surveys rank pest/disease knowledge, sowing time, fertilisation, space/time, monkeys and roof leakage above layout [S48]. A planner is an *enabler*, not the headline advantage. Precise CAD-style dimensions may be over-engineering for users who think in **grow bags and pots** (standard 24×18 in bags [S39]).
2. **Each half is copyable.**
   - Fryd already accepts cm dimensions and has a Bangalore page with monsoon awareness. Adding Indian cities is a content task for them [Assumption].
   - Plantix is free with millions of Indian users. Competing on care and diagnosis alone is weak.
   - The combination is a moat only if the *local layer* is deep (zones, monsoon, heat, Indian crops, languages, kits, inputs) and the *planner* produces outputs that use it.
3. **Willingness to pay** is unproven. Indian users get diagnosis free (Plantix), content free (Ugaoo, YouTube) and help from community groups. Global apps charge $35–168/yr [S3, S7, S32]. Monetisation may need to come from commerce or affiliate (grow bags, seeds), services, or B2B with government, nurseries or kit vendors [Assumption].
4. **Evidence gaps:** no Reddit data; no Play install counts for Android-only rivals; no Indian market-size data.

**Suggested refined positioning** [Assumption]:
> "The only planner that knows Indian terraces: tell it your space (photo + rough size + sun direction) and it tells you how many grow bags of what size, what to sow *this* monsoon/rabi/summer in your city, the load and drainage risks, and sends heat/monsoon-aware care nudges in your language."

Lead with *local outcomes* (what to grow now, how many bags, will my roof cope). The dimension-aware planner is the mechanism behind them. Validate with users from TN/Kerala kit recipients and FB/WhatsApp gardening groups before heavy investment in the canvas.

**Overall confidence in the assessment: Medium.** The competitor scan is broad. User-pain evidence relies on a few Indian academic surveys, and Reddit and Play data were unavailable.

---

## 4. Sources (all accessed 2026-10-18)

- S1. Fryd – Bangalore garden guide: https://fryd.app/en/garden-guide/bangalore
- S2. Fryd – home: https://fryd.app/en
- S3. Emma Mason PR – Fryd UK launch, 2025 pricing: https://emmamasonpr.co.uk/2025/03/
- S4. Emma Mason PR – Fryd tag (2024 pricing): https://emmamasonpr.co.uk/tag/fryd-app/
- S5. Fryd help – "How can I set up my garden beds within the app?" (search snippet; now redirects to https://fryd.app/en/support): https://support.fryd.app/en/support/solutions/articles/77000517757-how-can-i-set-up-my-garden-beds-within-the-app-
- S6. Fryd – garden guide index: https://fryd.app/en/garden-guide
- S7. Seedtime: https://seedtime.us/
- S8. GrowVeg Garden Planner intro: https://www.growveg.com/garden-planner-intro.aspx
- S9. Almanac Garden Planner article: https://gardenplanner.almanac.com/guides/its-here-our-new-and-improved-garden-planner/
- S10. Similarweb – Urban Garden: MacetoHuerto: https://similarweb.com/ja/app/google/com.centelles.josep.macetohuerto
- S11. Google Play – Urban veggie garden / MacetoHuerto: https://play.google.com/store/apps/details?id=com.centelles.josep.macetohuerto&hl=en_IN&gl=US
- S12. Applesfera – MacetoHuerto: https://www.applesfera.com/aplicaciones-ios/macetohuerto-tus-plantas-y-jardin-al-dia-desde-el-iphone-e-ipod-touch ; iPhoneItalia: https://www.iphoneitalia.com/?p=112310
- S13. Google Play – Balcony Garden Planner: https://play.google.com/store/apps/details?id=fi.busydays.garden
- S14. Product Hunt – Balcony Plants Care: https://www.producthunt.com/p/blacony-plants-care-recomedation/balcony-plants-care-recomedation
- S15. FAO Agritech Observatory – Plantix: https://agritechobservatory.review.fao.org/en/plantix-crop-doctor ; CGIAR: https://bigdata.cgiar.org/blog-post/artificial-intelligence-to-track-pests-and-diseases-in-india/
- S16. Future Farming – Plantix: https://futurefarming.com/smart-farming/plantix-more-than-a-crop-doctor-driven-by-ai
- S17. Plantix official: https://plantix.net/en/
- S18. CGIAR case study – Plantix: https://bigdata.cgiar.org/digital-intervention/plant-disease-diagnosis-using-artificial-intelligence-a-case-study-on-plantix/
- S19. App Store – UGAOO: https://apps.apple.com/in/app/ugaoo/id6502299028
- S20. Chrome-stats – Ugaoo Android: https://chrome-stats.com/d/com.ugaoo.android
- S21. Inc42 – Kyari: https://inc42.com/startups/can-kyaris-self-watering-planters-solve-urban-gardening-challenges/
- S22. App Store – Kyari: https://apps.apple.com/es/app/kyari/id6746532016
- S23. Ugaoo – planting calendar blog: https://www.ugaoo.com/blogs/kitchen-gardening/is-your-planting-calendar-ready
- S24. Ugaoo – garden maintenance services: https://www.ugaoo.com/blogs/garden-maintenance/garden-maintenance-services-everything-you-need-to-know
- S25. Krishi Jagran – urban farming startups: https://krishijagran.com/blog/these-5-urban-farming-startups-will-help-you-to-set-up-your-own-organic-farm-in-no-time/?amp=1
- S26. Brown Living – home gardening services: https://brownliving.in/blogs/sustainability-guide/home-gardening-permaculture-services
- S27. AI Tools Bakery – iScape review 2026: https://aitoolsbakery.com/blog/iscape-review/
- S28. App Store – Garden AI: Design Planner: https://apps.apple.com/us/app/id6751772833
- S29. Garden Pro Planner: https://thegardenplanner.app/
- S30. Screensdesign – Planter: https://screensdesign.com/showcase/planter-garden-planner
- S31. App Store – Seed to Spoon: https://apps.apple.com/us/app/seed-to-spoon-garden-planner/id1312538762
- S32. App Store – Gardenize: https://apps.apple.com/app/apple-store/id1118448120
- S33. Smart Gardener: https://www.smartgardener.com/home/garden_plan
- S34. Search result – MyGrowPal / MyGardener: https://chrome-stats.com/d/id6789994972 ; https://apps.apple.com/ca/app/id6448050970
- S35. DEV – CARE Garden Planner: https://dev.to/raju_793fbf792b497c4e0825/care-garden-planner-5e67
- S36. DEV – Balconize: https://dev.to/ashish_pandey_84a3406a5ae/balconize-380f
- S37. The Better India – Grow2Share: https://thebetterindia.com/102435/grow2share-app-urban-gardeners-vegetables-grow/
- S38. Google Play – Gardroid: https://play.google.com/store/apps/details?id=com.hookah.gardroid.free&hl=en_US
- S39. TNAU Agritech – DIY terrace kit scheme: https://agritech.tnau.ac.in/horticulture/horti_schemes_doit_yourself.html
- S40. DT Next – Chennaiites grow their own greens: https://www.dtnext.in/news/chennai/chennaiites-grow-their-own-greens ; Mylapore Times: https://www.mylaporetimes.com/2023/03/good-response-to-terrace-garden-workshop-in-r-a-puram/
- S41. Down To Earth – Rooftop revolution (2015): https://www.downtoearth.org.in/environment/rooftop-revolution-50161
- S42. LEISA India (FAO FSN) – urban home gardening & social media, Kerala (2022): https://assets.fsnforum.fao.org/public/contributions/2023/Leisa%20India-March%202022_Anita%20Pinheiro%20urban%20home%20gardening_social%20media.pdf
- S43. Public Services Map – Arka Vertical Garden (Kerala SHM): https://www.publicservicesmap.in/schemes/arka-vertical-garden--avg?lang=en
- S44. Kerala Kaumudi – vegetable self-sufficiency schemes (2025): https://keralakaumudi.com/en/news/news-amp.php?id=1587682
- S45. Telangana Horticulture – Urban Farming: https://horticulture.tg.nic.in/Ufarming/UFarming.html
- S46. Telangana – RKVY 2018-19 terrace application: https://horticulture.tg.nic.in/Ufarming/Downloads/AF201819.pdf
- S47. IIHR sales outlet programme: https://api-dev.iihr.res.in/sites/default/files/Sales%20outlet%20programme%20%28english%29-1.pdf ; CRN – Arka Vyapar app: https://www.crn.in/?p=41771
- S48. "Terrace Gardening: A Sustainable Yet Economic Approach" (IJECC ms 86950, Hyderabad n=90): https://sdiopr.s3.ap-south-1.amazonaws.com/doc/Revised-ms_IJECC_86950_v1.pdf
- S49. Rooftop Gardening: An Explorative Study in Urban Area of Cochin City: https://www.researchgate.net/publication/351841894_Rooftop_Gardening_An_Explorative_Study_in_Urban_Area_of_Cochin_City
- S50. Balcony and terrace gardens… Mumbai Metropolitan Region: https://www.researchgate.net/publication/304597530_BALCONY_AND_TERRACE_GARDENS_IN_URBAN_GREENING_AND_LOCAL_FOOD_PRODUCTION_SCENARIOS_FROM_MUMBAI_METROPOLITAN_REGION_MMR_INDIA
- S51. Survey data on home gardeners, Pune (Data in Brief, 2019): https://pmc.ncbi.nlm.nih.gov/articles/PMC6849123/
- S52. The Better India – summer soil drying (28 May 2026): https://thebetterindia.com/gardening/prevent-garden-soil-from-drying-out-summer-heat-india-heatwaves-plant-health-gardening-tips-11881033
- S53. Urbanplant – heatwave care: https://www.urbanplant.in/a/blog/plant-care-in-heatwave ; AllThatGrows – 40°C heat: https://www.allthatgrows.in/blogs/posts/save-garden-india-40c-heat
- S54. Studio Matrx – terrace planning India: https://www.studiomatrx.org/guides/terrace-planning-india ; Ongrid – waterproofing India: https://ongrid.design/blogs/home-building-guide/home-waterproofing-india ; Weber – terrace waterproofing: https://www.in.weber/blog/best-waterproofing-methods-for-terrace
- S55. Deccan Herald – monkey encounters Bengaluru: https://deccanherald.com/india/karnataka/bengaluru/monkey-encounters-rise-as-city-pushes-its-borders-2648871
- S56. Citizen Matters – home gardening lessons from Hyderabad (2021): https://citizenmatters.in/guide-to-home-gardening-lessons-from-hyderabad
- S57. Livingetc – container gardening mistakes: https://livingetc.com/advice/container-gardening-mistakes-to-avoid ; Planters Place: https://plantersplace.com/container-gardening/container-corner/common-mistakes-when-gardening-in-containers
- S58. IBEF – urban farming in metro cities: https://www.ibef.org/blogs/how-urban-farming-is-gaining-ground-in-india-s-metro-cities
