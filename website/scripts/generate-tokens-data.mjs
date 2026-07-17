// Generates src/TokensData.res from the framework's design tokens
// (../../tokens/tokens.json), so the website can render a reference of every
// token the framework defines — grouped, with resolved values and a render hint.
import { readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const tokens = JSON.parse(readFileSync(join(here, "..", "..", "tokens", "tokens.json"), "utf8"));

// Flatten to { path: { type, value, description } }, inheriting $type.
const flat = {};
function walk(node, path, inheritedType) {
  const type = node.$type || inheritedType;
  if (Object.prototype.hasOwnProperty.call(node, "$value")) {
    flat[path.join(".")] = { type, value: node.$value, description: node.$description || "" };
    return;
  }
  for (const [k, v] of Object.entries(node)) {
    if (k.startsWith("$")) continue;
    walk(v, [...path, k], type);
  }
}
for (const [k, v] of Object.entries(tokens)) {
  if (k.startsWith("$")) continue;
  walk(v, [k], undefined);
}

function resolve(value, seen = new Set()) {
  if (typeof value === "string") {
    const m = value.match(/^\{(.+)\}$/);
    if (m) {
      const ref = m[1];
      if (seen.has(ref) || !flat[ref]) return value;
      seen.add(ref);
      return resolve(flat[ref].value, seen);
    }
  }
  return value;
}

function cssValue(type, rawValue) {
  const value = resolve(rawValue);
  switch (type) {
    case "fontFamily":
      return (Array.isArray(value) ? value : [value]).map((f) => (/\s/.test(f) ? `"${f}"` : f)).join(", ");
    case "shadow": {
      const list = Array.isArray(value) ? value : [value];
      return list.map((s) => `${s.offsetX} ${s.offsetY} ${s.blur} ${s.spread || "0"} ${s.color}`).join(", ");
    }
    default:
      return String(value);
  }
}

// How the token should be previewed on the reference page.
function sampleOf(path, type) {
  if (path.startsWith("color.")) return "color";
  if (path.startsWith("radius.")) return "radius";
  if (path.startsWith("space.")) return "space";
  if (path.startsWith("shadow.")) return "shadow";
  if (path.startsWith("borderWidth.")) return "border";
  if (path.startsWith("font.family.")) return "font-family";
  if (path.startsWith("font.size.")) return "font-size";
  if (path.startsWith("font.weight.")) return "font-weight";
  if (type === "fontFamily") return "font-family";
  return "text";
}

// Group by top-level category, in a curated order; keep insertion order within.
const order = ["color", "radius", "space", "font", "shadow", "borderWidth", "duration", "zIndex"];
const groups = new Map();
for (const [path, tok] of Object.entries(flat)) {
  const group = path.split(".")[0];
  if (!groups.has(group)) groups.set(group, []);
  groups.get(group).push({
    name: path.slice(group.length + 1), // path minus the group prefix
    value: cssValue(tok.type, tok.value),
    raw: typeof tok.value === "string" && tok.value.startsWith("{") ? tok.value : "",
    description: tok.description,
    sample: sampleOf(path, tok.type),
  });
}

const groupMeta = {
  color: "Palette and semantic roles. Monochrome by design; retheme by pointing roles at brand hues.",
  radius: "Corner radii, from square to pill.",
  space: "Spacing scale for padding, margins, and gaps.",
  font: "Families, weights, sizes, and line heights.",
  shadow: "Elevation levels.",
  borderWidth: "Stroke widths.",
  duration: "Motion timings.",
  zIndex: "Stacking order for layered surfaces.",
};

const ordered = [...groups.keys()].sort((a, b) => {
  const ai = order.indexOf(a), bi = order.indexOf(b);
  return (ai === -1 ? 99 : ai) - (bi === -1 ? 99 : bi);
});

const s = (v) => JSON.stringify(v);
const body = ordered
  .map((g) => {
    const toks = groups
      .get(g)
      .map(
        (t) =>
          `      { name: ${s(t.name)}, value: ${s(t.value)}, raw: ${s(t.raw)}, description: ${s(t.description)}, sample: ${s(t.sample)} }`,
      )
      .join(",\n");
    return `  {
    group: ${s(g)},
    description: ${s(groupMeta[g] || "")},
    tokens: [
${toks},
    ],
  }`;
  })
  .join(",\n");

const out = `// GENERATED FILE — do not edit by hand.
// Run \`npm run tokens:data\` (scripts/generate-tokens-data.mjs) to regenerate.
// Source of truth: ../../tokens/tokens.json (W3C DTCG design tokens).

type token = {
  name: string,
  value: string,
  raw: string,
  description: string,
  sample: string,
}

type group = {
  group: string,
  description: string,
  tokens: array<token>,
}

let all: array<group> = [
${body},
]
`;

writeFileSync(join(here, "..", "src", "TokensData.res"), out);
console.log(`Wrote ${ordered.length} token groups to src/TokensData.res`);
