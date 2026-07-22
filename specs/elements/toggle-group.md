---
id: toggle-group
title: Toggle Group
layer: element
version: 1.0.0
status: stable
summary: A set of toggles acting as a single control for single- or multi-selection.
since: 0.2.0
updated: 2026-07-16
tags: [control, toolbar, selection, segmented]
implementation: ToggleGroup.res
aliases: [segmented-control, button-group-toggle]
composedOf: [toggle]
usedBy: [toolbar, menubar, data-table]
related: [toggle, radio-group, tabs, button-group]
traits: [roving-focus]
maintainers: [brnrdog]
---

# Toggle Group

## Intent

A toggle group binds several toggles into one control so the user can pick one
option (single-select, like a segmented control) or several (multi-select, like a
formatting toolbar). It communicates that the options belong together and are
governed as a set.

## API

```json
{
  "responsive": {
    "container": false,
    "minTarget": "44px",
    "reflow": [
      {
        "at": "sm",
        "pattern": "wrap",
        "note": "segments wrap when they exceed the row"
      }
    ]
  },
  "props": [
    {"name":"type","type":"enum","values":["single","multiple"],"default":"single","description":"One or many selections."},
    {"name":"value","type":"string","default":"","description":"Selected item id(s)."},
    {"name":"disabled","type":"boolean","default":"false","description":"Disables the group."}
  ],
  "slots": [
    {"name":"item","required":true,"description":"A toggle within the group."}
  ],
  "events": ["onChange"],
  "a11y": {"role":"group","keyboard":["ArrowLeft","ArrowRight"],"announces":["pressed"]},
  "states": ["default","selected","focus-visible","disabled"],
  "tokens": ["color.action.*","radius.md"]
}
```

## When to use / When not to use

**Use when**
- Grouping related on/off tools (text alignment, formatting).
- Offering a compact single choice among a few options (segmented control).

**Avoid when**
- Options are navigational views — use **tabs**.
- The exclusive choice is a form field with labels — a **radio-group** reads clearer.

## Anatomy

- **Group container** (required) — with an accessible group name.
- **Toggle items** (required) — each a toggle with icon/label.
- **Selection mode** (required) — single or multiple.

## States & behavior

- **Single-select** — choosing one clears the others (segmented behavior).
- **Multi-select** — items toggle independently.
- **Disabled** — group or individual items.

Arrow keys move focus within the group; the group is a single tab stop.

## Variants

- **Single (segmented)** — exactly one active.
- **Multiple** — any number active.
- **Icon / label / mixed** items.

## Layout & responsiveness

Items sit flush in a row as a unified control with shared borders/rounding at the
ends. On narrow widths, allow wrapping or scrolling rather than shrinking targets
below usable size.

## Accessibility

- **Keyboard** — single tab stop; arrows move between items; `Space`/`Enter` activates.
- **Semantics** — a named group; items expose pressed (multi) or selected (single)
  state appropriately.
- **Screen reader** — announces group name, item, and state.
- **Focus** — visible focus on the active item.

## Content guidelines

- Keep item labels short and parallel.
- Provide accessible names for icon-only items.

## Composition

**Composed of:** toggle.

**Used by:** toolbars, menubar, data-table (view switches).

## Do / Don't

**Do**
- Make selection mode obvious and consistent.
- Treat the group as one control for keyboard users.

**Don't**
- Use it for navigation between views (that's tabs).

## References

- WAI-ARIA Authoring Practices — Toolbar and toggle button guidance.
