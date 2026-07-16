---
id: separator
title: Separator
layer: element
version: 1.0.0
status: stable
summary: A thin divider that visually and semantically separates groups of content.
since: 0.2.0
updated: 2026-07-16
tags: [layout, divider, structure]
aliases: [divider, rule, hr]
composedOf: []
usedBy: [dropdown-menu, menubar, card, sidebar, navbar, list]
related: [scroll-area, aspect-ratio]
maintainers: [brnrdog]
---

# Separator

## Intent

A separator divides content into distinct groups, giving structure and rhythm
without adding a heavier container. It clarifies where one set of items ends and
another begins.

## When to use / When not to use

**Use when**
- Grouping items within a menu, list, toolbar, or card.
- Providing a light visual break between sections.

**Avoid when**
- Whitespace alone already communicates the grouping.
- You need an interactive boundary — use a **resizable** handle.

## Anatomy

- **Line** (required) — horizontal or vertical rule.
- **Optional label** (optional) — a caption breaking the line (e.g. "OR").

## States & behavior

Separators are static. A labeled separator centers text within the rule. Decorative
separators carry no semantics; meaningful ones expose a separator role.

## Variants

- **Horizontal** — between stacked sections.
- **Vertical** — between inline items in a toolbar or nav.
- **Labeled** — divider with centered text.

## Layout & responsiveness

Horizontal separators span their container's content width; vertical separators
match the height of adjacent inline items. Orientation may switch when a layout
reflows from row to column.

## Accessibility

- **Semantics** — purely decorative separators are hidden from assistive tech;
  meaningful ones expose a separator role with orientation.
- **Screen reader** — does not announce redundant dividers.
- **Contrast** — as non-text, keep it perceivable without being loud.

## Content guidelines

- Use labeled separators sparingly; keep labels to a word or two.

## Composition

**Composed of:** Not applicable — a primitive element.

**Used by:** dropdown-menu, menubar, card, sidebar, navbar, lists.

## Do / Don't

**Do**
- Prefer spacing first; add a separator when grouping needs reinforcing.
- Mark decorative separators as such.

**Don't**
- Stack multiple separators to create heavy borders.

## References

- WAI-ARIA Authoring Practices — Separator role.
