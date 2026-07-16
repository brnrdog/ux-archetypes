---
id: collapsible
title: Collapsible
layer: component
version: 1.0.0
status: stable
summary: A single region that expands and collapses to show or hide its content.
since: 0.2.0
updated: 2026-07-16
tags: [disclosure, content, progressive-disclosure]
aliases: [disclosure, expandable, show-more]
composedOf: [button]
usedBy: [accordion, sidebar, card, form]
related: [accordion, popover]
maintainers: [brnrdog]
---

# Collapsible

## Intent

A collapsible is a single show/hide region controlled by a trigger. It defers
secondary detail until the user asks for it — a "show more", an optional form
section, an expandable row of detail — keeping the default view clean.

## When to use / When not to use

**Use when**
- One region of content is optional or secondary and can be hidden by default.
- You want a lightweight "show more / show less" toggle.

**Avoid when**
- There are several sibling sections to expand — use an **accordion**.
- Hidden content overlays rather than pushes — use a **popover**.

## Anatomy

- **Trigger** (required) — toggles the region and shows expanded/collapsed state.
- **Content region** (required) — revealed or hidden.

## States & behavior

- **Collapsed / expanded** — toggled by the trigger.
- **Disabled** — cannot be toggled.

Expansion animates height and pushes surrounding content rather than overlaying.

## Variants

- **Inline "show more"** — for truncated text.
- **Sectioned** — an optional block within a form or panel.

## Layout & responsiveness

Content flows in the document, moving what follows. Keep the trigger's target
adequate and the expand/collapse motion smooth to avoid jumps.

## Accessibility

- **Keyboard** — trigger is focusable and toggles on `Enter`/`Space`.
- **Semantics** — the trigger exposes expanded/collapsed and controls the region.
- **Screen reader** — announces state and the relationship to the content.
- **Focus** — visible focus on the trigger.

## Content guidelines

- Label the trigger by what it reveals ("Show advanced options").
- Keep the collapsed state informative enough to decide whether to expand.

## Composition

**Composed of:** button (trigger).

**Used by:** accordion (as items), sidebar, card, form.

## Do / Don't

**Do**
- Make the trigger's state and target obvious.
- Use it for genuinely secondary content.

**Don't**
- Hide essential content everyone needs.
- Use a single collapsible where an accordion of peers is meant.

## References

- WAI-ARIA Authoring Practices — Disclosure pattern.
