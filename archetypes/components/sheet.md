---
id: sheet
title: Sheet
layer: component
version: 1.0.0
status: stable
summary: A panel that slides in from a screen edge for secondary content or tasks alongside the page.
since: 0.2.0
updated: 2026-07-16
tags: [overlay, panel, side, task]
aliases: [side-panel, slide-over, off-canvas]
composedOf: [scroll-area, button, separator]
usedBy: [dashboard, data-table, settings]
related: [dialog, drawer, sidebar, popover]
maintainers: [brnrdog]
---

# Sheet

## Intent

A sheet slides a panel in from an edge of the screen (commonly the side) to host
secondary content or a task while keeping the page context adjacent. It's roomier
than a popover and less interruptive than a centered dialog — ideal for details,
filters, or edit forms that relate to what's on screen.

## When to use / When not to use

**Use when**
- Showing supplementary content or a task beside the current page (details,
  filters, quick edit).
- The content is taller than wide and benefits from an edge panel.

**Avoid when**
- The task demands full focus and centering — use a **dialog**.
- It's a mobile bottom, gesture-first panel — use a **drawer**.
- It's persistent primary navigation — use a **sidebar**.

## Anatomy

- **Overlay / scrim** (optional) — dims the page when modal.
- **Panel** (required) — slides from top/right/bottom/left.
- **Header** (required) — title and close.
- **Content** (required) — scrollable body.
- **Footer** (optional) — actions.

## States & behavior

- **Open / closed** — animated slide from the chosen edge.
- **Modal vs. non-modal** — blocks the page or leaves it usable.
- **Scrolling** — long content scrolls within the panel.
- **Dismiss** — close control, `Escape`, or scrim click.

## Variants

- **Right / left / top / bottom** placement.
- **Modal / non-modal**.
- **Sizes** — from a defined width/height scale.

## Layout & responsiveness

Anchored to an edge with a constrained size; content scrolls while header/footer
stay reachable. On small screens it may expand to full width or become a drawer.

## Accessibility

- **Semantics** — a dialog (modal when it blocks) with an accessible name.
- **Keyboard** — focus moves in on open, is trapped when modal, and returns on
  close; `Escape` closes.
- **Screen reader** — announces open/close and purpose; background inert when modal.
- **Motion** — respects reduced-motion.

## Content guidelines

- Give the sheet a clear title and a visible close.
- Keep it focused on content related to the current context.

## Composition

**Composed of:** scroll-area, button, separator.

**Used by:** dashboard, data-table (filters/details), settings.

## Do / Don't

**Do**
- Manage focus and provide an explicit close.
- Choose the edge that fits the content shape.

**Don't**
- Use a modal sheet where the page must stay interactive.
- Confuse a task sheet with persistent navigation.

## References

- WAI-ARIA Authoring Practices — Dialog (Modal) pattern.
