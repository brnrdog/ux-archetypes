---
id: field
title: Field
layer: component
version: 1.0.0
status: stable
summary: A wrapper that pairs a form control with its label, help text, and validation message.
since: 0.2.0
updated: 2026-07-16
tags: [form, control, layout, validation]
aliases: [form-field, form-control, form-group]
usedBy: [form, sign-in, settings]
related: [form, label, input]
maintainers: [brnrdog]
---

# Field

## Intent

A field is the connective wrapper that turns a bare control into a complete,
accessible form element: label, the control itself, optional helper text, and
validation feedback — all wired together. It standardizes structure, spacing, and
the label/description/error associations so every control behaves consistently.

## When to use / When not to use

**Use when**
- Presenting any form control that needs a label and possibly help or error text.
- Enforcing consistent structure and associations across a form.

**Avoid when**
- The control is standalone with no label/help/validation needs (rare).

## Anatomy

- **Label** (required) — names the control (label element).
- **Control** (required) — the input, select, checkbox, etc.
- **Helper/description** (optional) — guidance about the value.
- **Validation message** (conditional) — error/success feedback.
- **Requirement indicator** (optional) — required/optional marker.

## States & behavior

- **Default / focus-within** — reflects the control's focus.
- **Invalid** — shows the message and associates it with the control.
- **Disabled / read-only** — reflected on label and control together.
- **Required** — communicated in text/semantics.

The wrapper wires label→control and description/error→control associations.

## Variants

- **Stacked** — label above the control (default).
- **Inline** — label beside the control (e.g. checkbox/switch rows).
- **With counter / adornments** — passed through to the control.

## Layout & responsiveness

Vertical stack of label, control, and message with consistent spacing and a shared
vertical rhythm across a form. Controls fill the column width; inline layouts align
label and control on a baseline. Messages reserve space to avoid layout jumps.

## Accessibility

- **Associations** — label, description, and error are programmatically bound to the
  control so name/description/validity are complete.
- **Validation** — errors are announced and linked; required and invalid states are
  exposed, not just colored.
- **Focus** — the label activates the control; focus-within is visible.
- **Screen reader** — announces label, description, requirement, and error together.

## Content guidelines

- Keep labels short; put format guidance in helper text, not placeholders.
- Write actionable error messages; mark requirement consistently across the form.

## Composition

```json
{
  "parts": [
    {"ref":"label","slot":"label"},
    {"ref":"input","slot":"control"},
    {"ref":"textarea","slot":"control"},
    {"ref":"select","slot":"control"},
    {"ref":"checkbox","slot":"control"},
    {"ref":"radio-group","slot":"control"},
    {"ref":"switch","slot":"control"}
  ]
}
```

## Do / Don't

**Do**
- Wire label/description/error associations for every field.
- Reserve space for messages to prevent layout shift.

**Don't**
- Rely on placeholders as labels.
- Convey errors with color alone.

## References

- WCAG — Labels or Instructions; Info and Relationships; Error Identification.
