---
id: slider
title: Slider
layer: element
version: 1.0.0
status: stable
summary: A control for choosing a value or range by dragging a handle along a track.
since: 0.2.0
updated: 2026-07-16
tags: [form, control, range, input]
aliases: [range, range-slider]
composedOf: []
usedBy: [form, field, settings, data-table]
related: [input, progress, switch]
maintainers: [brnrdog]
---

# Slider

## Intent

A slider lets a person pick a value from a continuous or stepped range by moving
a handle along a track. It suits choices where the approximate position matters
more than exact typing, and where seeing the value's place within the range is
useful.

## When to use / When not to use

**Use when**
- Choosing from a bounded range where relative position is meaningful (volume,
  brightness, price range).
- A rough, quickly-adjustable value is acceptable.

**Avoid when**
- Precision matters and the range is large — a numeric **input** is better.
- Options are discrete categories — use a **radio-group** or **select**.

## Anatomy

- **Track** (required) — the full range.
- **Filled range** (required) — from start (or lower thumb) to the value.
- **Thumb(s)** (required) — one for a single value, two for a range.
- **Value label / tooltip** (optional) — current value on interaction.
- **Ticks / marks** (optional) — for stepped ranges.

## States & behavior

- **Default / focus / active** — with a visible focus indicator on the thumb.
- **Dragging** — value updates live; may snap to steps.
- **Disabled** — not interactive.
- **Range** — two thumbs define lower and upper bounds that cannot cross.

Keyboard arrows adjust by step; Home/End jump to bounds.

## Variants

- **Single value** — one thumb.
- **Range** — two thumbs.
- **Stepped** — snaps to discrete increments with optional marks.
- **Vertical** — for contexts like volume faders.

## Layout & responsiveness

The track spans its container; the current value is often shown adjacent or on a
tooltip during interaction. Ensure the thumb hit area is comfortably large on
touch, larger than its visual size if needed.

## Accessibility

- **Keyboard** — focusable thumb; arrows change by step, Home/End to bounds; for
  ranges each thumb is operable.
- **Semantics** — slider role with min/max/now and a text value when the number
  alone is ambiguous.
- **Screen reader** — announces the value (and unit) as it changes.
- **Focus & target** — visible focus; generous touch target.

## Content guidelines

- Show units with the value ("$40", "70%").
- Label what the slider controls.

## Composition

**Composed of:** Not applicable — a primitive control.

**Used by:** form, field, settings, data-table (range filters).

## Do / Don't

**Do**
- Provide keyboard control and a visible value.
- Use steps and marks when discrete values are expected.

**Don't**
- Use a slider when exact input is essential.
- Make thumbs too small to grab on touch.

## References

- WAI-ARIA Authoring Practices — Slider and Slider (Multi-Thumb) patterns.
