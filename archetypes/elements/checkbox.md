---
id: checkbox
title: Checkbox
layer: element
version: 1.0.0
status: stable
summary: A control for toggling a single option on or off, or selecting several from a set.
since: 0.2.0
updated: 2026-07-16
tags: [form, control, selection, boolean]
aliases: [check, tickbox]
composedOf: []
usedBy: [form, field, data-table, dropdown-menu]
related: [switch, radio-group, toggle]
maintainers: [brnrdog]
---

# Checkbox

## Intent

A checkbox lets a person turn a single option on or off, or pick any number of
options from a set. It represents a discrete boolean choice whose effect is
typically applied on form submission rather than immediately.

## API

```json
{
  "props": [
    {"name":"checked","type":"boolean","default":"false","description":"Whether the box is ticked."},
    {"name":"indeterminate","type":"boolean","default":"false","description":"Partial/mixed state."},
    {"name":"disabled","type":"boolean","default":"false","description":"Not interactive."},
    {"name":"required","type":"boolean","default":"false","description":"Must be checked to proceed."}
  ],
  "slots": [
    {"name":"label","required":false,"description":"Describes what the checkbox controls."}
  ],
  "events": ["onChange"],
  "a11y": {"role":"checkbox","keyboard":["Space"],"announces":["checked","mixed","disabled"]},
  "states": ["default","checked","indeterminate","focus-visible","disabled","error"],
  "tokens": ["color.action.*","radius.sm"]
}
```

## When to use / When not to use

**Use when**
- Selecting zero or more options from a list.
- Accepting a single binary condition (e.g. "I agree").

**Avoid when**
- The choice takes effect instantly with an on/off meaning — use a **switch**.
- Exactly one option must be chosen from several — use a **radio-group**.

## Anatomy

- **Control box** (required) — the checkable target.
- **Check / indeterminate mark** (required) — indicates state.
- **Label** (required) — describes the option and extends the hit target.
- **Description / helper** (optional) — extra context.

## States & behavior

- **Unchecked / checked** — the two primary states, toggled on activation.
- **Indeterminate** — represents a partial selection of child items (e.g. a
  "select all" parent).
- **Disabled** / **read-only** — not editable.
- **Invalid** — fails validation (e.g. a required agreement).

Clicking the label toggles the box. A parent "select all" reflects children as
checked, unchecked, or indeterminate.

## Variants

- **Single** — standalone boolean.
- **Group** — multiple related checkboxes.
- **With description** — richer label block.

## Layout & responsiveness

The box and label sit on a shared baseline with the label to the trailing side;
the whole row is the target. Groups stack vertically with consistent spacing.
Long labels wrap without misaligning the control.

## Accessibility

- **Keyboard** — focusable; `Space` toggles.
- **Semantics** — checkbox role with checked/unchecked/mixed state exposed;
  label programmatically associated.
- **Screen reader** — announces label, role, and state (including mixed).
- **Focus** — visible focus indicator required.

## Content guidelines

- Label states the positive option; avoid negatives that invert meaning.
- Keep labels parallel in phrasing within a group.

## Composition

**Composed of:** Not applicable — a primitive control (often wrapped by **field**
for label/error).

**Used by:** form, field, data-table (row selection), dropdown-menu.

## Do / Don't

**Do**
- Make the label part of the clickable target.
- Use indeterminate for partial parent selection.

**Don't**
- Use a checkbox for an instantly-applied setting.
- Rely on the box alone without a label.

## References

- WAI-ARIA Authoring Practices — Checkbox pattern.
