# Changelog

All notable changes to this collection are documented here. The collection
follows [Semantic Versioning](https://semver.org/) and the format of
[Keep a Changelog](https://keepachangelog.com/).

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
