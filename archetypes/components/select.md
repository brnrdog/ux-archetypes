---
id: select
title: Select
layer: component
version: 1.0.0
status: stable
summary: A control that opens a list for choosing one option (or several) from a defined set.
since: 0.2.0
updated: 2026-07-16
tags: [form, selection, dropdown, control]
aliases: [dropdown, picker, listbox]
composedOf: [popover, scroll-area, separator, checkbox]
usedBy: [form, field, data-table, pagination]
related: [combobox, dropdown-menu, radio-group]
maintainers: [brnrdog]
---

# Select

## Intent

A select lets users choose from a defined set of options by opening a list and
picking one (or several). It conserves space compared to showing all options and
suits sets too long for radios but not large enough to need typed filtering.

## When to use / When not to use

**Use when**
- Choosing from a moderate, fixed set of options where space is limited.

**Avoid when**
- The set is very large or benefits from typing to filter — use a **combobox**.
- There are only a few options worth showing at once — use a **radio-group**.
- The list contains actions, not values — use a **dropdown-menu**.

## Anatomy

- **Trigger** (required) — shows the current value and opens the list.
- **Listbox** (required) — the scrollable set of options.
- **Options** (required) — selectable items, possibly grouped, with a selected
  indicator.
- **Placeholder** (optional) — when nothing is selected.
- **Multi-select indicators** (conditional) — checkboxes/chips.

## States & behavior

- **Closed / open** — trigger shows value; list opens on click/keyboard.
- **Highlighted option** — moves with arrows; typeahead jumps to matches.
- **Selection** — single (closes on pick) or multiple (stays open, shows count).
- **Disabled options** — skipped in navigation.

## Variants

- **Single-select** — one value.
- **Multi-select** — several values with a summary/chips.
- **Grouped** — options under labeled groups.

## Layout & responsiveness

The trigger sizes to its field; the list anchors to it, flips to stay in view, and
scrolls when long. On small screens the list may present as a sheet for larger
targets. The selected option is scrolled into view on open.

## Accessibility

- **Keyboard** — open with Enter/Space/Down; arrows move; typeahead; Enter selects;
  Esc closes; Home/End jump.
- **Semantics** — a listbox with the expanded state on the trigger and selected
  state per option; group labels exposed.
- **Screen reader** — announces the current value, active option, and selection.
- **Focus** — returns to the trigger on close; highlight tracks the active option.

## Content guidelines

- Order options predictably (logical or alphabetical); label groups clearly.
- Use a placeholder that states the choice ("Select a country").

## Composition

**Composed of:** popover, scroll-area, separator, checkbox (multi-select).

**Used by:** form, field, data-table (filters), pagination (page size).

## Do / Don't

**Do**
- Support keyboard navigation and typeahead.
- Show the selected value clearly on the trigger.

**Don't**
- Use a select for a huge list better served by a combobox.
- Put actions in a select.

## References

- WAI-ARIA Authoring Practices — Listbox and Select-Only Combobox patterns.
