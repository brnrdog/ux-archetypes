# @prescriptive/tokens

The design tokens of [Prescriptive](https://github.com/brnrdog/prescriptive)
as ready-to-consume artifacts — CSS custom properties, a Tailwind v4 preset,
theme overlays, and a typed JS export. Generated from the framework's W3C DTCG
source of truth, so they never drift from the specs.

## Install

```sh
npm install @prescriptive/tokens
```

## Use

**Plain CSS** — every token as a `--ux-*` custom property:

```css
@import "@prescriptive/tokens/variables.css";

.button { background: var(--ux-color-action-default); color: var(--ux-color-action-onAction); }
```

**Tailwind v4** — get the semantic utilities (`bg-action`, `text-ink`,
`bg-status-danger`, `rounded-lg`, …) that resolve from the tokens:

```css
@import "tailwindcss";
@import "@prescriptive/tokens/tailwind.css";
```

**Theming** — opt into a named theme and light/dark by setting attributes on any
ancestor (usually `<html>`); the overlays re-point the token variables:

```css
@import "@prescriptive/tokens/themes.css";
```
```html
<html data-theme="ocean" data-mode="dark">
```

**JS / TS** — the resolved values as data:

```js
import { tokens, flat, themes } from "@prescriptive/tokens";

flat["color.action.default"]; // "#1b1917"
tokens.color.neutral["900"];  // "#1b1917"
```

## What's in `dist/`

| File | Contents |
| --- | --- |
| `variables.css` | `:root { --ux-* }` — all tokens as custom properties (aliases stay live). |
| `tailwind.css` | A Tailwind v4 `@theme` block (utility bridge) plus the `--ux-*` mirror. |
| `themes.css` | `[data-theme]` / `[data-mode]` overlays for the bundled themes and light/dark. |
| `tokens.js` / `tokens.d.ts` | Resolved tokens as nested + flat objects, and the theme list. |
| `tokens.json` / `themes.json` | The raw DTCG sources. |

Run `npm run build` to regenerate from the framework source.
