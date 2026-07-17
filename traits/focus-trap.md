---
id: focus-trap
title: Focus Trap
summary: While a modal surface is open, keyboard focus is confined to it and restored to the trigger when it closes.
version: 1.0.0
since: 0.6.0
updated: 2026-07-17
---

# Focus Trap

## Contract

A focus trap applies to modal surfaces — those that demand resolution before the
user returns to the page beneath. It keeps keyboard focus inside the surface so
the user cannot silently interact with inert content behind it.

- **Confinement** — `Tab` and `Shift+Tab` cycle only through the focusable
  elements within the surface; focus wraps from last to first and back.
- **Initial focus** — on open, focus moves to the surface: the first meaningful
  control, or the surface container itself when there is none.
- **Restoration** — on close, focus returns to the element that opened the
  surface, so the user's place in the page is preserved.
- **Inert background** — content outside the surface is not focusable or
  interactive while the trap is active, and is hidden from assistive tech.

## Accessibility

- The surface exposes a dialog role and an accessible name.
- Screen-reader users must not be able to escape into the background; the trap
  and the inert marking must agree.

## Notes for implementers

Focus-trap composes with **dismissible**: dismissal is how the trap ends, and
restoration is part of the dismissible surface's clean teardown.
