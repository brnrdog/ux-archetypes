# Releasing

Publishing is automated with [Changesets](https://github.com/changesets/changesets)
and GitHub Actions. Four packages are published from this monorepo; the
`website` is private and never published.

| Package | Contents |
| ------- | -------- |
| `xpecs` | The spec catalogue + tokens (the repo root). |
| `@xpecs/tokens` | CSS variables, Tailwind preset, theme overlays, JS export. |
| `@xpecs/xote` | The Xote/ReScript component library. |
| `@xpecs/skill` | The Agent Skill (`SKILL.md` + compiled `reference/`). |

## One-time setup

1. **npm scope.** The publishing npm account must own the `@xpecs` scope
   (create an org named `xpecs`, or publish under an account that owns it). The
   scoped packages already declare `publishConfig.access = public`.
2. **`NPM_TOKEN` secret.** Add a repository secret `NPM_TOKEN` (Settings →
   Secrets → Actions) containing an npm **Automation** token with publish
   rights. The [`Release`](.github/workflows/release.yml) workflow uses it; until
   it's set, the workflow is a no-op (it never publishes).

## Day to day

1. Make your change on a branch.
2. Record it: `npx changeset` — pick the affected packages, the bump type
   (patch / minor / major), and write a one-line summary. This creates a file
   under `.changeset/`; **commit it with your PR.**
3. Open the PR. [`CI`](.github/workflows/ci.yml) builds the packages and runs
   every conformance gate.

## Cutting a release

On every push to `main`, the `Release` workflow runs:

- **If there are pending changesets** → it opens (or updates) a **"Version
  Packages"** PR that applies the bumps, updates each package's changelog, and
  deletes the consumed changesets. Review and merge it when you're ready.
- **When that PR merges** (no changesets left) → it runs `npm run release`,
  which builds the packages (`build:packages`) and `changeset publish`es the
  ones whose version isn't yet on npm, then pushes the git tags.

Nothing publishes without a merged Version Packages PR **and** a valid
`NPM_TOKEN`.

## Doing it locally (optional)

```sh
npm run build:packages   # build tokens → xote → skill
npm run version          # apply pending changesets (bumps + changelogs)
npm run release          # build + changeset publish  (needs npm auth)
```
