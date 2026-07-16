---
id: kbd
title: Keyboard Key
layer: element
version: 1.0.0
status: stable
summary: An inline representation of a key or key combination the user can press.
since: 0.2.0
updated: 2026-07-16
tags: [display, keyboard, shortcut, hint]
aliases: [kbd, keycap, shortcut-hint, hotkey]
composedOf: []
usedBy: [command, tooltip, dropdown-menu, menubar]
related: [badge, tooltip]
maintainers: [brnrdog]
---

# Keyboard Key

## Intent

A keyboard-key element renders a physical key or shortcut combination inline
("⌘K", "Ctrl+S") so users can discover and recall keyboard shortcuts. It is
display-only — it documents an interaction rather than performing one.

## When to use / When not to use

**Use when**
- Showing a shortcut next to a command, in a menu, tooltip, or help text.

**Avoid when**
- The element should trigger an action — that's a **button**.

## Anatomy

- **Keycap(s)** (required) — one per key, styled like a physical key.
- **Combinator** (optional) — separators between keys in a chord.

## States & behavior

Static. Combinations render as ordered keys joined by a separator or spacing.
Platform-specific glyphs (⌘, ⌥, ⇧) may substitute for names by platform.

## Variants

- **Single key** — one keycap.
- **Combination** — multiple keys forming a chord.
- **Platform-aware** — swaps modifiers per operating system.

## Layout & responsiveness

Keycaps sit inline with surrounding text, aligned to the baseline, and stay
compact. In menus they typically align to the trailing edge of the row.

## Accessibility

- **Semantics** — mark up as keyboard input so it's conveyed as such, not as code.
- **Screen reader** — announces the keys understandably (e.g. "Command K"), not
  raw glyphs that read poorly.
- **Contrast** — legible against its surface.

## Content guidelines

- Match the platform's real modifier names/glyphs.
- Keep chords short and conventional.

## Composition

**Composed of:** Not applicable — a primitive display element.

**Used by:** command, tooltip, dropdown-menu, menubar.

## Do / Don't

**Do**
- Reflect the user's actual platform modifiers.
- Keep it display-only.

**Don't**
- Use it as a clickable control.

## References

- HTML — the `kbd` element semantics.
