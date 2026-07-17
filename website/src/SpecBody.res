// Renders an archetype's full spec. The spec is pre-rendered to HTML at build
// time (scripts/generate-registry.mjs) from the markdown source, so here we
// inject it into a scoped `.ux-prose` container after the node mounts.
let setHtmlById: (string, string) => unit = %raw(`(id, html) => setTimeout(() => { const el = document.getElementById(id); if (el) el.innerHTML = html; }, 0)`)

@jsx.component
let make = (~html: string) => {
  Effect.run(() => {
    setHtmlById("spec-body", html)
    None
  })
  <div id="spec-body" class="ux-prose mt-10" />
}
