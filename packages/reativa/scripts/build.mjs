// Build the @prescriptive/reativa component bundle (consumed by the website's Reativa
// tab). reativa's core library is a *private* dune library (no public_name), so
// it can't be consumed as an installed opam library — its own demo works only
// because it lives inside the reativa dune project. We do the same: clone
// reativa (pinned), drop this package's `dune` + src/ modules into a
// subdirectory of that project so the private `reativa` library and the
// `reativa.mlx_ppx` ppx resolve, compile to JS with Melange, then bundle the
// emitted entry (Registry.js) into dist/reativa.bundle.js with esbuild.
//
// Requires: an opam switch with `dune`, `melange`, `mlx` installed, plus git and
// esbuild. Not part of `npm run build:packages`/the website's default build
// (it needs opam/melange, which the rest of the build does not) — invoked
// explicitly by `npm run build --workspace @prescriptive/reativa`, and by CI so PRs
// compile the components and Pages ships the real bundle.

import { execFileSync } from "node:child_process";
import {
  existsSync,
  mkdirSync,
  copyFileSync,
  readdirSync,
} from "node:fs";
import { resolve, join } from "node:path";
import { fileURLToPath } from "node:url";

const REATIVA_REPO = "https://github.com/brnrdog/reativa.git";
// Pin a known-good commit so the build is reproducible. Bump deliberately.
const REATIVA_REF = "c94697df4bcd16fae59f900a01f7c60964606492";

const pkgDir = resolve(fileURLToPath(import.meta.url), "../..");
const srcDir = resolve(pkgDir, "src");
const buildDir = resolve(pkgDir, ".build");
const clone = resolve(buildDir, "reativa");
// The subdirectory inside the reativa dune project we drop our sources into.
const exDir = resolve(clone, "prescriptive_reativa");
const distDir = resolve(pkgDir, "dist");

const sh = (file, args, cwd) => execFileSync(file, args, { cwd, stdio: "inherit" });

// 1. Clone reativa (or reuse a previous clone) and check out the pinned commit.
mkdirSync(buildDir, { recursive: true });
if (!existsSync(resolve(clone, ".git"))) {
  sh("git", ["clone", REATIVA_REPO, "reativa"], buildDir);
}
sh("git", ["fetch", "--quiet", "origin"], clone);
sh("git", ["checkout", "--quiet", REATIVA_REF], clone);

// 2. Drop this package's dune + every src module into the reativa project (same
//    dune-project ⇒ the private `reativa` library and reativa.mlx_ppx are in
//    scope, and the `.mlx` dialect is available).
mkdirSync(exDir, { recursive: true });
copyFileSync(resolve(pkgDir, "dune"), resolve(exDir, "dune"));
for (const name of readdirSync(srcDir)) {
  if (name.endsWith(".mlx") || name.endsWith(".ml") || name.endsWith(".mli")) {
    copyFileSync(resolve(srcDir, name), resolve(exDir, name));
  }
}

// 3. Compile the components (and reativa itself) to ES modules via Melange.
sh("opam", ["exec", "--", "dune", "build", "@melange"], clone);

// 4. Bundle the emitted entry (Registry.js) into a single ES module. melange.emit
//    mirrors the source path under the target dir, so the entry is normally
//    <target>/<emit-dir>/output/Registry.js — but locate it defensively in case
//    the nesting differs across dune/melange versions.
const outputRoot = resolve(clone, "_build/default/prescriptive_reativa/output");
const findEntry = (dir) => {
  for (const name of readdirSync(dir, { withFileTypes: true })) {
    const p = join(dir, name.name);
    if (name.isDirectory()) {
      const hit = findEntry(p);
      if (hit) return hit;
    } else if (name.name === "Registry.js") {
      return p;
    }
  }
  return null;
};
const entry = findEntry(outputRoot);
if (!entry) {
  throw new Error(`could not find emitted Registry.js under ${outputRoot}`);
}
mkdirSync(distDir, { recursive: true });
const outfile = resolve(distDir, "reativa.bundle.js");
sh(
  "npx",
  ["--yes", "esbuild", entry, "--bundle", "--format=esm", `--outfile=${outfile}`],
  pkgDir,
);

console.log(`\n✓ @prescriptive/reativa bundle written to ${outfile}`);
