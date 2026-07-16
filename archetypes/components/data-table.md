---
id: data-table
title: Data Table
layer: component
version: 1.0.0
status: stable
summary: An interactive table for exploring rows of structured data with sorting, filtering, and paging.
since: 0.2.0
updated: 2026-07-16
tags: [data, table, list, crud, enterprise]
aliases: [datagrid, grid, table-view]
composedOf: [table, checkbox, input, combobox, pagination, dropdown-menu, button, badge, skeleton]
usedBy: [dashboard, settings]
related: [table, pagination, chart, card]
maintainers: [brnrdog]
---

# Data Table

## Intent

A data table lets users explore and act on collections of structured records:
sort, filter, paginate, select, and trigger row actions. It extends the static
table into a working surface for datasets too large to read at once, common in
admin and analytics contexts.

## When to use / When not to use

**Use when**
- Presenting many records with columns users compare, sort, filter, and act on.
- Bulk actions or row-level operations are needed.

**Avoid when**
- Data is small and simple — a static **table** or list is enough.
- Content is object-like and better browsed as **cards**.

## Anatomy

- **Table core** (required) — header and body rows/cells (the table archetype).
- **Column headers with sort** (required) — sortable indicators.
- **Toolbar** (optional) — search, filters, column visibility, view switches.
- **Row selection** (optional) — checkboxes and a bulk-action bar.
- **Row actions** (optional) — per-row menu.
- **Pagination or virtualized scroll** (required for large sets).
- **States** (required) — loading (skeleton rows), empty, and error.

## States & behavior

- **Sorting** — by column, single or multi, with clear direction indicators.
- **Filtering / search** — narrows rows; reflects active filters.
- **Selection** — per-row and select-all (with indeterminate parent).
- **Paging / virtualization** — moves through or streams large sets.
- **Loading / empty / error** — distinct, informative states.
- **Density / column config** (optional) — user-adjustable.

## Variants

- **Client-side** — sort/filter/page in the browser for modest sets.
- **Server-side** — operations fetched per page for large sets.
- **Editable** — inline cell editing.
- **Expandable rows** — detail panels per row.

## Layout & responsiveness

A toolbar above, the table in a horizontally scrollable region, and pagination
below. On narrow screens, allow horizontal scroll, pin key columns, or collapse
rows into stacked cards. Keep headers visible while scrolling.

## Accessibility

- **Semantics** — a proper table with header associations; sortable headers expose
  sort state; selection state is exposed.
- **Keyboard** — sorting, filtering, selection, paging, and row actions are all
  keyboard-operable; consider grid keyboard navigation for editable tables.
- **Screen reader** — announces sort changes, result/selection counts, and
  loading/empty states via live regions.
- **States** — empty and error states are conveyed as text, not just visuals.

## Content guidelines

- Right-align numeric columns; keep headers concise nouns.
- Write empty states that explain and offer a next step.

## Composition

**Composed of:** table, checkbox, input/combobox (filters), pagination,
dropdown-menu (row/column actions), button, badge, skeleton.

**Used by:** dashboard, settings/admin.

## Do / Don't

**Do**
- Provide clear loading, empty, and error states.
- Keep sort/filter/selection state visible and accessible.

**Don't**
- Paginate away context users need to compare.
- Hide bulk actions once rows are selected.

## References

- WAI-ARIA Authoring Practices — Table and Grid patterns.
