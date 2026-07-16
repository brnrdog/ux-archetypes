---
id: breadcrumb
title: Breadcrumb
layer: component
version: 1.0.0
status: stable
summary: A trail showing the current location within a hierarchy and the path back to the top.
since: 0.2.0
updated: 2026-07-16
tags: [navigation, wayfinding, hierarchy]
aliases: [breadcrumbs, path-nav]
composedOf: [link, separator, dropdown-menu]
usedBy: [dashboard, settings, data-table]
related: [navbar, pagination, tabs, sidebar]
maintainers: [brnrdog]
---

# Breadcrumb

## Intent

A breadcrumb shows where the current page sits within a hierarchy and offers a
one-click path back to any ancestor. It answers "where am I and how do I get
back," reinforcing structure in deep or nested products.

## When to use / When not to use

**Use when**
- Content is hierarchical and users navigate several levels deep.
- Users benefit from seeing and jumping to ancestor levels.

**Avoid when**
- The site is flat or the hierarchy is shallow — breadcrumbs add little.
- The list represents peers, not ancestry — use **tabs** or nav.

## Anatomy

- **Items** (required) — ancestor links from root to parent.
- **Separators** (required) — between items.
- **Current page** (required) — the last item, non-linking.
- **Overflow menu** (optional) — collapses middle levels when the trail is long.

## States & behavior

- **Default** — ancestors are links; the current item is inert.
- **Overflow** — middle items collapse into a menu on narrow widths.
- **Hover/focus** — standard link states on ancestors.

## Variants

- **Full trail** — all levels shown.
- **Collapsed** — root + overflow + current.
- **With icons** — small icons per level.

## Layout & responsiveness

A single horizontal line reading root → current. When it exceeds available width,
collapse middle items behind an overflow control rather than wrapping or
truncating the current item. Keep the current page always visible.

## Accessibility

- **Semantics** — a navigation landmark labeled as breadcrumb; the current item is
  marked as current.
- **Keyboard** — all links reachable and operable in order.
- **Screen reader** — announces the trail and current location.
- **Separators** — decorative separators are not announced as content.

## Content guidelines

- Use the same titles as the destinations.
- Keep labels short; the current page matches the page title.

## Composition

**Composed of:** link, separator, dropdown-menu (overflow).

**Used by:** dashboard, settings, data-table detail views.

## Do / Don't

**Do**
- Mark the current page and keep it visible.
- Collapse gracefully when the trail is long.

**Don't**
- Use breadcrumbs for a flat structure.
- Link the current page to itself.

## References

- WAI-ARIA Authoring Practices — Breadcrumb pattern.
