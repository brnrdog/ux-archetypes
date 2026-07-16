# Contributing

Thanks for helping grow the UI Archetypes collection. The goal is a set of
patterns that stay **consistent**, **stack-agnostic**, and **useful to both
humans and AI agents**. Consistency is the whole value, so the process is mostly
about keeping the shape uniform.

## Adding a new archetype

1. **Pick the layer** — `element`, `component`, `page`, or `flow`. See the
   taxonomy in the [README](README.md#taxonomy-layers).
2. **Copy the template** — start from
   [`templates/ARCHETYPE_TEMPLATE.md`](templates/ARCHETYPE_TEMPLATE.md).
3. **Create the file** at `archetypes/<layer-plural>/<id>.md`.
   - `id` is lowercase kebab-case and unique across the whole collection.
   - The `id` in the frontmatter **must** match the filename.
   - The `layer` in the frontmatter **must** match the directory.
4. **Fill in the metadata** — every required field (see the
   [schema](schema/archetype.schema.json)). Set `version: 1.0.0` and
   `status: draft` (or `stable` if it is ready), and set `since` to the next
   collection version.
5. **Complete every body section.** Keep all sections in order. If a section
   truly doesn't apply, write a short _"Not applicable"_ note instead of deleting
   it, so the document shape stays constant.
6. **Wire the graph** — fill `composedOf` / `usedBy` / `related`, and add the
   reverse reference on the other archetypes where it makes sense.
7. **Register it** — add a row to [`INDEX.md`](INDEX.md).
8. **Bump the collection** — add a `MINOR` entry to
   [`CHANGELOG.md`](CHANGELOG.md) and update [`VERSION`](VERSION) /
   [`package.json`](package.json).

## Changing an existing archetype

- Bump the archetype's own `version` and update `updated`:
  - **MAJOR** — meaning/anatomy changes that would break implementations.
  - **MINOR** — a new variant, state, or compatible content addition.
  - **PATCH** — clarifications and wording fixes.
- Reflect the change in `INDEX.md` and `CHANGELOG.md`.
- To retire an archetype, set `status: deprecated` (keep the file for reference)
  rather than deleting it; removal is a collection `MAJOR`.

## Writing principles

- **Describe the pattern, not a design.** Capture intent, anatomy, states,
  behavior, and the accessibility contract — not pixels, colors, or framework
  code.
- **Stay stack-agnostic.** An archetype should map cleanly onto React, Vue,
  SwiftUI, a design tool, or plain HTML.
- **Accessibility is required**, not optional. Every archetype states its
  keyboard, semantics, screen-reader, and focus expectations.
- **Prefer plain, precise language.** These documents are read by people and
  parsed by agents; ambiguity costs both.

## Consistency checklist

- [ ] `id` matches filename and is unique.
- [ ] `layer` matches the directory.
- [ ] All required metadata fields present and valid per the schema.
- [ ] All body sections present and in order.
- [ ] Composition links added on both sides where relevant.
- [ ] `INDEX.md`, `CHANGELOG.md`, and `VERSION`/`package.json` updated.
