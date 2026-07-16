---
id: button-group
title: Button Group
layer: component
version: 1.0.0
status: stable
summary: A set of related buttons joined into a single visual unit.
since: 0.2.0
updated: 2026-07-16
tags: [action, layout, toolbar, grouping]
aliases: [btn-group, segmented-buttons, split-button]
composedOf: [button, dropdown-menu, separator]
usedBy: [toolbar, data-table, card, dialog]
related: [toggle-group, dropdown-menu, button]
maintainers: [brnrdog]
---

# Button Group

## Intent

A button group visually joins related buttons into one unit to signal that they
belong together — a set of related actions, or a primary action paired with a menu
of alternatives (a split button). It clarifies relationships and conserves space in
toolbars and action areas.

## When to use / When not to use

**Use when**
- Presenting a small set of related actions as a cohesive cluster.
- Pairing a default action with secondary options (split button).

**Avoid when**
- The buttons are unrelated — space them separately.
- The group represents selectable state — use a **toggle-group**.

## Anatomy

- **Buttons** (required) — two or more related actions with shared end-rounding.
- **Split trigger** (optional) — an attached menu button revealing more actions.
- **Dividers** (optional) — subtle separation between members.

## States & behavior

- **Default** — each button behaves as a normal button.
- **Split button** — the main button runs the default action; the attached trigger
  opens a dropdown of alternatives.
- **Disabled** — individual members or the whole group.

Members are independent controls, not a single selection.

## Variants

- **Grouped actions** — several peer buttons.
- **Split button** — default action + menu.
- **Attached vs. spaced** — joined seam or subtle gaps.

## Layout & responsiveness

Members sit flush with shared borders and rounded outer corners, forming one shape.
On narrow widths, allow wrapping or collapse less-used actions into an attached
menu. Keep targets adequately sized.

## Accessibility

- **Semantics** — a labeled group of buttons; the split menu button exposes that it
  opens a menu and its expanded state.
- **Keyboard** — each button is individually focusable and operable; the menu is
  keyboard-navigable.
- **Screen reader** — announces the group and each action; icon-only members have
  accessible names.
- **Focus** — visible focus on each member.

## Content guidelines

- Keep the group small and its actions related.
- Make the split button's default action the most common one.

## Composition

**Composed of:** button, dropdown-menu (split menu), separator.

**Used by:** toolbars, data-table, card, dialog action rows.

## Do / Don't

**Do**
- Group only genuinely related actions.
- Make each member independently operable.

**Don't**
- Confuse a button group (actions) with a toggle-group (state).
- Overfill the group; collapse extras into a menu.

## References

- WAI-ARIA Authoring Practices — Toolbar and Menu Button guidance.
