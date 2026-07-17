# Changelog

All notable changes to this collection are documented here. The collection
follows [Semantic Versioning](https://semver.org/) and the format of
[Keep a Changelog](https://keepachangelog.com/).

## [0.6.0] - 2026-07-17

A pre-release restructuring pass toward implementability. Contains breaking
changes (layer taxonomy, file locations); the collection is not yet formally
released.

### Changed (breaking)

- **New `block` layer.** Page-sections (`hero`, `feature-grid`, `testimonial`,
  `pricing-table`, `faq`, `cta-section`) moved out of `components/` into
  `archetypes/blocks/` and now declare `layer: block`. This restores a crisp
  meaning to "component" (a reusable, composable unit) versus "block" (a
  page-level section). The layer enum is now
  `element | component | block | page | flow`.

### Added

- **API contracts on every element, component, and block.** All 74
  element/component/block archetypes now carry a `## API` contract (props,
  slots, events, a11y, states, tokens); pages and flows are excluded as
  non-implementable. Ten are mapped to a reference implementation via a new
  `implementation:` frontmatter field and conformance-checked on every build;
  five (button, badge, icon-button, link, separator) are **compiler-enforced** —
  the component annotates its props with the generated `Contracts.*` types, so an
  enum value that drifts from the spec fails to compile.
- **Interactive components extracted and mapped.** `alert`, `tabs`, `accordion`,
  `collapsible`, `tooltip`, `dialog`, and `select` are now real reusable
  components (`Alert.res`, `Tabs.res`, …) that their live examples consume,
  rather than one-off inline demos — each mapped to its contract and
  conformance-checked (17 components checked in total; `alert`/`tabs`/`accordion`
  enums compiler-enforced). `Accordion` genuinely implements both `single` and
  `multiple` from its `type` prop.
- `INDEX.md` is now **generated** from the specs' frontmatter (`npm run index`),
  so the registry can no longer drift from the archetypes.

- **Structural composition.** The `## Composition` section can now carry a
  `json` block that wires each part to a **slot** with the **props** passed and a
  note, instead of a flat list of ids. The registry derives `composedOf` from
  these parts (the frontmatter `composedOf:` line is dropped in favor of the
  block), and the website renders composition grouped by slot with prop pills.
  **Every composite archetype** (components, blocks, pages, and flows — 56 in
  all) is now wired this way; only primitives have no parts.
- **Behavior traits.** A new `traits/` layer captures cross-cutting interaction
  contracts — `dismissible`, `focus-trap`, `anchored`, `roving-focus`,
  `typeahead` — that many archetypes share. Archetypes reference them via a new
  `traits:` frontmatter field (schema in `schema/trait.schema.json`); 19
  overlays and collections now declare their behaviors instead of re-describing
  them in prose. The website renders trait chips on each archetype, dedicated
  trait pages (with an "exhibited by" back-reference), and a Behaviors group in
  the sidebar.
- **Traits are testable.** Each trait declares the keyboard `keys` an archetype
  must support to legitimately claim it (`match: all | any`). A new build gate
  (`npm run conformance:traits`) verifies every trait claim against the
  archetype's API `a11y.keyboard` — it caught that `command` (a modal palette)
  was missing `Tab` and `toast` was missing `Escape`; both are fixed. Trait
  pages list the required keys.

- **Semantic token layer.** `tokens.json` gains the roles the contracts bind to:
  `color.action.*`, `color.status.*`, `color.chart.*`, and `space.inline.*` —
  all aliased into the monochrome ramp, so the baseline stays grayscale but a
  retheme has real semantic hooks.
- **Two more build gates.** `conformance:composition` verifies every composition
  `ref` resolves and every `slot` is declared in the archetype's API (or the
  page-layout vocabulary); `conformance:tokens` verifies every token role a
  contract references exists in `tokens.json`. Both run in `npm run checks`
  alongside prop and trait conformance. Reconciling for the composition gate
  surfaced 13 slots that were used in composition but missing from the owning
  API — now added.

### Changed

- The conformance check is now driven by the `implementation:` frontmatter field
  rather than a hardcoded map, so mapping a component to its spec is a one-line
  edit in the archetype.
- The markdown→HTML renderer is now a shared module (`website/scripts/md.mjs`),
  used by both the archetype and trait generators.

## [0.5.0] - 2026-07-17

### Added

- **Themes are now framework-owned, with orthogonal light/dark modes.** The
  theme presets moved out of the website code into
  [`tokens/themes.json`](tokens/themes.json). A **theme** (monochrome, indigo,
  forest, editorial, terminal, sunset, vibrant, ocean, coral) carries the palette
  identity — accent, status, radius, font, light-mode ramp tint — and a separate
  **mode** overlay (`light` / `dark`) applies on top of *any* theme, inverting the
  neutral ramp for dark while preserving the theme's accent/status. The website's
  picker (a theme grid + a Light/Dark toggle) is generated from the file, and
  every theme and mode override is validated against the tokens
  (`conformance:tokens`). The reference components and chrome were made fully
  token-driven (`bg-surface` / `text-ink` / `text-neutral-0` instead of literal
  `bg-white` / `text-white`) so dark mode inverts cleanly.
- **Machine-readable API contracts.** Archetypes can now carry an `## API`
  section — a `json` block naming the props (with types, enum values, and
  defaults), slots, events, accessibility expectations, states, and design-token
  roles. This is the skin-agnostic interface an implementer builds against,
  validated by `schema/api.schema.json`. `button` is the first archetype with a
  contract (element version → 1.1.0); the template documents the pattern.

### Website

- The contract drives real tooling, proving the format end-to-end on `button`:
  - `scripts/generate-contracts.mjs` emits `Contracts.res` (a polymorphic-variant
    type per enum prop). `Button.res` annotates its props with these types, so
    the **compiler** enforces that the implementation's allowed values match the
    spec.
  - `scripts/check-conformance.mjs` asserts every contract prop is implemented
    and gates the build (`npm run conformance`) — drift now fails CI instead of
    rotting silently. (It immediately caught that `Button` was missing the
    `loading` and `lg` states the spec described; both are now implemented.)
  - Each detail page renders the contract as a **prop table** (props, slots,
    a11y, states, tokens) alongside the live example and prose spec.

## [0.4.1] - 2026-07-17

### Changed

- Design tokens: a softer, more modern radius scale (`radius.*` bumped, added
  `radius.3xl`). Flows through the website's Tailwind theme automatically.

### Website

- **Semantic color roles as Tailwind utilities.** The generated `@theme` now
  exposes the semantic roles — `bg-action` / `text-on-action` / `bg-action-hover`
  / `bg-action-subtle`, `bg-status-{info,success,warning,danger}`, `text-ink` /
  `text-muted`, `bg-surface` / `bg-paper` / `border-border`, `bg-chart-*` — so a
  component library just uses these classes instead of hardcoded grays. Aliases
  stay live (`--color-action: var(--color-neutral-900)`), so overriding a base
  token cascades through the roles that reference it. The reference components
  (`Ui.res` buttons/inputs/surfaces, `Alert`, `IconButton`, and the app chrome's
  accents) were repointed to these roles, so editing `action` recolors every
  control and `status.danger` recolors destructive actions and danger alerts —
  while the monochrome default is unchanged. Documented in `tokens/README.md`.
- **Design Tokens page + live editor.** A generated reference of every token the
  framework defines (from `tokens.json`), where each token is **editable in
  place** — colors via a picker, dimensions/fonts via text. Edits override the
  token's Tailwind `@theme` variable so they cascade through the entire site
  (colors, radius, shadow, fonts, weight, and spacing base), persist locally, and
  reset. The `@theme` mapping was widened so more token groups drive utilities.
- **Nine theme presets, including functional palettes.** The topbar's theme
  popup offers Monochrome, Indigo, Forest, Editorial, Terminal, and Sunset (ramp
  tints), plus **Vibrant, Ocean, and Coral** which also set the *functional*
  intent colors — the primary `action` and the four `status` roles
  (info / success / warning / danger) — shown as multi-color swatches. Those
  roles are now consumed across components (all four `Alert` variants, the
  archetype status badge), so a functional preset gives every feedback surface a
  purposeful color. Each preset also tints **both ends** of the neutral ramp —
  the light steps (backgrounds, borders, surfaces) as well as the dark ones
  (text, accents) — leaving the mid-greys neutral for readability, so switching a
  preset visibly re-skins the whole page, not just the accents. Presets and
  per-token edits share one override store, so they persist, appear in the
  editor, and reset together.
- New app shell: a topbar with a **spotlight search** (⌘K / Ctrl+K) that filters
  and jumps to any archetype, a **collapsible sidebar**, and a **fullscreen** view
  for any live example (Escape to exit).
- Each detail page now renders the **full archetype spec** (Intent, When to
  use, Anatomy, States, Variants, Accessibility, and the rest), generated from
  the archetype's markdown source at build time.
- The app shell now composes the reusable archetype components (Button, Badge,
  Kbd, Link, Icon Button) rather than bespoke markup.

## [0.4.0] - 2026-07-17

### Added

- **Flows** — the fourth layer is now populated: `authentication`, `onboarding`,
  `checkout` (under `archetypes/flows/`).
- Landing-page **section** components: `hero`, `feature-grid`, `testimonial`,
  `pricing-table`, `faq`, `cta-section`.
- Additional primitives and patterns: `icon`, `logo`, `legend` (elements);
  `stat`, `search`, `comment` (components).
- Live Xote examples on the website for all new archetypes; the site now
  renders the Flows layer in the sidebar.

### Changed

- The composition graph is now **fully closed** — every `composedOf` / `usedBy`
  / `related` reference resolves to an existing archetype.

## [0.3.0] - 2026-07-17

### Added

- New **element** archetypes: `link`, `icon-button`.
- New **component** archetypes: `toolbar`, `list`, `footer`.
- New **page** archetypes: `dashboard`, `settings`, `sign-in`, `pricing`.
- Design tokens (`tokens/tokens.json`, W3C DTCG format) with a monochrome
  baseline, documented in `tokens/README.md`; the website generates its theme
  from them.

### Fixed

- Corrected dangling composition references: `navbar` → `breadcrumb` (was
  `breadcrumbs`) and `dropdown-menu` (was `menu`); `button` → `dialog` (was
  `modal`).

## [0.2.0] - 2026-07-16

### Changed

- Renamed the collection to **UX Archetypes** (`ux-archetypes`), framing it as
  User Experience archetypes spanning elements through full experiences.

### Added

- A comprehensive baseline of **element** archetypes: avatar, badge, checkbox,
  label, progress, radio-group, separator, skeleton, slider, switch, textarea,
  toggle, toggle-group, aspect-ratio, scroll-area, input-otp, kbd, spinner,
  typography (joining button and input).
- A comprehensive baseline of **component** archetypes: accordion, alert,
  alert-dialog, breadcrumb, calendar, card, carousel, chart, collapsible,
  combobox, command, context-menu, data-table, date-picker, dialog, drawer,
  dropdown-menu, form, hover-card, menubar, navigation-menu, pagination, popover,
  resizable, select, sheet, sidebar, table, tabs, toast, tooltip, empty-state,
  field, button-group, input-group (joining navbar).
- Composition links (`composedOf` / `usedBy` / `related`) wiring the archetypes
  into a connected graph.

## [0.1.0] - 2026-07-16

### Added

- Initial repository structure for the UX Archetypes collection.
- Layer taxonomy: `element`, `component`, `page`, with `flow` as an extension.
- Canonical archetype document pattern (`templates/ARCHETYPE_TEMPLATE.md`).
- Metadata schema for frontmatter (`schema/archetype.schema.json`).
- Registry (`INDEX.md`), contribution guide (`CONTRIBUTING.md`), and two-level
  semantic versioning (collection + per-archetype).
- Example archetypes:
  - `button` (element)
  - `input` (element)
  - `navbar` (component)
  - `landing-page` (page)
