// Validates that every design-token role a contract references actually exists
// in tokens/tokens.json. A role may be concrete (`radius.md`) or a wildcard
// (`color.action.*`, matching any token under that group). Exits non-zero on an
// unknown role, so a contract can't reference a token the system doesn't define.
import { readFileSync, readdirSync } from "node:fs";
import { join, dirname, basename } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const archetypesDir = join(here, "..", "..", "archetypes");
const tokensFile = join(here, "..", "..", "tokens", "tokens.json");
const layers = ["elements", "components", "blocks", "pages", "flows"];

// Flatten tokens.json to the set of leaf token paths (those with a $value).
const tokens = JSON.parse(readFileSync(tokensFile, "utf8"));
const paths = new Set();
(function walk(node, trail) {
  if (node && typeof node === "object" && "$value" in node) {
    paths.add(trail.join("."));
    return;
  }
  for (const [k, v] of Object.entries(node)) {
    if (k.startsWith("$")) continue;
    if (v && typeof v === "object") walk(v, [...trail, k]);
  }
})(tokens, []);

function resolves(role) {
  if (role.endsWith(".*")) {
    const prefix = role.slice(0, -2) + ".";
    for (const p of paths) if (p.startsWith(prefix)) return true;
    return false;
  }
  return paths.has(role);
}

function apiTokens(raw) {
  const m = raw.match(/^##\s+API\s*$/m);
  if (!m) return null;
  const fence = raw.slice(m.index).match(/```json\s*([\s\S]*?)```/);
  if (!fence) return null;
  try {
    return JSON.parse(fence[1]).tokens || [];
  } catch {
    return null;
  }
}

let failures = 0;
let checked = 0;
const unknown = new Map(); // role → [archetype ids]
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
    for (const role of apiTokens(raw) || []) {
      checked++;
      if (!resolves(role)) {
        failures++;
        if (!unknown.has(role)) unknown.set(role, []);
        unknown.get(role).push(id);
      }
    }
  }
}

for (const [role, ids] of unknown) {
  console.log(`✗ unknown token role \`${role}\` — referenced by ${ids.length} archetype(s): ${ids.slice(0, 6).join(", ")}${ids.length > 6 ? "…" : ""}`);
}

// Themes must override real tokens (concrete leaf paths).
let themeChecked = 0;
try {
  const { themes } = JSON.parse(readFileSync(join(here, "..", "..", "tokens", "themes.json"), "utf8"));
  for (const t of themes) {
    for (const path of Object.keys(t.tokens || {})) {
      themeChecked++;
      if (!paths.has(path)) {
        failures++;
        console.log(`✗ theme \`${t.id}\` overrides unknown token \`${path}\``);
      }
    }
  }
} catch {
  /* no themes file */
}

console.log(
  `\n${failures ? "✗" : "✓"} tokens: ${checked} contract reference(s) + ${themeChecked} theme override(s) checked, ${unknown.size} unknown role(s)`,
);
process.exitCode = failures ? 1 : 0;
