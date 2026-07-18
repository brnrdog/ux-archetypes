// Validates the responsive contract on every implementable spec:
//   • a spec that carries an `## API` contract must declare `responsive`;
//   • each `reflow[].pattern` must be a known id in responsive/patterns.json;
//   • each `reflow[].at`, when present, must be a breakpoint id in tokens.json.
// Exits non-zero on any violation, so responsiveness can't drift from the
// shared vocabulary or reference a breakpoint the system doesn't define.
import { readFileSync, readdirSync } from "node:fs";
import { join, dirname, basename } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const root = join(here, "..", "..");
const specsDir = join(root, "specs");
const layers = ["elements", "components", "blocks", "pages", "flows"];

const patterns = new Set(
  Object.keys(JSON.parse(readFileSync(join(root, "responsive", "patterns.json"), "utf8")).patterns),
);
const tokens = JSON.parse(readFileSync(join(root, "tokens", "tokens.json"), "utf8"));
const breakpoints = new Set(
  Object.keys(tokens.breakpoint || {}).filter((k) => !k.startsWith("$")),
);

function apiOf(raw, id) {
  const m = raw.match(/^##\s+API\s*$/m);
  if (!m) return null;
  const fence = raw.slice(m.index).match(/```json\s*([\s\S]*?)```/);
  if (!fence) return null;
  try {
    return JSON.parse(fence[1]);
  } catch (e) {
    throw new Error(`Invalid API JSON in ${id}: ${e.message}`);
  }
}

let failures = 0;
let checkedSpecs = 0;
let checkedReflows = 0;
for (const layer of layers) {
  let files;
  try {
    files = readdirSync(join(specsDir, layer)).filter((f) => f.endsWith(".md"));
  } catch {
    continue;
  }
  for (const file of files) {
    const raw = readFileSync(join(specsDir, layer, file), "utf8");
    const id = (raw.match(/^id:\s*(.*)$/m) || [])[1]?.trim() || basename(file, ".md");
    const api = apiOf(raw, id);
    if (!api) continue; // pages/flows carry no API contract
    checkedSpecs++;
    const r = api.responsive;
    if (!r) {
      failures++;
      console.log(`✗ ${id}: has an API contract but no \`responsive\` block`);
      continue;
    }
    for (const rf of r.reflow || []) {
      checkedReflows++;
      if (!patterns.has(rf.pattern)) {
        failures++;
        console.log(`✗ ${id}: unknown reflow pattern \`${rf.pattern}\``);
      }
      if (rf.at && !breakpoints.has(rf.at)) {
        failures++;
        console.log(`✗ ${id}: reflow \`${rf.pattern}\` references unknown breakpoint \`${rf.at}\``);
      }
    }
  }
}

console.log(
  `\n${failures ? "✗" : "✓"} responsive: ${checkedSpecs} contract(s) + ${checkedReflows} reflow(s) checked against ${patterns.size} pattern(s) / ${breakpoints.size} breakpoint(s), ${failures} issue(s)`,
);
process.exitCode = failures ? 1 : 0;
