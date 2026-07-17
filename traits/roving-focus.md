---
id: roving-focus
title: Roving Focus
summary: A group of related controls exposes a single tab stop; arrow keys move focus among the items.
version: 1.0.0
since: 0.6.0
updated: 2026-07-17
---

# Roving Focus

## Contract

Roving focus (a "roving tabindex") applies to a homogeneous set of controls that
should feel like one widget — a tablist, toolbar, menu, radio group, or toggle
group. It keeps the `Tab` sequence short and makes intra-group movement fast.

- **Single tab stop** — only one item in the group is in the page tab order at a
  time; `Tab` moves past the whole group, not through every item.
- **Arrow navigation** — arrow keys move focus between items along the group's
  orientation (Left/Right for horizontal, Up/Down for vertical); the active item
  becomes the new tab stop.
- **Home / End** — jump to the first and last item.
- **Wrapping** — movement may wrap from last to first; wrapping is consistent
  within a group.
- **Remembered position** — leaving and returning with `Tab` restores focus to
  the last-active item (or the selected one, for single-select groups).

## Accessibility

- The group exposes an appropriate container role (e.g. tablist, toolbar,
  radiogroup, menu) and each item its matching role.
- Selection and focus are distinct: moving focus does not necessarily change
  selection unless the group's pattern is "selection follows focus".

## Notes for implementers

Roving focus often composes with **typeahead** for long lists and with
**anchored** + **dismissible** when the group lives inside a floating menu.
