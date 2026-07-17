---
id: anchored
title: Anchored
summary: A floating surface is positioned relative to a trigger, staying visible by flipping and shifting to avoid the viewport edges.
version: 1.0.0
since: 0.6.0
updated: 2026-07-17
---

# Anchored

## Contract

An anchored surface floats above the page tethered to a trigger element
(popover, tooltip, menu, listbox). It guarantees the surface stays connected to
its anchor and fully visible regardless of where the anchor sits.

- **Placement** — the surface opens on a requested side (top, right, bottom,
  left) and alignment (start, center, end) relative to the anchor.
- **Collision handling** — when the preferred placement would overflow the
  viewport, the surface **flips** to the opposite side and/or **shifts** along
  the axis to stay in view, without detaching from the anchor.
- **Follow** — the surface tracks the anchor through scroll and resize, or closes
  if the anchor leaves the viewport.
- **Layering** — the surface renders above page content and escapes clipping and
  stacking contexts (typically via a portal).

## Accessibility

- The surface is associated with its trigger (e.g. the trigger owns/controls the
  surface) so assistive tech announces the relationship.
- Positioning is purely visual; it must never be the only way meaning is
  conveyed, and it must not trap or displace focus (see anchored vs. modal).

## Notes for implementers

Anchoring is orthogonal to modality. Most anchored surfaces are **non-modal**
and pair with **dismissible**; only a few also take a **focus-trap**.
