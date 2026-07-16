---
id: carousel
title: Carousel
layer: component
version: 1.0.0
status: stable
summary: A scrollable, paged set of items revealed a few at a time with navigation controls.
since: 0.2.0
updated: 2026-07-16
tags: [media, gallery, slider, content]
aliases: [slider, gallery, slideshow]
composedOf: [button, card, aspect-ratio]
usedBy: [landing-page, dashboard]
related: [tabs, scroll-area, pagination]
maintainers: [brnrdog]
---

# Carousel

## Intent

A carousel presents a sequence of items — images, cards, testimonials — in a
horizontally scrollable track, showing a subset at a time with controls to move
through them. It suits browsable, non-essential content where saving vertical
space matters more than seeing everything at once.

## When to use / When not to use

**Use when**
- Showcasing a browsable set (gallery, featured items) where order is loose.
- Vertical space is constrained and users can page through content.

**Avoid when**
- Content is important and must not be missed — carousels hide items and lower
  engagement with later slides. Prefer a grid or list.
- Items are navigational sections — use **tabs**.

## Anatomy

- **Viewport & track** (required) — the clipped area and the moving row of slides.
- **Slides** (required) — the items, one or several visible.
- **Previous/next controls** (required) — move by item or page.
- **Pagination indicators** (optional) — position dots.
- **Autoplay controls** (conditional) — pause/play when autoplay exists.

## States & behavior

- **At start / middle / end** — controls disable or loop at bounds.
- **Dragging / swiping** — pointer and touch scrolling with snapping.
- **Autoplay** (optional) — advances on a timer; must be pausable and stop on
  interaction/hover/focus.

Keyboard moves between slides; focus stays visible as slides change.

## Variants

- **Single-item** — one slide at a time.
- **Multi-item** — several visible, paging by group.
- **With/without autoplay**; **looping vs. bounded**.

## Layout & responsiveness

Slides size to the viewport, showing fewer per view as width shrinks. Snap points
keep slides aligned. Ensure controls remain reachable and don't obscure content.

## Accessibility

- **Semantics** — a labeled group/region conveying it's a carousel with multiple
  slides and current position.
- **Keyboard** — controls are focusable and operable; off-screen slides don't trap
  focus.
- **Autoplay** — provide an accessible pause; never autoplay motion without one,
  and respect reduced-motion.
- **Screen reader** — announces slide position ("3 of 8") and updates on change.

## Content guidelines

- Don't bury critical content on later slides.
- Label controls clearly ("Previous slide"/"Next slide").

## Composition

**Composed of:** button (controls), card / aspect-ratio (slides).

**Used by:** landing-page, dashboard.

## Do / Don't

**Do**
- Provide manual controls and pause autoplay on interaction.
- Indicate position and total.

**Don't**
- Put essential content or primary CTAs only inside a carousel.
- Autoplay motion without a way to stop it.

## References

- WAI-ARIA Authoring Practices — Carousel pattern; NN/g carousel usability.
