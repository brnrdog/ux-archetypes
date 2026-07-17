---
id: tooltip
title: Tooltip
layer: component
version: 1.0.0
status: stable
summary: A brief text label that appears on hover or focus to clarify an element.
since: 0.2.0
updated: 2026-07-16
tags: [overlay, hint, help, contextual]
aliases: [hint, tip]
composedOf: [popover]
usedBy: [button, navbar, sidebar, toggle, data-table]
related: [hover-card, popover, kbd]
traits: [anchored]
maintainers: [brnrdog]
---

# Tooltip

## Intent

A tooltip shows a short, plain-text hint about an element when the user hovers or
focuses it — the meaning of an icon button, a truncated label, an extra detail. It
supplies supplementary clarification without permanently occupying space, and must
never carry essential or interactive content.

## When to use / When not to use

**Use when**
- Clarifying an icon-only control or adding a brief, non-essential hint.

**Avoid when**
- The content is essential or interactive — use a **popover** or visible text.
- The preview is rich (media, structured info) — use a **hover-card**.
- The element already has a clear visible label.

## Anatomy

- **Trigger** (required) — the element being described.
- **Tip surface** (required) — a small floating label, optionally with an arrow.
- **Text** (required) — a short phrase; no interactive controls.

## States & behavior

- **Hidden / shown** — appears after a short hover/focus delay, hides on leave/blur.
- **Positioned** — anchored to the trigger, flipping to stay in view.
- **Dismissible** — can be dismissed with `Escape` while the trigger stays focused.
- **Persistence** — stays visible while hovered so users can read it.

## Variants

- **Plain** — text only.
- **With shortcut** — includes a keyboard hint (kbd).

## Layout & responsiveness

Small and anchored near the trigger with collision handling. On touch there is no
hover, so never depend on tooltips there — ensure the same info is otherwise
available. Keep text short enough not to need scrolling.

## Accessibility

- **Semantics** — the tip provides the trigger's accessible description/name;
  triggered on both hover and keyboard focus.
- **Content on hover/focus** — dismissible, hoverable, and persistent per WCAG.
- **Screen reader** — the description is associated with the trigger, not orphaned.
- **Non-essential** — never place essential or interactive content in a tooltip.

## Content guidelines

- Keep to a short phrase; don't restate a visible label.
- No links or buttons inside — those belong in a popover.

## Composition

**Composed of:** popover (positioning foundation).

**Used by:** button/toggle (icon controls), navbar, sidebar, data-table.

## Do / Don't

**Do**
- Trigger on focus as well as hover.
- Keep it brief and dismissible.

**Don't**
- Put essential or interactive content in a tooltip.
- Rely on tooltips on touch devices.

## References

- WAI-ARIA Authoring Practices — Tooltip pattern; WCAG Content on Hover or Focus.
