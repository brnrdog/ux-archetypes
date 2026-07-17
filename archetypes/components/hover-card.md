---
id: hover-card
title: Hover Card
layer: component
version: 1.0.0
status: stable
summary: A rich preview surface revealed when a pointer rests on a trigger.
since: 0.2.0
updated: 2026-07-16
tags: [overlay, preview, contextual, hover]
aliases: [preview-card, rich-tooltip]
composedOf: [popover, avatar, button, typography]
usedBy: [navbar, card, data-table]
related: [tooltip, popover, card]
traits: [anchored]
maintainers: [brnrdog]
---

# Hover Card

## Intent

A hover card shows a richer preview — a person's profile, a link's summary, an
item's details — when the pointer rests on a trigger. It offers a peek of related
information without a click or navigation, richer than a plain tooltip but lighter
than opening a page.

## When to use / When not to use

**Use when**
- Offering an optional, supplementary preview on hover for pointer users (profile
  cards, link previews).

**Avoid when**
- The information is essential — hover is not available on touch or keyboard-only;
  don't hide required content here.
- A short text hint suffices — use a **tooltip**.
- The content is interactive and primary — use a **popover** opened by click.

## Anatomy

- **Trigger** (required) — the element hovered.
- **Preview surface** (required) — a floating card with structured content.
- **Content** (required) — media, text, and optional light actions.

## States & behavior

- **Closed / open** — appears after a short hover delay, dismisses on leave with a
  small grace period so the pointer can travel to it.
- **Positioned** — anchored to the trigger, flipping to stay in view.

Because it's hover-driven, it must be treated as supplementary, not required.

## Variants

- **Profile preview** — avatar, name, meta, follow action.
- **Link preview** — title, description, image.

## Layout & responsiveness

Anchored near the trigger with collision handling. On touch, provide an alternative
access path (tap to open a popover or navigate), since hover doesn't exist there.

## Accessibility

- **Non-essential** — never place required information only in a hover card.
- **Keyboard** — if the trigger is focusable and the content matters, expose it on
  focus too, or provide a click alternative.
- **Screen reader** — associate the preview with the trigger when it conveys
  meaningful, persistent info.
- **Dismissal** — dismissible and not obstructive; respects reduced motion.

## Content guidelines

- Keep previews concise and scannable.
- Don't gate primary actions behind hover.

## Composition

**Composed of:** popover (surface/positioning), avatar, typography, button.

**Used by:** navbar, card, data-table (entity previews).

## Do / Don't

**Do**
- Add a small open/close delay and grace area.
- Provide touch/keyboard alternatives.

**Don't**
- Hide essential content or actions behind hover.
- Trigger on every element, creating noise.

## References

- WCAG — Content on Hover or Focus.
