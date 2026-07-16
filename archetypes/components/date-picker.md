---
id: date-picker
title: Date Picker
layer: component
version: 1.0.0
status: stable
summary: A field that lets users enter or choose a date (or range) via typing and a calendar.
since: 0.2.0
updated: 2026-07-16
tags: [form, date, selection, input]
aliases: [date-input, date-field, datetime-picker]
composedOf: [input, calendar, popover, button]
usedBy: [form, field, data-table]
related: [calendar, input, popover, combobox]
maintainers: [brnrdog]
---

# Date Picker

## Intent

A date picker helps users provide a date (or range) accurately by combining a
typed field with a calendar for browsing. It balances speed for those who know the
date with visual context for those who need to see the month, and it enforces valid
ranges and formats.

## When to use / When not to use

**Use when**
- Collecting a date, date range, or date-time in a form.
- Both fast typing and calendar browsing are valuable.

**Avoid when**
- Only a month or year is needed — use a dedicated month/year picker.
- The full calendar view is the primary surface — use **calendar** directly.

## Anatomy

- **Field / input** (required) — accepts typed dates with a clear format.
- **Trigger** (required) — opens the calendar (icon button).
- **Popover calendar** (required) — for browsing and selecting.
- **Presets** (optional) — quick ranges ("Last 7 days").
- **Validation message** (conditional) — for invalid or out-of-range dates.

## States & behavior

- **Typed entry** — parses and formats as the user types; tolerant of formats.
- **Calendar selection** — opens a popover; selecting fills the field.
- **Range** — start then end, with a hover/focus preview.
- **Constraints** — min/max and disabled dates enforced in both entry paths.
- **Invalid** — clear message; input preserved.

## Variants

- **Single date / range / date-time**.
- **With presets** — common relative ranges.
- **Inline** — calendar always visible (no popover).

## Layout & responsiveness

The field sits with a trigger; the calendar opens in a popover that flips to stay
in view, or as a sheet on small screens. Presets sit beside or above the calendar.

## Accessibility

- **Keyboard** — type a date directly; open and operate the calendar by keyboard;
  Esc closes and returns focus to the field.
- **Semantics** — the field describes the expected format; the calendar exposes
  grid semantics and selection/bounds.
- **Screen reader** — announces selected date(s), constraints, and validation.
- **Focus** — managed between field, popover, and back on close.

## Content guidelines

- Show the expected format in helper text and honor locale.
- Explain disabled dates and range rules.

## Composition

**Composed of:** input, calendar, popover, button.

**Used by:** form, field, data-table (date filters).

## Do / Don't

**Do**
- Allow both typing and picking.
- Enforce and explain min/max and disabled dates in both paths.

**Don't**
- Force calendar navigation for a date the user can type.
- Reset the field on an invalid parse.

## References

- WAI-ARIA Authoring Practices — Date Picker (Dialog) and combobox guidance.
