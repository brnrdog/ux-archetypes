# UX Archetypes — Website

An interactive catalogue for the archetypes in this repository. Browse every
archetype in the sidebar and see a **live implementation rendered with
[Xote](https://xote.dev)** for each one.

## Stack

- **[Vite](https://vitejs.dev)** — dev server and bundler.
- **[ReScript](https://rescript-lang.org)** — typed language compiling to JS.
- **[Xote](https://xote.dev)** — fine-grained reactive UI library for ReScript,
  built on `rescript-signals`.
- **[Tailwind CSS](https://tailwindcss.com)** (v4) — utility styling.
- **Monochrome theme** — a single neutral (grayscale) palette; hierarchy comes
  from value, weight, and spacing rather than hue.

## How it works

```
archetypes/**/*.md            (the specs, one directory up)
        │
        ▼  scripts/generate-registry.mjs   (npm run registry)
src/ArchetypesData.res        generated, typed list of every archetype
        │
        ▼
src/App.res                   sidebar + router (Xote Router)
src/Examples.res              a live Xote component per archetype (`get`)
src/Ui.res                    shared monochrome class tokens + helpers
src/Main.res                  entry: Router.init + View.mountById
```

The **registry generator** reads the archetype markdown frontmatter (plus the
first paragraph of each `## Intent`) and emits `src/ArchetypesData.res`. That
guarantees the sidebar always lists every archetype in the collection.

Each archetype's example is a small self-contained Xote component in
`Examples.res`; `Examples.get(id)` maps an archetype `id` to its rendered node.
Archetypes without an example fall back to a graceful placeholder.

## Develop

```bash
npm install
npm run registry     # generate src/ArchetypesData.res from ../archetypes
npm run res:dev      # ReScript compiler in watch mode  (terminal 1)
npm run dev          # Vite dev server                  (terminal 2)
```

`npm run dev` also runs the registry + a one-off ReScript build first, so a
single `npm run dev` is enough for a quick look; use `res:dev` in parallel for
live recompilation while editing `.res` files.

## Build

```bash
npm run build        # registry → rescript → vite build  →  dist/
npm run preview      # serve the production build
```

## Deploy (GitHub Pages)

The site deploys automatically via
[`.github/workflows/deploy-pages.yml`](../.github/workflows/deploy-pages.yml)
on every push to the deploy branch that touches `website/`, `archetypes/`, or
the workflow itself. It builds with `BASE_PATH=/<repo>/`, adds a `404.html`
SPA fallback and `.nojekyll`, and publishes `website/dist`.

**One-time setup:** in the repository, go to **Settings → Pages** and set
**Source** to **GitHub Actions**. After the first successful run the site is
live at:

```
https://brnrdog.github.io/ux-archetypes/
```

Notes:

- The build injects the base path; `Router.init(~basePath=…)` reads Vite's
  `BASE_URL`, so client-side routing and deep links resolve under the subpath.
- Deep links (e.g. `/ux-archetypes/a/button`) are served through `404.html`
  (a copy of `index.html`), which boots the app and lets the router take over —
  the standard SPA pattern for a static host.
- For a custom domain / user site served from `/`, no base is needed; the same
  build works with `BASE_PATH=/` (the default).

## Verify (optional)

```bash
npm run smoke        # drives every /a/:id route in headless Chromium,
                     # asserting each renders with no console errors
```

Requires a Chromium available to `playwright-core`.

## Adding a live example

1. Add a `@jsx.component` module to `src/Examples.res`.
2. Register it in `Examples.get` under the archetype's `id`.
3. Recompile — the detail page picks it up automatically.

Keep examples framework-idiomatic and monochrome: reach for the shared tokens in
`Ui.res` (`btnPrimary`, `inputBase`, `card`, …) so every example reads as one
system.
