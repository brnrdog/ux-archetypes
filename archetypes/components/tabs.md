---
id: tabs
title: Tabs
layer: component
version: 1.0.0
status: stable
summary: A set of labeled sections where selecting a tab reveals its associated panel in place.
since: 0.2.0
updated: 2026-07-16
tags: [navigation, content, sections, in-page]
aliases: [tab-group, segmented-views]
composedOf: [separator, badge]
usedBy: [dashboard, settings, card]
related: [accordion, toggle-group, navigation-menu]
traits: [roving-focus]
maintainers: [brnrdog]
---

# Tabs

## Intent

Tabs divide related content into peer sections and let users switch between them in
place, showing one panel at a time. They organize a moderate amount of content
without navigation or scrolling, keeping the user in the same context while they
move between views of the same subject.

## When to use / When not to use

**Use when**
- Content splits into a few peer sections viewed one at a time within the same context.

**Avoid when**
- Users need to compare sections simultaneously — show them together.
- Sections are steps in a sequence — use a stepper/wizard.
- There are many sections or deep hierarchy — use navigation instead.

## Anatomy

- **Tab list** (required) — the row/column of tab triggers.
- **Tabs** (required) — labels, optional icons/badges, one selected.
- **Active indicator** (required) — marks the selected tab.
- **Panels** (required) — one content region per tab; only the active shows.

## States & behavior

- **Selected / unselected** — one active tab and panel.
- **Activation model** — automatic (on focus) or manual (on Enter/Space).
- **Disabled** — a tab that can't be selected.
- **Overflow** — scroll or collapse tabs that exceed the width.

Arrow keys move between tabs; the tab list is a single tab stop.

## Variants

- **Horizontal / vertical** orientation.
- **Underline / pill / enclosed** styles.
- **Scrollable** — for many tabs.

## Layout & responsiveness

The tab list sits above (or beside) the panels; the active indicator tracks
selection. When tabs exceed the width, make the list scrollable with affordances,
or collapse into a select on very small screens. Panels occupy the same space.

## Accessibility

- **Keyboard** — one tab stop; arrows move between tabs; Home/End jump; activation
  is automatic or manual consistently.
- **Semantics** — a tablist with tabs controlling their panels; selected state and
  tab/panel relationships exposed.
- **Screen reader** — announces the tab, its selected state, and the associated panel.
- **Focus** — visible focus on the active tab; panel is reachable.

## Content guidelines

- Short, parallel tab labels; keep the number small.
- Don't hide critical, always-needed content behind a non-default tab.

## Composition

**Composed of:** separator, badge (counts on tabs).

**Used by:** dashboard, settings, card.

## Do / Don't

**Do**
- Keep labels short and the set small.
- Follow tab keyboard conventions.

**Don't**
- Use tabs to compare content that must be seen together.
- Overflow into an unusable row without a fallback.

## References

- WAI-ARIA Authoring Practices — Tabs pattern.
