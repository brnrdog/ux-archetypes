---
id: pagination
title: Pagination
layer: component
version: 1.0.0
status: stable
summary: Controls for moving through content split across multiple pages.
since: 0.2.0
updated: 2026-07-16
tags: [navigation, data, list, paging]
aliases: [pager, page-nav]
composedOf: [button, link, select]
usedBy: [data-table, table, dashboard]
related: [data-table, table, breadcrumb]
maintainers: [brnrdog]
---

# Pagination

## Intent

Pagination breaks a long set of results into pages and gives users controls to
move among them. It bounds how much loads and renders at once, and lets users
orient themselves ("page 3 of 20") within a large collection.

## When to use / When not to use

**Use when**
- A result set is too large to show at once and discrete pages aid orientation.
- Users benefit from jumping to specific pages or knowing totals.

**Avoid when**
- Continuous browsing suits better — consider infinite scroll or "load more"
  (with their own trade-offs).
- The list is short enough to show fully.

## Anatomy

- **Previous / next** (required) — step controls, disabled at bounds.
- **Page numbers** (optional) — direct jumps, with ellipses for large ranges.
- **Current-page indicator** (required) — the active page.
- **Page size selector** (optional) — items per page.
- **Range/total summary** (optional) — "showing 21–40 of 320".

## States & behavior

- **At first / last page** — boundary controls disabled.
- **Active page** — clearly marked and non-interactive as a jump.
- **Truncation** — middle pages collapse into ellipses for long ranges.
- **Loading** — the region indicates fetching on page change.

## Variants

- **Numbered** — full page links with truncation.
- **Prev/next only** — minimal stepping.
- **Load more / infinite** — progressive loading (related pattern).

## Layout & responsiveness

A horizontal control group, centered or trailing. On narrow screens, reduce to
prev/next plus current indicator. Keep targets tappable and the current page
obvious.

## Accessibility

- **Semantics** — a navigation landmark labeled as pagination; the current page is
  marked; disabled controls are conveyed as such.
- **Keyboard** — all controls reachable and operable in order.
- **Screen reader** — announces page changes and current position (e.g. via a live
  region) so context isn't lost.

## Content guidelines

- Label controls clearly ("Previous page"); show totals when helpful.
- Keep page-size options sensible and few.

## Composition

**Composed of:** button/link (controls), select (page size).

**Used by:** data-table, table, dashboard lists.

## Do / Don't

**Do**
- Indicate the current page and disable boundary controls.
- Announce page changes to assistive tech.

**Don't**
- Hide totals when users need to gauge scope.
- Make number targets too small on touch.

## References

- WAI-ARIA Authoring Practices — navigation landmark guidance.
