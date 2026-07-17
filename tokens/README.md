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

## Theming

To re-skin an implementation, override token values — most usefully the
`color.neutral` ramp and the semantic aliases. Swapping the neutral ramp for a
tinted or fully different palette restyles everything downstream without
touching a single archetype or component.
