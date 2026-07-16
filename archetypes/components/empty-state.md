---
id: empty-state
title: Empty State
layer: component
version: 1.0.0
status: stable
summary: A placeholder shown when there is no content yet, guiding the user toward a first action.
since: 0.2.0
updated: 2026-07-16
tags: [feedback, onboarding, guidance, zero-data]
aliases: [zero-state, blank-slate, no-results]
composedOf: [button, typography, aspect-ratio]
usedBy: [data-table, dashboard, card, search]
related: [skeleton, alert, card]
maintainers: [brnrdog]
---

# Empty State

## Intent

An empty state fills the void when there's no content — a new list, no search
results, a cleared inbox — turning a dead end into guidance. It explains why the
space is empty and points to the next useful action, so absence of data doesn't
feel like a broken screen.

## When to use / When not to use

**Use when**
- A region has no items yet (first-run), no matches (filtered), or has been cleared.
- Users benefit from context and a clear next step.

**Avoid when**
- Content is still loading — use a **skeleton** or spinner.
- An error occurred — use an error state/**alert** that explains the failure.

## Anatomy

- **Visual** (optional) — illustration or icon setting the tone.
- **Headline** (required) — names the situation.
- **Description** (required) — why it's empty and what to do.
- **Primary action** (conditional) — the main next step (create, invite, clear
  filters).
- **Secondary action / help** (optional) — learn more, import, contact.

## States & behavior

- **First-run / onboarding** — encourages creating the first item.
- **No results** — after search/filter; offers to adjust or clear filters.
- **Cleared / all-done** — a positive, completed message.
- **Restricted** — content exists but the user lacks access (explain, don't dead-end).

## Variants

- **Onboarding empty state** — guidance to get started.
- **No-results empty state** — recovery from a query/filter.
- **Success/all-clear** — nothing left to do.

## Layout & responsiveness

Centered within the empty region with a comfortable vertical stack: visual,
headline, description, action. Scales down gracefully, keeping the action visible
on small screens. Occupies the space the content would, avoiding a jarring void.

## Accessibility

- **Structure** — the headline is a proper heading; the region is announced when it
  replaces loading content.
- **Keyboard** — actions are focusable and operable.
- **Screen reader** — conveys that the area is empty and what to do next, not just a
  decorative image.
- **Imagery** — illustrations are decorative (hidden) unless they carry meaning.

## Content guidelines

- Be encouraging and specific; explain the cause and the fix.
- Distinguish "no results" (adjust query) from "nothing yet" (create something).
- One clear primary action.

## Composition

**Composed of:** typography, button (actions), aspect-ratio (illustration).

**Used by:** data-table, dashboard, card lists, search results.

## Do / Don't

**Do**
- Explain the cause and offer a concrete next step.
- Differentiate empty from loading and from error.

**Don't**
- Leave a blank area with no guidance.
- Show an empty state while data is still loading.

## References

- Nielsen Norman Group — empty states and first-time user experience.
