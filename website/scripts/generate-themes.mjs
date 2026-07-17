// Generates src/ThemesData.res from the framework's theme presets
// (../../tokens/themes.json), so the website's theme picker is driven by the
// canonical themes rather than hardcoded data.
import { readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const file = join(here, "..", "..", "tokens", "themes.json");
const outFile = join(here, "..", "src", "ThemesData.res");

const { themes } = JSON.parse(readFileSync(file, "utf8"));

const s = (v) => JSON.stringify(v);
const arr = (xs) => `[${xs.map(s).join(", ")}]`;

const body = themes
  .map((t) => {
    const tokens = Object.entries(t.tokens || {})
      .map(([path, value]) => `(${s(path)}, ${s(value)})`)
      .join(", ");
    return `  {
    id: ${s(t.id)},
    label: ${s(t.label)},
    swatches: ${arr(t.swatches || [])},
    tokens: [${tokens}],
  }`;
  })
  .join(",\n");

const out = `// GENERATED FILE — do not edit by hand.
// Run \`npm run themes\` (scripts/generate-themes.mjs) to regenerate.
// Source of truth: ../../tokens/themes.json.

type theme = {
  id: string,
  label: string,
  swatches: array<string>,
  tokens: array<(string, string)>,
}

let all: array<theme> = [
${body},
]
`;

writeFileSync(outFile, out);
console.log(`Wrote ${themes.length} themes to ${outFile}`);
