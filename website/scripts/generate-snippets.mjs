// Generates src/ExampleSource.res — the ReScript source of every example in
// Examples.res, keyed by archetype id — so each detail page can show the exact
// implementation that produces its live preview. Examples.res stays the single
// source of truth; this just extracts it.
import { readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const src = readFileSync(join(here, "..", "src", "Examples.res"), "utf8");
const outFile = join(here, "..", "src", "ExampleSource.res");

// Find the matching close brace for the block that opens at `start` ("{"),
// skipping string literals (", `) and comments so braces inside them don't count.
function matchBrace(s, start) {
  let depth = 0;
  let mode = "code";
  for (let i = start; i < s.length; i++) {
    const c = s[i];
    const c2 = s[i + 1];
    if (mode === "code") {
      if (c === '"') mode = "dq";
      else if (c === "`") mode = "bt";
      else if (c === "/" && c2 === "/") { mode = "lc"; i++; }
      else if (c === "/" && c2 === "*") { mode = "bc"; i++; }
      else if (c === "{") depth++;
      else if (c === "}") { depth--; if (depth === 0) return i; }
    } else if (mode === "dq") {
      if (c === "\\") i++;
      else if (c === '"') mode = "code";
    } else if (mode === "bt") {
      if (c === "\\") i++;
      else if (c === "`") mode = "code";
    } else if (mode === "lc") {
      if (c === "\n") mode = "code";
    } else if (mode === "bc") {
      if (c === "*" && c2 === "/") { mode = "code"; i++; }
    }
  }
  return s.length - 1;
}

// Extract every top-level `module Name = { ... }` block.
const modules = {};
const modRe = /^module\s+(\w+)\s*=\s*\{/gm;
let m;
while ((m = modRe.exec(src))) {
  const open = src.indexOf("{", m.index);
  const close = matchBrace(src, open);
  modules[m[1]] = src.slice(m.index, close + 1);
}

// Map archetype id -> module name from the `get` switch.
const idToModule = {};
const armRe = /\|\s*"([^"]+)"\s*=>\s*Some\(<(\w+)\s*\/>\)/g;
while ((m = armRe.exec(src))) idToModule[m[1]] = m[2];

const s = (v) => JSON.stringify(v); // valid ReScript string literal

const arms = Object.entries(idToModule)
  .map(([id, mod]) => {
    let code = modules[mod];
    // Make snippets that rely on the shared Backdrop helper self-contained.
    if (/<Backdrop\b/.test(code) && modules.Backdrop) {
      code = modules.Backdrop + "\n\n" + code;
    }
    return `  | ${s(id)} => Some(${s(code)})`;
  })
  .join("\n");

const out = `// GENERATED FILE — do not edit by hand.
// Run \`npm run snippets\` (scripts/generate-snippets.mjs) to regenerate.
// Source of each example is extracted verbatim from Examples.res.

let get = (id: string): option<string> =>
  switch id {
${arms}
  | _ => None
  }
`;

writeFileSync(outFile, out);
console.log(`Wrote ${Object.keys(idToModule).length} snippets to ${outFile}`);
