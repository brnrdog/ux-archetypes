// Generates src/tokens.generated.css from the framework's design tokens
// (../tokens/tokens.json, W3C DTCG format). Emits a Tailwind `@theme` block so
// utilities (bg-neutral-900, font-sans, rounded-lg, …) resolve from the tokens,
// plus a `:root` mirror of every token as a --ux-* custom property for direct use.
import { readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { themeVarFor } from "./token-vars.mjs";

const here = dirname(fileURLToPath(import.meta.url));
const tokens = JSON.parse(readFileSync(join(here, "..", "..", "tokens", "tokens.json"), "utf8"));

// Flatten to { "color.neutral.900": { type, value }, ... }, inheriting $type.
const flat = {};
function walk(node, path, inheritedType) {
  const type = node.$type || inheritedType;
  if (Object.prototype.hasOwnProperty.call(node, "$value")) {
    flat[path.join(".")] = { type, value: node.$value };
    return;
  }
  for (const [k, v] of Object.entries(node)) {
    if (k.startsWith("$")) continue;
    walk(v, [...path, k], type);
  }
}
for (const [k, v] of Object.entries(tokens)) {
  if (k.startsWith("$")) continue;
  walk(v, [k], undefined);
}

// Resolve {a.b.c} aliases to their concrete value.
function resolve(value, seen = new Set()) {
  if (typeof value === "string") {
    const m = value.match(/^\{(.+)\}$/);
    if (m) {
      const ref = m[1];
      if (seen.has(ref) || !flat[ref]) return value;
      seen.add(ref);
      return resolve(flat[ref].value, seen);
    }
  }
  return value;
}

// Format a token's resolved value as a CSS value based on its $type.
function cssValue(type, rawValue) {
  const value = resolve(rawValue);
  switch (type) {
    case "fontFamily":
      return (Array.isArray(value) ? value : [value])
        .map((f) => (/\s/.test(f) ? `"${f}"` : f))
        .join(", ");
    case "shadow": {
      const list = Array.isArray(value) ? value : [value];
      return list
        .map((s) => `${s.offsetX} ${s.offsetY} ${s.blur} ${s.spread || "0"} ${s.color}`)
        .join(", ");
    }
    default:
      return String(value);
  }
}

// Aliases stay live: a token whose value is `{ref}` emits a `var(--ref)` pointing
// at the referenced token's variable, so editing (or theming) a base token
// cascades through the whole semantic graph at runtime. `varFor` picks the right
// variable namespace for the reference (@theme vs --ux-*).
function aliasRef(rawValue) {
  return typeof rawValue === "string" && /^\{(.+)\}$/.test(rawValue) ? rawValue.slice(1, -1) : null;
}
function themeValueFor(tok) {
  const ref = aliasRef(tok.value);
  if (ref) {
    const v = themeVarFor(ref);
    if (v) return `var(${v})`;
  }
  return cssValue(tok.type, tok.value);
}
function uxValueFor(tok) {
  const ref = aliasRef(tok.value);
  if (ref) return `var(--ux-${ref.replace(/\./g, "-")})`;
  return cssValue(tok.type, tok.value);
}

// --- Tailwind @theme mapping (drives utility classes) -----------------------
// Any token whose path maps to a theme var (see token-vars.mjs) is emitted here,
// so bg-*, text-*, rounded-*, shadow-*, font-*, and the spacing base all resolve
// from the tokens — and overriding the var at runtime re-themes the whole site.
const themeLines = [];
for (const [path, tok] of Object.entries(flat)) {
  const varName = themeVarFor(path);
  if (varName) themeLines.push(`  ${varName}: ${themeValueFor(tok)};`);
}

// --- :root mirror of every token (--ux-*) -----------------------------------
const rootLines = [];
for (const [path, tok] of Object.entries(flat)) {
  rootLines.push(`  --ux-${path.replace(/\./g, "-")}: ${uxValueFor(tok)};`);
}

const out = `/* GENERATED FILE — do not edit by hand.
 * Run \`npm run tokens\` (scripts/generate-tokens-css.mjs) to regenerate.
 * Source of truth: ../../tokens/tokens.json (W3C DTCG design tokens). */

@theme {
${themeLines.join("\n")}
}

:root {
${rootLines.join("\n")}
}
`;

writeFileSync(join(here, "..", "src", "tokens.generated.css"), out);
console.log(`Wrote ${Object.keys(flat).length} tokens to src/tokens.generated.css`);
