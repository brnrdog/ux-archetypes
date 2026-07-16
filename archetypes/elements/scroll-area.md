---
id: scroll-area
title: Scroll Area
layer: element
version: 1.0.0
status: stable
summary: A container that scrolls overflowing content with consistent, styleable scrollbars.
since: 0.2.0
updated: 2026-07-16
tags: [layout, scroll, container, overflow]
aliases: [scroll-container, scrollbox]
composedOf: []
usedBy: [dropdown-menu, command, sidebar, dialog, data-table]
related: [separator, resizable, aspect-ratio]
maintainers: [brnrdog]
---

# Scroll Area

## Intent

A scroll area confines overflowing content to a bounded region with predictable,
consistently-styled scrollbars across platforms. It keeps long lists, menus, and
panels contained without letting the whole page scroll.

## When to use / When not to use

**Use when**
- A region's content can exceed its bounds (long menus, chat logs, side panels).
- You need consistent scrollbar appearance and behavior across platforms.

**Avoid when**
- The main page should scroll naturally — don't trap the primary document.

## Anatomy

- **Viewport** (required) — the clipped, scrollable region.
- **Content** (required) — may exceed the viewport in one or both axes.
- **Scrollbar(s) & thumb** (required when overflowing) — indicate and control position.
- **Edge affordance** (optional) — fades/shadows hinting more content.

## States & behavior

- **No overflow** — scrollbars hidden.
- **Overflowing** — scrollbars appear; thumb reflects position and proportion.
- **Scrolling** — content moves; sticky headers may remain pinned.

Keyboard and wheel/trackpad scrolling both work; focus moving to an off-screen
item scrolls it into view.

## Variants

- **Vertical / horizontal / both**.
- **Overlay vs. inset** scrollbars.

## Layout & responsiveness

The area takes a bounded size from its context and scrolls the remainder. On
touch, native momentum scrolling is preserved; scrollbars may be thinner or
overlaid. Avoid nested scroll traps that confuse gesture direction.

## Accessibility

- **Keyboard** — the region is reachable and scrollable by keyboard; focusable
  descendants scroll into view.
- **Semantics** — a scrollable region is discoverable; it is labeled when its
  content warrants.
- **Focus** — never hide focused content behind the viewport edge.

## Content guidelines

- Hint at more content with an edge fade when discovery matters.

## Composition

**Composed of:** Not applicable — a layout primitive.

**Used by:** dropdown-menu, command, sidebar, dialog, data-table.

## Do / Don't

**Do**
- Keep focused items visible by scrolling them into view.
- Provide affordances that content continues beyond the fold.

**Don't**
- Trap the primary page scroll.
- Nest conflicting scroll regions.

## References

- WCAG — Reflow; keyboard operability of scrollable regions.
