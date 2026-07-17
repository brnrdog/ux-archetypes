---
id: command
title: Command Palette
layer: component
version: 1.0.0
status: stable
summary: A searchable list of commands and destinations for fast, keyboard-driven navigation and action.
since: 0.2.0
updated: 2026-07-16
tags: [navigation, search, productivity, keyboard]
aliases: [command-palette, command-menu, quick-search, spotlight]
composedOf: [input, scroll-area, dialog, kbd, separator]
usedBy: [dashboard, navbar]
related: [combobox, dialog, dropdown-menu]
traits: [dismissible, focus-trap]
maintainers: [brnrdog]
---

# Command Palette

## Intent

A command palette gives power users a single, keyboard-first surface to search
across commands, navigation targets, and entities, then execute or jump with a
keystroke. It collapses deep menus into one fast query box, usually summoned by a
shortcut from anywhere in the app.

## When to use / When not to use

**Use when**
- An app has many actions/destinations and users benefit from fast keyboard access.
- You want a global "do anything" entry point.

**Avoid when**
- The app is simple with few actions — a menu suffices.
- You're selecting a form value — use a **combobox**.

## Anatomy

- **Trigger** (required) — a shortcut (and optional button) to open it.
- **Search input** (required) — filters items as the user types.
- **Grouped results** (required) — commands, pages, and entities in labeled groups.
- **Item** (required) — icon, label, optional shortcut hint (kbd), and description.
- **Empty state** (required) — when nothing matches.
- **Footer hints** (optional) — keyboard legend.

## States & behavior

- **Open / closed** — typically in a centered modal overlay.
- **Filtering** — fuzzy search across items; recent/suggested shown when empty.
- **Highlighted item** — moves with arrows; Enter executes.
- **Nested pages** (optional) — a selection can drill into a sub-command list.
- **Async** — remote results show loading.

## Variants

- **Flat command list**.
- **Multi-group** — commands, navigation, search results together.
- **Nested** — sub-menus for parameterized commands.

## Layout & responsiveness

A centered overlay with the input pinned at top and a scrolling results region
below. On small screens it can fill more of the viewport. Keep the highlighted
item scrolled into view.

## Accessibility

- **Keyboard** — fully operable: open via shortcut, arrows to move, Enter to run,
  Esc to close; focus trapped while open and restored on close.
- **Semantics** — a modal dialog containing a combobox/listbox with active-option
  and expanded state exposed.
- **Screen reader** — announces result counts, the active item, and group context.
- **Focus** — starts in the input; highlight tracks the active item.

## Content guidelines

- Name commands as verbs ("Create project", "Go to settings").
- Show the shortcut for commands that have one.
- Provide useful defaults (recent/most-used) before any query.

## Composition

**Composed of:** input, scroll-area, dialog (overlay/modality), kbd, separator.

**Used by:** dashboard, navbar (global search/actions).

## Do / Don't

**Do**
- Make it reachable by a discoverable shortcut and restore focus on close.
- Group and label results; show shortcuts.

**Don't**
- Hide essential actions only behind the palette.
- Neglect the empty and loading states.

## References

- WAI-ARIA Authoring Practices — Combobox and Dialog (modal) patterns.
