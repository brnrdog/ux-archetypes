---
id: aspect-ratio
title: Aspect Ratio
layer: element
version: 1.0.0
status: stable
summary: A layout primitive that constrains content to a fixed width-to-height proportion.
since: 0.2.0
updated: 2026-07-16
tags: [layout, media, structure, responsive]
aliases: [ratio-box, media-box]
composedOf: []
usedBy: [card, carousel, avatar, landing-page]
related: [skeleton, scroll-area, separator]
maintainers: [brnrdog]
---

# Aspect Ratio

## Intent

An aspect-ratio box holds its content to a consistent width-to-height proportion
(16:9, 1:1, 4:3) regardless of viewport size. It keeps media grids tidy and
prevents layout shift by reserving the correct space before content loads.

## When to use / When not to use

**Use when**
- Displaying media (images, video, embeds, maps) that must keep a shape.
- Keeping items in a grid uniformly proportioned.

**Avoid when**
- Content height should follow its natural text flow.

## Anatomy

- **Ratio container** (required) — enforces the proportion.
- **Content slot** (required) — media or embed that fills the box.

## States & behavior

- **Loading** — reserves exact space (often paired with a skeleton).
- **Loaded** — content fills the box, cropped or fitted as configured.

## Variants

- **Common ratios** — 16:9, 4:3, 3:2, 1:1, 21:9.
- **Fit modes** — cover (crop to fill) or contain (fit within).

## Layout & responsiveness

The box scales with its container's width while preserving the ratio, so height is
derived, not fixed. This keeps grids aligned and avoids cumulative layout shift as
media loads.

## Accessibility

- **Semantics** — a layout wrapper only; the contained media carries its own text
  alternatives and roles.
- **Content** — ensure cropping (cover) doesn't hide essential parts of an image.

## Content guidelines

- Choose a ratio that suits the content and keep it consistent across a set.

## Composition

**Composed of:** Not applicable — a layout primitive wrapping other content.

**Used by:** card, carousel, avatar, landing-page.

## Do / Don't

**Do**
- Reserve space to prevent layout shift.
- Pick a fit mode intentionally.

**Don't**
- Crop away meaningful image content with cover fit.

## References

- Web platform — CSS aspect-ratio and intrinsic sizing.
