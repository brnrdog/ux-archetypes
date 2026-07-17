---
id: badge
title: Badge
layer: element
version: 1.0.0
status: stable
summary: A small label that annotates an element with a status, category, or count.
since: 0.2.0
updated: 2026-07-16
tags: [status, label, metadata, count, tag]
aliases: [tag, pill, chip, status-badge]
composedOf: []
usedBy: [avatar, card, navbar, table, tabs, sidebar]
related: [button, label]
maintainers: [brnrdog]
implementation: Badge.res
---

# Badge

## Intent

A badge attaches a short, high-signal annotation to another element — a status
("Active"), a category ("Beta"), or a count (unread items). It is read at a
glance and never the primary focus; it enriches the thing it sits on.

## API

```json
{
  "props": [
    {"name":"variant","type":"enum","values":["solid","soft","outline"],"default":"solid","description":"Visual weight."}
  ],
  "slots": [
    {"name":"label","required":true,"description":"Short status, category, or count."}
  ],
  "states": ["default"],
  "tokens": ["color.*","radius.full","font.weight.medium"]
}
```

## When to use / When not to use

**Use when**
- Communicating status, category, or a small count inline with content.

**Avoid when**
- The label is interactive and triggers an action — use a **button** or a
  removable chip.
- The text is long or explanatory — use inline text or an **alert**.

## Anatomy

- **Label / value** (required) — short text or number.
- **Leading icon or dot** (optional) — reinforces status.
- **Container** (required) — compact, high-contrast surface.

## States & behavior

- **Static** — most badges are non-interactive.
- **Count** — may cap large numbers ("99+").
- **Dismissible (chip variant)** — includes a remove affordance and announces removal.

## Variants

- **Status** — semantic colors mapped to meaning (success, warning, danger, info,
  neutral) with a non-color cue.
- **Count / notification** — numeric or dot indicator.
- **Category / tag** — neutral labeling.
- **Emphasis** — solid, soft, or outline treatments.

## Layout & responsiveness

Badges size to content with tight padding and align to the baseline or center of
the element they annotate. Notification dots anchor to a corner of their host
(e.g. an avatar or icon button). Text truncates rather than wraps.

## Accessibility

- **Semantics** — status badges convey meaning via text or an accessible label,
  not color alone; live counts may use a polite live region.
- **Screen reader** — announces the value and, for status, its meaning.
- **Contrast** — text and background meet contrast requirements.

## Content guidelines

- Keep to one or two words, or a bounded number.
- Use consistent status vocabulary across the product.

## Composition

**Composed of:** Not applicable — a primitive element.

**Used by:** avatar (overlay), card, navbar, table cells, tabs, sidebar.

## Do / Don't

**Do**
- Pair color with text or an icon for meaning.
- Keep a consistent status color-to-meaning mapping.

**Don't**
- Make a badge the only way to trigger an action.
- Overload a view with competing badges.

## References

- WCAG — Use of Color; Status Messages.
