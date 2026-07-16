---
id: context-menu
title: Context Menu
layer: component
version: 1.0.0
status: stable
summary: A menu of actions relevant to a specific element, opened by right-click or long-press.
since: 0.2.0
updated: 2026-07-16
tags: [menu, actions, contextual, overlay]
aliases: [right-click-menu, contextual-menu]
composedOf: [popover, separator, kbd]
usedBy: [data-table, sidebar, card]
related: [dropdown-menu, menubar, popover]
maintainers: [brnrdog]
---

# Context Menu

## Intent

A context menu offers actions specific to the element the user targeted, summoned
in place by right-click (or long-press on touch). It surfaces object-specific
commands exactly where the user is working, without permanently occupying screen
space.

## When to use / When not to use

**Use when**
- Providing power-user shortcuts to actions on a specific object (rows, files,
  canvas items).

**Avoid when**
- The actions must be discoverable by everyone — also expose them via visible
  controls or a **dropdown-menu**, since context menus are easy to miss.
- The menu isn't tied to a specific target — use a **dropdown-menu**.

## Anatomy

- **Trigger gesture** (required) — right-click / long-press on the target.
- **Menu surface** (required) — a floating list at the pointer.
- **Items** (required) — actions, with optional icons and shortcut hints.
- **Submenus** (optional) — nested actions.
- **Separators & section labels** (optional) — grouping.
- **Checkable items** (optional) — toggles and single-choice groups.

## States & behavior

- **Closed / open at pointer** — positioned near the cursor, flipping to stay
  on-screen.
- **Highlighted item** — follows keyboard/pointer.
- **Submenu open** — on hover/arrow.
- **Dismiss** — on selection, `Escape`, or outside interaction.

Opening moves keyboard focus into the menu.

## Variants

- **Flat actions**; **grouped**; **with submenus**; **with checkable items**.

## Layout & responsiveness

Anchored to the pointer with collision handling to keep it in view. On touch, a
long-press opens it; consider a larger, tap-friendly presentation. Keep menus
short; deep nesting is hard to use.

## Accessibility

- **Keyboard** — a keyboard equivalent to open (e.g. the context-menu key) is
  provided; arrows navigate, Enter activates, Esc closes; focus is trapped and
  restored.
- **Semantics** — a menu with menuitem roles, including checked state and submenu
  relationships.
- **Screen reader** — announces items, groups, submenus, and checked state.
- **Discoverability** — don't make an action _only_ reachable by right-click.

## Content guidelines

- Order by frequency; group related actions; keep labels verb-led.
- Mark destructive actions distinctly.

## Composition

**Composed of:** popover (surface/positioning), separator, kbd (shortcut hints).

**Used by:** data-table (row actions), sidebar, card.

## Do / Don't

**Do**
- Provide a keyboard way to open and operate it.
- Mirror key actions in visible controls too.

**Don't**
- Bury essential actions behind right-click only.
- Nest submenus deeply.

## References

- WAI-ARIA Authoring Practices — Menu and Menu Button patterns.
