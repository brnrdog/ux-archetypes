# @xpecs/xote

Accessible UI components for [Xote](https://xote.dev) / ReScript that implement
the [Xpecs](https://github.com/brnrdog/ux-archetypes) contracts. Each
component's prop types are **generated from the spec's `## API` contract**
(`Contracts.res`), so the compiler enforces that the implementation can't drift
from the spec's allowed values.

Styled against [`@xpecs/tokens`](../tokens) via the semantic utilities
(`bg-action`, `text-ink`, …), so re-theming is a token change, not a code change.

## Components

`Button`, `IconButton`, `Link`, `Badge`, `Avatar`, `Icon`, `Kbd`, `Separator`,
`Spinner`, `Input`, `Field`, `Switch`, `Alert`, `Accordion`, `Collapsible`,
`Tabs`, `Tooltip`, `Dialog`, `Select`, `Backdrop`, plus shared `Ui` helpers.

## Icons

`Icon` renders a named glyph from a small, modern **outline icon set** (`Icons`)
in the Feather / Lucide visual language — every glyph is drawn on a 24×24 grid
with no fill, 2px strokes, and round caps/joins, so it inherits the surrounding
text color and optical weight.

```rescript
<Icon name="search" />                     // decorative (hidden from a11y)
<Icon name="trash" label="Delete" />       // meaningful (role=img + name)
<Icon name="check" size=#lg />             // xs · sm · md · lg · xl
<IconButton label="Edit"> <Icon name="edit" /> </IconButton>
```

`Icons.names` lists the full set; `Icons.get(name)` returns a glyph's geometry.
Colour comes from the text (`currentColor`), so `class="text-status-danger"` on
an ancestor tints the icon. Icon paths are adapted from
[Feather Icons](https://feathericons.com) (MIT).

## Install

```sh
npm install @xpecs/xote @xpecs/tokens
```

Peer dependencies: `rescript`, `@rescript/core`, `rescript-signals`, `xote`.

## Use

Add it to your `rescript.json` dependencies (the package builds `namespace:false`,
so its modules are available unqualified):

```json
{ "dependencies": ["@rescript/core", "rescript-signals", "xote", "@xpecs/xote"] }
```

```rescript
<Button variant=#primary onClick={_ => submit()}>
  {React.string("Save")}
</Button>
```

Import the token CSS once at your app entry (see `@xpecs/tokens`):

```css
@import "tailwindcss";
@import "@xpecs/tokens/tailwind.css";
```

## Build

`npm run build` regenerates `Contracts.res` from the spec specs and compiles
the package with ReScript.
