// Checks that each implemented component conforms to its archetype's `## API`
// contract: every contract prop is exposed, and every enum prop's allowed
// values match (either the inline polymorphic variant, or — better — a reference
// to the generated Contracts.<Name>.<prop> type, which the compiler enforces).
// Exits non-zero on drift, so a spec/implementation mismatch fails the build.
import { readFileSync, readdirSync, existsSync } from "node:fs";
import { join, dirname, basename } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const archetypesDir = join(here, "..", "..", "archetypes");
const srcDir = join(here, "..", "src");
const layers = ["elements", "components", "blocks", "pages", "flows"];

// Which archetypes have a component implementation to check, and where.
const componentFor = { button: "Button.res" };

// ReScript renames a few reserved words used as prop labels.
const reserved = { type: "type_" };
const pascal = (id) =>
  id
    .split("-")
    .map((p) => p.charAt(0).toUpperCase() + p.slice(1))
    .join("");

function apiOf(body) {
  const m = body.match(/^##\s+API\s*$/m);
  if (!m) return null;
  const fence = body.slice(m.index).match(/```json\s*([\s\S]*?)```/);
  return fence ? JSON.parse(fence[1]) : null;
}

// Extract the labeled args of the component's `make` and, for each, its
// annotation text (between `~name:` and the next `,`, `=`, or `)`).
function parseProps(src) {
  const block = src.match(/let make = \(([\s\S]*?)\) =>/);
  if (!block) return {};
  const body = block[1];
  const props = {};
  const re = /~([a-zA-Z_][a-zA-Z0-9_]*)\s*(?::\s*([^=,)]+))?/g;
  let m;
  while ((m = re.exec(body))) props[m[1]] = (m[2] || "").trim();
  return props;
}

const contracts = [];
for (const layerDir of layers) {
  let files;
  try {
    files = readdirSync(join(archetypesDir, layerDir)).filter((f) => f.endsWith(".md"));
  } catch {
    continue;
  }
  for (const file of files.sort()) {
    const id = basename(file, ".md");
    const api = apiOf(readFileSync(join(archetypesDir, layerDir, file), "utf8"));
    if (api) contracts.push({ id, api });
  }
}

let failures = 0;
let checked = 0;
for (const { id, api } of contracts) {
  const rel = componentFor[id];
  if (!rel) {
    console.log(`• ${id}: contract present, no implementation mapped — skipped`);
    continue;
  }
  const file = join(srcDir, rel);
  if (!existsSync(file)) {
    console.log(`✗ ${id}: mapped to ${rel}, but the file is missing`);
    failures++;
    continue;
  }
  checked++;
  const props = parseProps(readFileSync(file, "utf8"));
  console.log(`\n${id} → ${rel}`);
  for (const p of api.props || []) {
    const label = reserved[p.name] || p.name;
    if (!(label in props)) {
      console.log(`  ✗ prop \`${p.name}\` (~${label}) is missing`);
      failures++;
      continue;
    }
    const ann = props[label];
    if (p.type === "enum") {
      const ref = `Contracts.${pascal(id)}.${reserved[p.name] || p.name}`;
      if (ann.startsWith(ref)) {
        console.log(`  ✓ ${p.name} — enum, compiler-enforced via ${ref}`);
      } else {
        const inline = [...ann.matchAll(/#([a-zA-Z0-9]+)/g)].map((x) => x[1]);
        const want = [...p.values].sort().join(",");
        const got = [...inline].sort().join(",");
        if (want === got) {
          console.log(`  ✓ ${p.name} — enum values match [${p.values.join(", ")}]`);
        } else {
          console.log(`  ✗ ${p.name} — enum drift: contract [${want}] vs impl [${got}]`);
          failures++;
        }
      }
    } else {
      console.log(`  ✓ ${p.name} — ${p.type}`);
    }
  }
}

console.log(
  `\n${failures ? "✗" : "✓"} conformance: ${checked} component(s) checked, ${failures} issue(s)`,
);
process.exitCode = failures ? 1 : 0;
