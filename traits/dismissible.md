---
id: dismissible
title: Dismissible
summary: A transient surface can be closed by Escape, an outside interaction, or an explicit close affordance, and returns control cleanly.
version: 1.0.0
since: 0.6.0
updated: 2026-07-17
---

# Dismissible

## Contract

A dismissible surface is a temporary layer (menu, popover, dialog, toast) that
the user can close without completing a task. It guarantees three independent
ways out and a clean teardown.

- **Escape** — pressing `Escape` closes the topmost dismissible surface. When
  surfaces are nested, `Escape` closes them one level at a time.
- **Outside interaction** — a pointer press outside the surface closes it. A
  surface that models an irreversible decision (an alert dialog) may opt out of
  outside-dismiss so a stray click can't discard the choice.
- **Explicit affordance** — a visible close control (or a menu item that
  performs its action) dismisses the surface.
- **Clean teardown** — on close, any transient state is discarded and focus is
  returned to a sensible place (see the focus-trap trait for modal surfaces).

## Accessibility

- The dismiss keys must not be swallowed by inner controls; `Escape` reaches the
  surface even when a field inside it is focused.
- Auto-dismissing surfaces (toasts) must give enough time and a way to pause or
  re-summon the content, and must not be the only channel for critical messages.

## Notes for implementers

Dismissal is a behavior, not a visual style. Expose an `onDismiss` event and let
the surface's owner decide what "closed" means (unmount, hide, or animate out).
