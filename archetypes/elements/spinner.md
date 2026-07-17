---
id: spinner
title: Spinner
layer: element
version: 1.0.0
status: stable
summary: A compact, indeterminate indicator that signals a short, ongoing wait.
since: 0.2.0
updated: 2026-07-16
tags: [loading, feedback, indeterminate, status]
aliases: [loader, busy-indicator, activity-indicator]
composedOf: []
usedBy: [button, form, card, dialog, data-table]
related: [progress, skeleton]
maintainers: [brnrdog]
implementation: Spinner.res
---

# Spinner

## Intent

A spinner signals that something is happening and the user should wait, without
claiming to know how long. It is the lightest-weight loading cue — ideal inline,
inside buttons, or over a small region during a brief, unmeasured wait.

## API

```json
{
  "props": [

  ],
  "a11y": {"role":"status","announces":["busy"]},
  "states": ["spinning"],
  "tokens": ["color.neutral.*"]
}
```

## When to use / When not to use

**Use when**
- Indicating a short, indeterminate wait for an action or a small region.

**Avoid when**
- Duration/steps are measurable — use **progress**.
- Content has a known layout that's loading — use a **skeleton**.
- The wait is long — provide progress or explanatory context instead.

## Anatomy

- **Animated indicator** (required) — a rotating or pulsing motif.
- **Optional label** (optional) — "Loading…" for context.

## States & behavior

- **Active** — animating while work is in flight.
- **Resolved** — removed and replaced by the result (content, success, or error).

Prefer a brief delay before showing a spinner to avoid flicker on fast responses.

## Variants

- **Inline** — within a button or next to text.
- **Region overlay** — centered over a loading area.
- **Sizes** — from a defined scale.

## Layout & responsiveness

Spinners keep a fixed size and center within their context. When replacing a
button's label, preserve the button's dimensions to avoid layout shift.

## Accessibility

- **Semantics** — convey a busy/loading status to assistive tech (a live status
  message), not just a spinning graphic.
- **Screen reader** — announces that content is loading and, ideally, when it
  finishes.
- **Motion** — respect reduced-motion; keep the animation calm.

## Content guidelines

- Add a short "Loading…" label where context helps.
- Don't pair a spinner with a fake percentage.

## Composition

**Composed of:** Not applicable — a primitive element.

**Used by:** button (loading), form, card, dialog, data-table.

## Do / Don't

**Do**
- Reserve space so the layout doesn't jump.
- Announce busy/loaded states accessibly.

**Don't**
- Use a spinner for long or measurable waits.
- Show it so briefly it flickers.

## References

- WAI-ARIA — status/live region guidance; WCAG reduced motion.
