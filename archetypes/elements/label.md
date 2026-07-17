---
id: label
title: Label
layer: element
version: 1.0.0
status: stable
summary: A short caption that names a form control and is programmatically bound to it.
since: 0.2.0
updated: 2026-07-16
tags: [form, text, accessibility, field]
aliases: [caption, field-label]
composedOf: []
usedBy: [input, checkbox, radio-group, select, switch, field, form]
related: [field, input]
maintainers: [brnrdog]
---

# Label

## Intent

A label names a form control so people know what value to provide and assistive
technology can announce the control correctly. Its defining property is not the
text itself but the **programmatic association** with a control — a label that
isn't bound to anything is just text.

## API

```json
{
  "props": [
    {"name":"for","type":"string","default":"","description":"id of the control this labels."},
    {"name":"required","type":"boolean","default":"false","description":"Marks the field as required."}
  ],
  "slots": [
    {"name":"text","required":true,"description":"The field name."}
  ],
  "a11y": {"announces":["name"]},
  "states": ["default"],
  "tokens": ["font.weight.medium","color.neutral.*"]
}
```

## When to use / When not to use

**Use when**
- Naming any interactive form control (input, checkbox, select, switch, …).

**Avoid when**
- You need long-form guidance — use helper text or a description instead.
- The text is a heading for a section, not a control name.

## Anatomy

- **Text** (required) — the control's name.
- **Required/optional indicator** (optional) — marks whether input is mandatory.
- **Association** (required) — a binding to exactly one control.

## States & behavior

- **Default** — static; clicking it focuses or activates the associated control.
- **Disabled** — visually reflects a disabled control.
- **Error** (optional) — may adopt an error treatment alongside the field's message.

## Variants

- **Inline** — beside the control (e.g. checkbox/switch rows).
- **Stacked** — above the control (most inputs).
- **With requirement marker** — required or optional annotation.

## Layout & responsiveness

Stacked labels sit directly above their control for reliable reading order and
wrapping; inline labels align to the control's baseline. Keep placement
consistent across a form.

## Accessibility

- **Semantics** — bound to its control so name/role/value is complete.
- **Screen reader** — read as the control's accessible name.
- **Interaction** — activating the label moves focus to the control.
- **Requirement** — convey required state in text/semantics, not color alone.

## Content guidelines

- Short noun phrases ("Email", "Card number"), not sentences or instructions.
- Mark requirement consistently (either mark required or mark optional, not both).

## Composition

**Composed of:** Not applicable — a primitive; typically orchestrated by **field**.

**Used by:** input, checkbox, radio-group, select, switch, field, form.

## Do / Don't

**Do**
- Always associate the label with its control.
- Keep labels visible; don't rely on placeholders.

**Don't**
- Use a label as the only guidance for complex formats.
- Bind one label to multiple controls.

## References

- WCAG — Labels or Instructions; Info and Relationships.
