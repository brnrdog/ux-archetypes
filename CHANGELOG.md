# Changelog

All notable changes to this collection are documented here. The collection
follows [Semantic Versioning](https://semver.org/) and the format of
[Keep a Changelog](https://keepachangelog.com/).

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
