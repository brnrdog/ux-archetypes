---
id: pricing-table
title: Pricing Table
layer: block
version: 1.0.0
status: stable
summary: A side-by-side comparison of plans and their features to help a visitor choose.
since: 0.4.0
updated: 2026-07-17
tags: [marketing, pricing, comparison, conversion]
aliases: [plan-comparison, pricing-cards, tiers]
composedOf: [card, badge, button, switch, toggle-group, table]
usedBy: [landing-page, pricing]
related: [pricing, card, table]
maintainers: [brnrdog]
---

# Pricing Table

## Intent

A pricing table lays out plans side by side so a visitor can compare what each
costs and includes, then choose. It makes differences legible at a glance,
highlights a recommended plan to guide the decision, and answers the practical
questions — price, billing period, and what's in each tier — that gate a purchase.

## When to use / When not to use

**Use when**
- Presenting two or more plans a visitor compares before selecting.

**Avoid when**
- There is a single plan/price — state it plainly.
- The full matrix would overwhelm before the summary — lead with plan cards.

## Anatomy

- **Billing toggle** (optional) — monthly/annual switch that updates all prices.
- **Plan columns/cards** (required) — name, price, short pitch, and a call to
  action per plan.
- **Recommended highlight** (optional) — a badge and emphasis on one plan.
- **Feature rows** (required) — a per-feature comparison (included, limited, or
  absent) across plans.
- **Footnotes** (optional) — caveats, limits, and definitions.

## States & behavior

- **Billing switch** — toggling monthly/annual updates prices and shows savings.
- **Recommended** — one plan emphasized to steer choice.
- **Per-plan CTA** — reflects state (start, upgrade, contact sales).
- **Currency/locale** (optional) — prices adapt.

## Variants

- **Cards** — plans as side-by-side cards with key features.
- **Matrix** — a full feature-by-plan table.
- **Cards + matrix** — summary cards above a detailed table.

## Layout & responsiveness

Plans sit in a row on wide screens with the recommended plan emphasized; they
stack into a single column on small screens, keeping the recommended plan
prominent. A full matrix scrolls horizontally or restructures per plan on narrow
widths.

## Accessibility

- **Semantics** — a real table with header associations (plans as columns,
  features as rows), or clearly-structured cards.
- **Billing toggle** — its effect on prices is announced.
- **Keyboard** — the toggle and every plan CTA are operable.
- **Non-color emphasis** — the recommended plan and included/excluded cells are
  distinguished by more than color.

## Content guidelines

- Make prices, billing period, and included features easy to compare.
- Keep feature rows parallel; define limits clearly.
- One specific CTA verb per plan.

## Composition

**Composed of:** card, badge, button, switch / toggle-group (billing), table.

**Used by:** landing-page, pricing.

## Do / Don't

**Do**
- Highlight a recommended plan honestly.
- Show billing period and real costs up front.

**Don't**
- Hide limits or fees, or use dark patterns to force a plan.
- Lead with an exhaustive matrix before a scannable summary.

## References

- Nielsen Norman Group — pricing and plan-comparison usability.
