// Build the reativa (OCaml + Melange) example bundle consumed by the website's
// "Reativa" tab (see website/reativa/README.md).
//
// reativa's core library is a *private* dune library (no public_name), so it
// can't be consumed as an installed opam library — its own demo works only
// because it lives inside the reativa dune project. We do the same: clone
// reativa (pinned), drop website/reativa/{dune,xpecs_reativa.mlx} into a
// subdirectory of that project so the private `reativa` library and the
// `reativa.mlx_ppx` ppx resolve, compile to JS with Melange, then bundle the
// emitted entry into website/src/reativa.bundle.js with esbuild.
//
// Requires: opam switch with `dune`, `melange`, `mlx` installed, plus git and
// the website's esbuild devDependency. Not part of `npm run build`/CI's website
// build — invoked explicitly by `npm run reativa`.

import { execFileSync } from "node:child_process";
import { existsSync, mkdirSync, copyFileSync, readdirSync } from "node:fs";
import { resolve, join } from "node:path";
import { fileURLToPath } from "node:url";

const REATIVA_REPO = "https://github.com/brnrdog/reativa.git";
// Pin a known-good commit so the build is reproducible. Bump deliberately.
const REATIVA_REF = "c94697df4bcd16fae59f900a01f7c60964606492";

const websiteDir = resolve(fileURLToPath(import.meta.url), "../..");
const reativaDir = resolve(websiteDir, "reativa");
const buildDir = resolve(reativaDir, ".build");
const clone = resolve(buildDir, "reativa");
const exDir = resolve(clone, "xpecs_examples");

const sh = (file, args, cwd) =>
  execFileSync(file, args, { cwd, stdio: "inherit" });

// 1. Clone reativa (or reuse a previous clone) and check out the pinned commit.
mkdirSync(buildDir, { recursive: true });
if (!existsSync(resolve(clone, ".git"))) {
  sh("git", ["clone", REATIVA_REPO, "reativa"], buildDir);
}
sh("git", ["fetch", "--quiet", "origin"], clone);
sh("git", ["checkout", "--quiet", REATIVA_REF], clone);

// 2. Drop the example dune + source into the reativa project (same dune-project
//    ⇒ the private `reativa` library and reativa.mlx_ppx are in scope).
mkdirSync(exDir, { recursive: true });
copyFileSync(resolve(reativaDir, "dune"), resolve(exDir, "dune"));
copyFileSync(
  resolve(reativaDir, "xpecs_reativa.mlx"),
  resolve(exDir, "xpecs_reativa.mlx"),
);

// 3. Compile the examples (and reativa itself) to ES modules via Melange.
sh("opam", ["exec", "--", "dune", "build", "@melange"], clone);

// 4. Bundle the emitted entry into a single ES module under the website's src.
//    melange.emit mirrors the source path under the target dir, so the entry is
//    normally <target>/<emit-dir>/<module>.js — but locate it defensively in
//    case the nesting differs across dune/melange versions.
const outputRoot = resolve(clone, "_build/default/xpecs_examples/output");
const findEntry = (dir) => {
  for (const name of readdirSync(dir, { withFileTypes: true })) {
    const p = join(dir, name.name);
    if (name.isDirectory()) {
      const hit = findEntry(p);
      if (hit) return hit;
    } else if (name.name === "xpecs_reativa.js") {
      return p;
    }
  }
  return null;
};
const entry = findEntry(outputRoot);
if (!entry) {
  throw new Error(`could not find emitted xpecs_reativa.js under ${outputRoot}`);
}
const outfile = resolve(websiteDir, "src/reativa.bundle.js");
sh(
  "npx",
  ["--yes", "esbuild", entry, "--bundle", "--format=esm", `--outfile=${outfile}`],
  websiteDir,
);

console.log(`\n✓ reativa bundle written to ${outfile}`);
