// Generates src/ArchetypesData.res from the archetype markdown files.
// Parses the YAML frontmatter (simple, line-based), extracts the first
// paragraph of the "Intent" section for a teaser, and converts the full body
// to HTML so each archetype's complete spec renders on its detail page. Emits
// a typed ReScript module.
import { readFileSync, writeFileSync, readdirSync } from "node:fs";
import { join, dirname, basename } from "node:path";
import { fileURLToPath } from "node:url";
import { mdToHtml } from "./md.mjs";

const here = dirname(fileURLToPath(import.meta.url));
const archetypesDir = join(here, "..", "..", "archetypes");
const outFile = join(here, "..", "src", "ArchetypesData.res");

const layers = ["elements", "components", "blocks", "pages", "flows"];

function parseInlineArray(value) {
  const inner = value.trim().replace(/^\[/, "").replace(/\]$/, "").trim();
  if (inner === "") return [];
  return inner
    .split(",")
    .map((s) => s.trim())
    .filter((s) => s.length > 0);
}

function parseFrontmatter(raw) {
  const m = raw.match(/^---\n([\s\S]*?)\n---\n([\s\S]*)$/);
  if (!m) return null;
  const [, fm, body] = m;
  const meta = {};
  for (const line of fm.split("\n")) {
    const mm = line.match(/^([a-zA-Z]+):\s*(.*)$/);
    if (!mm) continue;
    const [, key, val] = mm;
    if (val.startsWith("[")) meta[key] = parseInlineArray(val);
    else meta[key] = val.trim();
  }
  return { meta, body };
}

function extractSection(body, heading) {
  const re = new RegExp(`^##\\s+${heading}\\s*$`, "m");
  const start = body.match(re);
  if (!start) return "";
  const rest = body.slice(start.index + start[0].length);
  const next = rest.search(/^##\s+/m);
  const section = next === -1 ? rest : rest.slice(0, next);
  // First non-empty paragraph, stripped of markdown emphasis/links.
  const paras = section
    .split(/\n\s*\n/)
    .map((p) => p.trim())
    .filter((p) => p && !p.startsWith("<!--"));
  const first = paras[0] || "";
  return first
    .replace(/\s*\n\s*/g, " ")
    .replace(/\*\*(.+?)\*\*/g, "$1")
    .replace(/\*(.+?)\*/g, "$1")
    .replace(/`(.+?)`/g, "$1")
    .replace(/\[(.+?)\]\((.+?)\)/g, "$1")
    .replace(/_(.+?)_/g, "$1")
    .trim();
}

// Pull the machine-readable contract out of the `## API` section (a ```json
// fenced block) and return it alongside the body with that section removed, so
// the raw JSON never renders as prose.
function extractApi(body, id) {
  const m = body.match(/^##\s+API\s*$/m);
  if (!m) return { api: null, body };
  const after = body.slice(m.index + m[0].length);
  const nextIdx = after.search(/^##\s+/m);
  const section = nextIdx === -1 ? after : after.slice(0, nextIdx);
  const rest = nextIdx === -1 ? "" : after.slice(nextIdx);
  const fence = section.match(/```json\s*([\s\S]*?)```/);
  let api = null;
  if (fence) {
    try {
      api = JSON.parse(fence[1]);
    } catch (e) {
      throw new Error(`Invalid API JSON in ${id}: ${e.message}`);
    }
  }
  return { api, body: body.slice(0, m.index) + rest };
}

// Pull the structured composition wiring out of the `## Composition` section
// (a ```json block of parts) and strip that section from the prose so neither
// raw JSON nor a stale prose list renders. Absent block → prose left as-is.
function extractComposition(body, id) {
  const m = body.match(/^##\s+Composition\s*$/m);
  if (!m) return { composition: null, body };
  const after = body.slice(m.index + m[0].length);
  const nextIdx = after.search(/^##\s+/m);
  const section = nextIdx === -1 ? after : after.slice(0, nextIdx);
  const fence = section.match(/```json\s*([\s\S]*?)```/);
  if (!fence) return { composition: null, body };
  let composition = null;
  try {
    composition = JSON.parse(fence[1]).parts || [];
  } catch (e) {
    throw new Error(`Invalid Composition JSON in ${id}: ${e.message}`);
  }
  const rest = nextIdx === -1 ? "" : after.slice(nextIdx);
  return { composition, body: body.slice(0, m.index) + rest };
}

const records = [];
for (const layerDir of layers) {
  let files;
  try {
    files = readdirSync(join(archetypesDir, layerDir)).filter((f) =>
      f.endsWith(".md"),
    );
  } catch {
    continue;
  }
  for (const file of files.sort()) {
    const raw = readFileSync(join(archetypesDir, layerDir, file), "utf8");
    const parsed = parseFrontmatter(raw);
    if (!parsed) continue;
    const { meta, body: rawBody } = parsed;
    const id = meta.id || basename(file, ".md");
    const { api, body: bodyA } = extractApi(rawBody, id);
    const { composition, body } = extractComposition(bodyA, id);
    records.push({
      id,
      title: meta.title || "",
      layer: meta.layer || "",
      status: meta.status || "",
      version: meta.version || "",
      summary: meta.summary || "",
      tags: meta.tags || [],
      aliases: meta.aliases || [],
      composedOf: composition ? [...new Set(composition.map((c) => c.ref))] : meta.composedOf || [],
      usedBy: meta.usedBy || [],
      related: meta.related || [],
      traits: meta.traits || [],
      composition: composition || [],
      intent: extractSection(body, "Intent"),
      spec: mdToHtml(body),
      api,
    });
  }
}

const layerOrder = { element: 0, component: 1, block: 2, page: 3, flow: 4 };
records.sort(
  (a, b) =>
    (layerOrder[a.layer] ?? 9) - (layerOrder[b.layer] ?? 9) ||
    a.title.localeCompare(b.title),
);

const s = (v) => JSON.stringify(v); // valid ReScript string literal
const arr = (xs) => `[${xs.map(s).join(", ")}]`;
const b = (v) => (v ? "true" : "false");

// Emit the contract as an `option<apiContract>` ReScript expression.
function emitApi(api) {
  if (!api) return "None";
  const props = (api.props || [])
    .map(
      (p) =>
        `{ name: ${s(p.name)}, type_: ${s(p.type || "")}, values: ${arr(
          p.values || [],
        )}, default: ${s(p.default || "")}, description: ${s(p.description || "")} }`,
    )
    .join(", ");
  const slots = (api.slots || [])
    .map(
      (sl) =>
        `{ name: ${s(sl.name)}, required: ${b(sl.required)}, description: ${s(
          sl.description || "",
        )} }`,
    )
    .join(", ");
  const a = api.a11y || {};
  return `Some({ props: [${props}], slots: [${slots}], events: ${arr(
    api.events || [],
  )}, role: ${s(a.role || "")}, keyboard: ${arr(a.keyboard || [])}, announces: ${arr(
    a.announces || [],
  )}, states: ${arr(api.states || [])}, tokens: ${arr(api.tokens || [])} })`;
}

// Emit composition parts as a ReScript array<compPart>.
function emitComposition(parts) {
  return `[${(parts || [])
    .map((c) => {
      const props = Object.entries(c.props || {})
        .map(([k, v]) => `(${s(k)}, ${s(String(v))})`)
        .join(", ");
      return `{ compRef: ${s(c.ref)}, slot: ${s(c.slot || "")}, props: [${props}], note: ${s(
        c.note || "",
      )} }`;
    })
    .join(", ")}]`;
}

const body = records
  .map(
    (r) => `  {
    id: ${s(r.id)},
    title: ${s(r.title)},
    layer: ${s(r.layer)},
    status: ${s(r.status)},
    version: ${s(r.version)},
    summary: ${s(r.summary)},
    tags: ${arr(r.tags)},
    aliases: ${arr(r.aliases)},
    composedOf: ${arr(r.composedOf)},
    usedBy: ${arr(r.usedBy)},
    related: ${arr(r.related)},
    traits: ${arr(r.traits)},
    composition: ${emitComposition(r.composition)},
    intent: ${s(r.intent)},
    spec: ${s(r.spec)},
    api: ${emitApi(r.api)},
  }`,
  )
  .join(",\n");

const out = `// GENERATED FILE — do not edit by hand.
// Run \`npm run registry\` (scripts/generate-registry.mjs) to regenerate.

type apiProp = {
  name: string,
  type_: string,
  values: array<string>,
  default: string,
  description: string,
}

type apiSlot = {
  name: string,
  required: bool,
  description: string,
}

type compPart = {
  compRef: string,
  slot: string,
  props: array<(string, string)>,
  note: string,
}

type apiContract = {
  props: array<apiProp>,
  slots: array<apiSlot>,
  events: array<string>,
  role: string,
  keyboard: array<string>,
  announces: array<string>,
  states: array<string>,
  tokens: array<string>,
}

type archetype = {
  id: string,
  title: string,
  layer: string,
  status: string,
  version: string,
  summary: string,
  tags: array<string>,
  aliases: array<string>,
  composedOf: array<string>,
  usedBy: array<string>,
  related: array<string>,
  traits: array<string>,
  composition: array<compPart>,
  intent: string,
  spec: string,
  api: option<apiContract>,
}

let all: array<archetype> = [
${body},
]
`;

writeFileSync(outFile, out);
console.log(`Wrote ${records.length} archetypes to ${outFile}`);
