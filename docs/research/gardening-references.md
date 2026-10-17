# Gardening References and Domain Rules

> **How this document is used by the product (read first)**
> - This is the **provenance register** for all horticultural content in the app. Source IDs such as `S12` or `D3` are the `sourceIds` stored in the bundled plant catalogue and care-rule templates (see `docs/architecture/data-model.md`). A catalogue validation test (Phase 4) fails if a record cites an ID not listed in §1.
> - **Rules for adding content:**
>   1. No value enters the catalogue without a source ID. Unsourced values are `null` with `dataStatus: unverified`, never guessed.
>   2. **SS** (snippet-only) facts must be re-verified (upgraded to **F**) before a public release.
>   3. **Proxy** values are shown with a lower-confidence badge.
>   4. Where sources conflict, use the conservative or newer option noted under **CONFLICT**.
> - **Product rules derived from this research** (binding for implementation):
>   - Never present "water every X days" as fact. Watering tasks are *check* reminders with finger-test guidance (§4).
>   - Never claim a layout is structurally safe. Recommend a structural engineer for raised beds, large planters, tanks or dense clusters; suggest placing weight over walls or columns (§8).
>   - Show fertiliser doses only where a source gives one; otherwise give frequency guidance with a "limited evidence" badge. Exclude dasagavya (contains *Datura*) (§5).
>   - Neem and other sprays carry the caveats in §6c (no spraying stressed plants or above ~32 °C; pet caution).
>   - Toxicity is shown only where ASPCA or an equivalent documents it; otherwise "Not documented" (§7).
>   - Do not recommend a gravel drainage layer (§3c CONFLICT resolution).
> - **Open gaps** that block a public release are tracked in §11 and in `TODO.md` (task P4-DATA-*).

---


**Prepared:** 2026-10-18. **Access date for all URLs:** 2026-10-18 unless noted otherwise.
**Purpose:** Source-backed facts for a rule-based recommendation and care-scheduling engine. No horticultural values below are invented. Anything without a solid source is marked **UNVERIFIED**.

## How to read this document

- Each fact carries a source ID like **[S1]**. Section 1 maps every ID to its URL, publisher and reliability.
- **Verification level** (shown in the register):
  - **F** = page or PDF was fetched and read directly (PDFs were text-extracted).
  - **SS** = seen only in a search-engine snippet, or the page later failed to load (404, DNS error, 403). **Re-verify SS facts before shipping them.**
- **"Proxy"** means the source covers a related crop or category, not the exact crop (for example, extension "basil" data used for tulsi). Proxies need human review.
- Sources sometimes disagree. Conflicts are flagged with **CONFLICT** and the more conservative or more recent option is suggested.
- Unit conversions (gallons to litres, inches to cm) are my own arithmetic: 1 US gal = 3.785 L, 1 in = 2.54 cm.

---

## 0. Key findings (summary)

1. **There is no single authoritative Indian table of container sizes for terrace crops.** Indian institutions (ICAR, TNAU, KAU, state horticulture departments) publish *field-scale* packages of practice (seasons, spacing, duration) plus a few terrace-specific recommendations. Container sizes come mostly from US extension services (Texas A&M, Maryland, Penn State) and RHS. Combine the two: Indian sources for *when* and *how long*, extension sources for *how big*.
2. **The best Indian terrace-specific sources found:**
   - KAU's official "Farming on House Terrace" recommendation: soil:sand:powdered cow dung **2:1:1**, fill sacks 75%, place sacks on bricks *with a wall underneath* [S12].
   - ICAR *Indian Horticulture* season table for terrace vegetables, with North vs South India sowing months and days to maturity [S11].
   - Telangana Horticulture's urban-farming season table (Kharif, Rabi and Summer) [S13].
   - TNAU Agritech crop pages [S14–S25].
3. **Watering must be check-based, not calendar-based.** K-State says it is "impossible" to water properly on a fixed schedule [S10]. RHS says to water when compost is dry 2–3 cm down, or a third of the way down the pot [S5, S6]. Small, shallow, terracotta and metal pots, and warm, windy, south- or west-facing spots, all dry faster [S5].
4. **Fertiliser dosing evidence for organic inputs in containers is weak.**
   - Jeevamrutham/ZBNF has been called "unproven" by India's National Academy of Agricultural Sciences, as reported in the press [S47].
   - TNAU and KAU give recipes but no container dose [S25, S12].
   - The only per-pot organic doses found in an official source are for anthurium [S12].
   - Recommendation: keep fertiliser rules generic ("feed lightly every 2–4 weeks in active growth; leach salts") and cite them [S1, S3, S4].
5. **Neem oil:**
   - Use a 2% neem-oil + garlic emulsion (KAU recipe) [S12].
   - Do not spray stressed plants or above 32 °C/90 °F [S32–S34, S37].
   - Coverage must be thorough [S32].
   - Neem breaks down on leaves in 1–2.5 days [S38].
   - Some cats had adverse reactions to neem flea products [S38].
6. **Pet toxicity (ASPCA):**
   - Toxic to dogs and cats: pothos/money plant, snake plant, aloe, lemongrass, mint, and tomato foliage.
   - Non-toxic: rose, jasmine (*Jasminum*), *Hibiscus syriacus*, basil and calendula [S39].
   - Not assessed by ASPCA: Indian marigold (*Tagetes*), tulsi and *Hibiscus rosa-sinensis*.
7. **Rooftop safety:**
   - The Indian loading code IS 875 (Part 2) sets a design imposed load of only **1.5 kN/m² (~153 kg/m²) for an accessible flat roof** [S42].
   - Wet soil weighs roughly 1,500–2,200 kg/m³ [S43, SS]. A 10 cm layer of wet soil spread over a square metre can therefore already be about 150–220 kg (my arithmetic).
   - The app must tell users to consult a structural engineer, put heavy pots over walls or beams, and protect waterproofing [S9, S11, S12].
8. **Datasets:**
   - OpenFarm shut down on **21 April 2025**; its repo was archived on 22 April 2025 and its data is CC0 [D3].
   - Trefle is live but "still in beta"; its code is AGPL-3.0 and its data licence is unclear [D2].
   - Perenual's free tier covers species IDs 1–3000 at 100 requests/day, and commercial use is listed only on paid tiers [D1].
   - None of these covers Indian edible crops with cited care data. **Recommendation: bundle a hand-curated, cited dataset**, and use Wikidata (CC0) and POWO/WCVP for taxonomy IDs only [D6, D7].

---

## 1. Source register

Reliability scale:
- **A** = peer-reviewed or official institutional guidance.
- **B** = official institution, but older, partial, or non-crop-specific.
- **C** = secondary or news (context only).
- **D** = commercial or unverified.

Facts are not copyrightable, so the app can state facts with attribution. **Do not copy text, tables or images wholesale without permission** unless the licence below allows it.

### 1a. Indian institutions

| ID | Source | URL | Publisher | Good for | Rel. | Ver. | Licensing / reuse notes |
|---|---|---|---|---|---|---|---|
| S11 | Bisht K., Bisht K., Sharma A., Singh Y.P. "Rooftop gardening: Avenue for healthy living", *Indian Horticulture* (PDF header Sep–Oct 2021; listing says 66(5), 2022) | https://epubs.icar.org.in/index.php/IndHort/article/view/119872 (PDF: https://epubs.icar.org.in/index.php/IndHort/article/download/119872/46110/473150) | ICAR (DKMA) | North/South India sowing months, days to maturity, structural and waterproofing cautions, sunlight 6–8 h | A | F | ICAR e-pubs open access. Cite facts; check the article licence before reproducing the table verbatim. |
| S12 | *Adhoc Package of Practices Recommendations for Organic Farming*, Kerala Agricultural University (dated June 2009 inside; hosted as "package_2015.pdf") | https://keralaagriculture.gov.in/wp-content/uploads/2018/12/package_2015.pdf | KAU Directorate of Research / Kerala Dept. of Agriculture | Official terrace-farming rules, potting mix 2:1:1, neem-garlic emulsion recipe, panchagavya recipe, organic pest tables | A (official), B (age) | F | Government/university publication. Cite; no explicit open licence seen. |
| S13 | Urban Farming: Horticulture crops, season-wise details | https://horticulture.tg.nic.in/UFarming/cropinfo.html | Dept. of Horticulture, Govt. of Telangana | Kharif/Rabi/Summer sowing months, spacing, seed per m² for urban farming | A (regional) | F | Govt. of India NIC site. Cite facts. |
| S14 | TNAU Agritech: Bhendi (main and sowing pages) | https://agritech.tnau.ac.in/horticulture/horti_vegetables_bhendi.html ; https://agritech.tnau.ac.in/horticulture/horti_vegetables_bhendi_sowing.html | Tamil Nadu Agricultural University | Okra season, spacing | A (TN) | Main page SS (404 on fetch); sowing page F | TNAU copyright; cite facts. |
| S15 | TNAU Agritech: Curry leaf | https://agritech.tnau.ac.in/horticulture/horti_vegetables_curry%20leaf.html | TNAU | Curry leaf propagation, pruning, harvest intervals | A | F | as above |
| S16 | TNAU Agritech: Coriander | https://agritech.tnau.ac.in/horticulture/horti_spice%20crops_corinader.html | TNAU | Season, seed splitting, greens harvest 30–40 d | A | F | as above |
| S17 | TNAU Agritech: Fenugreek | https://agritech.tnau.ac.in/horticulture/horti_spice%20crops_fenugreek.html | TNAU | Season, greens 20–25 d | A | F | as above |
| S18 | TNAU Agritech: Malligai (*Jasminum sambac*) | https://agritech.tnau.ac.in/horticulture/horti_flower%20crops_malligai.html | TNAU | Planting season, pruning date/height, pests | A | F | as above |
| S19 | TNAU Agritech: Chilli season/sowing and cultural pages | https://agritech.tnau.ac.in/horticulture/horti_vegetables_chili_season_sowing.html ; https://agritech.tnau.ac.in/horticulture/horti_vegetables_chilli_cultural.html | TNAU | Sowing seasons; transplant age, spacing | A | Season page F; cultural page SS | as above |
| S20 | TNAU Agritech: Tomato (seed certification; organic climate pages) | https://agritech.tnau.ac.in/seed_certification/seed_veg_tomato.html ; https://agritech.tnau.ac.in/org_farm/orgfarm_tomato_climate.html | TNAU | Season, seedling age, duration | A | SS | as above |
| S21 | TNAU Agritech: Brinjal | https://agritech.tnau.ac.in/horticulture/horti_vegetables_brinjal_seed.html | TNAU | Transplant age 30–35 d | A | SS | as above |
| S22 | TNAU Agritech: Varieties of vegetable crops | https://agritech.tnau.ac.in/horticulture/horti_TNAU_varieties_vegetablecrops.html | TNAU | Amaranthus CO 1 duration (25 d greens) | A | SS (404 on fetch) | as above |
| S23 | TNAU Agritech: Mint | https://agritech.tnau.ac.in/horticulture/horti_aromatic%20crops_mint.html | TNAU | Propagation by cuttings and suckers (field/oil context) | B | SS | as above |
| S24 | TNAU Agritech: "Do It Yourself" rooftop kit scheme | https://agritech.tnau.ac.in/horticulture/horti_schemes_doit_yourself.html | TNAU / TN Horticulture Dept. scheme | Official kit: 24×18 in grow bags with 2 kg cocopeat each | B (last updated Oct 2014) | F | as above |
| S25 | TNAU Agritech: Organic farming preparations (Jivamirtham, Panchagavya) | https://agritech.tnau.ac.in/org_farm/orgfarm_farming_practices_treatment_preperation.html | TNAU | Recipes only (no container dose) | B | F | as above |
| S26 | TNAU Agritech: Coir pith compost | https://agritech.tnau.ac.in/ta/org_farm/orgfarm_coircompost.html | TNAU | 20% composted coir pith in pot/polybag mixes | B | SS | as above |
| S27 | TNAU Agritech: Brinjal pests | https://agritech.tnau.ac.in/crop_protection/crop_prot_crop_insect-veg_brinjal_pest&disease.html | TNAU | Shoot and fruit borer: cultural control, NSKE 5% | A | SS | as above |
| S28 | ICAR-IIHR news: composting and home gardening demo (27 Mar 2022) | https://www.iihr.res.in/node/25504 | ICAR-IIHR Bengaluru | IIHR soilless terrace/utility-area production using Arka Fermented Cocopeat | B | F | Cite. |
| S29 | ICAR-IIHR: Arka Sasya Poshak Ras | https://iihr.res.in/node/25063 ; dosage page https://atic.iihr.res.in/?p=34 | ICAR-IIHR | Liquid nutrient for cocopeat soilless vegetables; dose per crop group | A | node F (no dose); dose page SS only (DNS failure on fetch) | Product of IIHR; cite. |
| S30 | ICAR-IIHR product/sales listing (Arka Fermented Cocopeat, Arka Urban Horti-Kit) | https://iihr.res.in/node/25027 | ICAR-IIHR | Existence of the products | B | SS | Cite. |
| S31 | VFPCK Haritha Nagari (terrace garden) and VFPCK Package of Practices (amaranth) | https://www.vfpck.org/terrace_garden.asp ; https://vfpck.org/package_of_practices.asp?ID=1 | Vegetable & Fruit Promotion Council Keralam | Crop list for terrace kits; amaranth year-round but avoid heavy rain | B | Terrace page F; POP page SS | Cite. |

### 1b. University extension, RHS, FAO, poison and safety data

| ID | Source | URL | Publisher | Good for | Rel. | Ver. | Licensing / reuse notes |
|---|---|---|---|---|---|---|---|
| S1 | Masabni J.G., *Vegetable Gardening in Containers*, HORT-PU-090 (05/14); also E-545 (3-09) | https://cdn-de.agrilife.org/extension/departments/hort/hort-pu-090/publications/files/Vegetable-gardening-in-containers.pdf ; https://aggie-horticulture.tamu.edu/vegetable/files/2010/10/E-545_vegetable_gardening_containers.pdf | Texas A&M AgriLife Extension | Container size and plants per container (Table 1); germination, light, days to harvest (Table 2); fertiliser solution; leaching; troubleshooting table | A | F | Extension publication. Cite; reproduce only with credit and permission. |
| S2 | *Types of Containers for Growing Vegetables* (updated 20 Feb 2023) | https://extension.umd.edu/resource/types-containers-growing-vegetables | University of Maryland Extension | Volume and depth by plant size class; drainage myths (no gravel layer) | A | F | Cite. |
| S3 | *Container Vegetable Gardening: Four Keys to Success* | https://extension.psu.edu/container-vegetable-gardening-four-keys-to-success | Penn State Extension | Pot widths, pot material, mix, fertiliser frequency, sun hours | A | F | Cite. |
| S10 | Upham W. et al., *MF2805 Watering Raised Beds, Berms, Containers, and Houseplants* | https://bookstore.ksre.ksu.edu/download/watering-raised-beds-berms-containers-and-houseplants_MF2805 | Kansas State University Research & Extension | Why fixed schedules fail; finger-depth tests; clay vs plastic; heat on exposed containers; air-lock under flat pots | A | F | Cite. |
| S32 | UC IPM Pest Notes: Aphids (Pub. 7404) | https://ipm.ucanr.edu/PMG/PESTNOTES/pn7404.html | University of California ANR | Monitoring frequency; water sprays; soaps/oils cautions; excess N favours aphids | A | F | Text may be reproduced for *educational* purposes with credits; commercial distribution prohibited; photos need written consent [S36]. |
| S33 | UC IPM Pest Notes: Spider Mites (Pub. 7405) | https://ipm.ucanr.edu/PMG/PESTNOTES/pn7405.html | UC ANR | Monitoring (white-paper tap); dusty conditions; broad-spectrum sprays trigger outbreaks | A | F | as S32 |
| S34 | UC IPM Pest Notes: Whiteflies (Pub. 7401) | https://ipm.ucanr.edu/PMG/PESTNOTES/pn7401.html | UC ANR | Yellow sticky traps; leaf undersides; soap/oil/neem cautions | A | F | as S32 |
| S35 | UC IPM Pest Notes: Mealybugs (Pub. 74174, 03/2016) | https://ipm.ucanr.edu/PMG/PESTNOTES/pn74174.html | UC ANR | Where they hide; ants; hand removal; soaps/oils less effective on adults | A | F | as S32 |
| S36 | UC IPM Legal Notices | https://ipm.ucanr.edu/GENERAL/copyright.html | UC ANR | Reuse terms | A | SS | n/a |
| S37 | *Horticultural Oils* fact sheet | https://homegarden.cahnr.uconn.edu/factsheets/horticultural-oils | UConn Home & Garden Education Center | Oil spray cautions (temperature, drought, humidity, sensitive plants, test spray) | A | F | Cite. |
| S38 | *Neem Oil General Fact Sheet* (last reviewed March 2012) | http://npic.orst.edu/factsheets/neemgen.html | National Pesticide Information Center (Oregon State Univ./US EPA) | Toxicity to bees, fish, cats, humans; breakdown half-lives | A (dated) | F | Cite. |
| S40 | NC State Extension Gardener Plant Toolbox (pages listed in §7) | https://plants.ces.ncsu.edu/ | NC State Extension | Light, soil, water, container suitability, toxicity severity for ornamentals and herbs | A | F | No site-wide text licence found. Photos carry individual CC licences (CC BY, BY-NC, BY-NC-ND, BY-SA, CC0). Cite facts; check each photo's licence. |
| S46 | UC ANR blog: air-pruning containers | https://ucanr.edu/blog/under-solano-sun/article/air-pruning | UC ANR (Master Gardener blog) | Fabric/air-pruning pots dry out faster | B | SS | Cite. |
| S4 | RHS: Container maintenance | https://www.rhs.org.uk/container-gardening/maintenance | Royal Horticultural Society | Daily checks in warm/windy weather (twice daily when hot); overwatering is the most common loss; feeding; repotting every few years | A | F | RHS content is copyright. RHS Collections terms describe non-commercial use and say commercial use needs permission (https://collections.rhs.org.uk/terms-of-use, SS). Cite facts; don't copy text. |
| S5 | RHS: How to water containers | https://www.rhs.org.uk/container-gardening/how-to-water-containers | RHS | Finger test a third of the way down; terracotta and metal dry or heat; larger pots hold moisture longer; aspect | A | F | as S4 |
| S6 | RHS: Watering (garden jobs) | https://www.rhs.org.uk/garden-jobs/watering | RHS | Water when dry 2–3 cm below surface; morning best; avoid midday | A | F | as S4 |
| S7 | RHS: Vegetables in containers | https://www.rhs.org.uk/vegetables/containers | RHS | ≥45 cm depth and width recommendation; sterile peat-free compost; feeding | A | SS | as S4 |
| S8 | RHS: Roses, growing in containers | https://www.rhs.org.uk/plants/roses/growing-in-containers | RHS | Rose pot depths, feeding, watering | A | SS | as S4 |
| S9 | RHS: Roof gardens and balconies | https://www.rhs.org.uk/garden-design/roof-gardens-balconies | RHS | Consult a chartered structural engineer; heavy pots over load-bearing walls or beams; lightweight materials | A | SS | as S4 |
| S44 | FAO: Microgardens | https://www.fao.org/agriculture/crops/thematic-sitemap/theme/hort-indust-crops/microgardens/en/ | FAO | Container micro-garden concept; substrates; rooftop rainwater harvesting (20 m² roof collects 2,000 L per 100 mm rain) | A | F | FAO content is generally reusable for non-commercial purposes with attribution (check FAO copyright page). |
| S45 | FAO (2012) *Growing greener cities in Africa* (ISBN 978-92-5-107286-8) | https://www.fao.org/urban-food-actions/resources/resources-detail/zh/c/1043596/ | FAO | Urban horticulture context (Africa); not container-specific | B | SS | as S44 |
| S39 | ASPCA Toxic and Non-Toxic Plants (pages listed in §7) | https://www.aspca.org/pet-care/animal-poison-control/toxic-and-non-toxic-plants | ASPCA Animal Poison Control Center | Pet toxicity (dogs, cats, horses) | A for pets | F | ASPCA copyright. Cite and link; don't bulk-copy. Pets only, **not** children. |
| S41 | Queensland Children's Health: Pothos | https://childrens.health.qld.gov.au/poisonous-plant-pothos-epipremnum/ | Children's Health Queensland (Govt.) | Pothos effects in children | A | SS | Cite. |
| S42 | IS 875 (Part 2): 1987, Imposed Loads (reaffirmed) | https://law.resource.org/pub/in/bis/S03/is.875.2.1987.pdf | Bureau of Indian Standards (public copy via Public.Resource.Org) | Roof imposed loads (Table 2) | A | F (text extracted) | Indian Standard; public copy. Cite. |
| S43 | NParks/CUGE CSE01:2009 *Guidelines on Design Loads for Rooftop Greenery* | https://skyrisegreenery.nparks.gov.sg/files/CUGE%20Standards/CSE01_2009___Guidelines_on_Design_Loads_for_Rooftop_Greenery.pdf | National Parks Board, Singapore | Wet soil unit weight ≈ 22 kN/m³ | A | SS (404 on fetch) | Cite; re-verify. |
| S47 | The Wire: reporting of NAAS position on Zero Budget Natural Farming | https://thewire.in/agriculture/questions-zero-budget-natural-farming | The Wire (news) | NAAS called ZBNF "unproven" | C | SS | News; cite as context only. Locate the primary NAAS document before relying on it. |

### 1c. Datasets and APIs (details in §8)

| ID | Source | URL | Ver. |
|---|---|---|---|
| D1 | Perenual API docs; pricing | https://perenual.com/docs/api ; https://perenual.com/subscription-api-pricing | F |
| D2 | Trefle site; docs; GitHub | https://trefle.io/ ; https://docs.trefle.io/docs/guides/getting-started ; https://github.com/treflehq/trefle-api | F |
| D3 | OpenFarm sunset post; archived repo; community CC0 rescue | https://farm.bot/blogs/news/sunsetting-openfarm ; https://github.com/openfarmcc/OpenFarm ; https://github.com/thefullnacho/openfarm-crops-rescue (via https://growingfruit.org/t/openfarms-crop-data-restored-in-website/81182) | F |
| D4 | USDA PLANTS: data.gov entry; Conditions of Use | https://catalog.data.gov/dataset/plants ; https://plants.usda.gov/assets/docs/ConditionsofImageandDataUse.pdf | SS |
| D5 | GBIF terms and licensing | https://www.gbif.org/terms ; https://data-blog.gbif.org/post/gbif-occurrence-license-processing/ | SS (403 on fetch) |
| D6 | Wikidata licensing | https://www.wikidata.org/wiki/Wikidata:Licensing | F |
| D7 | Kew terms of use; POWO about | https://www.kew.org/node/2426 ; https://powo.science.kew.org/about | SS (POWO terms page 403) |

---

## 2. Container guidance per crop

### 2a. Base extension data (fetched)

**Texas A&M Table 1 [S1]: container size and plants per container**

| Crop | Container and plants |
|---|---|
| Broccoli | 2 gal, 1 plant |
| Carrot | 1 gal, 2–3 plants; "use pots 2 inch deeper than the carrot length" |
| Cucumber | 1 gal, 1 plant |
| Eggplant | 5 gal, 1 plant |
| Green bean | 2 gal minimum, plants 3 in apart |
| Green onion | 1 gal, 3–5 plants |
| Leaf lettuce | 1 gal, 2 plants |
| Parsley | 1 gal, 3 plants |
| Pepper | 5 gal, 1–2 plants |
| Radish | 1 gal, 3 plants |
| Spinach | 1 gal, 2 plants |
| Squash | 5 gal, 1 plant |
| Tomato | 5 gal, 1 plant |
| Turnip | 2 gal, 2 plants |

Texas A&M text [S1]:
- Pots of 6–10 in suit green onion, parsley and herbs.
- 5 gal is "most suitable" for tomatoes, peppers and eggplant.
- 1–2 gal is best for chard and dwarf tomatoes.

**Texas A&M Table 2 [S1]: germination, transplant age, container class, light, days to harvest**

| Crop | Days to germinate | Weeks to transplant age | Container class | Light | Days from seeding to harvest |
|---|---|---|---|---|---|
| Beans | 5–8 | – | Medium | Sun | 45–65 |
| Cucumbers | 6–8 | 3–4 | Large | Sun | 50–70 |
| Eggplant | 8–12 | 6–8 | Large | Sun | 90–120 |
| Leaf lettuce | 6–8 | 3–4 | Medium | Partial shade | 45–60 |
| Onions | 6–8 | 6–8 | Small | Partial shade | 80–100 |
| Parsley | 10–12 | – | Small | Partial shade | 70–90 |
| Pepper | 10–14 | 6–8 | Large | Sun | 90–120 |
| Radish | 4–6 | – | Small | Partial shade | 20–60 |
| Squash | 5–7 | 3–4 | Large | Sun | 50–70 |
| Tomato | 7–10 | 5–6 | Large | Sun | 90–130 |

Table footnote: "All vegetables grow best in full sunlight, but those indicated will also do well in partial shade." [S1]

Texas A&M light section [S1]:
- Leafy crops (lettuce, cabbage, greens, spinach, parsley) tolerate more shade than root crops (radish, beet, turnip, onion).
- Fruit-bearing plants (cucumber, pepper, tomato, eggplant) "need the most sun of all."

**Maryland size classes [S2]**

| Class | Minimum media volume | Depth | Examples named by UMD |
|---|---|---|---|
| Large (1 plant per container) | 8–10 gal (~30–38 L) | 12–16 in (~30–41 cm) | tomatoes, peppers, eggplant, cucumber, winter squash |
| Medium | 4–6 gal (~15–23 L) | 8–12 in (~20–30 cm) | dwarf tomato/pepper/eggplant, summer squash, cole crops, beans, beets, chard, carrots, cabbage, larger herbs |
| Small | 1–3 gal (~4–11 L) | 4–6 in (~10–15 cm) | herbs (garlic, basil, cilantro, thyme, mint, marjoram), radish, scallions, Swiss chard, spinach, salad greens, Asian greens, mustard greens, peas, beans, small annual flowers |
| Shrubs | 25 gal | – | shrubs |

**Penn State [S3]:**
- Tomato: at least a 20-in-wide pot.
- Peppers and eggplant: a 14-in pot.
- Herbs and greens: smaller pots.
- All pots should be "at least as tall as they are wide."
- Tomatoes and peppers need at least 6 h of sun a day; lettuce and kale prefer some shade.

**RHS [S7, SS]:**
- Aim for containers at least 45 cm deep and wide; smaller ones need more frequent watering and feeding.

**ICAR Indian Horticulture [S11]:**
- The terrace site should get 6–8 hours of sunlight "at least."

**CONFLICT on large crops:** Texas A&M says 5 gal [S1]. Maryland says 8–10 gal [S2]. **Suggested rule:** treat 5 gal (~19 L) as the minimum and 8–10 gal (~30–38 L) as recommended for tomato, brinjal and chilli. On hot terraces bigger is better, because larger and deeper pots hold moisture longer [S5].

### 2b. Crop table: container, spacing, sun

"Proxy" means the source category covers the crop only by analogy.

| # | Crop (Indian name) | Minimum container | Plants per container / spacing | Sunlight | Notes |
|---|---|---|---|---|---|
| 1 | Tomato (tamatar) | 5 gal, 1 plant [S1]. Large class: 8–10 gal, 12–16 in deep [S2]. ≥20 in wide pot [S3]. Dwarf types: 1–2 gal [S1] or 4–6 gal, 8–12 in [S2] | 1 per pot [S1]. Field: 60×45 cm [S13] | Full sun; ≥6 h [S3]; "Sun" [S1] | Nursery 25–30 days before transplanting [S11] |
| 2 | Chilli (mirchi) | Pepper: 5 gal [S1]; large class 8–10 gal [S2]; 14 in pot [S3] | 1–2 per 5 gal [S1]. Field: varieties 60×45 cm, hybrids 75×60 cm [S19, SS] | ≥6 h [S3]; "Sun" [S1] | Transplant 40–45-day-old seedlings [S19, SS]. Pepper data used for chilli (same genus) |
| 3 | Brinjal (baingan) | Eggplant: 5 gal, 1 plant [S1]; large class [S2]; 14 in pot [S3] | 1 per pot [S1]. Field: 75×50 cm (Kharif), 60×45 (Rabi), 50×50 (Summer) [S13] | "Sun" [S1]; fruiting crops need the most sun [S1] | Transplant 30–35 days after sowing [S21, SS] |
| 4 | Okra (bhindi) | **UNVERIFIED.** No extension container figure found. Secondary sites suggest ≥5 gal, ~12 in deep, and attribute "1 plant per 5–7 gal" to Alabama Extension (unconfirmed) | Field: 45×30 cm, thin to 2 plants per hill [S14] | **UNVERIFIED** (fruiting crop; Texas A&M's "most sun" statement is a proxy [S1]) | Direct seeded [S11] |
| 5 | Spinach / palak | Spinach: 1 gal, 2 plants [S1]; small class 1–3 gal, 4–6 in [S2] | Field: palak 25×30 cm [S13] | Leafy crops tolerate more shade [S1] | Indian "palak" may differ botanically from true spinach (taxonomy not verified here). Extension spinach data is a **proxy** |
| 6 | Amaranth (chaulai, keerai) | **Proxy:** small class "salad greens / Asian greens" 1–3 gal, 4–6 in [S2] | Field: 25×30 cm [S13] | **UNVERIFIED** | Grown year-round; avoid sowing during heavy rain [S31, SS] |
| 7 | Coriander (dhania) | Cilantro: small class 1–3 gal, 4–6 in [S2] | Field: 20×15 cm; thin at 30 days to 2 per hill [S16] | **UNVERIFIED** | "Whole seed will not germinate": split seeds before sowing [S16] |
| 8 | Mint (pudina) | Mint: small class 1–3 gal, 4–6 in [S2] | Field: 40×40 cm [S23, SS] | **UNVERIFIED** | Propagate by terminal cuttings or root suckers [S23, SS] |
| 9 | Methi (fenugreek) | **Proxy:** small-class greens [S2] | Field: 20×15 cm [S17] | **UNVERIFIED** | – |
| 10 | Curry leaf (kadi patta) | **UNVERIFIED** (perennial shrub; Maryland's general shrub figure is 25 gal [S2], a proxy) | Field: 1.2–1.5 m [S15] | **UNVERIFIED** | Prune: at ~1 m height cut the terminal bud; keep 5–6 branches [S15] |
| 11 | Tulsi (holy basil, *Ocimum tenuiflorum*) | **Proxy:** basil in small class 1–3 gal [S2] | – | Full sun, ≥6 h [S40: ocimum-tenuiflorum] | Avoid waterlogged soil; seed-propagated; reseeds and can be weedy [S40] |
| 12 | Lemongrass | **UNVERIFIED** (container use confirmed by [S40], no size given) | – | Full sun, ≥6 h [S40: cymbopogon-citratus] | Propagate by division or seed; in containers "do not let it dry out" over winter [S40] |
| 13 | Bitter gourd (karela) | **UNVERIFIED.** Proxy: vining cucurbits (cucumber, winter squash) in the large class 8–10 gal, 12–16 in [S2]. Texas A&M notes vining crops "require considerably more space" [S1] | Field: 100×75 cm (Kharif), 75×75 cm (Summer); 3–5 seeds per basin [S13] | **Proxy:** cucumber/squash are "Sun" [S1] | Needs trellis (vining). Direct seeded [S11] |
| 14 | Bottle gourd (lauki) | **UNVERIFIED.** Same proxy as bitter gourd [S1, S2] | **UNVERIFIED** | **Proxy:** "Sun" [S1] | Direct seeded [S11] |
| 15 | Beans (French/cluster/dolichos) | Green bean: 2 gal minimum, plants 3 in apart [S1]; Maryland lists beans under both medium (4–6 gal) and small (1–3 gal) [S2] | 3 in apart [S1]. Field: French bean 30×30 cm, creeper beans 50×50 cm [S13] | "Sun" [S1] | Pole types are vining and need more space [S1] |
| 16 | Radish (mooli) | 1 gal, 3 plants [S1]; small class 4–6 in [S2] | 3 per gal [S1]. Field: 30×10 cm [S13] | Partial shade OK per Table 2 [S1], but Texas A&M's light text says root crops need more sun than leafy crops [S1] | Long Indian radish types need deeper pots (Texas A&M carrot rule: pot 2 in deeper than root length [S1]; applying it to radish is a proxy) |
| 17 | Carrot (gajar) | 1 gal, 2–3 plants; pot 2 in deeper than carrot length [S1]. Medium class 4–6 gal, 8–12 in [S2] | Field: 25×25 cm [S13] | **UNVERIFIED** | CONFLICT: 1 gal [S1] vs 4–6 gal [S2]. Prefer depth-based rule [S1] |
| 18 | Lettuce | 1 gal, 2 plants [S1]; small class [S2] | 2 per gal [S1] | Partial shade OK [S1]; prefers some shade [S3] | – |
| 19 | Marigold (genda, *Tagetes erecta*) | **UNVERIFIED** (container use recommended by [S40], no size given) | Mature size 1–4 ft tall × 1–2 ft wide [S40] | Full sun ≥6 h; appreciates light afternoon shade; dislikes full shade [S40: tagetes-erecta] | Deadhead promptly: heavy heads can snap stems [S40] |
| 20 | Hibiscus (gudhal, *H. rosa-sinensis*) | **UNVERIFIED**; "large container" indoors [S40: hibiscus-rosa-sinensis] | – | Full sun to partial shade (6+ or 2–6 h) [S40] | Keep roots moist; protect from wind; moving the plant can cause leaf and bud drop [S40] |
| 21 | Jasmine (mogra, *J. sambac*) | **UNVERIFIED** | Field: 1.25 m each way [S18] | **UNVERIFIED** | Semi-hardwood cuttings 15–20 cm [S18] |
| 22 | Rose | Patio/miniature: pots 23–35 cm deep. Compact climbers/ground cover: ≥30–45 cm deep [S8, SS] | – | **UNVERIFIED** (RHS rose sun guidance not fetched) | Mulch 5 cm; peat-free John Innes No 3-type compost [S8, SS] (UK product) |
| 23 | Aloe vera | **UNVERIFIED** size; pot with several drainage holes; clay pots "best" [S40: aloe-vera] | – | Full sun to partial shade (6+ or 2–6 h) [S40] | Very well-drained succulent mix; let soil dry completely between waterings [S40] |
| 24 | Money plant / pothos (*Epipremnum aureum*) | Containers or hanging baskets [S40: epipremnum-aureum] | – | Bright indirect light; survives long periods of low light; low light can cause loss of variegation [S40] | Let mix dry between waterings; overwatering causes root rot and blackened leaf margins [S40] |
| 25 | Snake plant (*Dracaena trifasciata*, syn. *Sansevieria*) | Commonly container-grown; needs good drainage [S40: dracaena-trifasciata] | – | 2–6 h direct sun; tolerates very low light [S40] | Dry between waterings; overwatering is the main risk (root rot) [S40] |

### 2c. Crop table: days to harvest and Indian sowing seasons

**Sources for this table:**
- **[S11]** ICAR *Indian Horticulture* terrace table. Columns were cleanly extracted with `pdftotext -table`.
- **[S13]** Telangana (Hyderabad region). Kharif table months are as given (e.g. Jun–Oct). The Rabi table is labelled "Rabi". The Summer table is labelled "Summer".
- **[S14–S22]** TNAU (Tamil Nadu).

ICAR "days to maturity" may mean the first harvest or the full crop duration. The article does not define it, so treat it as **approximate time to first harvest (UNVERIFIED definition)**.

| Crop | Days to harvest / maturity | North India sowing [S11] | South India sowing [S11] | Other regional sowing windows | Sowing method |
|---|---|---|---|---|---|
| Tomato | 110–115 d [S11]; 90–130 d seed to harvest [S1]; crop duration 120–140 d (varieties), ~160 d (hybrids) [S20, SS] | Jun–Aug; Nov–Dec | Jan–Feb; Jun–Jul; Oct–Nov | Telangana: Jun–Oct; Nov–Feb; Feb–Jun [S13]. TNAU: Nov–Mar; Jun–Jul [S20, SS] | Nursery 25–30 d then transplant [S11] |
| Chilli | Pepper 90–120 d from seed [S1]. Chilli not in ICAR table (capsicum: 95–100 d [S11], different crop) | – (capsicum: Nov–Jan; May–Jun) | – (capsicum: Jan–Feb; May–Jun; Oct–Nov) | TNAU: Jan–Feb; Jun–Jul; Sep–Oct [S19] | Nursery; transplant at 40–45 d [S19, SS] |
| Brinjal | 100–110 d [S11]; eggplant 90–120 d from seed [S1] | Feb–Mar; May–Jun; Oct | Jan–Feb; Oct | Telangana: Jun–Oct; Nov–Feb; Feb–Jun [S13] | Nursery 25–30 d then transplant [S11] |
| Okra | 50–60 d [S11] | Feb–Mar; Jun–Jul | Jan–Feb; May–Jun; Oct–Dec | TNAU: Jun–Aug and Feb [S14]. Telangana: Jun–Aug; Jan–Mar [S13] | Direct seeded [S11] |
| Spinach / palak | Spinach 60 d [S11] | Sep–Nov; Feb | Sep–Nov | Telangana palak: "throughout the year" [S13] | Direct seeded [S11] |
| Amaranth | CO 1: 25 d for tender greens (mulaikeerai), 50–60 d for stem type [S22, SS] | – | – | Telangana: throughout the year [S13]. Kerala: year-round, avoid heavy rain [S31, SS] | **UNVERIFIED** |
| Coriander | Greens: pull at 30–40 d [S16] | – | – | TNAU: Jun–Jul; Oct–Nov [S16] | Direct; split seed [S16] |
| Mint | Field oil crop: first cut ~5 months, then every 3 months [S23, SS]. **Not applicable** to kitchen picking; kitchen harvest timing UNVERIFIED | – | – | TNAU planting: Jun–Jul [S23, SS] | Cuttings or suckers [S23, SS] |
| Methi | Greens: 20–25 d; grain: 90–100 d [S17] | – | – | TNAU: Jun–Jul; Oct–Nov [S17]. Telangana: Jun–Aug; Oct–Feb [S13] | Direct [S17] |
| Curry leaf | First harvest 10–12 months after planting; every 4 months in year 2; every 3 months from year 4 [S15] | – | – | Fruits (seed) available Jul–Aug; sow within days of collection; plant 1-year-old seedlings [S15] | Seed [S15] |
| Tulsi | **UNVERIFIED** | – | – | **UNVERIFIED** | Seed [S40] |
| Lemongrass | **UNVERIFIED** | – | – | **UNVERIFIED** | Division or seed [S40] |
| Bitter gourd | 55–60 d [S11] | Feb–Mar; Jun–Jul | Nov–Dec; Dec–Jan; Jun–Jul | Telangana: Jul–Oct; Feb–May [S13] | Direct seeded [S11] |
| Bottle gourd | 55–60 d [S11] | Feb–Mar; Jun–Jul | Nov–Dec; Dec–Jan; Jun–Jul | **UNVERIFIED** (not in [S13]) | Direct seeded [S11] |
| Beans | 45–50 d [S11]; 45–65 d [S1] | Feb–Mar | Jan–Mar | Telangana: French bean and creeper beans Oct–Nov; cluster bean Jun–Sep, Oct–Nov, Jan–Jun [S13] | Direct seeded [S11] |
| Radish | 40–45 d [S11]; 20–60 d [S1] | Aug–Jan | Sep–Nov | Telangana: Aug–Nov [S13] | Direct seeded [S11] |
| Carrot | 75–80 d [S11] | Aug–Oct | Aug–Nov | Telangana: Jun–Jul; Aug–Nov [S13] | Direct seeded [S11] |
| Lettuce | 45–55 d [S11]; 45–60 d [S1] | Sep–Oct | Oct–Dec | – | Direct or transplant [S11] |
| Marigold | **UNVERIFIED** days. Research: pinching at ~40 days after transplanting increased flower yield (KAU journal study, SS: https://jtropag.kau.in/index.php/ojs2/article/view/369) | – | – | **UNVERIFIED** | – |
| Hibiscus | Perennial; **UNVERIFIED** | – | – | – | – |
| Jasmine (*J. sambac*) | Flowering begins Mar–Apr [S18] | – | – | TNAU planting: Jun–Nov. Prune to ~50 cm in the last week of November [S18] | Cuttings/layers [S18] |
| Rose, aloe, pothos, snake plant | Perennials; no sowing season | – | – | – | – |

**Engineering notes:**
- Store regions as `north_india`, `south_india`, `telangana`, `tamil_nadu`, `kerala`. Show a lower-confidence badge when falling back from a state-level window to a macro region.
- ICAR's table has a germination temperature column (°C) [S11]. Examples: brinjal 21–27, okra 20–32, radish 10–30, tomato 20–30, spinach 10–22, lettuce 7–27. These can drive weather-aware sowing hints.
- Texas A&M germination days (Table 2 [S1]) can drive "seedlings should appear by" checks.

---

## 3. Potting mix and drainage

### 3a. Indian official mixes

| Context | Mix | Source |
|---|---|---|
| Terrace vegetables in plastic sacks (official KAU recommendation) | Soil : sand : powdered cow dung **2:1:1**, incorporated with PGPR Mix I. Fill **75%** of sack volume. Fold the top edge to form a thick border. "Plastic sacs are better than earthen flower pots. Among plastic sacs, fertilizer sacs are better." Two plants per hill, two hills per sack | [S12] |
| Nursery polybags/mud pots (TNAU) | Composted coir pith **20%** mixed with soil and sand. Coir pith must be fully composted; buy only with a quality certificate | [S26, SS] |
| KAU nursery potting mixture (rootstock raising, fruit-crop section) | Red soil : river sand : compost **1:1:1** + rock phosphate 5 g per 2 kg mix; use solarised soil | [S12] |
| Anthurium in pots (KAU) | Per pot: FYM 200 g, vermicompost 100 g, Trichoderma 20 g; biofertilisers 2 g/plant every 2 months | [S12] |
| TN Horticulture DIY rooftop kit | Sealed polythene grow bags 24×18 in with **2 kg cocopeat per bag**, plus water-soluble fertiliser, biofertilisers, bio-pesticide and bio-fungicide (page last updated Oct 2014) | [S24] |
| ICAR-IIHR soilless | Arka Fermented Cocopeat as medium plus the Arka Sasya Poshak Ras nutrient solution; used for tomato, chilli, cabbage, cucumber, French bean, pea, ridge gourd and leafy vegetables | [S28, S29] |
| ICAR Indian Horticulture (general) | Fresh farm soil with organic manure and vermicompost; cocopeat for water retention and aeration; prefer lightweight mixes | [S11] |

**Research note (single study, SS):** For strawberry in terrace gardening, soil + vermicompost + cocopeat at 1:1:1 was "most appropriate" (agris record https://agris.fao.org/search/en/records/67598e52c7a957febdfc0d2f). An Indian journal paper notes cocopeat "does not contain any nutrient" (https://epubs.icar.org.in/index.php/IJAgS/article/download/124805/47056/333058). The commonly circulated 1:1:1 soil:cocopeat:compost terrace mix is therefore **plausible but only weakly sourced** for vegetables. Use the KAU 2:1:1 mix as the cited default, and offer 1:1:1 soil:cocopeat:compost as a lighter alternative marked "community practice; limited evidence".

### 3b. Extension guidance on mixes

- **Texas A&M [S1]:**
  - Soilless mixes are disease- and weed-free, hold moisture and nutrients, drain well and are light.
  - Soil mixes are equal parts sphagnum peat or compost, pasteurised soil, and vermiculite or perlite, plus composted cow manure. "Soil mixes tend to hold water better than soilless mixes."
  - Do not reuse the same soil for a second season unless it has been properly composted.
- **Penn State [S3]:** use soilless mix, not garden soil ("heavy and drains poorly"); finished compost can be up to 50%.
- **RHS [S7, SS]:** sterile, peat-free multipurpose or container compost gives best results; homemade soil mixes aren't sterile.
- **RHS [S9, SS]:** loam-based mixes are heavier than soilless ones. This matters on roofs.
- **RHS [S4]:** as organic components decay, compost becomes "soggy, dense and lacking in air spaces." This supports periodic repotting or refreshing.

### 3c. Drainage

- Every container needs drainage holes; empty saucers after watering; raise pots on pot feet or bricks [S2].
- **CONFLICT:** Maryland (2023) says adding rocks, gravel or pot shards "does not improve drainage and may cause drainage problems" [S2]. Texas A&M (2009/2014) says about 1 in of coarse gravel "will improve drainage" [S1]. **Suggested rule:** follow Maryland (newer, and the consensus position); do not tell users to add a gravel layer.
- Flat-bottomed pots on flat surfaces can form an "air-lock" that blocks drainage; choose pots with feet or elevate them [S10].
- KAU: place sacks on bricks arranged in a triangle [S12].
- In very wet periods, move pots under temporary cover [S4]. Remove saucers in the wet season: RHS says to remove them in winter [S4, S5]; applying this to the Indian monsoon is **my inference**.
- Lightweight crocking: use polystyrene instead of broken pots to reduce load [S9, SS].
- Grow bags: fill to ~75% [S12]. A news source suggests a red-soil layer to stop light bags blowing over (C-grade, thebetterindia.com; **UNVERIFIED**).

---

## 4. Watering principles

### 4a. Why fixed schedules fail

- "It is impossible to properly water a houseplant on an arbitrary, predetermined schedule". Frequency depends on plant size and growth rate, potting soil, container type, temperature and humidity [S10].
- Container water needs depend on the container's shape, size and material, sun and wind exposure, and plant density and maturity. "Monitor container gardens daily" [S10].
- RHS gives no fixed schedule: "in summer dry spells, you may well need to water every day or every other day" [S5].
- **CONFLICT:** Texas A&M says "usually once per day is adequate," and twice a day for leafy plants [S1]. Penn State says at least once daily in hot summer [S3]. Treat these as *upper-bound hints for hot weather*, not schedules.

### 4b. How to check (rule inputs)

| Check | Guidance | Source |
|---|---|---|
| Finger test (general) | Water when compost is dry 2–3 cm (~1 in) below the surface | [S6] |
| Finger test (pot-relative) | Feel moisture about a third of the way down the pot | [S5] |
| Pot-size scaling (houseplants) | Water when dry 1 in down in a 6-in pot, or 2 in down in a 10-in pot | [S10] |
| Ornamental container gardens | Dry at least 3 in deep before watering | [S10] |
| Succulents (aloe, snake plant) | Let the soil dry completely [S40]. K-State method: record how long the soil takes to dry an inch deep, then wait that long again before watering [S10] | [S10, S40] |
| How much | Water until it drains from the holes; stop once draining [S5]. Saturate so some runs out of the bottom; this also leaches fertiliser salts [S10] | [S5, S10] |
| After rain | Check that soil is moist below the surface even after rain | [S4] |

### 4c. Modifiers for the app's "check soon" heuristic

| Factor | Effect | Source |
|---|---|---|
| Pot size and depth | Larger and deeper pots hold moisture longer than shallow ones | [S5] |
| Terracotta / clay | Dries faster than plastic [S3, S10]. Porous materials (clay, ceramic, concrete, wood) dry more quickly [S2]. Clay suits people who tend to over-water [S10] | [S2, S3, S10] |
| Metal | Heats up in sun, "baking the compost" | [S5] |
| Dark colours | Heat up and can injure young roots | [S2] |
| Fabric grow bags | More surface exposed to air means quicker drying (air-pruning containers) | [S46, SS] |
| Wind, heat, aspect | Warm windy weather increases water loss. North- and east-facing containers dry more slowly than south- or west-facing ones. Move pots to shade in very hot spells | [S5] |
| Exposed hot terraces | Soil in exposed containers can get too hot for roots. A light midday moistening of plants and soil surface (not soaking) can cool it, with cool water | [S10] |
| Grouping and mulch | Grouping pots creates shade and humidity; mulch reduces evaporation | [S4]; mulches listed in [S1] |
| Time of day | Early morning is best. Evening is OK, but damp leaves overnight can encourage disease. Avoid midday (evaporation) | [S6] |
| Foliage | Water the base, not the leaves [S6]. Wet leaves encourage disease [S1] | [S1, S6] |
| Over-watering | "The most common cause of container plant loss." Keep compost "moist, never soggy and avoid alternating dryness and saturation" | [S4] |
| Monsoon / wet spells | Move pots under cover in very wet periods [S4]. Shift sacks and bricks after each crop so no part of the terrace stays permanently wet [S12]. Avoid sowing amaranth during heavy rain [S31, SS] | [S4, S12, S31] |
| KAU terrace practice | Irrigate morning and evening "so that excess water will not drip out and plants will not wither" | [S12] |
| Saucers | Can reduce water and fertiliser use in dry spells; empty a few hours after watering; remove in the wet/cold season | [S4, S5] |
| Peat-free compost | Needs slightly less water per session but more frequent watering | [S5] |
| Hydrogels | Starch-based gels absorb at least 100× their weight and release water slowly; mix in before planting | [S1] |
| Rainwater | A 20 m² roof collects 2,000 L per 100 mm of rain (FAO) [S44]. RHS recommends stored rainwater where possible [S6] but fresh tap water for seeds and seedlings because of pathogen risk [S7, SS] | [S6, S7, S44] |

**Suggested app behaviour (design, derived from the sources above):**
- Default to a **daily check reminder** in hot, dry or windy weather [S4, S10]. Tell the user to water only if the finger test says dry [S5, S6].
- Lengthen the check interval for large plastic pots, cool or overcast weather and the monsoon.
- Shorten it for small, terracotta, metal or fabric containers and for south- or west-facing terraces.
- Never show a fixed "water every X days" rule as fact.

---

## 5. Fertilising principles

### 5a. Generic container feeding (best-evidenced)

| Guidance | Source |
|---|---|
| Container compost nutrients run out quickly; most plants benefit from regular feeding | [S7, SS], [S4] |
| Slow-release fertiliser at planting, then soluble fertiliser every **2–4 weeks** | [S3] |
| Feed fast-growing edibles and hungry plants regularly during the active season, with a general liquid feed; feed when compost is moist | [S4] |
| Texas A&M dilute nutrient-solution method. Make a concentrate of 2 cups complete fertiliser (e.g. 10-20-10) per gallon of warm water, then use 2 tablespoons of concentrate per gallon. **Leach with plain water at least once a week** to flush salts | [S1] |
| Occasionally use a fertiliser containing micronutrients (Fe, Zn, B, Mn); follow the label | [S1] |
| Diagnostics: tall spindly plants (low light or **excess nitrogen**, so reduce feeding); yellowing from the bottom (over-watering or low fertility); marginal leaf burn (**high salts**, so leach); purplish stunting (low temperature or low phosphate) | [S1] (Table 3) |
| High nitrogen favours aphid reproduction; "never use more nitrogen than necessary"; prefer slow-release forms in small portions | [S32] |
| Roses in containers: liquid feed fortnightly in the growing season; high-potash once flowering (UK calendar) | [S8, SS] |
| Long-term pots (shrubs): controlled-release fertiliser at planting, topdressing or repotting | [S4] |

### 5b. Indian institutional inputs

| Input | What the source actually says | Source | Evidence strength for containers |
|---|---|---|---|
| Arka Sasya Poshak Ras (IIHR, for cocopeat soilless) | Two-part (A + B) liquid with N, P, K, Ca, Mg, S and micronutrients [S29 node]. **Dose (SS only):** fruiting vegetables 5.0 ml each of A and B per litre; legumes 4.0 ml; leafy 3.5 ml; 200 ml per pot or grow bag; twice a week from day 10 to day 30, then three times a week; don't mix with pesticides | [S29] | Good (institutional product) but **re-verify dose** from the product label or IIHR ATIC |
| Organic manures (KAU terrace) | "Organic manures enriched with PGPR mix I are to be applied in sacs at weekly interval." **No quantity given** | [S12] | Weak (no dose) |
| Cow dung slurry, vermiwash, cow urine (KAU amaranth, field) | Top dressing at 7–10 day intervals: fresh cow dung slurry 1 kg/10 L; cow urine or vermiwash at 8× dilution; vermicompost 1 t/ha; groundnut cake 1 kg/10 L | [S12] | Field rates; container conversion **UNVERIFIED** |
| Panchagavya | KAU recipe: cow dung 7 kg + ghee 1 kg (3 days), then urine 10 L + water 10 L (15 days), then milk 3 L, curd 2 L, tender coconut water 3 L, jaggery 3 kg, 12 ripe bananas; ready after 30 days; stir twice daily; keep shaded and netted. Used as **3% foliar spray at 15-day intervals** in several KAU crop recommendations (e.g. anthurium, orchids) [S12]. TNAU gives a different, simpler recipe [S25] | [S12, S25] | Recipes official. Efficacy evidence not reviewed here: **weak/unknown** |
| Jeevamrutham (jivamirtham) | TNAU recipe per 200 L: cow dung 10 kg, cow urine 10 L, old jaggery 2 kg, pulse flour 2 kg, live soil 1 kg; ferment 2–7 days, stirring three times daily. **No application dose given** | [S25] | **Weak.** The NAAS reportedly called ZBNF "unproven" [S47, C/SS] |
| Dasagavya | Panchagavya plus extracts of plants that include *Datura metel*, *Calotropis* and *Jatropha* | [S12] | **Do not recommend in a consumer app.** Several listed plants are toxic. Safety in home settings is not evaluated |
| Vermicompost per pot (vegetables) | No TNAU/KAU per-pot vegetable rate found. Vendor labels say 100–500 g per pot (D-grade) | – | **UNVERIFIED** |

**Recommendation for the rules engine:**
- Use **generic, conservative** feeding rules: "feed every 2–4 weeks during active growth; leach monthly or weekly if using soluble fertiliser; reduce if plants are leggy or show leaf-edge burn" [S1, S3, S4, S32].
- Offer Indian organic options (vermicompost, cow-dung slurry, panchagavya) as **user-selectable inputs with a 'limited dosage evidence' badge**.
- Never give a precise container dose unless it comes from a product label or institution (e.g. Arka Sasya Poshak Ras after verification).
- **Flag (not evaluated in sources reviewed):** the food-safety implications of foliar sprays based on raw manure or urine on leafy greens eaten raw. Consider a caution until a source is found.

---

## 6. Pest and disease monitoring for containers

### 6a. Monitoring cadence (rule inputs)

- Inspect plants daily when watering; remove pests; treat diseases [S1]. KAU terrace: "Daily observation and mechanical methods are to be followed for pest control"; use organic pesticides only if warranted [S12].
- Aphids: "at least twice a week when plants are growing rapidly"; check leaf undersides; aphids gather on the upwind edge [S32].
- Container plants get the same pests and diseases as garden plants; check periodically for foliage and fruit feeders [S1].

### 6b. Pest quick reference

| Pest | What to look for | First-line actions | Source |
|---|---|---|---|
| Aphids | Colonies on leaf undersides and new growth; ants tending them | Shake off or spray with a strong water jet early in the day; conserve natural enemies; control ants; soaps or oils (incl. neem) need thorough coverage and repeat applications | [S32] |
| Spider mites | Stippled or yellow leaves before mites are visible; webbing; check undersides with a hand lens; tap onto white paper; dusty conditions favour outbreaks | Regular forceful water sprays; keep plants well irrigated (stressed plants are hit hardest); avoid broad-spectrum insecticides (they trigger outbreaks); oils/soaps with full coverage | [S33] |
| Whitefly | Colonies under leaves | Yellow sticky traps (sticky side to plants, out of direct sun); syringing; soaps/neem/oils reduce but don't eliminate; avoid broad-spectrum products (resistance, kill natural enemies) | [S34] |
| Mealybugs | Hidden in protected spots such as the crown; ants feeding on honeydew | Hand-pick or prune; remove badly infested plants; soaps/oils work best on young nymphs (adults' wax reduces effect); keep checking plants, pots and stakes | [S35] |
| Brinjal shoot and fruit borer | Wilted terminal shoots with bore holes; bored fruits | Remove affected shoots and fruits; pheromone traps; NSKE 5% starting one month after planting at 15-day intervals; avoid synthetic pyrethroids and avoid sprays near harvest | [S27, SS] |
| Fruit borer (tomato), Epilachna beetle, leaf miner (KAU organic) | – | Hand-pick egg masses, grubs and larvae; neem-garlic emulsion 2%; NSKE 4–5%; yellow sticky traps for leaf miner; *Bt* products | [S12] |
| Aphids, jassids, whitefly, mites in vegetables (KAU organic) | – | Neem oil + garlic emulsion 2%; fish oil soap 1.5% | [S12] |
| Jasmine pests | Bud worm, leaf webber, blossom midge; **mites in drought and hot weather** | – | [S18] |
| Pothos | Mealybugs, scale | Monitor | [S40] |

### 6c. Neem oil: recipe and caveats

- **KAU 2% neem oil + garlic emulsion (10 L) [S12]:**
  - Ingredients: 200 ml neem oil, 200 g garlic, 50 g bar soap.
  - Dissolve the sliced soap in 500 ml lukewarm water.
  - Grind the garlic in 300 ml water and strain.
  - Pour the soap solution slowly into the neem oil, stirring vigorously to emulsify.
  - Add the garlic extract. This gives 1 L of stock.
  - Dilute the 1 L stock with 9 L water.
  - Pro-rata for a home sprayer: **20 ml neem oil, 20 g garlic, 5 g soap per litre** (KAU gives this per-litre form for another use [S12]).
- ICAR's article gives a neem-oil spray with 10 g soap per 10 L water, but the neem-oil quantity is missing from the text [S11]. **Do not use that line.**
- **When not to spray:** don't use soaps or oils on water-stressed plants or above 90 °F (~32 °C); test on a small area first [S32, S33, S34]. Avoid when humidity stays above 90% for 48 h or rain is likely; don't use on ferns or sensitive plants [S37]. Indian terrace summers often exceed 32 °C, so the app should suggest **early-morning or evening spraying and a temperature check** (applying the UC IPM rule [S32]).
- **Coverage:** contact products only kill pests they hit; spray leaf undersides [S32, S34]. Oils are non-selective and kill susceptible beneficial insects they coat [S37].
- **Persistence:** azadirachtin half-life on leaves is 1–2.5 days [S38], so repeat applications may be needed [S32].
- **Toxicity [S38]:**
  - "Practically non-toxic to birds, mammals, bees and plants."
  - Slightly toxic to fish (azadirachtin moderately toxic), so keep runoff away from ponds.
  - Can irritate eyes and skin.
  - **Cats:** neem flea products caused adverse reactions in some cats, including some deaths. Warn pet owners not to apply neem products to pets.
- **Commercial neem formulations:** KAU lists Nimbicidin or Econeem at 2 ml/L [S12]. The app should defer to the product label.

### 6d. Chemical pesticides

The sources recommend EPA-approved or label-directed products and local extension advice [S1]. TNAU lists chemical options with doses [S27]. **Recommendation:** the app should not prescribe synthetic pesticide doses. It should point to the product label, KVK or state agriculture department advice.

---

## 7. Plant safety: pets and children

ASPCA covers **dogs, cats and horses only** [S39]. ASPCA also notes that eating *any* plant material may cause vomiting or GI upset in dogs and cats (ASPCA general page). NC State gives a severity rating and lists human symptoms [S40].

| Plant | ASPCA (pets) [S39] | NC State severity / notes [S40] | Children note |
|---|---|---|---|
| Money plant / golden pothos (*Epipremnum aureum*) | **Toxic** to dogs and cats. Insoluble calcium oxalates: oral burning, drooling, vomiting, difficulty swallowing (https://www.aspca.org/pet-care/animal-poison-control/toxic-and-non-toxic-plants/golden-pothos) | **Medium**; all parts; contact dermatitis (https://plants.ces.ncsu.edu/plants/epipremnum-aureum/) | Chewing causes burning pain and swelling of lips, mouth, tongue and throat; seek urgent care if swelling or breathing/swallowing difficulty [S41, SS] |
| Snake plant (*Sansevieria trifasciata*) | **Toxic** to dogs and cats (saponins): GI upset (https://www.aspca.org/pet-care/animal-poison-control/toxic-and-non-toxic-plants/snake-plant) | **Low**; sap irritates skin (https://plants.ces.ncsu.edu/plants/dracaena-trifasciata/) | Toxic if ingested per [S40] |
| Aloe vera | **Toxic** to dogs, cats and horses (saponins, anthraquinones). ASPCA says the gel is regarded as safe to consume (https://www.aspca.org/pet-care/animal-poison-control/toxic-and-non-toxic-plants/aloe) | **Low**; leaves; abdominal cramping, diarrhoea, red urine; latex causes dermatitis (https://plants.ces.ncsu.edu/plants/aloe-vera/) | as NC State |
| Lemongrass | **Toxic** to dogs, cats and horses (essential oils, cyanogenic glycosides) (https://www.aspca.org/pet-care/animal-poison-control/toxic-and-non-toxic-plants/lemon-grass) | Tagged as a problem for cats, dogs and horses (https://plants.ces.ncsu.edu/plants/cymbopogon-citratus/) | Culinary herb |
| Mint (*Mentha*) | **Toxic** to dogs, cats and horses (essential oils); vomiting and diarrhoea only with large ingestions (https://www.aspca.org/pet-care/animal-poison-control/toxic-and-non-toxic-plants/mint) | – | Culinary herb |
| Tomato (plant) | **Toxic** to dogs, cats and horses (solanine); ripe fruit non-toxic (https://www.aspca.org/pet-care/animal-poison-control/toxic-and-non-toxic-plants/tomato-plant) | – | – |
| Marigold, *Tagetes* (genda) | **Not assessed** on the ASPCA pages found. ASPCA lists pot/garden marigold (*Calendula officinalis*) as non-toxic (https://www.aspca.org/pet-care/aspca-poison-control/toxic-and-non-toxic-plants/garden-marigold, SS) | *T. erecta* **low**: phototoxic sap (skin redness, burning, blisters in sunlight); flower aroma can irritate (https://plants.ces.ncsu.edu/plants/tagetes-erecta/) | Gloves when deadheading (inference from NC State) |
| Hibiscus | ASPCA page covers ***Hibiscus syriacus***: **non-toxic** to dogs, cats and horses (https://www.aspca.org/pet-care/animal-poison-control/toxic-and-non-toxic-plants/hibiscus). ***H. rosa-sinensis*** (common Indian gudhal) **not assessed** | NC State *H. rosa-sinensis* page has no toxicity info | **UNVERIFIED** |
| Jasmine (*Jasminum* spp.) | **Non-toxic** to dogs, cats and horses (https://www.aspca.org/pet-care/animal-poison-control/toxic-and-non-toxic-plants/jasmine) | – | Note: "night jasmine" and "Carolina jasmine" (*Gelsemium*) are different genera (**UNVERIFIED** here; check before generalising "jasmine") |
| Rose (*Rosa*) | **Non-toxic** to dogs, cats and horses (https://www.aspca.org/pet-care/animal-poison-control/toxic-and-non-toxic-plants/rose) | – | Thorns (physical hazard) |
| Basil (*Ocimum basilicum*) as proxy for tulsi | **Non-toxic** to dogs and cats (https://www.aspca.org/pet-care/animal-poison-control/toxic-and-non-toxic-plants/basil). **Tulsi (*O. tenuiflorum*) not directly assessed** | NC State tulsi page: no toxicity info | – |
| Curry leaf, coriander, methi, amaranth, okra, gourds, chilli | **Not assessed** in this research | – | **UNVERIFIED** |

**App rules:**
- Show a "Toxic to pets" badge only where ASPCA (or an equivalent) says so.
- Show "Not assessed" rather than "safe" when there is no source.
- Show species-level caveats (e.g. hibiscus).
- Link the ASPCA Animal Poison Control Center and the local poison centre.
- For India, list a local poison-information service. **Not researched here**; add one before launch.

---

## 8. Rooftop structural load and waterproofing

| Point | Detail | Source |
|---|---|---|
| Check structure first | "Examine the structural integrity of the building and make sure the roof can hold the load. Soil and pots are heavy and will get heavier as the plants grow." | [S11] |
| Professional sign-off | Consult a chartered structural engineer or surveyor to confirm the roof can take the planned design; balconies have strict weight limits | [S9, SS] |
| Put weight on structure | Heavy containers near load-bearing walls or over beams or joists. KAU: arrange sacks "ensuring wall underneath" | [S9, SS], [S12] |
| Waterproofing | Make arrangements for draining irrigation and rain water. Waterproof the roof (plastic sheets, polymer coating, etc.). The membrane "should be root and rot-resistant" | [S11] |
| Avoid permanent wetting | After each crop, shift bricks and sacks slightly so no part of the terrace stays permanently wet | [S12] |
| Reduce load | Lightweight containers (fibreglass, plastic, thin metal); polystyrene instead of crocks; soilless mixes are lighter than loam-based ones; shallow-rooted plants on small areas | [S9, SS] |
| Indian design imposed load | IS 875 (Part 2) Table 2: flat roof (slope ≤10°) with **access provided: 1.5 kN/m²**; access not provided: 0.75 kN/m² | [S42] |
| Wet soil weight | ~22 kN/m³ typical wet soil (≈2,200 kg/m³) [S43, SS]. Secondary sources give 1,500–2,000 kg/m³ for saturated soil-based media (studiomatrx.org, D-grade) | [S43] |

**Illustrative arithmetic (mine; not engineering advice):**
- 1.5 kN/m² ≈ 153 kg per m².
- A wet soil bed 10 cm deep at 1,500–2,200 kg/m³ weighs about 150–220 kg per m², already at or above the code's imposed-load allowance before counting pots, water, people or plants.
- This supports a hard rule: **the app must never claim a layout is structurally safe.** It should:
  - recommend a structural engineer for raised beds, large planters, water tanks or dense pot clusters;
  - suggest putting heavy items over walls or columns [S9, S12];
  - suggest preferring light mixes and containers [S9].

---

## 9. Other scheduling inputs found

| Task | Guidance | Source |
|---|---|---|
| Repotting | Roots eventually fill containers and reduce growth. Shrubs and trees kept in pots for years are especially vulnerable unless repotted. Repot or refresh compost every few years (compost loses structure) | [S4] |
| End of season (annual vegetables) | Discard plant and soil, or compost properly before reuse | [S1] |
| Transplant timing | Most vegetables go into final containers at 2–3 true leaves; start seed 4–8 weeks before transplanting | [S1] |
| Nursery durations (India) | Brinjal, tomato, chilli: raise in pro-trays and transplant at 25–30 days. Okra, cluster bean, bitter gourd, bottle gourd, radish: direct sow | [S11] |
| Crop rotation in sacks | Rotate crops in each sack, including a pulse crop | [S12] |
| Transplant shock | Shade seedlings by unfolding the sack edge; put a handful of azolla at the base | [S12] |
| Variety choice | Prefer photo-insensitive, bushy varieties over photo-sensitive, trailing ones [S12]. Prefer compact, bush or container varieties [S1] | [S1, S12] |
| Pruning: curry leaf | Top at ~1 m; keep 5–6 branches; harvest intervals in §2c | [S15] |
| Pruning: jasmine (*J. sambac*) | Cut back to ~50 cm in the last week of November (Tamil Nadu); fertilise after pruning (Nov) and in Jun–Jul | [S18] |
| Pruning: marigold | Deadhead promptly [S40]. Pinching ~40 DAT increased flowers (study, SS) | [S40] |
| Plants per person | Telangana urban farming page includes plants-per-person guidance (e.g. tomato 2–3 plants per person) | [S13] |

---

## 10. Open plant datasets and APIs

| Dataset / API | Status (as of 2026-10-18) | Licence | Coverage and suitability for Indian edible crops | Verdict |
|---|---|---|---|---|
| **OpenFarm** | **Shut down 21 Apr 2025** after ~10 years: unmaintained codebase, server infrastructure losing security updates from May, declining usage [D3]. GitHub repo archived 22 Apr 2025 (read-only) [D3] | Data **CC0** (public domain); code MIT [D3] | Community rescue: 340 structured crop records from the Wayback Machine, CC0, posted Jul 2026 (https://github.com/thefullnacho/openfarm-crops-rescue) [D3]. Crowd-sourced and uncited; Indian crop coverage **UNVERIFIED** | Not usable as a live API. The rescued CC0 records could seed fields, but every value needs re-sourcing |
| **Trefle** | Live; "Trefle is still in beta"; "backed by Mashum"; ~450,000 plants indexed (426,248 species) [D2]. Needs an account token; 60 requests/min (sponsors higher) [D2]. A search snippet suggested a past outage and restoration (unconfirmed) | Code **AGPL-3.0** [D2]. **Data licence not stated** on site, docs or GitHub [D2] | Botanical and taxonomic data gathered from USDA, Kew, IPNI, Tropicos, Tela Botanica, Wikimedia and others, "completed by hand by contributors" [D2]. Not a care-schedule source | Taxonomy lookups at most. Licence ambiguity and beta status make it unsuitable to bundle |
| **Perenual** | Commercial API; ~10,104 species [D1]. Free "Personal" tier: **100 requests/day, species IDs 1–3000 only**. Premium $59.99/mo (10k/day); Supreme $139.99/mo (100k/day) [D1] | Commercial use listed only for Premium and above [D1]. Data reuse and caching terms not visible on docs or pricing pages (read their T&C). Images carry per-image CC licences [D1] | Has watering, sunlight, pruning, toxicity and pest fields [D1], but **no per-field citations**. Generic (often temperate) care benchmarks. Indian crop coverage **UNVERIFIED** | Not acceptable as a source of truth under the "every rule needs provenance" constraint. Optional for images or names, subject to T&C |
| **USDA PLANTS** | Live (plants.usda.gov redirects to plants.sc.egov.usda.gov) [D4]. Bulk Darwin Core archive mirrored on Zenodo [D4] | Text and data **not copyrighted / public domain**; data.gov lists CC0. Images may be copyrighted [D4] | **U.S. and territories only**; no Indian sowing seasons or terrace care [D4] | Use for US-centric traits and names only; low value for India |
| **GBIF** | Live | Occurrence datasets each carry **CC0, CC BY or CC BY-NC**. Mixed downloads take the most restrictive licence (commercial apps must filter out BY-NC) [D5] | Occurrence and taxonomy backbone; no care data | Taxon matching and IDs only |
| **Wikidata** | Live | Structured data **CC0** [D6] | Multilingual names (Hindi, Tamil, Malayalam, Telugu, Kannada labels likely available; **UNVERIFIED**); taxon IDs linking to GBIF, POWO, etc. | **Recommended** for names and cross-IDs |
| **POWO / WCVP (Kew)** | Live; POWO pages attach data to the accepted name from the WCVP backbone [D7] | Kew: dataset metadata CC BY; data governed by each dataset's licence field. Re-users must state Kew cannot warrant accuracy and must not imply endorsement. API rate limits apply. Images separately licensed [D7]. The WCVP-specific licence was not confirmed | Authoritative accepted names and distribution; no care data | **Recommended** for accepted scientific names (check the WCVP licence field) |

**Recommendation:**
1. **Bundle a curated, hand-authored crop catalogue** (start with the ~25 crops in §2) as versioned JSON in the app.
2. Give every field a `source_id`, `url`, `accessed` (2026-10-18), `verification` (F/SS) and `confidence`. Mark unsourced fields `null` plus an `unverified` flag, not a guessed value.
3. Use **Wikidata QIDs and POWO/WCVP IDs** for taxonomy and vernacular names (CC0 / CC BY).
4. Do **not** depend on Perenual or Trefle for care rules. If Perenual is used for images, honour each image's CC licence and the paid-tier commercial terms.
5. Optionally mine the CC0 OpenFarm rescue only as a checklist of fields, not as values.

---

## 11. Gaps and next steps (must resolve before launch)

1. **Indian container sizes** for okra, gourds, curry leaf, lemongrass, jasmine and hibiscus are unverified.
   - Contact or download: ICAR-IIHR extension bulletins and Arka Urban Horti-Kit instructions (the IIHR ATIC site was unreachable); the KVK terrace-gardening leaflets; and the TN Horticulture DIY kit operational manual PDF (linked from [S24]).
   - The ICAR KRISHI vertical-garden record (https://krishi.icar.gov.in/jspui/handle/123456789/23596) reportedly gives pot sizes (tomato ~16 in diameter × 12 in deep; chilli, brinjal, French bean, peas ~12 in × 10 in) **[SS only, host unreachable]**.
2. **Re-verify all SS facts.** Priority: the Arka Sasya Poshak Ras dose, NParks wet-soil weight, RHS rose and vegetable container pages, and TNAU tomato, brinjal and amaranth pages.
3. **UF/IFAS "Container Gardening: Recommended Varieties and Spacing"** chart (minimum volume and depth per crop) is now a dead link (404; no Wayback copy). Ask UF/IFAS Leon County extension for the current version.
4. **University of Minnesota Extension** container page returned 403 to automated fetch. Re-check manually.
5. **Pet/child toxicity** for *Tagetes*, *H. rosa-sinensis*, tulsi and curry leaf: check the ASPCA database by scientific name and Indian poison-information resources.
6. **Primary NAAS document** on ZBNF: locate and cite it directly instead of the news report.
7. **Licensing:** before quoting any text verbatim, get permission from RHS and NC State. UC IPM allows educational reproduction only [S36]. TNAU/ICAR: cite facts and link.

*End of document.*
