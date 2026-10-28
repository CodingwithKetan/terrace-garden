# Monetisation: Terrace Garden Plus

Last updated: 2026-10-29. Decision record: ADR-028. Competitor evidence: `docs/research/competitor-analysis.md` Part E.

## 1. Principle

**Everything that keeps a plant alive is free.** Plus pays for room and keepsakes, not for safety or care. People garden on small budgets, and paywalled care is the most common complaint in this category (Part E3).

## 2. Free vs Plus

| Always free | Plus adds |
|---|---|
| Soil checks, care plans and reminders | Unlimited gardens (free: 1) |
| The sourced plant library, Seasons, pet safety, skin-use notes | Unlimited journal photos (free: 60) |
| Pest guide | Then-and-now photo comparison |
| One garden with its to-scale layout and plant ideas | Garden report (one page, shared as an image) |
| Journal with up to 60 photos, milestones and harvests | |
| Export and delete all data | |
| English and Hindi | |

Limits live in one place: `PlanLimits` and `Entitlements` in `lib/features/subscription/domain/plan.dart`.

**Never paywalled:** anything about safety (pet toxicity, pest and spray cautions, skin cautions, structural warnings), data export and deletion, and languages.

**Promise shown on the Plus screen:** "We will never move a free feature behind Plus." Moving released free features behind a paywall drew complaints (Seed to Spoon, Part E3), so this promise is binding (ADR-028).

## 3. Prices (planned; Google Play sets the shown price)

| Product | Planned price | Play product ID |
|---|---|---|
| Monthly | ₹49 | `terrace_plus_monthly` (subscription) |
| Yearly | ₹399 | `terrace_plus_yearly` (subscription) |
| Lifetime | ₹999 | `terrace_plus_lifetime` (one-time in-app product) |

**Why these numbers** (Part E1, Indian App Store prices):
- Monthly plans in this category cost about ₹500–1,000 (Planta ₹649, Blossom ₹599, Fryd ₹999). ₹49 is less than a tenth of that.
- Yearly plans run ₹1,199–4,999 (Planter, Planta, Fryd). ₹399 a year is under a third of the lowest.
- Lifetime: Planter charges ₹7,900–9,900. Reviewers praise one-time purchases (Part E3), so ₹999 lifetime is offered.
- **No free trial.** Trials that turn into annual charges are a top complaint. With a real free tier, a trial adds risk without value. No card is ever needed for the free tier.
- **No weekly plans, and the yearly price is never shown as a monthly equivalent.**

These are starting points. Revisit after the first 3 months of Play data: conversion, refunds, and reviews mentioning price.

## 4. Store and policy requirements

The Plus screen follows these rules:
- auto-renewal is stated in plain words next to the prices;
- how to cancel (Google Play → Payments and subscriptions), plus a "Manage subscription" link;
- Plus stays on until the end of the paid period;
- "Restore purchases";
- terms in English and Hindi.

**Before selling:**
1. Create the three products in Play Console with the prices above, publishing an internal-testing build signed with the release key (KI-038).
2. Test purchase, cancel, restore and the lifetime product with licence testers on a device.
3. Add the subscription terms and a privacy policy to the store listing.
4. Decide on server-side purchase verification (KI-037).

## 5. How it works

- `PurchaseService` (domain interface) and `PlayPurchaseService` (`in_app_purchase`):
  - active purchases come from `queryPastPurchases`;
  - pending purchases are completed;
  - the last known plan is cached in SharedPreferencesAsync, so the app works offline.
- `currentPlanProvider` is warmed at launch, and `requirePlus()` awaits it, so a Plus user never sees a limit while the plan loads.
- Gates:
  - New garden (`canAddGarden`);
  - Adding journal photos (`canAddJournalPhotos`; picks are trimmed to the photos left);
  - Compare (`photoComparison`);
  - Garden report (`gardenReport`).
  Each shows a calm upgrade sheet with "See Plus" and "Not now"; nothing is blocked mid-task.
- If Play is unavailable, or the products don't exist yet, the Plus screen says "Plus isn't on sale yet", and everything free keeps working.

## 6. Later (not built)

Candidates that would need a server and therefore a cost to cover:
- cloud backup and sync;
- family sharing;
- weather-adjusted care;
- photo identification.

Each needs value, cost and a privacy review first (Phase 7). Partnerships (nurseries, kits) are an alternative to raising prices.
