---
id: dropdown-menu
title: Dropdown Menu
layer: component
version: 1.0.0
status: stable
summary: A button-triggered menu of actions, revealed in a floating list.
since: 0.2.0
updated: 2026-07-16
tags: [menu, actions, overlay, navigation]
aliases: [action-menu, menu-button, overflow-menu]
composedOf: [popover, separator, kbd, checkbox]
usedBy: [navbar, data-table, card, sidebar, toolbar]
related: [context-menu, menubar, popover, select]
traits: [dismissible, anchored, roving-focus, typeahead]
maintainers: [brnrdog]
---

# Dropdown Menu

## Intent

A dropdown menu attaches a list of actions to a button, revealing them on demand
so a surface can offer many operations without clutter. It's the workhorse for
"more actions", account menus, and overflow — an explicitly triggered, keyboard-
navigable menu of commands.

## When to use / When not to use

**Use when**
- Grouping several actions behind one trigger (overflow, account, row actions).

**Avoid when**
- Selecting a form value — use a **select** or **combobox**.
- Actions are tied to right-clicking an object — use a **context-menu**.
- There's a single action — use a plain **button**.

## Anatomy

- **Trigger** (required) — a button showing it opens a menu.
- **Menu surface** (required) — a floating, positioned list.
- **Items** (required) — actions with optional icons and shortcut hints.
- **Submenus** (optional) — nested action groups.
- **Separators & labels** (optional) — grouping.
- **Checkable items** (optional) — toggles or single-choice groups.

## States & behavior

- **Closed / open** — anchored to the trigger, flipping to stay on-screen.
- **Highlighted item** — via keyboard/pointer.
- **Submenu open** — on hover/arrow.
- **Dismiss** — on selection, `Escape`, or outside click; focus returns to trigger.

## Variants

- **Actions menu** — commands.
- **With checkable items** — toggles / single-choice.
- **With submenus** — nested.

## Layout & responsiveness

The menu aligns to the trigger and collision-flips within the viewport; long menus
scroll. On small screens it may present as a sheet/drawer for larger targets.

## Accessibility

- **Keyboard** — open with Enter/Space/Down; arrows navigate; Enter activates; Esc
  closes; typeahead optional. Focus moves into the menu and returns to the trigger.
- **Semantics** — a menu button controlling a menu of menuitems, with checked and
  submenu relationships exposed.
- **Screen reader** — announces items, groups, checked state, and submenus.
- **Focus** — visible highlight; trap while open.

## Content guidelines

- Verb-led item labels; group related actions; mark destructive items.
- Show shortcuts where they exist.

## Composition

**Composed of:** popover (surface/positioning), separator, kbd, checkbox
(checkable items).

**Used by:** navbar, data-table, card, sidebar, toolbars.

## Do / Don't

**Do**
- Support full keyboard operation and focus return.
- Group and label; keep menus reasonably short.

**Don't**
- Use a menu to pick form values.
- Nest submenus deeply.

## References

- WAI-ARIA Authoring Practices — Menu Button pattern.
