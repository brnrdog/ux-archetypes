---
id: toggle
title: Toggle
layer: element
version: 1.0.0
status: stable
summary: A two-state button that can be turned on or off, often used in toolbars.
since: 0.2.0
updated: 2026-07-16
tags: [control, button, state, toolbar]
aliases: [toggle-button, pressed-button]
composedOf: []
usedBy: [toggle-group, toolbar, menubar]
related: [toggle-group, switch, button, checkbox]
maintainers: [brnrdog]
---

# Toggle

## Intent

A toggle is a button that stays pressed or unpressed, representing an on/off state
for a formatting or view option — bold text, grid vs. list, mute. Unlike a switch
(a setting) it reads as a momentary tool that happens to remember its state, which
is why it lives naturally in toolbars.

## When to use / When not to use

**Use when**
- Turning a tool or view option on/off, especially in a toolbar (e.g. bold).

**Avoid when**
- Toggling a persistent setting in a form — use a **switch** or **checkbox**.
- Choosing one of several exclusive options — use a **toggle-group** or radios.

## Anatomy

- **Icon and/or label** (required) — what the toggle controls.
- **Container** (required) — the pressable target reflecting pressed state.

## States & behavior

- **Off (unpressed) / On (pressed)** — flips on activation.
- **Hover / focus / active** — with a visible focus indicator.
- **Disabled** — not interactive.

Activation flips the state on click and `Enter`/`Space`.

## Variants

- **Icon-only** — compact toolbar tool with an accessible name.
- **Icon + label** — clearer intent.
- **Sizes / emphasis** — from a defined scale.

## Layout & responsiveness

Toggles sit inline in toolbars with consistent sizing and spacing, often grouped.
Icon-only toggles must keep an adequate target size.

## Accessibility

- **Keyboard** — focusable; `Enter`/`Space` toggles.
- **Semantics** — button with a pressed state exposed (on/off).
- **Screen reader** — announces name and pressed/not-pressed.
- **Focus** — visible focus indicator; icon-only toggles have accessible names.

## Content guidelines

- Name the option the toggle controls; keep tooltips consistent with the name.

## Composition

**Composed of:** Not applicable — a primitive; composed into **toggle-group**.

**Used by:** toggle-group, toolbars, menubar.

## Do / Don't

**Do**
- Expose the pressed state to assistive tech.
- Give icon-only toggles accessible names.

**Don't**
- Confuse a toggle (tool state) with a switch (setting).

## References

- WAI-ARIA Authoring Practices — Button (toggle) pattern.
