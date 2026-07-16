---
id: input-group
title: Input Group
layer: component
version: 1.0.0
status: stable
summary: An input combined with adjacent add-ons or controls that act as one composite control.
since: 0.2.0
updated: 2026-07-16
tags: [form, input, layout, control]
aliases: [input-addon, combined-input]
composedOf: [input, button, select, badge]
usedBy: [form, field, navbar, data-table]
related: [input, field, button-group]
maintainers: [brnrdog]
---

# Input Group

## Intent

An input group binds an input with adjacent add-ons — a prefix/suffix, an icon, a
unit, a select, or a button — into one composite control. It gives the value
context (currency symbol, protocol, unit) or an attached action (search, copy,
apply) while reading as a single, cohesive field.

## When to use / When not to use

**Use when**
- An input needs a fixed affix (unit, symbol, domain) or an attached action/select.
- Combining input + button (search, apply) into one visual control.

**Avoid when**
- The affix is guidance, not part of the value — use helper text instead.
- Multiple independent fields are involved — use separate fields.

## Anatomy

- **Input** (required) — the editable value.
- **Leading add-on** (optional) — icon, symbol, prefix text, or select.
- **Trailing add-on** (optional) — unit, action button, or select.
- **Validation message** (conditional) — for the composite value.

## States & behavior

- **Focus-within** — the whole group reflects focus on the input.
- **Add-on actions** — attached buttons trigger actions (search, clear, apply,
  copy); attached selects change a related parameter (unit, protocol).
- **Disabled / invalid** — applied consistently across the group.

## Variants

- **Prefix/suffix text** — symbols or units.
- **With icon** — leading/trailing icon.
- **With button** — attached action.
- **With select** — an attached choice affecting the input's meaning.

## Layout & responsiveness

Add-ons sit flush against the input with shared borders and rounded outer corners,
forming one control. On narrow widths, ensure attached controls stay tappable;
consider stacking only if the seam would break. Keep the input the dominant target.

## Accessibility

- **Associations** — the group has one accessible name for the value; affixes that
  change meaning (e.g. unit select) are exposed, not just visual.
- **Keyboard** — the input and any attached controls are each focusable and operable.
- **Screen reader** — announces the value with meaningful affixes and the purpose of
  attached actions.
- **Focus** — visible focus on the focused member; adequate target sizes.

## Content guidelines

- Use affixes that are genuinely part of the value; keep them short.
- Label attached buttons/selects by their action or parameter.

## Composition

**Composed of:** input, button (attached action), select (attached choice), badge.

**Used by:** form, field, navbar (search), data-table (filters).

## Do / Don't

**Do**
- Keep the composite readable as one control with one value name.
- Ensure attached controls are individually operable.

**Don't**
- Stuff unrelated fields into one group.
- Hide meaningful affixes from assistive tech.

## References

- WCAG — Labels or Instructions; Info and Relationships.
