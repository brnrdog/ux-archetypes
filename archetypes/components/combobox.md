---
id: combobox
title: Combobox
layer: component
version: 1.0.0
status: stable
summary: A text input paired with a filtered list of suggestions for selecting a value.
since: 0.2.0
updated: 2026-07-16
tags: [form, selection, search, autocomplete]
aliases: [autocomplete, typeahead, searchable-select]
composedOf: [input, popover, scroll-area, badge]
usedBy: [form, field, command, data-table]
related: [select, command, input, dropdown-menu]
traits: [dismissible, anchored, typeahead]
maintainers: [brnrdog]
---

# Combobox

## Intent

A combobox combines a text input with a dynamically filtered list, letting users
either type to narrow options or browse and pick one. It scales selection to large
option sets where a plain select would be unwieldy, and supports free-form entry
when allowed.

## When to use / When not to use

**Use when**
- Choosing from many options where typing to filter helps.
- You want search + selection in one control, optionally allowing new values.

**Avoid when**
- The option set is small and fixed — a **select** or **radio-group** is simpler.
- You're issuing commands, not picking a value — use **command**.

## Anatomy

- **Text input** (required) — accepts the query.
- **Toggle / trigger** (optional) — opens the list without typing.
- **Popover list** (required) — filtered options in a scrollable region.
- **Options** (required) — selectable items, possibly grouped, with highlight of
  the query match.
- **Selected indicator / tokens** (conditional) — check for single, chips for multi.
- **Empty & loading states** (required) — "no results" and async loading.

## States & behavior

- **Closed / open** — list toggled by typing, click, or keyboard.
- **Filtering** — options narrow to the query; async sources show loading.
- **Highlighted option** — moves with arrow keys independent of focus.
- **Selection** — single (fills the input) or multiple (chips), clearable.
- **No results** — explicit empty state, optionally offering to create the value.

## Variants

- **Single / multi-select**.
- **Free-solo** — allows values not in the list.
- **Async** — options fetched as the user types.

## Layout & responsiveness

The input anchors a popover list sized to the trigger, flipping when space is
tight. On small screens the list may present as a full-height sheet. The list
scrolls; the selected/highlighted item stays in view.

## Accessibility

- **Keyboard** — type to filter; arrows move the highlight; Enter selects; Esc
  closes; Home/End jump.
- **Semantics** — a combobox exposing expanded state, the controlled listbox, and
  the active option; selection state per option.
- **Screen reader** — announces the active option, result counts, and selection.
- **Focus** — focus stays in the input; visible highlight tracks the active option.

## Content guidelines

- Placeholder hints the action ("Search framework…").
- Provide a helpful empty state and, if allowed, a "create" affordance.

## Composition

**Composed of:** input, popover, scroll-area, badge (multi-select tokens).

**Used by:** form, field, command, data-table (filters).

## Do / Don't

**Do**
- Support keyboard filtering and selection fully.
- Show clear loading and empty states.

**Don't**
- Use a combobox for a handful of fixed options.
- Lose the user's query or selection on reopen.

## References

- WAI-ARIA Authoring Practices — Combobox pattern.
