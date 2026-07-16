---
id: radio-group
title: Radio Group
layer: element
version: 1.0.0
status: stable
summary: A set of mutually exclusive options from which exactly one can be selected.
since: 0.2.0
updated: 2026-07-16
tags: [form, control, selection, single-choice]
aliases: [radio, radio-buttons, option-group]
composedOf: [label]
usedBy: [form, field, settings]
related: [checkbox, select, toggle-group, switch]
maintainers: [brnrdog]
---

# Radio Group

## Intent

A radio group presents a small set of mutually exclusive options and lets the
user choose exactly one. Showing all options at once makes the full set of
choices visible and comparable, which aids decisions among a few alternatives.

## When to use / When not to use

**Use when**
- Exactly one choice must be made from roughly two to five visible options.
- Seeing all options at once helps the user decide.

**Avoid when**
- Many options would overwhelm the layout — use a **select** or **combobox**.
- Multiple selections are allowed — use **checkboxes**.
- The choice is binary and instantly applied — use a **switch**.

## Anatomy

- **Group container** (required) — with a group label describing the decision.
- **Options** (required) — each a control plus a label.
- **Selected indicator** (required) — marks the current choice.
- **Per-option description** (optional).

## States & behavior

- **Unselected group** — no option chosen (avoid unless intentionally optional).
- **Selected** — exactly one option marked; choosing another clears the previous.
- **Disabled** — whole group or individual options.
- **Invalid** — required group with no selection.

Arrow keys move selection within the group; the group is a single tab stop.

## Variants

- **Vertical list** — default, one option per row.
- **Horizontal** — for very short option sets.
- **Card / segmented** — richer options with descriptions or as a segmented control.

## Layout & responsiveness

Options stack vertically for scannability; horizontal layouts only suit two or
three short labels and should wrap gracefully. Align indicators and labels
consistently; the full row is the target.

## Accessibility

- **Keyboard** — one tab stop for the group; arrow keys change selection; `Space`
  selects the focused option.
- **Semantics** — radiogroup with a group label; each option exposes a radio role
  and state.
- **Screen reader** — announces group name, option label, position, and selection.
- **Focus** — visible focus on the active option.

## Content guidelines

- Give the group a clear question or noun as its label.
- Keep option labels parallel and mutually exclusive in meaning.

## Composition

**Composed of:** label (group and per-option).

**Used by:** form, field, settings.

## Do / Don't

**Do**
- Provide a group label describing the decision.
- Preselect a safe default when appropriate.

**Don't**
- Use radios for multi-select.
- Cram a long list into radios.

## References

- WAI-ARIA Authoring Practices — Radio Group pattern.
