# Design Tokens

The **shared, technology-agnostic design decisions** behind the archetypes —
color, type, spacing, radius, elevation, motion — defined once so every
implementation can stay visually consistent.

Archetypes describe a pattern's _structure and behavior_ in words and
deliberately avoid pixels and hues. Tokens are the other half: the concrete,
named values a project plugs in. Together they let the same pattern render
consistently across projects and stacks.

## Format

Tokens live in [`tokens.json`](tokens.json) in the
**[W3C Design Tokens (DTCG) format](https://www.w3.org/community/design-tokens/)** —
the emerging interchange standard, readable by a growing set of tools (Style
Dictionary, Tokens Studio, etc.).

- Each token is an object with a `$value` (and inherits `$type` from its group).
- Aliases reference another token with `{group.token}` syntax, e.g.
  `"ink": { "$value": "{color.neutral.900}" }`.

```jsonc
"color": {
  "$type": "color",
  "neutral": { "900": { "$value": "#171717" }, ... },
  "ink":     { "$value": "{color.neutral.900}" }
}
```

## Categories

| Group         | What it holds |
| ------------- | ------------- |
| `color`       | A single grayscale `neutral` ramp (0–1000) plus semantic aliases: `ink`, `paper`, `surface`, `muted`, `border`, `accent`, `accentContrast`. **Semantic roles** the archetype contracts bind to: `action` (`default`/`hover`/`subtle`/`onAction`), `status` (`info`/`success`/`warning`/`danger`), and `chart` (`1`–`6`). Monochrome by design — hierarchy comes from value, not hue; retheme by pointing these roles at brand hues. |
| `font`        | `family` (sans/mono), `weight`, `size` scale, `lineHeight`. |
| `space`       | Spacing scale for padding, margin, and gaps, plus semantic `inline` padding (`sm`/`md`/`lg`) for controls. |
| `radius`      | Corner radii, `none` → `full`. |
| `borderWidth` | Hairline / thick. |
| `shadow`      | Elevation `sm` / `md` / `lg`. |
| `duration`    | Motion timings. |
| `zIndex`      | Stacking order for overlays, modals, toasts. |

## Consuming tokens

Because tokens are plain, standard JSON, any project can adopt them:

- **This website** — [`website/scripts/generate-tokens-css.mjs`](../website/scripts/generate-tokens-css.mjs)
  reads `tokens.json` and emits a Tailwind `@theme` block (so utilities like
  `bg-neutral-900`, `font-sans`, and `rounded-lg` resolve from the tokens) plus
  a `:root` mirror of every token as a `--ux-*` custom property. Change a value
  here and the whole site re-themes.
- **Other stacks** — feed `tokens.json` to Style Dictionary or an equivalent to
  emit CSS variables, SCSS, Swift, Kotlin, JS objects, etc.

## Building a component library on the tokens

The generated `@theme` exposes the semantic roles as ordinary Tailwind utilities,
so a new component library just uses these classes and re-themes for free — no
hardcoded grays. Aliases stay live (`--color-action: var(--color-neutral-900)`),
so overriding a base token cascades through everything that references it.

| Role | Utilities | Use for |
| ---- | --------- | ------- |
| `action` / `action-hover` / `action-subtle` / `on-action` | `bg-action`, `hover:bg-action-hover`, `bg-action-subtle`, `text-on-action`, `ring-action` | interactive controls (buttons, toggles, focus rings) |
| `status-{info,success,warning,danger}` | `bg-status-danger`, `text-status-success`, `border-status-warning` | feedback (alerts, toasts, validation) |
| `ink` / `muted` | `text-ink`, `text-muted` | primary and secondary text |
| `surface` / `paper` / `border` | `bg-surface`, `bg-paper`, `border-border` | cards, page background, dividers |
| `chart-1…6` | `bg-chart-1`, `text-chart-2` | categorical data series |
| `neutral-0…1000` | `bg-neutral-900`, `text-neutral-500` | raw ramp when no role fits |

For example, the reference `Button` composes `bg-action text-on-action
hover:bg-action-hover`, and `Alert` uses `border-status-danger` — so editing the
`action` or `status.danger` token re-themes every button or alert instantly.

## Theming

To re-skin an implementation, override token values — most usefully the
`color.neutral` ramp (which the semantic roles alias by default) or the semantic
roles themselves (`color.action.*`, `color.status.*`) for finer control.
Swapping the ramp for a tinted palette restyles everything downstream without
touching a single archetype or component.

### Themes (presets)

[`themes.json`](./themes.json) ships ready-made themes — each a named bundle of
token overrides (a map of token path → value) on top of the monochrome baseline.
Included: `monochrome`, `indigo`, `forest`, `editorial`, `terminal`, `sunset`,
`vibrant`, `ocean`, `coral`, and a dark `night`. A theme that tints **both ends**
of the neutral ramp re-skins backgrounds and text together; `night` inverts the
whole ramp for a dark mode. The website's theme picker is generated from this
file (`website/scripts/generate-themes.mjs`), and every override path is
validated against the tokens (`npm run conformance:tokens`).
