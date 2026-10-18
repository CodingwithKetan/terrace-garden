# User-testing kit (P6-09)

For the first round of moderated sessions with the MVP build. It tests the six assumptions and the risks in `opportunity-analysis.md` §7.

## 1. Who to recruit

5–8 people. Aim for at least:
- 3 **established terrace growers (P-A)** from Hyderabad, Chennai or Bengaluru gardening groups. Include at least one aged 55+ (risk R6).
- 3 **balcony beginners (P-B)** who have grown fewer than five plants.
- 1 **kit starter (P-C)**, if a TN DIY kit owner is available.

Use cities whose sowing calendars the app has sources for (Telangana, Tamil Nadu, Kerala, South and North India). West, central and east Indian cities have no sourced region yet (KI-017), and that gap is one of the things to observe.

## 2. Setup

- Install the debug build on the participant's own Android phone if possible; otherwise on a test phone (`flutter build apk --debug`). iOS can't be built here (KI-003).
- Start from a fresh install so onboarding appears. Settings → Your data → Delete all data also resets the app.
- Record the screen with consent, plus notes. No personal data leaves the device; the app has no analytics.
- About 45 minutes: 5 intro, 30 tasks, 10 debrief.

## 3. Tasks (think aloud; don't help unless they're stuck for 2 minutes)

| # | Task as read to the participant | Watch for | Assumption or risk |
|---|---|---|---|
| T1 | "Set up the space you grow in, as it really is." | Do they enter dimensions? Do they know their sun hours? Do they pick "Not sure"? | A2, R1 |
| T2 | "Show where your pots and grow bags are." | Canvas vs objects list; do drag, resize and rotate make sense; overlap warnings understood | A1, R3 |
| T3 | "Find something you could plant this month." | Do they open Plant ideas? Do they read the reasons? Is "Sow now" the hook? Trust in "Not documented" | A3, R2, R8 |
| T4 | "Add it to one of your containers." | Do they notice the container-size warning? Do they understand it? | R2 |
| T5 | "What should you do for your plants today?" | Do they understand "Check the soil" as a check rather than an order? Mark done, skip with a reason | A4, R4 |
| T6 | "You'd like a reminder each morning. Set that up." | Permission prompt; reaction to one daily digest; preferred time | A4, R4 |
| T7 | "Note that your plant has flowered, with a photo." | Journal entry with photo; milestone chips | — |
| T8 | (P-A 55+) "Make the text bigger on your phone, then repeat T5." | Readability and tap targets at large text sizes | R6 |

## 4. Debrief questions

1. Do you think about your space as pots and grow bags or as an area? Which screen felt closer to how you think? (A1)
2. What would make you open this app every week? (A3)
3. Were the reminders helpful, or nagging? How often is right? (A4)
4. Which language would you prefer to use the app in? (A5)
5. Is there anything you would pay for: weather-aware advice, help diagnosing a sick plant, expert help? Or would you rather buy seeds and kits through the app? (A6)
6. Was any advice wrong for your area or experience? (R2, R8). Write down the exact plant and claim, and check it against `gardening-references.md`.

## 5. What to measure

- Task success (unaided, with a hint, failed) and time per task.
- How often participants choose "Not sure" in onboarding (R1).
- Whether they created a layout at all (R1).
- Mistakes about watering: did anyone read "Check the soil" as "water now"? Each one is a critical finding.
- Every horticultural objection, recorded verbatim with the plant and the region.

## 6. After the sessions

- Add findings to `docs/quality/known-issues.md` (usability: new KI rows) and decisions to the PRD.
- Any horticultural objection: check the source; if the data is wrong, fix the catalogue and add a test.
- Before any public release: a horticulturist reviews the catalogue and care defaults (R2), the research gaps KI-010..KI-013 are closed, and plant images are licensed (KI-016).
