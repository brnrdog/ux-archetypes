// App shell: monochrome layout with a filterable sidebar of every archetype
// and a router that renders the overview or an archetype detail page.

open ArchetypesData

let layers = [("element", "Elements"), ("component", "Components"), ("page", "Pages")]

let byId = id => all->Array.find(a => a.id == id)
let existsId = id => all->Array.some(a => a.id == id)
let inLayer = layer => all->Array.filter(a => a.layer == layer)
let layerPlural = layer => layer ++ "s"
let docUrl = a =>
  "https://github.com/brnrdog/ux-archetypes/blob/main/archetypes/" ++
  layerPlural(a.layer) ++ "/" ++ a.id ++ ".md"

let query = Signal.make("")

let matches = (a, q) =>
  q == "" ||
  a.title->String.toLowerCase->String.includes(q) ||
  a.id->String.includes(q) ||
  a.summary->String.toLowerCase->String.includes(q)

module Badge = {
  @jsx.component
  let make = (~layer) =>
    <span
      class={"inline-flex items-center rounded px-2 py-0.5 text-[10px] font-semibold uppercase tracking-wide " ++
      Ui.layerBadge(layer)}>
      <View.Text> {layer} </View.Text>
    </span>
}

module Status = {
  @jsx.component
  let make = (~status) => {
    let dot = switch status {
    | "stable" => "bg-neutral-900"
    | "draft" => "bg-neutral-400"
    | _ => "bg-neutral-300"
    }
    <span class="inline-flex items-center gap-1.5 text-xs text-neutral-500">
      <span class={"size-1.5 rounded-full " ++ dot} />
      <View.Text> {status} </View.Text>
    </span>
  }
}

module Chip = {
  @jsx.component
  let make = (~id) => {
    let base = "inline-flex items-center rounded-full border px-2.5 py-1 text-xs transition-colors"
    if existsId(id) {
      <Router.Link
        to={"/a/" ++ id}
        class={base ++ " border-neutral-300 text-neutral-700 hover:border-neutral-900 hover:text-neutral-900"}>
        <View.Text> {id} </View.Text>
      </Router.Link>
    } else {
      <span class={base ++ " border-dashed border-neutral-200 text-neutral-400"}>
        <View.Text> {id} </View.Text>
      </span>
    }
  }
}

module ChipRow = {
  @jsx.component
  let make = (~title, ~ids) =>
    if Array.length(ids) == 0 {
      View.null()
    } else {
      <div class="space-y-2">
        <h3 class="text-xs font-semibold uppercase tracking-wide text-neutral-500">
          <View.Text> {title} </View.Text>
        </h3>
        <div class="flex flex-wrap gap-1.5">
          <View.For each={Prop.static(ids)} render={id => <Chip id />} />
        </div>
      </div>
    }
}

module SidebarGroup = {
  @jsx.component
  let make = (~layer, ~title) => {
    let items = Computed.make(() => {
      let q = Signal.get(query)->String.toLowerCase
      inLayer(layer)->Array.filter(a => matches(a, q))
    })
    let countLabel = Computed.make(() => Signal.get(items)->Array.length->Int.toString)
    <View.Show when_={Prop.signal(Computed.make(() => Signal.get(items)->Array.length > 0))}>
      <div class="mb-4">
        <div class="mb-1 flex items-center justify-between px-2">
          <span class="text-xs font-semibold uppercase tracking-wide text-neutral-500">
            <View.Text> {title} </View.Text>
          </span>
          <span class="text-xs tabular-nums text-neutral-400"> <View.Text> {countLabel} </View.Text> </span>
        </div>
        <ul class="space-y-0.5">
          <View.For
            each={Prop.signal(items)}
            by={a => a.id}
            render={a => {
              let cls = Computed.make(() => {
                let active = Signal.get(Router.location()).pathname == "/a/" ++ a.id
                "block rounded-md px-2 py-1.5 text-sm transition-colors " ++ (
                  active
                    ? "bg-neutral-900 text-white"
                    : "text-neutral-700 hover:bg-neutral-100"
                )
              })
              <li>
                <Router.Link to={"/a/" ++ a.id} class={Prop.signal(cls)}>
                  <View.Text> {a.title} </View.Text>
                </Router.Link>
              </li>
            }}
          />
        </ul>
      </div>
    </View.Show>
  }
}

module Sidebar = {
  @jsx.component
  let make = () =>
    <aside class="flex h-screen w-72 shrink-0 flex-col border-r border-neutral-200 bg-neutral-50">
      <div class="border-b border-neutral-200 p-4">
        <Router.Link to="/" class="block">
          <div class="text-sm font-semibold tracking-tight text-neutral-900">
            <View.Text> "UX Archetypes" </View.Text>
          </div>
          <div class="text-xs text-neutral-500">
            <View.Text> {Array.length(all)->Int.toString ++ " patterns"} </View.Text>
          </div>
        </Router.Link>
        <input
          class={Ui.inputBase ++ " mt-3"}
          type_="search"
          placeholder="Filter archetypes…"
          onInput={e => Signal.set(query, Ui.inputValue(e))}
        />
      </div>
      <nav class="flex-1 overflow-y-auto p-2">
        <SidebarGroup layer="element" title="Elements" />
        <SidebarGroup layer="component" title="Components" />
        <SidebarGroup layer="page" title="Pages" />
      </nav>
    </aside>
}

module Home = {
  @jsx.component
  let make = () => {
    let stat = (layer, title) =>
      <div class={Ui.card ++ " p-5"}>
        <div class="text-3xl font-bold tabular-nums text-neutral-900">
          <View.Text> {inLayer(layer)->Array.length->Int.toString} </View.Text>
        </div>
        <div class="mt-1 text-sm text-neutral-500"> <View.Text> {title} </View.Text> </div>
      </div>
    <div class="mx-auto max-w-3xl px-8 py-16">
      <span class="inline-flex items-center rounded-full border border-neutral-300 px-3 py-1 text-xs text-neutral-600">
        <View.Text> "Monochrome · Xote · ReScript" </View.Text>
      </span>
      <h1 class="mt-6 text-4xl font-bold tracking-tight text-neutral-900">
        <View.Text> "User Experience Archetypes" </View.Text>
      </h1>
      <p class="mt-4 text-lg leading-relaxed text-neutral-600">
        <View.Text> "A technology-agnostic catalogue of UI patterns. Browse every archetype in the sidebar and see a live implementation rendered with " </View.Text>
        <a class="underline decoration-neutral-300 underline-offset-4 hover:decoration-neutral-900" href="https://xote.dev" target="_blank">
          <View.Text> "Xote" </View.Text>
        </a>
        <View.Text> "." </View.Text>
      </p>
      <div class="mt-10 grid grid-cols-3 gap-4">
        {stat("element", "Elements")}
        {stat("component", "Components")}
        {stat("page", "Pages")}
      </div>
      <p class="mt-10 text-sm text-neutral-500">
        <View.Text> "Pick a pattern from the left to get started — try " </View.Text>
        <Router.Link to="/a/button" class="underline decoration-neutral-300 underline-offset-4 hover:decoration-neutral-900">
          <View.Text> "Button" </View.Text>
        </Router.Link>
        <View.Text> " or " </View.Text>
        <Router.Link to="/a/switch" class="underline decoration-neutral-300 underline-offset-4 hover:decoration-neutral-900">
          <View.Text> "Switch" </View.Text>
        </Router.Link>
        <View.Text> "." </View.Text>
      </p>
    </div>
  }
}

module Preview = {
  @jsx.component
  let make = (~id) =>
    switch Examples.get(id) {
    | Some(node) =>
      <div class="preview-surface flex min-h-48 items-center justify-center rounded-lg border border-neutral-200 p-10">
        {node}
      </div>
    | None =>
      <div class="flex min-h-48 flex-col items-center justify-center gap-2 rounded-lg border border-dashed border-neutral-300 p-10 text-center">
        <span class="text-sm font-medium text-neutral-600"> <View.Text> "Live example coming soon" </View.Text> </span>
        <span class="max-w-xs text-xs text-neutral-400">
          <View.Text> "The written specification is complete. An interactive Xote implementation for this archetype is on the way." </View.Text>
        </span>
      </div>
    }
}

module NotFound = {
  @jsx.component
  let make = () =>
    <div class="mx-auto max-w-3xl px-8 py-16">
      <h1 class="text-2xl font-bold text-neutral-900"> <View.Text> "Archetype not found" </View.Text> </h1>
      <Router.Link to="/" class="mt-4 inline-block text-sm underline underline-offset-4">
        <View.Text> "← Back to overview" </View.Text>
      </Router.Link>
    </div>
}

module ExampleBlock = {
  @jsx.component
  let make = (~a: archetype) => {
    let mode = Signal.make("preview")
    let copied = Signal.make(false)
    let snippet = ExampleSource.get(a.id)
    let tabCls = target =>
      Computed.make(() =>
        "rounded-md px-3 py-1 text-xs font-medium transition-colors " ++ (
          Signal.get(mode) == target ? "bg-neutral-900 text-white" : "text-neutral-600 hover:text-neutral-900"
        )
      )
    let isPreview = Computed.make(() => Signal.get(mode) == "preview")
    let isCode = Computed.make(() => Signal.get(mode) == "code")
    let copyLabel = Computed.make(() => Signal.get(copied) ? "Copied ✓" : "Copy")
    <div class="mt-10">
      <div class="mb-3 flex items-center justify-between">
        <div class="inline-flex items-center gap-1 rounded-lg border border-neutral-200 bg-neutral-50 p-0.5">
          <button class={Prop.signal(tabCls("preview"))} onClick={_ => Signal.set(mode, "preview")}>
            <View.Text> "Preview" </View.Text>
          </button>
          {switch snippet {
          | Some(_) =>
            <button class={Prop.signal(tabCls("code"))} onClick={_ => Signal.set(mode, "code")}>
              <View.Text> "Code" </View.Text>
            </button>
          | None => View.null()
          }}
        </div>
        <a
          class="text-xs text-neutral-400 underline underline-offset-4 hover:text-neutral-700"
          href={docUrl(a)}
          target="_blank">
          <View.Text> "Read the spec ↗" </View.Text>
        </a>
      </div>
      <View.Show when_={Prop.signal(isPreview)}>
        <Preview id={a.id} />
      </View.Show>
      {switch snippet {
      | Some(code) =>
        <View.Show when_={Prop.signal(isCode)}>
          <div class="relative">
            <button
              class="absolute right-2 top-2 z-10 rounded-md border border-neutral-700 bg-neutral-800 px-2 py-1 text-xs text-neutral-200 transition-colors hover:bg-neutral-700"
              onClick={_ => {
                Ui.copyToClipboard(code)
                Signal.set(copied, true)
                Ui.setTimeout(() => Signal.set(copied, false), 1500)
              }}>
              <View.Text> {copyLabel} </View.Text>
            </button>
            <pre
              class="max-h-[32rem] overflow-auto rounded-lg border border-neutral-800 bg-neutral-900 p-4 text-xs leading-relaxed text-neutral-100">
              <code class="font-mono"> <View.Text> {code} </View.Text> </code>
            </pre>
          </div>
        </View.Show>
      | None => View.null()
      }}
    </div>
  }
}

module Detail = {
  @jsx.component
  let make = (~id) =>
    switch byId(id) {
    | None => <NotFound />
    | Some(a) =>
      <div class="mx-auto max-w-3xl px-8 py-12">
        <nav class="flex items-center gap-2 text-xs text-neutral-400">
          <Router.Link to="/" class="hover:text-neutral-700"> <View.Text> "Overview" </View.Text> </Router.Link>
          <span> <View.Text> "/" </View.Text> </span>
          <span class="capitalize"> <View.Text> {layerPlural(a.layer)} </View.Text> </span>
          <span> <View.Text> "/" </View.Text> </span>
          <span class="text-neutral-700"> <View.Text> {a.title} </View.Text> </span>
        </nav>
        <div class="mt-4 flex flex-wrap items-center gap-3">
          <h1 class="text-3xl font-bold tracking-tight text-neutral-900"> <View.Text> {a.title} </View.Text> </h1>
          <Badge layer={a.layer} />
          <Status status={a.status} />
          <span class="font-mono text-xs text-neutral-400"> <View.Text> {"v" ++ a.version} </View.Text> </span>
        </div>
        <p class="mt-4 text-lg leading-relaxed text-neutral-700"> <View.Text> {a.summary} </View.Text> </p>
        <View.Show when_={Prop.static(a.intent != "")}>
          <p class="mt-4 leading-relaxed text-neutral-600"> <View.Text> {a.intent} </View.Text> </p>
        </View.Show>
        <View.Show when_={Prop.static(Array.length(a.tags) > 0)}>
          <div class="mt-4 flex flex-wrap gap-1.5">
            <View.For
              each={Prop.static(a.tags)}
              render={t =>
                <span class="rounded bg-neutral-100 px-2 py-0.5 text-xs text-neutral-500">
                  <View.Text> {t} </View.Text>
                </span>}
            />
          </div>
        </View.Show>

        <ExampleBlock a />

        <div class="mt-10 grid gap-6 sm:grid-cols-3">
          <ChipRow title="Composed of" ids={a.composedOf} />
          <ChipRow title="Used by" ids={a.usedBy} />
          <ChipRow title="Related" ids={a.related} />
        </div>
      </div>
    }
}

@jsx.component
let make = () => {
  let routes = Router.routes([
    {pattern: "/", render: _ => <Home />},
    {pattern: "/a/:id", render: params => <Detail id={params->Dict.get("id")->Option.getOr("")} />},
  ])
  <div class="flex">
    <Sidebar />
    <main class="h-screen flex-1 overflow-y-auto"> {routes} </main>
  </div>
}
