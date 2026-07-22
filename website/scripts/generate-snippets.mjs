// Generates src/ExampleSource.res — the ReScript source of every example in
// Examples.res, keyed by spec id — so each detail page can show the exact
// implementation that produces its live preview. Examples.res and the reusable
// component modules stay the single source of truth; this just extracts them.
// Any reusable component an example composes (Button, Badge, …) is prepended so
// each snippet is self-contained and shows the reuse.
import { readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const srcDir = join(here, "..", "src");
// Reusable components now live in the @xpecs/xote package.
const compDir = join(here, "..", "..", "packages", "xote", "src");
const examplesSrc = readFileSync(join(srcDir, "Examples.res"), "utf8");
const outFile = join(srcDir, "ExampleSource.res");

// The reusable components, each defined in its own file (referenced as <Name>).
const COMPONENTS = [
  "Button", "Badge", "Input", "Field", "Avatar",
  "Switch", "Spinner", "Kbd", "Separator", "Backdrop",
  "Link", "IconButton", "Skeleton",
  // Block-level sections — inlined so a block's snippet shows the full
  // implementation behind its usage.
  "PageHeader", "StatGrid", "LogoCloud", "Steps",
  "ContactSection", "Newsletter", "AnnouncementBar",
];

// Read a component file and drop its leading // comment block.
function componentBody(name) {
  const raw = readFileSync(join(compDir, `${name}.res`), "utf8").split("\n");
  let i = 0;
  while (i < raw.length && (raw[i].startsWith("//") || raw[i].trim() === "")) i++;
  return raw.slice(i).join("\n").trimEnd();
}
const componentSrc = Object.fromEntries(COMPONENTS.map((n) => [n, componentBody(n)]));

// Find the matching close brace for the block opening at `start` ("{"),
// skipping strings and comments so their braces don't count.
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

// Extract every top-level `module Name = { ... }` block from Examples.res.
const exampleMods = {};
for (const m of examplesSrc.matchAll(/^module\s+(\w+)\s*=\s*\{/gm)) {
  const open = examplesSrc.indexOf("{", m.index);
  exampleMods[m[1]] = examplesSrc.slice(m.index, matchBrace(examplesSrc, open) + 1);
}

// Component names referenced (<Name>) within a chunk of code.
function refs(text) {
  return [...new Set([...text.matchAll(/<([A-Z]\w*)/g)].map((m) => m[1]))].filter((n) =>
    COMPONENTS.includes(n),
  );
}

// Dependency-ordered closure of components an example needs.
function collect(seed) {
  const seen = new Set();
  const order = [];
  const visit = (name) => {
    if (seen.has(name) || !componentSrc[name]) return;
    seen.add(name);
    for (const dep of refs(componentSrc[name])) visit(dep);
    order.push(name);
  };
  seed.forEach(visit);
  return order;
}

const indent = (t) => t.split("\n").map((l) => (l.length ? "  " + l : l)).join("\n");
const wrapComponent = (name) => `module ${name} = {\n${indent(componentSrc[name])}\n}`;

// Map spec id -> example module name from the `get` switch.
const idToModule = {};
for (const m of examplesSrc.matchAll(/\|\s*"([^"]+)"\s*=>\s*Some\(<(\w+)\s*\/>\)/g)) {
  idToModule[m[1]] = m[2];
}

const s = (v) => JSON.stringify(v); // valid ReScript string literal

const arms = Object.entries(idToModule)
  .map(([id, mod]) => {
    const code = exampleMods[mod];
    const parts = collect(refs(code)).map(wrapComponent);
    parts.push(code);
    return `  | ${s(id)} => Some(${s(parts.join("\n\n"))})`;
  })
  .join("\n");

const out = `// GENERATED FILE — do not edit by hand.
// Run \`npm run snippets\` (scripts/generate-snippets.mjs) to regenerate.
// Source is extracted verbatim from Examples.res and the reusable components.

let get = (id: string): option<string> =>
  switch id {
${arms}
  | _ => None
  }
`;

writeFileSync(outFile, out);
console.log(`Wrote ${Object.keys(idToModule).length} snippets to ${outFile}`);
