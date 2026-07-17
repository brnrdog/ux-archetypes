---
id: feature-grid
title: Feature Grid
layer: block
version: 1.0.0
status: stable
summary: A grid of concise, icon-led items that communicate a product's key features or benefits.
since: 0.4.0
updated: 2026-07-17
tags: [marketing, landing, section, features]
aliases: [feature-list, benefits-grid, feature-cards]
composedOf: [icon, card, typography]
usedBy: [landing-page]
related: [card, list]
maintainers: [brnrdog]
---

# Feature Grid

## Intent

A feature grid presents a product's key features or benefits as a scannable set of
short, parallel items — each an icon, a title, and a sentence. It lets a visitor
grasp the breadth of what's offered at a glance, framed as outcomes for the user
rather than a raw list of capabilities.

## When to use / When not to use

**Use when**
- Summarizing several comparable features or benefits on a marketing page.

**Avoid when**
- Features need deep, sequential explanation — use alternating feature sections.
- The items are a detailed spec comparison — use a table.

## Anatomy

- **Grid container** (required) — arranges items in columns.
- **Feature items** (required) — each with an icon, a short title, and a one-line
  description.
- **Item action** (optional) — a "learn more" link per feature.
- **Section heading** (optional) — introduces the set.

## States & behavior

- **Static** — presentational; items may link to detail.
- **Responsive reflow** — column count adapts to width.
- **Hover** (optional) — subtle emphasis on interactive items.

## Variants

- **Icon + text** — the compact default.
- **Cards** — each feature in a bordered card.
- **Two / three / four columns** — by content volume.

## Layout & responsiveness

Items lay out in an even grid that reduces columns as width shrinks, down to a
single column on small screens. Keep titles and descriptions parallel in length so
rows align and the set scans cleanly.

## Accessibility

- **Structure** — a list of items with real headings for each title.
- **Icons** — decorative icons are hidden from assistive tech; meaningful ones
  have text alternatives.
- **Keyboard** — any per-item links are reachable and operable.
- **Contrast** — text and icons meet contrast requirements.

## Content guidelines

- Frame each item as a user outcome; keep titles short and descriptions to a line.
- Use a consistent icon style across items.

## Composition

**Composed of:** icon, card (optional per-item), typography.

**Used by:** landing-page.

## Do / Don't

**Do**
- Keep items parallel and scannable.
- Lead with benefits, not internal feature names.

**Don't**
- Overload each item with a paragraph.
- Mix icon styles or wildly uneven item lengths.

## References

- Nielsen Norman Group — feature communication and scannability.
