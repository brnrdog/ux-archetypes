---
id: typeahead
title: Typeahead
summary: Typing printable characters moves focus (or selection) to the item whose label matches, for fast keyboard access in a list.
version: 1.0.0
since: 0.6.0
updated: 2026-07-17
---

# Typeahead

## Contract

Typeahead lets a keyboard user jump to an item in a list or menu by typing the
start of its label, instead of arrowing through every entry. It applies to
option lists, menus, and select-like controls.

- **Match on type** — pressing printable keys focuses the next item whose label
  begins with the typed string.
- **Buffering** — successive keystrokes within a short window accumulate into a
  query ("ge" → "Germany"); a pause resets the buffer.
- **Same-letter cycling** — repeatedly pressing one letter cycles through all
  items starting with it.
- **Non-destructive** — typeahead moves focus/active item only; it does not
  commit a selection on its own (that remains Enter/Space or click).
- **Wrap** — matching continues from the top after reaching the end.

## Accessibility

- Typeahead supplements, never replaces, arrow-key navigation (see the
  roving-focus trait) and pointer interaction.
- The matched item follows the group's normal focus/selection semantics so
  assistive tech announces it consistently.

## Notes for implementers

Typeahead is a refinement layered on a navigable collection; specify it wherever
a list can grow long enough that arrowing becomes tedious.
