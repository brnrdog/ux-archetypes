// Validates structured composition: every part's `ref` resolves to a real
// archetype, and every `slot` is a region the archetype actually declares — its
// API `slots` for element/component/block archetypes, or a fixed page-layout
// vocabulary for pages and flows (which have no component API). Exits non-zero
// on any dangling ref or undeclared slot, so composition can't drift.
import { readFileSync, readdirSync } from "node:fs";
import { join, dirname, basename } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const archetypesDir = join(here, "..", "..", "archetypes");
const layers = ["elements", "components", "blocks", "pages", "flows"];

// Slots a page or flow may wire parts into (they have no component-level API).
const layoutSlots = ["chrome", "content", "step", "aside"];

function jsonUnder(raw, heading) {
  const m = raw.match(new RegExp(`^##\\s+${heading}\\s*$`, "m"));
  if (!m) return null;
  const fence = raw.slice(m.index).match(/```json\s*([\s\S]*?)```/);
  if (!fence) return null;
  try {
    return JSON.parse(fence[1]);
  } catch {
    return null;
  }
}

// Pass 1: collect every archetype id.
const ids = new Set();
const records = [];
for (const layer of layers) {
  let files;
  try {
    files = readdirSync(join(archetypesDir, layer)).filter((f) => f.endsWith(".md"));
  } catch {
    continue;
  }
  for (const file of files) {
    const raw = readFileSync(join(archetypesDir, layer, file), "utf8");
    const id = (raw.match(/^id:\s*(.*)$/m) || [])[1]?.trim() || basename(file, ".md");
    ids.add(id);
    records.push({ id, layer, raw });
  }
}

let failures = 0;
let checkedRefs = 0;
let checkedSlots = 0;
for (const { id, layer, raw } of records) {
  const comp = jsonUnder(raw, "Composition");
  const parts = comp?.parts || [];
  if (parts.length === 0) continue;
  const api = jsonUnder(raw, "API");
  const hasApiSlots = api && Array.isArray(api.slots);
  const allowed = hasApiSlots ? api.slots.map((s) => s.name) : layoutSlots;
  for (const p of parts) {
    checkedRefs++;
    if (!ids.has(p.ref)) {
      console.log(`✗ ${id}: composition ref \`${p.ref}\` does not resolve to an archetype`);
      failures++;
    }
    checkedSlots++;
    if (!allowed.includes(p.slot)) {
      const where = hasApiSlots ? "API slots" : "page-layout slots";
      console.log(`✗ ${id}: slot \`${p.slot}\` is not one of the ${where} [${allowed.join(", ")}]`);
      failures++;
    }
  }
}

console.log(
  `\n${failures ? "✗" : "✓"} composition: ${checkedRefs} ref(s) and ${checkedSlots} slot(s) checked, ${failures} issue(s)`,
);
process.exitCode = failures ? 1 : 0;
