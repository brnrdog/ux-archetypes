---
id: menubar
title: Menubar
layer: component
version: 1.0.0
status: stable
summary: A horizontal bar of top-level menus exposing an application's commands.
since: 0.2.0
updated: 2026-07-16
tags: [menu, commands, application, navigation]
aliases: [app-menu, menu-bar]
composedOf: [dropdown-menu, separator, kbd]
usedBy: [dashboard]
related: [dropdown-menu, navigation-menu, context-menu]
traits: [anchored, roving-focus, typeahead]
maintainers: [brnrdog]
---

# Menubar

## Intent

A menubar presents an application's commands as a persistent horizontal row of
top-level menus (File, Edit, View…), each opening a list of grouped actions. It
mirrors the desktop-application menu model, giving power users a comprehensive,
predictable home for commands.

## When to use / When not to use

**Use when**
- Building an application-like product with many grouped commands.
- Users expect a desktop-style, always-available command surface.

**Avoid when**
- The product is content/marketing-oriented — use a **navbar** or
  **navigation-menu**.
- There are only a few actions — a **dropdown-menu** suffices.

## Anatomy

- **Bar** (required) — the horizontal container of menu triggers.
- **Top-level menus** (required) — each a labeled trigger opening a menu.
- **Menu items** (required) — actions, with icons, shortcuts, and submenus.
- **Separators & groups** (optional).
- **Checkable items** (optional) — toggles and single-choice groups.

## States & behavior

- **Idle** — no menu open.
- **Menu open** — one menu at a time; moving across the bar switches menus.
- **Submenu open** — on hover/arrow.
- **Dismiss** — `Escape`, selection, or outside click.

Roving focus moves across the bar; arrows enter and traverse menus.

## Variants

- **Full menubar** — many top-level menus.
- **Compact** — a couple of menus for lighter apps.

## Layout & responsiveness

A single horizontal row of triggers with menus opening below. On narrow widths,
collapse into an overflow or a single menu button. Keep the bar's position stable.

## Accessibility

- **Keyboard** — left/right move across the bar, down opens a menu, up/down within
  it, submenus via right, Esc closes; a single tab stop for the bar.
- **Semantics** — a menubar with menuitem/menu roles, exposing submenu, checked,
  and disabled states.
- **Screen reader** — announces the bar, menus, items, and state.
- **Focus** — roving focus with a visible indicator.

## Content guidelines

- Use conventional menu names and ordering where they exist.
- Show shortcuts; mark destructive items.

## Composition

**Composed of:** dropdown-menu (each top-level menu), separator, kbd.

**Used by:** dashboard / application shells.

## Do / Don't

**Do**
- Follow established menubar keyboard conventions.
- Keep top-level groupings meaningful.

**Don't**
- Use a menubar for simple marketing navigation.
- Overload menus with deep nesting.

## References

- WAI-ARIA Authoring Practices — Menubar pattern.
