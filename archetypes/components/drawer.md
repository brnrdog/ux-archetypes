---
id: drawer
title: Drawer
layer: component
version: 1.0.0
status: stable
summary: A panel that slides in from a screen edge, often swipe-driven, for content or actions.
since: 0.2.0
updated: 2026-07-16
tags: [overlay, panel, mobile, gesture]
aliases: [bottom-sheet, slide-over]
composedOf: [scroll-area, button, separator]
usedBy: [navbar, dashboard, data-table]
related: [sheet, dialog, sidebar, popover]
traits: [dismissible, focus-trap]
maintainers: [brnrdog]
---

# Drawer

## Intent

A drawer slides content in from an edge of the screen — commonly the bottom on
touch — keeping partial context visible and inviting gesture-driven dismissal. It
suits mobile-first flows and secondary content that should feel attached to the
current screen rather than replacing it.

## When to use / When not to use

**Use when**
- Presenting secondary content/actions on touch, especially from the bottom.
- A swipe-to-dismiss, partially-overlaying panel fits the interaction.

**Avoid when**
- On desktop for a focused task — a **dialog** or **sheet** may read better.
- A confirmation is needed — use an **alert-dialog**.

## Anatomy

- **Overlay / scrim** (optional) — dims the background.
- **Panel** (required) — slides from an edge (usually bottom).
- **Drag handle** (optional) — affordance for swipe and snap points.
- **Header / content / footer** (as needed) — with scrollable content.

## States & behavior

- **Open / closed** — animated slide with optional snap points (peek, half, full).
- **Dragging** — follows the gesture; releases to the nearest snap or dismisses.
- **Dismiss** — swipe, scrim tap, close control, or `Escape`.

## Variants

- **Bottom drawer** — the common mobile pattern.
- **Side drawer** — from left/right (e.g. mobile navigation).
- **With snap points** — multi-height.

## Layout & responsiveness

Anchored to an edge, sized to content or snap points, with the content region
scrolling. On larger screens a drawer may become a sheet or dialog. Preserve safe
areas and keep the handle/close reachable.

## Accessibility

- **Semantics** — a dialog (modal when it blocks) with an accessible name.
- **Keyboard** — focus moves in on open, is trapped while modal, and returns on
  close; `Escape` closes. Gesture actions have keyboard/button equivalents.
- **Screen reader** — announces open/close and purpose.
- **Motion** — respect reduced-motion for the slide.

## Content guidelines

- Give the drawer a clear title/purpose.
- Provide an explicit close in addition to gestures.

## Composition

**Composed of:** scroll-area, button, separator.

**Used by:** navbar (mobile menu), dashboard, data-table (filters on mobile).

## Do / Don't

**Do**
- Offer both gesture and explicit controls to dismiss.
- Use snap points for content with natural heights.

**Don't**
- Rely on swipe alone for dismissal.
- Cover essential context when partial visibility is the point.

## References

- WAI-ARIA Authoring Practices — Dialog (Modal) pattern; touch gesture guidance.
