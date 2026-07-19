---
"@xpecs/xote": minor
"xpecs": minor
---

Add a modern SVG icon library with an `Icon` component.

- **`@xpecs/xote`**: new `Icons` module — a curated outline icon set (50 glyphs)
  in the Feather / Lucide visual language (24×24 grid, no fill, 2px round
  strokes) — and an `Icon` element that renders a named glyph as an inline SVG.
  Icons inherit the surrounding text color and optical size; pass `label` for a
  meaningful icon (role=img + accessible name) or omit it to mark it decorative.
  Sizes: `xs`, `sm`, `md`, `lg`, `xl`.
- **`@xpecs/xote`**: `Alert` now renders its `icon` as a glyph from the icon set
  (the prop takes an icon name) and shows a sensible per-variant default when none
  is given.
- **`xpecs`**: the `icon` element spec now types `size` as an enum and maps its
  implementation to `Icon.res`, so the component is compiler-checked against the
  contract.
