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

- **API contracts on every element.** All 26 element archetypes now carry a
  `## API` contract (props, slots, events, a11y, states, tokens). Nine are
  mapped to a reference implementation via a new `implementation:` frontmatter
  field and conformance-checked on every build; five of those (button, badge,
  icon-button, link, separator) are **compiler-enforced** — the component
  annotates its props with the generated `Contracts.*` types, so an enum value
  that drifts from the spec fails to compile.
- `INDEX.md` is now **generated** from the specs' frontmatter (`npm run index`),
  so the registry can no longer drift from the archetypes.

- **Structural composition.** The `## Composition` section can now carry a
  `json` block that wires each part to a **slot** with the **props** passed and a
  note, instead of a flat list of ids. The registry derives `composedOf` from
  these parts (the frontmatter line is dropped when the block exists), and the
  website renders composition grouped by slot with prop pills. Converted:
  `card`, `form`, `dialog`, `navbar`, `field`, `comment`; the rest keep the flat
  chip list until migrated.
- **Behavior traits.** A new `traits/` layer captures cross-cutting interaction
  contracts — `dismissible`, `focus-trap`, `anchored`, `roving-focus`,
  `typeahead` — that many archetypes share. Archetypes reference them via a new
  `traits:` frontmatter field (schema in `schema/trait.schema.json`); 19
  overlays and collections now declare their behaviors instead of re-describing
  them in prose. The website renders trait chips on each archetype, dedicated
  trait pages (with an "exhibited by" back-reference), and a Behaviors group in
  the sidebar.

### Changed

- The conformance check is now driven by the `implementation:` frontmatter field
  rather than a hardcoded map, so mapping a component to its spec is a one-line
  edit in the archetype.
- The markdown→HTML renderer is now a shared module (`website/scripts/md.mjs`),
  used by both the archetype and trait generators.

## [0.5.0] - 2026-07-17

### Added

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
