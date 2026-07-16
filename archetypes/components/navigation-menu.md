---
id: navigation-menu
title: Navigation Menu
layer: component
version: 1.0.0
status: stable
summary: A primary navigation control whose items can open rich flyout panels of links.
since: 0.2.0
updated: 2026-07-16
tags: [navigation, menu, wayfinding, flyout]
aliases: [mega-menu, nav-menu, flyout-nav]
composedOf: [link, popover, separator]
usedBy: [navbar, landing-page]
related: [navbar, menubar, dropdown-menu, tabs]
maintainers: [brnrdog]
---

# Navigation Menu

## Intent

A navigation menu presents a product's primary destinations, where top-level items
can reveal flyout panels grouping related links (a "mega menu"). It scales site
navigation beyond a flat row, organizing many destinations into browsable
categories while keeping the top level clean.

## When to use / When not to use

**Use when**
- A site has several sections, each with multiple destinations worth previewing.
- You want categorized flyouts rather than a flat link row.

**Avoid when**
- Navigation is a handful of links — a simple **navbar** row is enough.
- Items are application commands — use a **menubar**.
- Items switch views in place — use **tabs**.

## Anatomy

- **Menu list** (required) — top-level items.
- **Triggers** (required) — items that open a panel vs. plain links.
- **Flyout panels** (conditional) — grouped links, optionally with descriptions
  and featured content.
- **Active indicator** (required) — current section.

## States & behavior

- **Closed / open panel** — hover or focus/click opens; only one panel at a time.
- **Pointer intent** — small delays prevent flicker as the pointer moves.
- **Dismiss** — `Escape`, outside click, or moving away.

Keyboard opens and traverses panels; the current section stays indicated.

## Variants

- **Simple links** — no flyouts.
- **Mega menu** — multi-column grouped panels with rich content.
- **Mixed** — some items link directly, others open panels.

## Layout & responsiveness

Horizontal top-level items with panels dropping beneath, aligned and collision-
aware. On small screens it collapses into a drawer/accordion navigation. Panels
reflow columns to fit width.

## Accessibility

- **Keyboard** — items and panel links are reachable and operable; open/close and
  traverse by keyboard; Esc closes and restores focus.
- **Semantics** — a navigation landmark; disclosure/menu semantics for panels with
  expanded state; current item marked.
- **Screen reader** — announces the landmark, items, panel state, and current
  location.
- **Pointer intent** — hover behavior has keyboard/focus equivalents.

## Content guidelines

- Group destinations under clear category labels.
- Keep top-level labels short; use panels for depth.

## Composition

**Composed of:** link, popover (flyout positioning), separator.

**Used by:** navbar, landing-page.

## Do / Don't

**Do**
- Provide keyboard and focus parity with hover.
- Keep one panel open at a time and indicate current section.

**Don't**
- Overstuff mega menus into unscannable walls of links.
- Rely on hover-only behavior.

## References

- WAI-ARIA Authoring Practices — Disclosure and menu navigation guidance.
