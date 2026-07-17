// Generates src/Contracts.res from the `## API` blocks in the archetype
// markdown. For every enum prop it emits a polymorphic-variant type, grouped in
// a module named after the archetype. Components annotate their props with
// these types, so the ReScript compiler itself enforces that the implementation
// stays in sync with the contract's allowed values.
import { readFileSync, writeFileSync, readdirSync } from "node:fs";
import { join, dirname, basename } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const archetypesDir = join(here, "..", "..", "archetypes");
const outFile = join(here, "..", "src", "Contracts.res");
const layers = ["elements", "components", "blocks", "pages", "flows"];

// ReScript reserved words that can't be bare type names.
const reserved = new Set(["type", "and", "as", "open", "let", "module", "rec"]);
const typeName = (n) => (reserved.has(n) ? `${n}_` : n);
const pascal = (id) =>
  id
    .split("-")
    .map((p) => p.charAt(0).toUpperCase() + p.slice(1))
    .join("");

function apiOf(body) {
  const m = body.match(/^##\s+API\s*$/m);
  if (!m) return null;
  const fence = body.slice(m.index).match(/```json\s*([\s\S]*?)```/);
  if (!fence) return null;
  return JSON.parse(fence[1]);
}

const modules = [];
for (const layerDir of layers) {
  let files;
  try {
    files = readdirSync(join(archetypesDir, layerDir)).filter((f) => f.endsWith(".md"));
  } catch {
    continue;
  }
  for (const file of files.sort()) {
    const raw = readFileSync(join(archetypesDir, layerDir, file), "utf8");
    const api = apiOf(raw);
    if (!api || !Array.isArray(api.props)) continue;
    const enums = api.props.filter((p) => p.type === "enum" && p.values?.length);
    if (enums.length === 0) continue;
    const id = basename(file, ".md");
    const types = enums
      .map(
        (p) =>
          `  type ${typeName(p.name)} = [${p.values.map((v) => `#${v}`).join(" | ")}]`,
      )
      .join("\n");
    modules.push(`module ${pascal(id)} = {\n${types}\n}`);
  }
}

const out = `// GENERATED FILE — do not edit by hand.
// Run \`npm run contracts\` (scripts/generate-contracts.mjs) to regenerate.
// Types are derived from the \`## API\` contracts in the archetype markdown.

${modules.join("\n\n")}
`;

writeFileSync(outFile, out);
console.log(`Wrote ${modules.length} contract module(s) to ${outFile}`);
