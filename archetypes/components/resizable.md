---
id: resizable
title: Resizable Panels
layer: component
version: 1.0.0
status: stable
summary: Adjacent panels separated by draggable handles that let users redistribute space.
since: 0.2.0
updated: 2026-07-16
tags: [layout, panels, split, workspace]
aliases: [split-pane, split-view, resizable-panels]
composedOf: [separator, scroll-area]
usedBy: [dashboard, data-table]
related: [sidebar, scroll-area, separator]
maintainers: [brnrdog]
---

# Resizable Panels

## Intent

Resizable panels divide a region into two or more areas separated by draggable
handles, letting users decide how to split available space — a file tree beside an
editor, a list beside a detail pane. It hands layout control to the user for
workspace-style interfaces where preferred proportions vary.

## When to use / When not to use

**Use when**
- A workspace benefits from user-controlled proportions between adjacent regions.
- Users want to expand one area at the expense of another.

**Avoid when**
- A fixed or simply responsive layout serves users better.
- The secondary area is navigation that collapses — use a **sidebar**.

## Anatomy

- **Panels** (required) — two or more adjacent regions.
- **Handles / dividers** (required) — draggable separators between panels.
- **Min/max constraints** (required) — bounds each panel's size.
- **Collapse affordance** (optional) — snap a panel closed/open.

## States & behavior

- **Dragging** — the handle resizes neighboring panels within constraints.
- **At min/max** — resizing stops at bounds; a panel may collapse at its minimum.
- **Persisted** — remembers sizes across sessions where appropriate.

Keyboard focus on a handle allows resizing by arrow keys.

## Variants

- **Horizontal / vertical** splits.
- **Nested** — panels within panels (grid workspaces).
- **Collapsible panels** — snap to hidden.

## Layout & responsiveness

Panels fill the container and share space per the handles. On small screens,
splits often stack or one panel collapses to preserve usability. Respect minimum
sizes so no panel becomes unusable.

## Accessibility

- **Keyboard** — handles are focusable and resize via arrow keys; provide a way to
  reset or collapse.
- **Semantics** — each handle exposes a separator role with orientation and current
  value/bounds.
- **Screen reader** — announces the handle, orientation, and resulting sizes.
- **Focus** — visible focus on handles; adequate handle hit area.

## Content guidelines

- Set sensible minimums so content stays usable.
- Indicate collapsible handles clearly.

## Composition

**Composed of:** separator (handles), scroll-area (panel content).

**Used by:** dashboard, data-table (list/detail workspaces).

## Do / Don't

**Do**
- Support keyboard resizing and reasonable minimums.
- Persist user-chosen sizes when it helps.

**Don't**
- Allow panels to shrink into uselessness.
- Rely on drag alone with no keyboard path.

## References

- WAI-ARIA Authoring Practices — Window Splitter pattern.
