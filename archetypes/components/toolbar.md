---
id: toolbar
title: Toolbar
layer: component
version: 1.0.0
status: stable
summary: A grouped row of controls that act on the current view or selection.
since: 0.3.0
updated: 2026-07-17
tags: [actions, controls, editor, grouping]
aliases: [action-bar, command-bar, tool-strip]
composedOf: [button, icon-button, toggle, toggle-group, separator, dropdown-menu, input]
usedBy: [data-table, dashboard]
related: [button-group, menubar, navbar]
traits: [roving-focus]
maintainers: [brnrdog]
---

# Toolbar

## Intent

A toolbar gathers the controls that act on the current context — a document,
canvas, selection, or list — into one consistent strip. It keeps frequently used
actions visible and within reach, grouped by relationship, so users can operate
without hunting through menus.

## When to use / When not to use

**Use when**
- A view has a set of recurring actions (format, filter, sort, add, view options).
- Users benefit from persistent, at-a-glance access to those controls.

**Avoid when**
- Actions are a product's global commands — use a **menubar**.
- There is only a single action — a lone **button** is enough.

## Anatomy

- **Container** (required) — the horizontal (or vertical) strip.
- **Groups** (required) — related controls clustered together.
- **Controls** (required) — buttons, icon-buttons, toggles, toggle-groups,
  selects, and inputs.
- **Separators** (optional) — divide groups.
- **Overflow menu** (conditional) — collapses controls that don't fit.

## States & behavior

- **Contextual enablement** — controls enable/disable based on selection or state.
- **Toggle state** — view/format toggles reflect on/off or active option.
- **Overflow** — low-priority controls collapse into a menu on narrow widths.
- **Sticky** (optional) — remains visible while the content scrolls.

## Variants

- **Editor toolbar** — formatting/tool controls.
- **View toolbar** — search, filter, sort, and display options above a list/table.
- **Compact/overflow** — most controls behind an overflow menu.

## Layout & responsiveness

Controls lay out in a row with grouping and separators; a common pattern places
primary actions leading and view options trailing. As width shrinks, collapse
groups into overflow menus rather than shrinking targets below usable size.

## Accessibility

- **Semantics** — exposed as a toolbar with an accessible name; groups are
  conveyed.
- **Keyboard** — a single tab stop for the toolbar with arrow-key navigation
  between controls (roving focus), per the toolbar pattern.
- **Screen reader** — announces the toolbar, control names, and states.
- **Focus** — visible focus; overflow contents remain reachable.

## Content guidelines

- Group related controls; order by frequency and importance.
- Give every icon-only control an accessible name and tooltip.

## Composition

**Composed of:** button, icon-button, toggle, toggle-group, separator,
dropdown-menu, input.

**Used by:** data-table, dashboard, editors.

## Do / Don't

**Do**
- Support arrow-key navigation across the toolbar.
- Collapse gracefully into overflow when space is tight.

**Don't**
- Overload the strip so nothing stands out.
- Leave icon-only controls unlabeled.

## References

- WAI-ARIA Authoring Practices — Toolbar pattern.
