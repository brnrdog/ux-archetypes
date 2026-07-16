---
id: sidebar
title: Sidebar
layer: component
version: 1.0.0
status: stable
summary: A persistent vertical navigation region alongside the main content of an application.
since: 0.2.0
updated: 2026-07-16
tags: [navigation, layout, application, wayfinding]
aliases: [side-nav, nav-rail, app-sidebar]
composedOf: [link, button, collapsible, avatar, separator, badge, scroll-area]
usedBy: [dashboard, settings]
related: [navbar, navigation-menu, sheet, drawer]
maintainers: [brnrdog]
---

# Sidebar

## Intent

A sidebar provides persistent, vertically-organized navigation beside an
application's content, scaling to many sections and nested groups. It's the primary
wayfinding surface for product/app shells where a horizontal navbar would run out
of room, keeping destinations always visible or a click away.

## When to use / When not to use

**Use when**
- An application has many sections or nested navigation that needs to stay present.
- Vertical space for grouped, scrollable navigation suits the product.

**Avoid when**
- Navigation is a few marketing links — use a **navbar**.
- The panel is a transient task surface — use a **sheet**/**drawer**.

## Anatomy

- **Container / rail** (required) — the persistent vertical region.
- **Brand / header** (optional) — logo or workspace switcher.
- **Navigation groups** (required) — sections with items, optionally collapsible.
- **Nav items** (required) — links with icons, labels, and optional badges.
- **Active indicator** (required) — current destination.
- **Footer** (optional) — account, settings, collapse control.
- **Collapse toggle** (optional) — expand/collapse to an icon rail.

## States & behavior

- **Expanded / collapsed (rail)** — full labels vs. icons only, with tooltips when
  collapsed.
- **Group expand/collapse** — nested sections toggle.
- **Active item** — current location marked.
- **Mobile** — becomes an off-canvas drawer behind a toggle.

## Variants

- **Full sidebar** — icons + labels.
- **Icon rail** — compact, icon-only with tooltips.
- **Multi-level** — nested collapsible groups.
- **Dual (rail + panel)** — a slim rail plus a contextual panel.

## Layout & responsiveness

Fixed to a side, full height, with a scrollable navigation region and pinned
header/footer. It collapses to a rail on medium widths and to an off-canvas drawer
on small screens. Content area adjusts to the sidebar's width.

## Accessibility

- **Semantics** — a navigation landmark with an accessible name; current item
  marked; collapsible groups expose expanded state.
- **Keyboard** — all items and toggles reachable and operable; logical order.
- **Screen reader** — announces the landmark, groups, items, and current location;
  collapsed-rail items retain accessible names.
- **Focus** — visible focus; when it becomes a drawer, focus is managed and trapped.

## Content guidelines

- Group destinations meaningfully with short, distinct labels.
- Keep icons paired with labels; ensure collapsed icons have names.

## Composition

**Composed of:** link, button, collapsible, avatar, separator, badge, scroll-area.

**Used by:** dashboard, settings / application shells.

## Do / Don't

**Do**
- Keep the current location obvious and navigation scannable.
- Provide accessible names for collapsed icon items.

**Don't**
- Cram every action into the sidebar.
- Lose current-location context when collapsed.

## References

- WAI-ARIA Authoring Practices — landmark and disclosure guidance.
