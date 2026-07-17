---
id: progress
title: Progress
layer: element
version: 1.0.0
status: stable
summary: A visual indicator of how far a task has advanced toward completion.
since: 0.2.0
updated: 2026-07-16
tags: [feedback, status, loading, progress]
aliases: [progress-bar, meter, loader-bar]
composedOf: []
usedBy: [form, card, dialog, data-table, sidebar]
related: [spinner, skeleton, slider]
maintainers: [brnrdog]
---

# Progress

## Intent

A progress indicator communicates that a task is underway and, when known, how
much remains. It reassures the user that work is happening and sets expectations
for how long they must wait.

## API

```json
{
  "props": [
    {"name":"value","type":"number","default":"0","description":"Current progress."},
    {"name":"max","type":"number","default":"100","description":"Value representing complete."},
    {"name":"indeterminate","type":"boolean","default":"false","description":"Progress is unknown."}
  ],
  "a11y": {"role":"progressbar","announces":["valuenow","valuemax"]},
  "states": ["determinate","indeterminate","complete"],
  "tokens": ["color.action.*","radius.full"]
}
```

## When to use / When not to use

**Use when**
- Showing determinate progress of a measurable task (upload, import, steps).
- Showing indeterminate activity when duration is unknown.

**Avoid when**
- The wait is tiny and localized to a control — a **spinner** fits better.
- You are showing the shape of not-yet-loaded content — use a **skeleton**.

## Anatomy

- **Track** (required) — the full extent.
- **Indicator** (required) — the filled portion (determinate) or moving pattern
  (indeterminate).
- **Value label** (optional) — percentage or "x of y".

## States & behavior

- **Determinate** — indicator reflects a known 0–100% value that advances.
- **Indeterminate** — continuous motion signals ongoing, unmeasured work.
- **Complete** — reaches full and is typically replaced by a result state.
- **Error / paused** (optional) — communicates a stall or failure.

## Variants

- **Linear bar** — horizontal fill.
- **Circular / radial** — ring fill for compact contexts.
- **Stepped** — segmented for discrete stages.

## Layout & responsiveness

Linear bars span the width of their container; circular variants keep a fixed
diameter. Pair with a concise value or status label when precise expectations
matter. Avoid layout shift when the indicator appears or completes.

## Accessibility

- **Semantics** — exposes a progressbar role with min/max/now for determinate
  progress; indeterminate omits the value but conveys busy state.
- **Screen reader** — announces meaningful changes without spamming updates.
- **Non-color** — completion and error are conveyed by more than color.

## Content guidelines

- Prefer concrete labels ("Uploading 3 of 10") over bare percentages when helpful.
- Keep status copy short and reassuring.

## Composition

**Composed of:** Not applicable — a primitive element.

**Used by:** form (submission), card, dialog, data-table, sidebar (usage meters).

## Do / Don't

**Do**
- Use determinate progress whenever the total is known.
- Announce completion and errors accessibly.

**Don't**
- Fake precise percentages you cannot measure.
- Use a full progress bar for a sub-second action.

## References

- WAI-ARIA Authoring Practices — Meter and progressbar guidance.
