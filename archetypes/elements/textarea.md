---
id: textarea
title: Textarea
layer: element
version: 1.0.0
status: stable
summary: A multi-line field for entering and editing longer free-form text.
since: 0.2.0
updated: 2026-07-16
tags: [form, field, control, text, multiline]
aliases: [multiline-input, text-area]
composedOf: []
usedBy: [form, field, dialog, card]
related: [input, label, field]
maintainers: [brnrdog]
---

# Textarea

## Intent

A textarea captures longer, multi-line text — a comment, description, or message.
It gives the user room to write and review several lines at once, unlike the
single-line input.

## API

```json
{
  "props": [
    {"name":"placeholder","type":"string","default":"","description":"Hint shown when empty."},
    {"name":"value","type":"string","default":"","description":"Current text."},
    {"name":"rows","type":"number","default":"3","description":"Visible line count."},
    {"name":"required","type":"boolean","default":"false","description":"Must be filled to submit."}
  ],
  "events": ["onInput","onChange"],
  "a11y": {"role":"textbox","announces":["invalid","required"]},
  "states": ["default","focus-visible","filled","disabled","error"],
  "tokens": ["color.action.*","radius.md"]
}
```

## When to use / When not to use

**Use when**
- Collecting multi-line or lengthy free text (messages, notes, descriptions).

**Avoid when**
- The value is short and single-line — use an **input**.
- The content is rich/formatted — use a dedicated rich-text editor pattern.

## Anatomy

- **Label** (required) — names the field.
- **Editable area** (required) — multi-line region.
- **Helper text** (optional) — format or length guidance.
- **Character counter** (optional) — when a limit applies.
- **Resize handle** (optional) — manual or auto-growing height.
- **Validation message** (conditional).

## States & behavior

- **Empty / focus / filled** — as with inputs, with a visible focus indicator.
- **Auto-grow** (optional) — expands with content up to a max, then scrolls.
- **Disabled / read-only / invalid** — standard field states.

Preserve input on validation errors; validate on blur/submit, not each keystroke.

## Variants

- **Fixed height** — scrolls when overflowing.
- **Auto-resizing** — grows to fit content.
- **With counter** — enforces or surfaces a max length.

## Layout & responsiveness

Textareas typically span the form column width with a sensible default number of
visible rows. Auto-growing variants prevent the page from jumping while keeping a
maximum height. On small screens they remain full-width.

## Accessibility

- **Keyboard** — focusable; standard multi-line editing keys work.
- **Semantics** — label associated; required/invalid/described-by exposed.
- **Screen reader** — announces label, value, and validation messages.
- **Focus** — visible focus indicator.

## Content guidelines

- Set expectations for length in helper text, not the placeholder.
- Write actionable validation messages.

## Composition

**Composed of:** Not applicable — a primitive control (often wrapped by **field**).

**Used by:** form, field, dialog, card.

## Do / Don't

**Do**
- Give enough default height for the expected input.
- Show a counter when a limit is enforced.

**Don't**
- Use a textarea for single-line values.
- Clear the user's text when showing an error.

## References

- WCAG — Labels or Instructions; Error Identification.
