// Generates src/TraitsData.res from the trait specs in ../../traits.
import { readFileSync, writeFileSync, readdirSync } from "node:fs";
import { join, dirname, basename } from "node:path";
import { fileURLToPath } from "node:url";
import { mdToHtml } from "./md.mjs";

const here = dirname(fileURLToPath(import.meta.url));
const traitsDir = join(here, "..", "..", "traits");
const outFile = join(here, "..", "src", "TraitsData.res");

function parse(raw) {
  const m = raw.match(/^---\n([\s\S]*?)\n---\n([\s\S]*)$/);
  if (!m) return null;
  const meta = {};
  for (const line of m[1].split("\n")) {
    const mm = line.match(/^([a-zA-Z]+):\s*(.*)$/);
    if (mm) meta[mm[1]] = mm[2].trim();
  }
  return { meta, body: m[2] };
}

const records = [];
let files = [];
try {
  files = readdirSync(traitsDir).filter((f) => f.endsWith(".md"));
} catch {
  files = [];
}
for (const file of files.sort()) {
  const parsed = parse(readFileSync(join(traitsDir, file), "utf8"));
  if (!parsed) continue;
  const { meta, body } = parsed;
  records.push({
    id: meta.id || basename(file, ".md"),
    title: meta.title || "",
    summary: meta.summary || "",
    spec: mdToHtml(body),
  });
}
records.sort((a, b) => a.title.localeCompare(b.title));

const s = (v) => JSON.stringify(v);
const body = records
  .map(
    (r) => `  {
    id: ${s(r.id)},
    title: ${s(r.title)},
    summary: ${s(r.summary)},
    spec: ${s(r.spec)},
  }`,
  )
  .join(",\n");

const out = `// GENERATED FILE — do not edit by hand.
// Run \`npm run traits\` (scripts/generate-traits.mjs) to regenerate.

type trait = {
  id: string,
  title: string,
  summary: string,
  spec: string,
}

let all: array<trait> = [
${body},
]
`;

writeFileSync(outFile, out);
console.log(`Wrote ${records.length} traits to ${outFile}`);
