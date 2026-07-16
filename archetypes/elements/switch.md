---
id: switch
title: Switch
layer: element
version: 1.0.0
status: stable
summary: A control that toggles a single setting on or off with an immediate effect.
since: 0.2.0
updated: 2026-07-16
tags: [form, control, toggle, boolean, setting]
aliases: [toggle-switch, on-off]
composedOf: [label]
usedBy: [form, field, settings, sidebar]
related: [checkbox, toggle]
maintainers: [brnrdog]
---

# Switch

## Intent

A switch turns a single setting on or off, taking effect immediately like a
physical light switch. Its value is the instant, self-evident nature of the
change — no separate submit step.

## When to use / When not to use

**Use when**
- Toggling a binary setting that applies right away (notifications on/off).

**Avoid when**
- The choice is part of a form applied on submit — use a **checkbox**.
- More than two states are possible — use a **radio-group** or **select**.

## Anatomy

- **Track** (required) — the on/off channel.
- **Thumb** (required) — slides between positions.
- **Label** (required) — names the setting.
- **State text** (optional) — explicit on/off wording.

## States & behavior

- **Off / on** — toggled on activation, effect applied immediately.
- **Disabled** — not interactive.
- **Pending** (optional) — brief in-flight state if the change is async, with
  rollback on failure.

## Variants

- **With inline label** — label beside the switch.
- **With description** — supporting text under the label.

## Layout & responsiveness

The switch aligns to its label on a shared baseline, commonly with the switch at
the trailing edge of a settings row. The whole row can be the target.

## Accessibility

- **Keyboard** — focusable; `Space`/`Enter` toggles.
- **Semantics** — switch role with on/off state, or a checkbox exposing the same.
- **Screen reader** — announces label and on/off state.
- **Focus** — visible focus indicator.

## Content guidelines

- Label the setting, not the action ("Email notifications", not "Enable").
- Avoid relying on the thumb position alone; expose state to assistive tech.

## Composition

**Composed of:** label.

**Used by:** form, field, settings, sidebar.

## Do / Don't

**Do**
- Use for instantly-applied binary settings.
- Reflect async success/failure honestly.

**Don't**
- Use a switch where a submit step is expected.
- Depend on color alone to show on/off.

## References

- WAI-ARIA Authoring Practices — Switch pattern.
