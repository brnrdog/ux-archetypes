---
id: skeleton
title: Skeleton
layer: element
version: 1.0.0
status: stable
summary: A placeholder that mirrors the shape of content while it loads.
since: 0.2.0
updated: 2026-07-16
tags: [loading, placeholder, feedback, perceived-performance]
implementation: Skeleton.res
aliases: [placeholder, shimmer, loading-placeholder]
composedOf: []
usedBy: [card, data-table, list, avatar, dashboard]
related: [spinner, progress]
maintainers: [brnrdog]
---

# Skeleton

## Intent

A skeleton stands in for content that hasn't loaded yet, echoing its eventual
layout. By reserving space in the real shape, it reduces perceived wait and
prevents layout shift when the content arrives.

## API

```json
{
  "responsive": {
    "container": true,
    "reflow": [
      {
        "pattern": "fluid",
        "note": "mirrors the footprint of the content it stands in for"
      }
    ]
  },
  "props": [
    {"name":"shape","type":"enum","values":["text","circle","rect"],"default":"text","description":"Placeholder shape."}
  ],
  "a11y": {"role":"presentation","announces":["busy"]},
  "states": ["loading"],
  "tokens": ["color.neutral.*","radius.md"]
}
```

## When to use / When not to use

**Use when**
- Content has a predictable layout and takes a noticeable moment to load.
- You want to avoid a jarring jump when data fills in.

**Avoid when**
- The wait is trivial — no indicator is needed.
- Duration matters and is measurable — use **progress**.
- Layout is unknown — a **spinner** is simpler.

## Anatomy

- **Placeholder blocks** (required) — neutral shapes matching text lines, media,
  and controls of the real content.
- **Motion** (optional) — a subtle shimmer or pulse signaling activity.

## States & behavior

- **Loading** — placeholders shown, optionally animated.
- **Resolved** — replaced by the real content in the same footprint.

Match the count and rough proportions of the real content to avoid a visible jump.

## Variants

- **Text lines** — bars of varying width.
- **Media** — rectangles/circles for images and avatars.
- **Composite** — a full card or row skeleton.

## Layout & responsiveness

Skeletons occupy the same box dimensions the real content will, so the layout is
stable before and after load. They adapt to the responsive layout exactly as the
content does.

## Accessibility

- **Semantics** — the loading region conveys a busy state; placeholders are not
  announced as meaningful content.
- **Screen reader** — communicate "loading" via a status, not a wall of empty
  elements.
- **Motion** — respect reduced-motion preferences for the shimmer.

## Content guidelines

- Keep placeholders neutral; don't imply data that may not appear.

## Composition

**Composed of:** Not applicable — a primitive element.

**Used by:** card, data-table, list, avatar, dashboard.

## Do / Don't

**Do**
- Match the real content's shape and count.
- Reserve exact space to prevent layout shift.

**Don't**
- Animate aggressively or ignore reduced-motion.
- Use skeletons for very long or unbounded waits without any progress cue.

## References

- Nielsen Norman Group — skeleton screens and perceived performance.
