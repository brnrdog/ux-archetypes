---
id: card
title: Card
layer: component
version: 1.0.0
status: stable
summary: A self-contained surface that groups related content and actions into a single unit.
since: 0.2.0
updated: 2026-07-16
tags: [container, surface, layout, grouping]
aliases: [tile, panel]
usedBy: [dashboard, landing-page, data-table, settings]
related: [alert, table, sheet]
maintainers: [brnrdog]
---

# Card

## Intent

A card groups related content and actions about a single subject into one bounded
surface, making it scannable and manipulable as a unit. Cards turn a page of
disparate information into a tidy set of digestible objects, and tile naturally
into grids and lists.

## API

```json
{
  "props": [],
  "slots": [
    {"name":"media","required":false},
    {"name":"header","required":false},
    {"name":"body","required":true},
    {"name":"actions","required":false},
    {"name":"overlays","required":false,"description":""}
  ],
  "states": ["default","hover","focus-visible"],
  "tokens": ["color.neutral.*","radius.lg"]
}
```

## When to use / When not to use

**Use when**
- Presenting a collection of like items (products, projects, stats) as units.
- Grouping a subject's summary and actions on a surface.

**Avoid when**
- Content is a dense, comparable dataset — a **table** reads better.
- The grouping adds a box without meaning — plain sections may suffice.

## Anatomy

- **Container / surface** (required) — the bounded region.
- **Media** (optional) — image or visual, often in a fixed ratio.
- **Header** (optional) — title, subtitle, and metadata.
- **Body** (required) — the primary content.
- **Actions / footer** (optional) — buttons or links.
- **Overlays** (optional) — badges, avatars, menus.

## States & behavior

- **Static** — a display container.
- **Interactive** (optional) — the whole card acts as a link/button with hover and
  focus states and a single clear primary target.
- **Selected** (optional) — in selectable grids.
- **Loading** — a skeleton mirrors the card's shape.

## Variants

- **Content card** — media + text + actions.
- **Stat/metric card** — a KPI with supporting detail.
- **Interactive/link card** — the surface navigates or selects.
- **Elevated vs. outlined** — emphasis via shadow or border.

## Layout & responsiveness

Cards tile into responsive grids or stack in a column, reflowing column count with
width. Internally, media, header, body, and footer stack vertically with
consistent padding. Keep footers/actions aligned across a set for a clean grid.

## Accessibility

- **Interactive cards** — expose a single clear control with an accessible name;
  avoid nesting multiple independent links that fragment the target.
- **Structure** — card titles participate in the page's heading order where
  appropriate.
- **Keyboard** — interactive cards are focusable and operable; focus is visible.
- **Media** — images carry text alternatives.

## Content guidelines

- One subject per card; lead with the most identifying information.
- Keep actions few and prioritize one primary action.

## Composition

```json
{
  "parts": [
    {"ref":"aspect-ratio","slot":"media","note":"constrains the media"},
    {"ref":"avatar","slot":"header","note":"identity"},
    {"ref":"typography","slot":"header","note":"title and subtitle"},
    {"ref":"badge","slot":"overlays","props":{"variant":"soft"}},
    {"ref":"separator","slot":"body","note":"divides sections"},
    {"ref":"button","slot":"actions","props":{"variant":"primary"}}
  ]
}
```

## Do / Don't

**Do**
- Keep one subject and a clear primary action per card.
- Align content zones consistently across a set.

**Don't**
- Nest many competing links inside an interactive card.
- Use cards for dense tabular comparison.

## References

- Nielsen Norman Group — cards and content grouping.
