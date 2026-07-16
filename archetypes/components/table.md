---
id: table
title: Table
layer: component
version: 1.0.0
status: stable
summary: A grid of rows and columns for presenting structured, comparable data.
since: 0.2.0
updated: 2026-07-16
tags: [data, table, structure, comparison]
aliases: [data-grid-static, grid]
composedOf: [typography, badge, checkbox]
usedBy: [data-table, dashboard, card]
related: [data-table, card, chart]
maintainers: [brnrdog]
---

# Table

## Intent

A table arranges structured data into rows and columns so values align for easy
scanning and comparison across records and attributes. It is the clearest way to
present tabular information where relationships between columns matter; the
interactive **data-table** builds on it.

## When to use / When not to use

**Use when**
- Data is inherently tabular and users compare values across rows and columns.

**Avoid when**
- Items are object-like and better browsed as **cards**.
- You only need a simple vertical list — use a list.
- You need sorting/filtering/paging at scale — use a **data-table**.

## Anatomy

- **Column headers** (required) — name each column; may include units.
- **Rows** (required) — one record each.
- **Cells** (required) — values, aligned by data type.
- **Caption / title** (optional) — describes the table.
- **Row/column groups** (optional) — headers and footers, spanning cells.
- **Footer** (optional) — totals or summaries.

## States & behavior

- **Static display** — the base behavior.
- **Row emphasis** (optional) — zebra striping or hover highlighting for tracking.
- **Empty** — a clear message when there are no rows.

## Variants

- **Basic** — headers and rows.
- **With row/column groups** — multi-level headers.
- **Compact / comfortable** density.
- **With totals footer**.

## Layout & responsiveness

Columns size to content or a defined layout; numeric columns right-align for
comparison. When too wide, allow horizontal scroll within a bounded region, pin key
columns, or restructure rows into stacked blocks on small screens. Keep headers
associated with data when scrolling.

## Accessibility

- **Semantics** — real table structure with header cells associated to data cells;
  a caption where helpful; scope for row/column headers.
- **Screen reader** — announces headers with cells so context is preserved.
- **Reading order** — logical and preserved across responsive transforms.
- **Contrast** — striping/highlighting meets contrast and doesn't obscure text.

## Content guidelines

- Headers are concise nouns; align data types consistently.
- Provide a meaningful empty state.

## Composition

**Composed of:** typography, badge (status cells), checkbox (selection when
extended).

**Used by:** data-table (as its core), dashboard, card.

## Do / Don't

**Do**
- Use genuine table semantics with header associations.
- Right-align numbers for comparison.

**Don't**
- Fake a table with generic containers that lose semantics.
- Use a table purely for visual layout.

## References

- WAI-ARIA Authoring Practices — Table pattern; WCAG Info and Relationships.
