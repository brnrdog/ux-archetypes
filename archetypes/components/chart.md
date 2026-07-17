---
id: chart
title: Chart
layer: component
version: 1.0.0
status: stable
summary: A visual encoding of data — bars, lines, areas, and more — that reveals patterns and comparisons.
since: 0.2.0
updated: 2026-07-16
tags: [data, visualization, analytics, dashboard]
aliases: [graph, plot, data-viz]
usedBy: [dashboard, card, data-table]
related: [data-table, progress, card]
maintainers: [brnrdog]
---

# Chart

## Intent

A chart encodes data visually so people can perceive trends, comparisons, and
distributions faster than reading numbers. It turns a dataset into a shape the eye
can interpret, supporting decisions on dashboards and reports.

## API

```json
{
  "props": [
    {"name":"type","type":"enum","values":["bar","line","area","pie"],"default":"bar","description":"Visual encoding."}
  ],
  "slots": [
    {"name":"series","required":true},
    {"name":"axis","required":false},
    {"name":"legend","required":false},
    {"name":"surface","required":false,"description":""}
  ],
  "a11y": {"role":"img","announces":["summary","data table alternative"]},
  "states": ["default","loading","empty"],
  "tokens": ["color.chart.*"]
}
```

## When to use / When not to use

**Use when**
- Patterns, trends, or comparisons matter more than exact values.
- A dataset is easier to grasp visually than as a table.

**Avoid when**
- Users need precise, lookup-style values — pair with or use a **data-table**.
- There are too few data points to justify a chart.

## Anatomy

- **Plot area** (required) — where marks are drawn.
- **Marks** (required) — bars, lines, points, areas, arcs encoding values.
- **Axes & gridlines** (conditional) — scales and reference lines.
- **Legend** (conditional) — maps color/shape to series.
- **Tooltip** (optional) — precise values on hover/focus.
- **Title & caption** (optional) — what the chart shows and its source.
- **Empty/loading/error states** (required) — when data is missing or pending.

## States & behavior

- **Loading / empty / error** — clearly distinguished from "zero values".
- **Interactive** — hover/focus reveals values; series can be toggled.
- **Responsive redraw** — adapts marks and labels to available size.

## Variants

- **Comparison** — bar/column.
- **Trend** — line/area, sparkline.
- **Part-to-whole** — stacked bar, pie/donut (sparingly).
- **Distribution / relationship** — histogram, scatter.

## Layout & responsiveness

Charts resize to their container; labels thin out or rotate as space shrinks, and
small variants (sparklines) drop axes entirely. Keep a readable data-to-ink ratio
and avoid clutter at small sizes.

## Accessibility

- **Non-visual access** — provide the underlying data as an accessible table or
  summary; don't rely on the visual alone.
- **Color** — distinguish series by more than color (labels, patterns, direct
  labeling); meet contrast.
- **Keyboard** — interactive elements (legend toggles, focusable points) are
  operable; tooltips are reachable without hover.
- **Description** — a text summary conveys the key takeaway.

## Content guidelines

- Title states the insight, not just the metric.
- Label units and time ranges; start axes honestly.

## Composition

```json
{
  "parts": [
    {"ref":"legend","slot":"legend"},
    {"ref":"tooltip","slot":"series","note":"point details"},
    {"ref":"card","slot":"surface"}
  ]
}
```

## Do / Don't

**Do**
- Offer an accessible data alternative and a plain-language summary.
- Choose the chart type from the question being asked.

**Don't**
- Encode meaning by color alone.
- Mislead with truncated or distorted scales.

## References

- WCAG — non-text content and use of color.
- Data visualization best practices (encoding, honesty, clarity).
