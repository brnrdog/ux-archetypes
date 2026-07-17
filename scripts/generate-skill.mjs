// Builds the distributable Agent Skill (skill/) from the framework source, so
// the skill's reference data never drifts from the archetypes/tokens. Compiles
// every archetype's contract, traits, and composition into a single JSON the
// agent can look up, and copies the tokens and themes.
import { readFileSync, writeFileSync, readdirSync, mkdirSync, copyFileSync } from "node:fs";
import { join, dirname, basename } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const root = join(here, "..");
const archetypesDir = join(root, "archetypes");
const traitsDir = join(root, "traits");
const outDir = join(root, "skill", "reference");
const layers = ["elements", "components", "blocks", "pages", "flows"];

mkdirSync(outDir, { recursive: true });

function parse(raw) {
  const m = raw.match(/^---\n([\s\S]*?)\n---\n([\s\S]*)$/);
  if (!m) return null;
  const meta = {};
  for (const line of m[1].split("\n")) {
    const mm = line.match(/^([a-zA-Z]+):\s*(.*)$/);
    if (!mm) continue;
    const [, k, v] = mm;
    meta[k] = v.startsWith("[")
      ? v.replace(/^\[|\]$/g, "").split(",").map((s) => s.trim()).filter(Boolean)
      : v.trim();
  }
  return { meta, body: m[2] };
}
const jsonUnder = (body, heading) => {
  const h = body.match(new RegExp(`^##\\s+${heading}\\s*$`, "m"));
  if (!h) return null;
  const fence = body.slice(h.index).match(/```json\s*([\s\S]*?)```/);
  if (!fence) return null;
  try {
    return JSON.parse(fence[1]);
  } catch {
    return null;
  }
};
const section = (body, heading) => {
  const h = body.match(new RegExp(`^##\\s+${heading}\\s*$`, "m"));
  if (!h) return "";
  const rest = body.slice(h.index + h[0].length);
  const next = rest.search(/^##\s+/m);
  return (next === -1 ? rest : rest.slice(0, next)).trim();
};

const archetypes = [];
for (const layer of layers) {
  let files;
  try {
    files = readdirSync(join(archetypesDir, layer)).filter((f) => f.endsWith(".md"));
  } catch {
    continue;
  }
  for (const file of files.sort()) {
    const parsed = parse(readFileSync(join(archetypesDir, layer, file), "utf8"));
    if (!parsed) continue;
    const { meta, body } = parsed;
    archetypes.push({
      id: meta.id || basename(file, ".md"),
      title: meta.title || "",
      layer: meta.layer || "",
      summary: meta.summary || "",
      tags: meta.tags || [],
      traits: meta.traits || [],
      usedBy: meta.usedBy || [],
      related: meta.related || [],
      intent: section(body, "Intent"),
      api: jsonUnder(body, "API"),
      composition: jsonUnder(body, "Composition")?.parts || null,
      implementation: meta.implementation || null,
    });
  }
}

const traits = [];
try {
  for (const file of readdirSync(traitsDir).filter((f) => f.endsWith(".md")).sort()) {
    const parsed = parse(readFileSync(join(traitsDir, file), "utf8"));
    if (!parsed) continue;
    traits.push({
      id: parsed.meta.id || basename(file, ".md"),
      title: parsed.meta.title || "",
      summary: parsed.meta.summary || "",
      keys: parsed.meta.keys || [],
      match: parsed.meta.match || "all",
      contract: section(parsed.body, "Contract"),
    });
  }
} catch {
  /* no traits */
}

writeFileSync(join(outDir, "archetypes.json"), JSON.stringify(archetypes, null, 2));
writeFileSync(join(outDir, "traits.json"), JSON.stringify(traits, null, 2));
copyFileSync(join(root, "tokens", "tokens.json"), join(outDir, "tokens.json"));
copyFileSync(join(root, "tokens", "themes.json"), join(outDir, "themes.json"));

console.log(
  `Built skill/reference: ${archetypes.length} archetypes (${archetypes.filter((a) => a.api).length} with contracts), ${traits.length} traits, tokens + themes.`,
);
