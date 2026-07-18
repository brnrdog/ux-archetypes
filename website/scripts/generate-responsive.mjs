// Generates src/ResponsiveData.res from the framework's responsive-pattern
// vocabulary (../../responsive/patterns.json) so the website can render human
// labels/descriptions for the pattern ids a spec's contract references.
import { readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const { patterns } = JSON.parse(
  readFileSync(join(here, "..", "..", "responsive", "patterns.json"), "utf8"),
);

const s = (v) => JSON.stringify(v);
const rows = Object.entries(patterns)
  .map(([id, p]) => `  { id: ${s(id)}, label: ${s(p.label)}, description: ${s(p.description)} }`)
  .join(",\n");

const out = `// GENERATED FILE — do not edit by hand.
// Run \`npm run responsive\` (scripts/generate-responsive.mjs) to regenerate.
// Source of truth: ../../responsive/patterns.json.

type pattern = {
  id: string,
  label: string,
  description: string,
}

let patterns: array<pattern> = [
${rows},
]

let find = id => patterns->Array.find(p => p.id == id)
let labelFor = id =>
  switch find(id) {
  | Some(p) => p.label
  | None => id
  }
`;

writeFileSync(join(here, "..", "src", "ResponsiveData.res"), out);
console.log(`Wrote ${Object.keys(patterns).length} responsive patterns`);
