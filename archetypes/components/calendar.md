---
id: calendar
title: Calendar
layer: component
version: 1.0.0
status: stable
summary: A grid of dates for viewing a month and selecting one or more days.
since: 0.2.0
updated: 2026-07-16
tags: [date, selection, grid, input]
aliases: [date-grid, month-view]
usedBy: [date-picker, form, dashboard]
related: [date-picker, popover, input]
maintainers: [brnrdog]
---

# Calendar

## Intent

A calendar presents dates in a familiar month grid so users can orient by weekday
and week, and select a day, a range, or several days. It is the visual core that a
date-picker wraps in a popover, but it also stands alone for scheduling views.

## API

```json
{
  "props": [
    {"name":"mode","type":"enum","values":["single","range","multiple"],"default":"single","description":"Selection model."},
    {"name":"value","type":"string","default":"","description":"Selected date(s)."}
  ],
  "slots": [
    {"name":"day","required":true},
    {"name":"controls","required":false,"description":""}
  ],
  "events": ["onSelect"],
  "a11y": {"role":"grid","keyboard":["ArrowLeft","ArrowRight","ArrowUp","ArrowDown","PageUp","PageDown","Home","End"],"announces":["selected date"]},
  "states": ["default","selected","today","disabled","outside-month"],
  "tokens": ["color.action.*","radius.md"]
}
```

## When to use / When not to use

**Use when**
- Selecting dates where weekday/adjacency context matters.
- Displaying a month overview of events or availability.

**Avoid when**
- A single known date is easiest typed — offer a text **input** too.
- Only month/year is needed — use dedicated month/year pickers.

## Anatomy

- **Header** (required) — current month/year with previous/next controls.
- **Weekday row** (required) — column headings.
- **Day grid** (required) — selectable day cells.
- **Selection & today markers** (required) — highlight selected and current day.
- **Range preview** (conditional) — for range selection.
- **Disabled/unavailable days** (optional).

## States & behavior

- **Navigation** — move between months/years.
- **Selection** — single, range (start→end), or multiple days.
- **Disabled dates** — min/max bounds or blocked days are not selectable.
- **Hover preview** — range endpoints preview on hover/focus.

Keyboard moves day-by-day and week-by-week; Page changes months.

## Variants

- **Single / range / multiple** selection.
- **Single or multi-month** display.
- **With event indicators** — dots or counts per day.

## Layout & responsiveness

A seven-column week grid with a month header. Multi-month layouts collapse to one
month on small screens. Day targets stay large enough to tap.

## Accessibility

- **Keyboard** — arrows move by day, up/down by week, Page by month; Enter/Space
  selects; bounds respected.
- **Semantics** — a grid with the focused/selected date and month context exposed;
  disabled dates communicated.
- **Screen reader** — announces the full date, weekday, and selection/today state.
- **Focus** — a single roving focus within the grid.

## Content guidelines

- Respect locale: first day of week, month/day names, and date format.
- Explain why dates are unavailable when it matters.

## Composition

```json
{
  "parts": [
    {"ref":"button","slot":"controls","note":"prev/next month"}
  ]
}
```

## Do / Don't

**Do**
- Support full keyboard date navigation.
- Localize weekdays, months, and week start.

**Don't**
- Force calendar picking when typing a date is faster.
- Make day targets too small to tap.

## References

- WAI-ARIA Authoring Practices — Date Picker Dialog (grid) pattern.
