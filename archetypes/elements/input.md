---
id: input
title: Text Input
layer: element
version: 1.0.0
status: stable
summary: A single-line field that lets a person enter and edit a short piece of text.
since: 0.1.0
updated: 2026-07-16
tags: [form, field, control, interactive, text]
aliases: [textfield, text-field, field]
composedOf: []
usedBy: [form, navbar, sign-in, landing-page]
related: [button, textarea, select, checkbox]
maintainers: [brnrdog]
implementation: Input.res
---

# Text Input

## Intent

A text input captures a short, free-form value from the user — a name, an email,
a search query. It is the workhorse of data entry: a labelled field the user can
focus, type into, correct, and submit. A good input makes its purpose,
constraints, and current validity obvious at every moment.

## API

```json
{
  "props": [
    {"name":"type","type":"string","default":"text","description":"Native input type (text, email, password…)."},
    {"name":"placeholder","type":"string","default":"","description":"Hint shown when empty."},
    {"name":"value","type":"string","default":"","description":"Current text."},
    {"name":"required","type":"boolean","default":"false","description":"Must be filled to submit."}
  ],
  "slots": [

  ],
  "events": ["onInput","onChange"],
  "a11y": {"role":"textbox","announces":["invalid","required"]},
  "states": ["default","focus-visible","filled","disabled","error"],
  "tokens": ["color.action.*","radius.md","space.inline.md"]
}
```

## When to use / When not to use

**Use when**
- Collecting a short, single-line value that the user types.
- The set of acceptable values is open-ended or too large to enumerate.

**Avoid when**
- The value is long or multi-line — use a **textarea**.
- There is a small, fixed set of options — use a **select**, radio group, or
  checkboxes.
- The value is boolean — use a **checkbox** or **switch**.

## Anatomy

- **Label** (required) — a persistent, programmatically associated name for the
  field.
- **Field / control** (required) — the editable area that holds the value.
- **Placeholder** (optional) — an example format; never a replacement for the
  label.
- **Leading/trailing adornment** (optional) — icon, prefix, unit, or an inline
  action such as a clear or reveal-password button.
- **Helper text** (optional) — guidance about format or constraints.
- **Validation message** (conditional) — replaces or accompanies helper text
  when the value is invalid.
- **Character/limit counter** (optional) — when a max length applies.

## States & behavior

- **Empty** — awaiting input; may show a placeholder.
- **Focus** — active for typing, with a visible focus indicator.
- **Filled** — contains a value.
- **Disabled** — not editable and not focusable.
- **Read-only** — value visible and selectable but not editable.
- **Invalid / error** — fails validation; shows a message describing how to fix it.
- **Valid / success** (optional) — confirms a value that required verification.

Validate at sensible moments (typically on blur or submit, not on every
keystroke) to avoid punishing users mid-entry. Preserve the user's input when
showing errors — never clear the field.

## Variants

- **Plain text** — default free text.
- **Typed** — email, tel, url, number, and similar, which adjust keyboard,
  inline validation, and formatting.
- **Password** — obscured entry with an optional reveal toggle.
- **Search** — often with a leading search icon and a clear affordance.
- **With adornment** — currency, units, or inline actions attached to the field.

## Layout & responsiveness

Inputs typically span the width of their container or form column so the target
is easy to hit and the expected value length is legible. The label sits above
the field for the most reliable reading order and wrapping behavior. Group
related fields and keep a consistent vertical rhythm. On small screens, fields
go full-width and typed variants surface the appropriate on-screen keyboard.

## Accessibility

- **Keyboard** — focusable in tab order; standard text-editing keys work.
- **Semantics** — the label is programmatically associated with the field;
  required, invalid, and described-by relationships are exposed.
- **Screen reader** — announces label, current value, required state, and any
  active validation message.
- **Focus** — a visible focus indicator is required.
- **Errors** — error messages are associated with the field and conveyed by text
  and/or icon, never color alone.

## Content guidelines

- Labels are short nouns describing the value ("Email", "Full name"), not
  instructions.
- Put format guidance in helper text, not the placeholder.
- Write validation messages as specific, actionable fixes: "Enter a valid email
  address", not "Invalid input".

## Composition

**Composed of:** Not applicable — a text input is a primitive element. (Its
optional inline actions may reference the **button** element.)

**Used by:** form, navbar (search), sign-in, landing-page (lead capture).

## Do / Don't

**Do**
- Always provide a visible, associated label.
- Keep the user's input when validation fails and explain the fix.
- Choose the typed variant that matches the data to improve entry.

**Don't**
- Use the placeholder as the only label.
- Validate aggressively on every keystroke for fields still being typed.
- Signal errors with color alone.

## References

- WAI-ARIA Authoring Practices — form and text field guidance.
- WCAG — Labels or Instructions; Error Identification & Suggestion.
