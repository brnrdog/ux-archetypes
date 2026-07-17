---
id: legend
title: Legend
layer: element
version: 1.0.0
status: stable
summary: A key that maps a chart's colors or symbols to the series they represent.
since: 0.4.0
updated: 2026-07-17
tags: [chart, data, key, display]
aliases: [chart-key, key, series-key]
composedOf: []
usedBy: [chart]
related: [chart, badge]
maintainers: [brnrdog]
---

# Legend

## Intent

A legend is the key that tells the reader what a chart's colors, patterns, or
symbols mean — which line is revenue, which bar is churn. Without it a
multi-series chart is undecipherable; with it, the encoding becomes readable. It
often doubles as a control for toggling series on and off.

## API

```json
{
  "props": [

  ],
  "slots": [
    {"name":"text","required":true,"description":"Names the grouped set of controls."}
  ],
  "a11y": {"announces":["group name"]},
  "states": ["default"],
  "tokens": ["font.weight.medium"]
}
```

## When to use / When not to use

**Use when**
- A chart uses color/shape to distinguish multiple series or categories.

**Avoid when**
- There is a single series, or direct labeling on the marks is clearer.

## Anatomy

- **Items** (required) — one per series: a swatch/symbol plus its label.
- **Swatch** (required) — the color/pattern/marker matching the chart.
- **Label** (required) — the series name.
- **Value** (optional) — a current or total value per series.
- **Toggle affordance** (optional) — when items show/hide series.

## States & behavior

- **Static key** — maps encodings to labels.
- **Interactive** (optional) — clicking an item toggles that series; hidden series
  are visibly dimmed.
- **Hover link** (optional) — highlights the corresponding marks.

## Variants

- **Horizontal / vertical** placement.
- **Static vs. interactive** (toggle series).
- **With values** — legend items show numbers.

## Layout & responsiveness

Legend items sit adjacent to the plot (top, right, or bottom), wrapping as space
allows. On small charts the legend may move below the plot or collapse. Swatches
align with their labels and match the chart's encoding exactly.

## Accessibility

- **Association** — labels are the accessible source of series meaning, since
  color must not be the only cue; consider direct labeling too.
- **Interactive items** — expose pressed/selected state and are keyboard operable.
- **Contrast** — swatches and text meet non-text/text contrast.
- **Screen reader** — series names are available in the chart's accessible
  description or data alternative.

## Content guidelines

- Keep series names short and consistent with the data.
- Order legend items to match the chart (e.g., stacking order).

## Composition

**Composed of:** Not applicable — a small display element (swatch + label per item).

**Used by:** chart.

## Do / Don't

**Do**
- Match swatches exactly to the chart encoding.
- Provide labels so meaning doesn't depend on color alone.

**Don't**
- Rely on color-only differences without labels.
- Detach the legend so far it's hard to correlate.

## References

- WCAG — Use of Color; data visualization labeling guidance.
