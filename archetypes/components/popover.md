---
id: popover
title: Popover
layer: component
version: 1.0.0
status: stable
summary: A floating surface anchored to a trigger, holding contextual content or controls.
since: 0.2.0
updated: 2026-07-16
tags: [overlay, contextual, floating, container]
aliases: [flyout, pop-up, floating-panel]
composedOf: [button, scroll-area]
usedBy: [combobox, select, date-picker, dropdown-menu, tooltip, hover-card, navigation-menu]
related: [tooltip, dropdown-menu, dialog, hover-card]
traits: [dismissible, anchored]
maintainers: [brnrdog]
---

# Popover

## Intent

A popover is a general-purpose floating surface anchored to a trigger, used to
present contextual content or lightweight controls near what they relate to. It is
the shared foundation many overlays build on (menus, selects, date pickers), and
on its own it holds small interactive content without the weight of a modal dialog.

## When to use / When not to use

**Use when**
- Showing contextual, possibly interactive content next to its trigger (filters,
  small forms, info with actions).

**Avoid when**
- The content is a plain text hint — use a **tooltip**.
- It's a list of commands — use a **dropdown-menu**.
- The task needs full focus/blocking — use a **dialog**.

## Anatomy

- **Trigger** (required) — opens the popover (usually on click).
- **Surface / panel** (required) — the floating container, optionally with an arrow.
- **Content** (required) — text and/or interactive controls.
- **Optional close** (optional) — explicit dismiss control.

## States & behavior

- **Closed / open** — anchored to the trigger, flipping and shifting to stay in view.
- **Focus behavior** — may be modal (traps focus) or non-modal depending on content.
- **Dismiss** — `Escape`, outside click, or a close control.

## Variants

- **Non-modal** — background stays interactive (default for light content).
- **Modal** — traps focus for small interactive tasks.
- **With arrow** — points to the anchor.

## Layout & responsiveness

Positioned relative to the trigger with collision handling (flip/shift); content
can scroll if it grows. On small screens, larger popovers may become sheets. Keep
it clear of the trigger it points to.

## Accessibility

- **Semantics** — associated with its trigger; the trigger conveys it opens a
  popover and its expanded state.
- **Keyboard** — openable and dismissible by keyboard; `Escape` closes and returns
  focus; if modal, focus is trapped.
- **Screen reader** — content is discoverable and, where relevant, announced on open.
- **Focus** — managed into the popover for interactive content and restored on close.

## Content guidelines

- Keep content focused and small; escalate to a dialog if it grows.
- Give interactive popovers a clear way to dismiss.

## Composition

**Composed of:** button (trigger), scroll-area.

**Used by:** combobox, select, date-picker, dropdown-menu, tooltip, hover-card,
navigation-menu, context-menu.

## Do / Don't

**Do**
- Manage focus and support `Escape`.
- Keep positioning within the viewport.

**Don't**
- Cram large tasks into a popover.
- Use a popover where a simple tooltip is meant.

## References

- WAI-ARIA Authoring Practices — Dialog and Disclosure guidance for popovers.
