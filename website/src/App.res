// App shell: a topbar with spotlight search (⌘K), a collapsible sidebar of every
// archetype, and a router that renders the overview or an archetype detail page.

open ArchetypesData

let byId = id => all->Array.find(a => a.id == id)
let existsId = id => all->Array.some(a => a.id == id)
let inLayer = layer => all->Array.filter(a => a.layer == layer)
let layerPlural = layer => layer ++ "s"
let docUrl = a =>
  "https://github.com/brnrdog/ux-archetypes/blob/main/archetypes/" ++
  layerPlural(a.layer) ++ "/" ++ a.id ++ ".md"

let matches = (a, q) =>
  q == "" ||
  a.title->String.toLowerCase->String.includes(q) ||
  a.id->String.includes(q) ||
  a.summary->String.toLowerCase->String.includes(q)

// Global UI state shared across the shell.
let sidebarOpen = Signal.make(true)
let spotlightOpen = Signal.make(false)

module LayerBadge = {
  @jsx.component
  let make = (~layer) =>
    <span
      class={"inline-flex items-center rounded-md px-2 py-0.5 text-[10px] font-semibold uppercase tracking-wide " ++
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
    let items = inLayer(layer)
    <div class="mb-4">
      <div class="mb-1 flex items-center justify-between px-2">
        <span class="text-xs font-semibold uppercase tracking-wide text-neutral-500">
          <View.Text> {title} </View.Text>
        </span>
        <span class="text-xs tabular-nums text-neutral-400"> <View.Text> {Array.length(items)->Int.toString} </View.Text> </span>
      </div>
      <ul class="space-y-0.5">
        <View.For
          each={Prop.static(items)}
          by={a => a.id}
          render={a => {
            let cls = Computed.make(() => {
              let active = Signal.get(Router.location()).pathname == "/a/" ++ a.id
              "block rounded-lg px-2 py-1.5 text-sm transition-colors " ++ (
                active ? "bg-neutral-900 text-white" : "text-neutral-700 hover:bg-neutral-100"
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
  }
}

module Sidebar = {
  @jsx.component
  let make = () => {
    let cls = Computed.make(() =>
      "shrink-0 overflow-hidden border-r border-neutral-200 bg-neutral-50 transition-[width] duration-200 ease-out " ++ (
        Signal.get(sidebarOpen) ? "w-64" : "w-0"
      )
    )
    <aside class={Prop.signal(cls)}>
      <nav class="h-full w-64 overflow-y-auto p-2">
        <SidebarGroup layer="element" title="Elements" />
        <SidebarGroup layer="component" title="Components" />
        <SidebarGroup layer="block" title="Blocks" />
        <SidebarGroup layer="page" title="Pages" />
        <SidebarGroup layer="flow" title="Flows" />
      </nav>
    </aside>
  }
}

module Topbar = {
  @jsx.component
  let make = () =>
    <header class="flex h-14 shrink-0 items-center gap-3 border-b border-neutral-200 bg-white px-3">
      <IconButton label="Toggle sidebar" onClick={_ => Signal.update(sidebarOpen, v => !v)}>
        <span class="text-lg"> <View.Text> "☰" </View.Text> </span>
      </IconButton>
      <Router.Link to="/" class="flex items-center gap-2">
        <span class="flex size-7 items-center justify-center rounded-lg bg-neutral-900 text-xs font-bold text-white"> <View.Text> "U" </View.Text> </span>
        <span class="hidden text-sm font-semibold tracking-tight text-neutral-900 sm:block"> <View.Text> "UX Archetypes" </View.Text> </span>
      </Router.Link>
      <div class="flex flex-1 justify-center">
        <button
          class="flex w-full max-w-sm items-center gap-2 rounded-lg border border-neutral-200 bg-neutral-50 px-3 py-1.5 text-sm text-neutral-400 transition-colors hover:bg-neutral-100"
          onClick={_ => Signal.set(spotlightOpen, true)}>
          <span> <View.Text> "🔍" </View.Text> </span>
          <span class="flex-1 text-left"> <View.Text> "Search archetypes…" </View.Text> </span>
          <Kbd> <View.Text> "⌘K" </View.Text> </Kbd>
        </button>
      </div>
      <Link
        href="https://github.com/brnrdog/ux-archetypes"
        variant=#muted
        newTab=true
        extraClass="hidden text-sm sm:block">
        <View.Text> "GitHub ↗" </View.Text>
      </Link>
    </header>
}

module Spotlight = {
  @jsx.component
  let make = () => {
    let q = Signal.make("")
    let active = Signal.make(0)
    let results = Computed.make(() => {
      let s = Signal.get(q)->String.toLowerCase
      all->Array.filter(a => matches(a, s))
    })
    // Reset + focus the input whenever the palette opens.
    Effect.run(() => {
      if Signal.get(spotlightOpen) {
        Signal.set(q, "")
        Signal.set(active, 0)
        Ui.focusById("spotlight-input")
      }
      None
    })
    let navigate = a => {
      Signal.set(spotlightOpen, false)
      Router.push("/a/" ++ a.id, ())
    }
    let onKey = e =>
      switch Ui.eventKey(e) {
      | "ArrowDown" =>
        Ui.preventDefault(e)
        Signal.update(active, i => {
          let n = Signal.get(results)->Array.length
          n == 0 ? 0 : mod(i + 1, n)
        })
      | "ArrowUp" =>
        Ui.preventDefault(e)
        Signal.update(active, i => {
          let n = Signal.get(results)->Array.length
          n == 0 ? 0 : mod(i - 1 + n, n)
        })
      | "Enter" =>
        switch Signal.get(results)->Array.get(Signal.get(active)) {
        | Some(a) => navigate(a)
        | None => ()
        }
      | "Escape" => Signal.set(spotlightOpen, false)
      | _ => ()
      }
    let empty = Computed.make(() => Signal.get(results)->Array.length == 0)
    <View.Show when_={Prop.signal(spotlightOpen)}>
      <div class="fixed inset-0 z-50 flex items-start justify-center p-4 pt-[12vh]">
        <div class="absolute inset-0 bg-neutral-900/40" onClick={_ => Signal.set(spotlightOpen, false)} />
        <div class="relative z-10 w-full max-w-lg overflow-hidden rounded-2xl border border-neutral-200 bg-white shadow-2xl">
          <div class="flex items-center gap-2 border-b border-neutral-100 px-4">
            <span class="text-neutral-400"> <View.Text> "🔍" </View.Text> </span>
            <input
              id="spotlight-input"
              class="w-full bg-transparent py-3.5 text-sm focus:outline-none"
              placeholder="Search archetypes…"
              onInput={e => {
                Signal.set(q, Ui.inputValue(e))
                Signal.set(active, 0)
              }}
              onKeyDown={onKey}
            />
            <Kbd> <View.Text> "esc" </View.Text> </Kbd>
          </div>
          <ul class="max-h-80 overflow-y-auto p-2">
            <View.For
              each={Prop.signal(results)}
              by={a => a.id}
              render={a => {
                let cls = Computed.make(() => {
                  let sel = switch Signal.get(results)->Array.get(Signal.get(active)) {
                  | Some(x) => x.id == a.id
                  | None => false
                  }
                  "flex w-full cursor-pointer items-center justify-between gap-3 rounded-lg px-3 py-2 text-left text-sm transition-colors " ++ (
                    sel ? "bg-neutral-900 text-white" : "text-neutral-700 hover:bg-neutral-100"
                  )
                })
                <li>
                  <button class={Prop.signal(cls)} onClick={_ => navigate(a)}>
                    <span> <View.Text> {a.title} </View.Text> </span>
                    <span class="text-xs opacity-60"> <View.Text> {a.layer} </View.Text> </span>
                  </button>
                </li>
              }}
            />
            <View.Show when_={Prop.signal(empty)}>
              <li class="px-3 py-8 text-center text-sm text-neutral-400"> <View.Text> "No archetypes found" </View.Text> </li>
            </View.Show>
          </ul>
        </div>
      </div>
    </View.Show>
  }
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
      <Badge variant=#outline> <View.Text> "Monochrome · Xote · ReScript" </View.Text> </Badge>
      <h1 class="mt-6 text-4xl font-bold tracking-tight text-neutral-900">
        <View.Text> "User Experience Archetypes" </View.Text>
      </h1>
      <p class="mt-4 text-lg leading-relaxed text-neutral-600">
        <View.Text> "A technology-agnostic catalogue of UI patterns. Browse every archetype in the sidebar and see a live implementation rendered with " </View.Text>
        <Link href="https://xote.dev" newTab=true> <View.Text> "Xote" </View.Text> </Link>
        <View.Text> "." </View.Text>
      </p>
      <div class="mt-10 grid grid-cols-2 gap-4 sm:grid-cols-5">
        {stat("element", "Elements")}
        {stat("component", "Components")}
        {stat("block", "Blocks")}
        {stat("page", "Pages")}
        {stat("flow", "Flows")}
      </div>
      <p class="mt-10 text-sm text-neutral-500">
        <View.Text> "Press " </View.Text>
        <Kbd> <View.Text> "⌘K" </View.Text> </Kbd>
        <View.Text> " to search, or try " </View.Text>
        <Router.Link to="/a/button" class="underline decoration-neutral-300 underline-offset-4 hover:decoration-neutral-900">
          <View.Text> "Button" </View.Text>
        </Router.Link>
        <View.Text> " and " </View.Text>
        <Router.Link to="/a/dashboard" class="underline decoration-neutral-300 underline-offset-4 hover:decoration-neutral-900">
          <View.Text> "Dashboard" </View.Text>
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
      <div class="preview-surface flex min-h-48 items-center justify-center rounded-2xl border border-neutral-200 p-10">
        {node}
      </div>
    | None =>
      <div class="flex min-h-48 flex-col items-center justify-center gap-2 rounded-2xl border border-dashed border-neutral-300 p-10 text-center">
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
    let full = Signal.make(false)
    let snippet = ExampleSource.get(a.id)
    let hasExample = Examples.get(a.id)->Option.isSome
    let tabCls = target =>
      Computed.make(() =>
        "rounded-md px-3 py-1 text-xs font-medium transition-colors " ++ (
          Signal.get(mode) == target ? "bg-neutral-900 text-white" : "text-neutral-600 hover:text-neutral-900"
        )
      )
    let isPreview = Computed.make(() => Signal.get(mode) == "preview")
    let isCode = Computed.make(() => Signal.get(mode) == "code")
    let copyLabel = Computed.make(() => Signal.get(copied) ? "Copied ✓" : "Copy")
    // Close fullscreen on Escape while it is open.
    Effect.run(() => Signal.get(full) ? Some(Ui.onEscape(() => Signal.set(full, false))) : None)
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
        <div class="flex items-center gap-3">
          {hasExample
            ? <Button variant=#secondary size=#sm onClick={_ => Signal.set(full, true)}>
                <View.Text> "⤢ Fullscreen" </View.Text>
              </Button>
            : View.null()}
          <a
            class="text-xs text-neutral-400 underline underline-offset-4 hover:text-neutral-700"
            href={docUrl(a)}
            target="_blank">
            <View.Text> "Read the spec ↗" </View.Text>
          </a>
        </div>
      </div>
      <View.Show when_={Prop.signal(isPreview)}>
        <Preview id={a.id} />
      </View.Show>
      {switch snippet {
      | Some(code) =>
        <View.Show when_={Prop.signal(isCode)}>
          <div class="relative">
            <button
              class="absolute right-2 top-2 z-10 rounded-lg border border-neutral-700 bg-neutral-800 px-2 py-1 text-xs text-neutral-200 transition-colors hover:bg-neutral-700"
              onClick={_ => {
                Ui.copyToClipboard(code)
                Signal.set(copied, true)
                Ui.setTimeout(() => Signal.set(copied, false), 1500)
              }}>
              <View.Text> {copyLabel} </View.Text>
            </button>
            <pre
              class="max-h-[32rem] overflow-auto rounded-2xl border border-neutral-800 bg-neutral-900 p-4 text-xs leading-relaxed text-neutral-100">
              <code class="font-mono"> <View.Text> {code} </View.Text> </code>
            </pre>
          </div>
        </View.Show>
      | None => View.null()
      }}
      <View.Show when_={Prop.signal(full)}>
        <div class="fixed inset-0 z-50 flex flex-col bg-white">
          <div class="flex h-14 shrink-0 items-center justify-between border-b border-neutral-200 px-4">
            <span class="text-sm font-medium text-neutral-900"> <View.Text> {a.title ++ " — live preview"} </View.Text> </span>
            <Button variant=#secondary size=#sm onClick={_ => Signal.set(full, false)}>
              <View.Text> "Close ✕" </View.Text>
            </Button>
          </div>
          <div class="preview-surface flex flex-1 items-center justify-center overflow-auto p-12">
            {switch Examples.get(a.id) {
            | Some(node) => node
            | None => View.null()
            }}
          </div>
        </div>
      </View.Show>
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
          <LayerBadge layer={a.layer} />
          <Status status={a.status} />
          <span class="font-mono text-xs text-neutral-400"> <View.Text> {"v" ++ a.version} </View.Text> </span>
        </div>
        <p class="mt-4 text-lg leading-relaxed text-neutral-700"> <View.Text> {a.summary} </View.Text> </p>
        <View.Show when_={Prop.static(Array.length(a.tags) > 0)}>
          <div class="mt-4 flex flex-wrap gap-1.5">
            <View.For
              each={Prop.static(a.tags)}
              render={t => <Badge variant=#soft> <View.Text> {t} </View.Text> </Badge>}
            />
          </div>
        </View.Show>

        <ExampleBlock a />

        {switch a.api {
        | Some(api) => <ApiTable api />
        | None => View.null()
        }}

        <View.Show when_={Prop.static(a.spec != "")}>
          <SpecBody html={a.spec} />
        </View.Show>

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
  // Global ⌘K opens the spotlight search.
  Effect.run(() => Some(Ui.onCmdK(() => Signal.set(spotlightOpen, true))))
  let routes = Router.routes([
    {pattern: "/", render: _ => <Home />},
    {pattern: "/a/:id", render: params => <Detail id={params->Dict.get("id")->Option.getOr("")} />},
  ])
  <div class="flex h-screen flex-col">
    <Topbar />
    <div class="flex min-h-0 flex-1">
      <Sidebar />
      <main class="min-w-0 flex-1 overflow-y-auto"> {routes} </main>
    </div>
    <Spotlight />
  </div>
}
