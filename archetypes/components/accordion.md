---
id: accordion
title: Accordion
layer: component
version: 1.0.0
status: stable
summary: A stack of headers that expand and collapse to reveal or hide sections of content.
since: 0.2.0
updated: 2026-07-16
tags: [disclosure, content, navigation, faq]
aliases: [expander, disclosure-group]
composedOf: [collapsible, separator]
usedBy: [landing-page, settings, sidebar]
related: [collapsible, tabs]
maintainers: [brnrdog]
---

# Accordion

## Intent

An accordion organizes related content into collapsible sections so users can
scan headers and expand only what they need. It reduces long pages to a
manageable overview and is a natural fit for FAQs and grouped settings.

## When to use / When not to use

**Use when**
- Content divides into labeled sections and users need only some at a time.
- Vertical space is limited and progressive disclosure helps scanning.

**Avoid when**
- Users need to compare sections side by side — use **tabs** or show all.
- There is a single collapsible region — use a **collapsible**.

## Anatomy

- **Items** (required) — each a header plus a collapsible panel.
- **Header/trigger** (required) — labels the section and toggles it; shows an
  expanded/collapsed affordance.
- **Panel** (required) — the revealed content.
- **Dividers** (optional) — separate items.

## States & behavior

- **Collapsed / expanded** — per item, toggled by the header.
- **Single vs. multiple open** — either one item at a time or several.
- **Disabled** — an item that can't be opened.

Expanding animates height; the header reflects state.

## Variants

- **Single-open** — opening one closes the others.
- **Multi-open** — any number expanded.
- **Bordered / flush** — visual framing options.

## Layout & responsiveness

Items stack full-width; panels push content below rather than overlaying it.
Works well on small screens as a space-saving disclosure. Avoid layout jumps by
animating height smoothly.

## Accessibility

- **Keyboard** — headers are focusable and toggle on `Enter`/`Space`; arrow keys
  may move between headers.
- **Semantics** — each header is a button controlling its panel, exposing
  expanded/collapsed and the relationship to the panel.
- **Screen reader** — announces the header, state, and that it controls a region.
- **Focus** — visible focus on headers.

## Content guidelines

- Write headers as concise, scannable labels or questions.
- Keep panel content self-contained.

## Composition

**Composed of:** collapsible (per item), separator.

**Used by:** landing-page (FAQ), settings, sidebar.

## Do / Don't

**Do**
- Let users open multiple sections when comparison helps.
- Keep headers descriptive and consistent.

**Don't**
- Hide critical content that everyone needs behind a collapse.
- Nest accordions deeply.

## References

- WAI-ARIA Authoring Practices — Accordion pattern.
