---
id: icon
title: Icon
layer: element
version: 1.1.0
status: stable
summary: A small pictographic symbol that conveys meaning or reinforces a label compactly.
since: 0.4.0
updated: 2026-07-19
tags: [symbol, visual, display, glyph]
aliases: [glyph, pictogram, symbol]
composedOf: []
usedBy: [button, icon-button, feature-grid, alert, badge, list, stat]
related: [icon-button, logo]
maintainers: [brnrdog]
implementation: Icon.res
---

# Icon

## Intent

An icon is a small symbol that conveys a concept at a glance — a magnifier for
search, a trash can for delete — or reinforces a text label. Used well, icons speed
recognition and save space; used carelessly, they become decoration that assistive
technology and unfamiliar users can't interpret. Meaning, not ornament, is the bar.

## API

```json
{
  "responsive": {
    "container": false,
    "reflow": []
  },
  "props": [
    {"name":"name","type":"string","default":"","description":"Identifier of the glyph to render, from the icon set."},
    {"name":"size","type":"enum","values":["xs","sm","md","lg","xl"],"default":"md","description":"Optical size, from a fixed scale."},
    {"name":"label","type":"string","default":"","description":"Accessible name; omit to mark decorative."}
  ],
  "a11y": {"role":"img","announces":["name"]},
  "states": ["default"],
  "tokens": ["color.neutral.*"]
}
```

## When to use / When not to use

**Use when**
- Reinforcing a label, or marking a well-understood action/status compactly.

**Avoid when**
- The concept isn't reliably recognizable as a symbol — use text.
- The icon is the sole carrier of meaning without an accessible name.

## Anatomy

- **Glyph** (required) — the symbol itself, on a consistent grid and weight.
- **Bounding box** (required) — a consistent optical size for alignment.
- **Accessible name** (conditional) — required when the icon conveys meaning on its
  own; omitted (and hidden) when purely decorative beside a label.

## States & behavior

- **Decorative** — accompanies text; hidden from assistive tech.
- **Meaningful** — conveys standalone meaning; carries a text alternative.
- **Inherited styling** — typically takes color and size from surrounding text.

## Variants

- **Outline** — the default style set: a single, modern outline family drawn on a
  24×24 grid with a uniform stroke and round caps/joins, so glyphs inherit text
  color and optical weight.
- **Sizes** — from a fixed optical scale (`xs`, `sm`, `md`, `lg`, `xl`).
- **Standalone vs. inline** — beside text or on its own.

## Layout & responsiveness

Icons align optically with adjacent text (baseline and size) and scale from a
defined size set. Keep one style family across a product so the visual language
stays coherent.

## Accessibility

- **Decorative icons** — hidden from assistive tech so they aren't announced.
- **Meaningful icons** — provide a text alternative/accessible name describing the
  concept, not the picture.
- **Contrast** — meaningful icons meet non-text contrast against their background.
- **Not sole meaning** — never rely on an icon alone where the meaning must be
  understood; pair with text or a name.

## Content guidelines

- Use conventional metaphors; keep one icon meaning consistent across the product.
- Name meaningful icons by concept ("Search"), not appearance ("Magnifier").

## Composition

**Composed of:** Not applicable — a primitive display element.

**Used by:** button, icon-button, feature-grid, alert, badge, list, stat.

## Do / Don't

**Do**
- Keep a single, consistent icon style and grid.
- Give meaningful icons accessible names; hide decorative ones.

**Don't**
- Rely on an unfamiliar icon without a label.
- Mix icon styles within a product.

## References

- WCAG — Non-text Contrast; text alternatives.
