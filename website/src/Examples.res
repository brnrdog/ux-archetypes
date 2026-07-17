// Live Xote implementations of the archetypes. Each example is a small,
// self-contained component. `get` maps an archetype id to its example node
// (returning None when only the written spec exists yet).

module ButtonEx = {
  @jsx.component
  let make = () => {
    let loading = Signal.make(false)
    <div class="flex flex-wrap items-center gap-3">
      <Button variant=#primary> <View.Text> "Primary" </View.Text> </Button>
      <Button variant=#secondary> <View.Text> "Secondary" </View.Text> </Button>
      <Button variant=#ghost> <View.Text> "Ghost" </View.Text> </Button>
      <Button variant=#destructive> <View.Text> "Delete" </View.Text> </Button>
      <Button variant=#secondary disabled=true> <View.Text> "Disabled" </View.Text> </Button>
      <Button
        variant=#primary
        onClick={_ => {
          Signal.set(loading, true)
          Ui.setTimeout(() => Signal.set(loading, false), 1200)
        }}>
        <View.Show when_={Prop.signal(loading)} fallback={<View.Text> "Save" </View.Text>}>
          <Spinner tone=#onAccent />
          <View.Text> "Saving…" </View.Text>
        </View.Show>
      </Button>
    </div>
  }
}

module InputEx = {
  @jsx.component
  let make = () => {
    let value = Signal.make("")
    <div class="max-w-sm">
      <Field label="Email" for_="ex-email">
        <Input
          id="ex-email"
          type_="email"
          placeholder="you@example.com"
          onInput={e => Signal.set(value, Ui.inputValue(e))}
        />
      </Field>
      <p class="mt-2 text-xs text-neutral-500">
        <View.Text> "You typed: " </View.Text>
        <View.Text> {value} </View.Text>
      </p>
    </div>
  }
}

module Textarea = {
  @jsx.component
  let make = () => {
    let value = Signal.make("")
    let count = Computed.make(() => Signal.get(value)->String.length)
    <div class="max-w-sm">
      <Field label="Message" for_="ex-ta">
        <textarea
          id="ex-ta"
          rows=4
          class={Ui.inputBase ++ " resize-y"}
          placeholder="Write something…"
          onInput={e => Signal.set(value, Ui.inputValue(e))}
        />
      </Field>
      <p class="mt-2 text-right text-xs text-neutral-500">
        <View.Int> {count} </View.Int>
        <View.Text> " / 280" </View.Text>
      </p>
    </div>
  }
}

module BadgeEx = {
  @jsx.component
  let make = () => {
    <div class="flex flex-wrap items-center gap-2">
      <Badge variant=#solid> <View.Text> "Default" </View.Text> </Badge>
      <Badge variant=#soft> <View.Text> "Secondary" </View.Text> </Badge>
      <Badge variant=#outline> <View.Text> "Outline" </View.Text> </Badge>
      <Badge variant=#soft>
        <span class="mr-1 size-1.5 rounded-full bg-neutral-500" />
        <View.Text> "Idle" </View.Text>
      </Badge>
      <Badge variant=#solid> <View.Text> "99+" </View.Text> </Badge>
    </div>
  }
}

module AvatarEx = {
  @jsx.component
  let make = () => {
    <div class="flex items-center gap-4">
      <Avatar initials="BG" size="size-10 text-sm" />
      <Avatar initials="AK" size="size-12" />
      <div class="flex -space-x-2">
        <Avatar initials="JD" size="size-9 text-xs" />
        <Avatar initials="MP" size="size-9 text-xs" />
        <Avatar initials="RM" size="size-9 text-xs" />
        <span
          class="inline-flex size-9 items-center justify-center rounded-full bg-neutral-900 text-xs font-medium text-neutral-0 ring-2 ring-white">
          <View.Text> "+3" </View.Text>
        </span>
      </div>
    </div>
  }
}

module Checkbox = {
  @jsx.component
  let make = () => {
    let on = Signal.make(true)
    <label class="flex items-start gap-3">
      <input
        type_="checkbox"
        checked={Prop.signal(on)}
        class="mt-0.5 size-4 accent-neutral-900"
        onChange={e => Signal.set(on, Ui.checked(e))}
      />
      <span>
        <span class="block text-sm font-medium text-neutral-800"> <View.Text> "Subscribe" </View.Text> </span>
        <span class="block text-xs text-neutral-500"> <View.Text> "Get product updates by email." </View.Text> </span>
      </span>
    </label>
  }
}

module SwitchEx = {
  @jsx.component
  let make = () => {
    let on = Signal.make(false)
    <Switch on label="Airplane mode" />
  }
}

module Slider = {
  @jsx.component
  let make = () => {
    let value = Signal.make(40)
    <div class="max-w-sm space-y-2">
      <div class="flex justify-between text-sm text-neutral-800">
        <span> <View.Text> "Volume" </View.Text> </span>
        <span class="tabular-nums"> <View.Int> {value} </View.Int> <View.Text> "%" </View.Text> </span>
      </div>
      <input
        type_="range"
        min="0"
        max="100"
        value={Prop.signal(Computed.make(() => Signal.get(value)->Int.toString))}
        class="w-full accent-neutral-900"
        onInput={e => Signal.set(value, Ui.inputValue(e)->Int.fromString->Option.getOr(0))}
      />
    </div>
  }
}

module Progress = {
  @jsx.component
  let make = () => {
    let value = Signal.make(30)
    let bar = Computed.make(() => "height:100%;width:" ++ Signal.get(value)->Int.toString ++ "%")
    <div class="max-w-sm space-y-3">
      <div class="h-2 w-full overflow-hidden rounded-full bg-neutral-200" role="progressbar">
        <div class="rounded-full bg-neutral-900 transition-all" style={Prop.signal(bar)} />
      </div>
      <div class="flex gap-2">
        <Button variant=#secondary onClick={_ => Signal.update(value, v => v > 10 ? v - 10 : 0)}>
          <View.Text> "−10" </View.Text>
        </Button>
        <Button variant=#secondary onClick={_ => Signal.update(value, v => v < 90 ? v + 10 : 100)}>
          <View.Text> "+10" </View.Text>
        </Button>
      </div>
    </div>
  }
}

module SpinnerEx = {
  @jsx.component
  let make = () =>
    <div class="flex items-center gap-4 text-neutral-700">
      <Spinner size="size-4" />
      <Spinner size="size-6" />
      <Spinner size="size-8" />
      <span class="text-sm text-neutral-500"> <View.Text> "Loading…" </View.Text> </span>
    </div>
}

module Skeleton = {
  @jsx.component
  let make = () =>
    <div class="max-w-sm space-y-3">
      <div class="flex items-center gap-3">
        <div class="size-10 animate-pulse rounded-full bg-neutral-200" />
        <div class="flex-1 space-y-2">
          <div class="h-3 w-1/2 animate-pulse rounded bg-neutral-200" />
          <div class="h-3 w-1/3 animate-pulse rounded bg-neutral-200" />
        </div>
      </div>
      <div class="h-3 w-full animate-pulse rounded bg-neutral-200" />
      <div class="h-3 w-5/6 animate-pulse rounded bg-neutral-200" />
    </div>
}

module SeparatorEx = {
  @jsx.component
  let make = () =>
    <div class="max-w-sm text-sm text-neutral-700">
      <p> <View.Text> "Above the line" </View.Text> </p>
      <Separator extraClass="my-3" />
      <div class="flex items-center gap-3">
        <span> <View.Text> "Home" </View.Text> </span>
        <Separator orientation=#vertical />
        <span> <View.Text> "Docs" </View.Text> </span>
        <Separator orientation=#vertical />
        <span> <View.Text> "About" </View.Text> </span>
      </div>
    </div>
}

module Label = {
  @jsx.component
  let make = () =>
    <div class="max-w-sm space-y-1">
      <label class={Ui.label} for_="ex-label">
        <View.Text> "Full name " </View.Text>
        <span class="text-neutral-400"> <View.Text> "(required)" </View.Text> </span>
      </label>
      <Input id="ex-label" placeholder="Ada Lovelace" />
    </div>
}

module KbdEx = {
  @jsx.component
  let make = () => {
    <div class="flex items-center gap-2 text-sm text-neutral-700">
      <span> <View.Text> "Open search" </View.Text> </span>
      <Kbd> <View.Text> "⌘" </View.Text> </Kbd>
      <Kbd> <View.Text> "K" </View.Text> </Kbd>
    </div>
  }
}

module Typography = {
  @jsx.component
  let make = () =>
    <div class="max-w-prose space-y-3">
      <h1 class="text-3xl font-bold tracking-tight text-neutral-900"> <View.Text> "Heading one" </View.Text> </h1>
      <h2 class="text-xl font-semibold text-neutral-900"> <View.Text> "Heading two" </View.Text> </h2>
      <p class="text-sm leading-relaxed text-neutral-700">
        <View.Text> "Body copy sets the reading rhythm. Inline elements like " </View.Text>
        <strong class="font-semibold text-neutral-900"> <View.Text> "strong" </View.Text> </strong>
        <View.Text> " and " </View.Text>
        <code class="rounded bg-neutral-100 px-1 py-0.5 font-mono text-xs"> <View.Text> "code" </View.Text> </code>
        <View.Text> " carry meaning through markup, not styling alone." </View.Text>
      </p>
      <blockquote class="border-l-2 border-neutral-300 pl-4 text-sm italic text-neutral-600">
        <View.Text> "Type is the connective tissue of the interface." </View.Text>
      </blockquote>
    </div>
}

module RadioGroup = {
  @jsx.component
  let make = () => {
    let value = Signal.make("express")
    let opts = [
      ("standard", "Standard", "3–5 business days"),
      ("express", "Express", "1–2 business days"),
      ("overnight", "Overnight", "Next business day"),
    ]
    <fieldset class="max-w-sm space-y-2">
      <legend class="mb-1 text-sm font-medium text-neutral-800"> <View.Text> "Shipping speed" </View.Text> </legend>
      <View.For
        each={Prop.static(opts)}
        render={item => {
          let (id, title, desc) = item
          let rowCls = Computed.make(() =>
            "flex cursor-pointer items-start gap-3 rounded-md border p-3 transition-colors " ++ (
              Signal.get(value) == id
                ? "border-neutral-900 bg-neutral-50"
                : "border-neutral-200 hover:border-neutral-300"
            )
          )
          let ring = Computed.make(() =>
            "mt-0.5 flex size-4 items-center justify-center rounded-full border " ++ (
              Signal.get(value) == id ? "border-neutral-900" : "border-neutral-300"
            )
          )
          let dot = Computed.make(() =>
            "size-2 rounded-full " ++ (Signal.get(value) == id ? "bg-neutral-900" : "bg-transparent")
          )
          <label class={Prop.signal(rowCls)} onClick={_ => Signal.set(value, id)}>
            <span class={Prop.signal(ring)}> <span class={Prop.signal(dot)} /> </span>
            <span>
              <span class="block text-sm font-medium text-neutral-800"> <View.Text> {title} </View.Text> </span>
              <span class="block text-xs text-neutral-500"> <View.Text> {desc} </View.Text> </span>
            </span>
          </label>
        }}
      />
    </fieldset>
  }
}

module Toggle = {
  @jsx.component
  let make = () => {
    let on = Signal.make(true)
    let cls = Computed.make(() =>
      "inline-flex size-10 items-center justify-center rounded-md text-sm font-semibold transition-colors " ++ (
        Signal.get(on)
          ? "bg-neutral-900 text-neutral-0"
          : "border border-neutral-300 bg-surface text-neutral-700 hover:bg-neutral-100"
      )
    )
    <button class={Prop.signal(cls)} onClick={_ => Signal.update(on, v => !v)}>
      <span class="italic"> <View.Text> "B" </View.Text> </span>
    </button>
  }
}

module ToggleGroup = {
  @jsx.component
  let make = () => {
    let value = Signal.make("center")
    let opts = [("left", "Left"), ("center", "Center"), ("right", "Right")]
    <div class="inline-flex overflow-hidden rounded-md border border-neutral-300">
      <View.For
        each={Prop.static(opts)}
        render={item => {
          let (id, label) = item
          let cls = Computed.make(() =>
            "border-l border-neutral-300 px-4 py-2 text-sm transition-colors first:border-l-0 " ++ (
              Signal.get(value) == id
                ? "bg-neutral-900 text-neutral-0"
                : "bg-surface text-neutral-700 hover:bg-neutral-100"
            )
          )
          <button class={Prop.signal(cls)} onClick={_ => Signal.set(value, id)}>
            <View.Text> {label} </View.Text>
          </button>
        }}
      />
    </div>
  }
}

module AspectRatio = {
  @jsx.component
  let make = () => {
    let box = "flex items-center justify-center overflow-hidden rounded-lg bg-neutral-200 text-sm font-medium text-neutral-500"
    <div class="flex flex-wrap items-start gap-4">
      <div class="w-56">
        <div class={box ++ " aspect-video"}> <View.Text> "16 : 9" </View.Text> </div>
      </div>
      <div class="w-32">
        <div class={box ++ " aspect-square"}> <View.Text> "1 : 1" </View.Text> </div>
      </div>
    </div>
  }
}

module ScrollArea = {
  @jsx.component
  let make = () => {
    let rows = Array.fromInitializer(~length=24, i => "Row " ++ Int.toString(i + 1))
    <div class="h-44 w-64 overflow-y-auto rounded-md border border-neutral-200">
      <ul class="divide-y divide-neutral-100 text-sm">
        <View.For
          each={Prop.static(rows)}
          render={r => <li class="px-3 py-2 text-neutral-700"> <View.Text> {r} </View.Text> </li>}
        />
      </ul>
    </div>
  }
}

module InputOtp = {
  @jsx.component
  let make = () => {
    let code = Signal.make("")
    let slots = Array.fromInitializer(~length=6, i => i)
    <label class="relative inline-flex gap-2">
      <input
        class="absolute inset-0 z-10 cursor-pointer opacity-0"
        type_="text"
        maxLength=6
        onInput={e => {
          let digits =
            Ui.inputValue(e)->String.replaceRegExp(%re("/[^0-9]/g"), "")->String.slice(~start=0, ~end=6)
          Signal.set(code, digits)
        }}
      />
      <View.For
        each={Prop.static(slots)}
        render={i => {
          let cls = Computed.make(() => {
            let len = Signal.get(code)->String.length
            "flex size-11 items-center justify-center rounded-md border text-lg font-semibold text-neutral-900 " ++ (
              len == i ? "border-neutral-900 ring-1 ring-neutral-900" : "border-neutral-300"
            )
          })
          let ch = Computed.make(() => Signal.get(code)->String.charAt(i))
          <span class={Prop.signal(cls)}> <View.Text> {ch} </View.Text> </span>
        }}
      />
    </label>
  }
}

module Card = {
  @jsx.component
  let make = () =>
    <div class={Ui.card ++ " w-80 overflow-hidden"}>
      <div class="flex aspect-video items-center justify-center bg-neutral-100 text-neutral-400">
        <View.Text> "cover" </View.Text>
      </div>
      <div class="space-y-3 p-5">
        <div class="flex items-center justify-between">
          <h3 class="font-semibold text-neutral-900"> <View.Text> "Analytics plan" </View.Text> </h3>
          <Badge variant=#solid> <View.Text> "Pro" </View.Text> </Badge>
        </div>
        <p class="text-sm text-neutral-500">
          <View.Text> "Usage insights, exports, and unlimited dashboards for growing teams." </View.Text>
        </p>
        <div class="flex gap-2 pt-1">
          <Button variant=#primary> <View.Text> "Upgrade" </View.Text> </Button>
          <Button variant=#ghost> <View.Text> "Details" </View.Text> </Button>
        </div>
      </div>
    </div>
}

module AlertEx = {
  @jsx.component
  let make = () =>
    <div class="max-w-md space-y-3">
      <Alert variant=#info icon="i" title="Heads up" description="Your trial ends in 3 days." />
      <Alert variant=#success icon="✓" title="Changes saved" description="Your profile has been updated." />
      <Alert variant=#warning icon="!" title="Storage almost full" description="You've used 90% of your quota." />
      <Alert
        variant=#danger
        icon="!"
        title="Payment failed"
        description="Update your card to keep your subscription active."
      />
    </div>
}

module TabsEx = {
  @jsx.component
  let make = () => {
    let value = Signal.make("account")
    let tabs = [("account", "Account"), ("password", "Password"), ("team", "Team")]
    let content = Computed.make(() =>
      switch Signal.get(value) {
      | "account" => "Manage your account details and profile information."
      | "password" => "Change your password and configure two-factor authentication."
      | _ => "Invite teammates and manage their roles and access."
      }
    )
    <div class="w-96">
      <Tabs value tabs />
      <p class="p-4 text-sm text-neutral-600"> <View.Text> {content} </View.Text> </p>
    </div>
  }
}

module AccordionEx = {
  @jsx.component
  let make = () => {
    let value = Signal.make(["what"])
    let items = [
      ("what", "What is an archetype?", "A technology-agnostic definition of a UI pattern, described in words."),
      ("framework", "Is it tied to a framework?", "No. Each archetype maps onto any stack — this site happens to use Xote."),
      ("contribute", "Can I contribute?", "Yes. Copy the template, fill every section, and open a pull request."),
    ]
    <Accordion value items />
  }
}

module CollapsibleEx = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    <Collapsible open_ label="Show details">
      <View.Text> "Secondary content revealed on demand, pushing the layout below it." </View.Text>
    </Collapsible>
  }
}

module DialogEx = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    <div class="relative flex h-64 w-full max-w-lg items-center justify-center">
      <Button variant=#primary onClick={_ => Signal.set(open_, true)}>
        <View.Text> "Edit profile" </View.Text>
      </Button>
      <Dialog open_ title="Edit profile" description="Make changes and save when you're done.">
        <div class="mt-4">
          <Field label="Name" for_="dlg-name">
            <Input id="dlg-name" value="Ada Lovelace" />
          </Field>
        </div>
        <div class="mt-5 flex justify-end gap-2">
          <Button variant=#secondary onClick={_ => Signal.set(open_, false)}> <View.Text> "Cancel" </View.Text> </Button>
          <Button variant=#primary onClick={_ => Signal.set(open_, false)}> <View.Text> "Save" </View.Text> </Button>
        </div>
      </Dialog>
    </div>
  }
}

module AlertDialog = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    <div class="relative flex h-64 w-full max-w-lg items-center justify-center">
      <Button variant=#destructive onClick={_ => Signal.set(open_, true)}>
        <View.Text> "Delete account" </View.Text>
      </Button>
      <View.Show when_={Prop.signal(open_)}>
        <div class="absolute inset-0 z-10 flex items-center justify-center">
          <div class="absolute inset-0 bg-neutral-900/40" />
          <div class="relative z-20 w-80 rounded-lg border border-neutral-200 bg-surface p-5 shadow-2xl">
            <h3 class="text-lg font-semibold text-neutral-900"> <View.Text> "Are you absolutely sure?" </View.Text> </h3>
            <p class="mt-1 text-sm text-neutral-500"> <View.Text> "This permanently deletes your account and all data. This cannot be undone." </View.Text> </p>
            <div class="mt-5 flex justify-end gap-2">
              <Button variant=#secondary onClick={_ => Signal.set(open_, false)}> <View.Text> "Cancel" </View.Text> </Button>
              <Button variant=#destructive onClick={_ => Signal.set(open_, false)}> <View.Text> "Delete" </View.Text> </Button>
            </div>
          </div>
        </div>
      </View.Show>
    </div>
  }
}

module TooltipEx = {
  @jsx.component
  let make = () =>
    <div class="flex h-24 items-center justify-center">
      <Tooltip content="Add to library">
        <Button variant=#secondary> <View.Text> "Hover me" </View.Text> </Button>
      </Tooltip>
    </div>
}

module Breadcrumb = {
  @jsx.component
  let make = () => {
    let sep = <span class="text-neutral-300"> <View.Text> "/" </View.Text> </span>
    <nav class="flex items-center gap-2 text-sm">
      <a class="text-neutral-500 hover:text-neutral-900" href="#"> <View.Text> "Home" </View.Text> </a>
      {sep}
      <a class="text-neutral-500 hover:text-neutral-900" href="#"> <View.Text> "Projects" </View.Text> </a>
      {sep}
      <span class="font-medium text-neutral-900"> <View.Text> "Archetypes" </View.Text> </span>
    </nav>
  }
}

module Pagination = {
  @jsx.component
  let make = () => {
    let page = Signal.make(2)
    let pages = [1, 2, 3, 4, 5]
    let navBtn = "inline-flex size-9 items-center justify-center rounded-md text-sm transition-colors"
    <div class="flex items-center gap-1">
      <button
        class={navBtn ++ " border border-neutral-300 text-neutral-700 hover:bg-neutral-100"}
        onClick={_ => Signal.update(page, p => p > 1 ? p - 1 : 1)}>
        <View.Text> "‹" </View.Text>
      </button>
      <View.For
        each={Prop.static(pages)}
        render={p => {
          let cls = Computed.make(() =>
            navBtn ++ (
              Signal.get(page) == p
                ? " bg-neutral-900 text-neutral-0"
                : " text-neutral-700 hover:bg-neutral-100"
            )
          )
          <button class={Prop.signal(cls)} onClick={_ => Signal.set(page, p)}>
            <View.Text> {Int.toString(p)} </View.Text>
          </button>
        }}
      />
      <button
        class={navBtn ++ " border border-neutral-300 text-neutral-700 hover:bg-neutral-100"}
        onClick={_ => Signal.update(page, p => p < 5 ? p + 1 : 5)}>
        <View.Text> "›" </View.Text>
      </button>
    </div>
  }
}

module EmptyState = {
  @jsx.component
  let make = () =>
    <div class="flex max-w-sm flex-col items-center gap-3 rounded-lg border border-dashed border-neutral-300 p-10 text-center">
      <div class="flex size-12 items-center justify-center rounded-full bg-neutral-100 text-xl text-neutral-400">
        <View.Text> "☰" </View.Text>
      </div>
      <div>
        <p class="font-medium text-neutral-800"> <View.Text> "No projects yet" </View.Text> </p>
        <p class="mt-1 text-sm text-neutral-500"> <View.Text> "Create your first project to get started." </View.Text> </p>
      </div>
      <Button variant=#primary> <View.Text> "New project" </View.Text> </Button>
    </div>
}

module FieldEx = {
  @jsx.component
  let make = () => {
    let value = Signal.make("nope")
    let invalid = Computed.make(() => !(Signal.get(value)->String.includes("@")))
    let cls = Computed.make(() =>
      Ui.inputBase ++ (Signal.get(invalid) ? " border-neutral-900 ring-1 ring-neutral-900" : "")
    )
    <div class="max-w-sm">
      <Field label="Work email" for_="fld-email">
        <input
          id="fld-email"
          class={Prop.signal(cls)}
          value="nope"
          onInput={e => Signal.set(value, Ui.inputValue(e))}
        />
        <View.Show
          when_={Prop.signal(invalid)}
          fallback={<p class="text-xs text-neutral-500"> <View.Text> "We'll only use this to contact you." </View.Text> </p>}>
          <p class="text-xs font-medium text-neutral-900"> <View.Text> "Enter a valid email address." </View.Text> </p>
        </View.Show>
      </Field>
    </div>
  }
}

module Form = {
  @jsx.component
  let make = () => {
    let sent = Signal.make(false)
    <form
      class="w-80 space-y-4"
      onSubmit={e => {
        let _: unit = %raw(`(ev) => ev.preventDefault()`)(e)
        Signal.set(sent, true)
      }}>
      <Field label="Name" for_="frm-name">
        <Input id="frm-name" placeholder="Ada Lovelace" required=true />
      </Field>
      <Field label="Message" for_="frm-msg">
        <textarea id="frm-msg" rows=3 class={Ui.inputBase ++ " resize-none"} placeholder="Say hello…" />
      </Field>
      <Button type_=#submit variant=#primary extraClass="w-full"> <View.Text> "Send message" </View.Text> </Button>
      <View.Show when_={Prop.signal(sent)}>
        <p class="rounded-md bg-neutral-100 px-3 py-2 text-center text-sm text-neutral-700">
          <View.Text> "Thanks — we'll be in touch." </View.Text>
        </p>
      </View.Show>
    </form>
  }
}

module ButtonGroup = {
  @jsx.component
  let make = () =>
    <div class="inline-flex overflow-hidden rounded-md border border-neutral-300">
      <button class="border-r border-neutral-300 bg-surface px-3 py-2 text-sm hover:bg-neutral-100"> <View.Text> "Bold" </View.Text> </button>
      <button class="border-r border-neutral-300 bg-surface px-3 py-2 text-sm hover:bg-neutral-100"> <View.Text> "Italic" </View.Text> </button>
      <button class="bg-surface px-3 py-2 text-sm hover:bg-neutral-100"> <View.Text> "Underline" </View.Text> </button>
    </div>
}

module InputGroup = {
  @jsx.component
  let make = () =>
    <div class="flex max-w-sm">
      <span class="inline-flex items-center rounded-l-md border border-r-0 border-neutral-300 bg-neutral-50 px-3 text-sm text-neutral-500">
        <View.Text> "https://" </View.Text>
      </span>
      <Input extraClass="rounded-none" placeholder="example.com" />
      <Button variant=#primary extraClass="rounded-l-none"> <View.Text> "Go" </View.Text> </Button>
    </div>
}

module SelectEx = {
  @jsx.component
  let make = () => {
    let value = Signal.make("Medium")
    <Select value options=["Small", "Medium", "Large", "Extra large"] />
  }
}

module DropdownMenu = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    let items = ["Profile", "Billing", "Settings", "Sign out"]
    <div class="relative inline-block">
      <Button variant=#secondary onClick={_ => Signal.update(open_, v => !v)}>
        <View.Text> "Options ⌄" </View.Text>
      </Button>
      <View.Show when_={Prop.signal(open_)}>
        <Backdrop onClose={() => Signal.set(open_, false)} />
        <div class="absolute z-20 mt-1 w-48 rounded-md border border-neutral-200 bg-surface py-1 shadow-lg">
          <View.For
            each={Prop.static(items)}
            render={i =>
              <button
                class="block w-full px-3 py-1.5 text-left text-sm text-neutral-700 hover:bg-neutral-100"
                onClick={_ => Signal.set(open_, false)}>
                <View.Text> {i} </View.Text>
              </button>}
          />
        </div>
      </View.Show>
    </div>
  }
}

module ContextMenu = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    <div class="relative flex h-40 w-full max-w-md items-center justify-center">
      <div
        class="flex h-28 w-full items-center justify-center rounded-lg border border-dashed border-neutral-300 text-sm text-neutral-500"
        onContextMenu={e => {
          Ui.preventDefault(e)
          Signal.set(open_, true)
        }}>
        <View.Text> "Right-click here" </View.Text>
      </div>
      <View.Show when_={Prop.signal(open_)}>
        <Backdrop onClose={() => Signal.set(open_, false)} />
        <div class="absolute left-1/2 top-1/2 z-20 w-44 rounded-md border border-neutral-200 bg-surface py-1 shadow-lg">
          <View.For
            each={Prop.static(["Cut", "Copy", "Paste", "Delete"])}
            render={i =>
              <button
                class="block w-full px-3 py-1.5 text-left text-sm text-neutral-700 hover:bg-neutral-100"
                onClick={_ => Signal.set(open_, false)}>
                <View.Text> {i} </View.Text>
              </button>}
          />
        </div>
      </View.Show>
    </div>
  }
}

module Popover = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    <div class="relative inline-block">
      <Button variant=#secondary onClick={_ => Signal.update(open_, v => !v)}>
        <View.Text> "Open popover" </View.Text>
      </Button>
      <View.Show when_={Prop.signal(open_)}>
        <Backdrop onClose={() => Signal.set(open_, false)} />
        <div class="absolute z-20 mt-2 w-64 rounded-lg border border-neutral-200 bg-surface p-4 shadow-xl">
          <p class="text-sm font-medium text-neutral-900"> <View.Text> "Dimensions" </View.Text> </p>
          <p class="mt-1 text-xs text-neutral-500"> <View.Text> "Set the width and height of the layer." </View.Text> </p>
          <div class="mt-3 space-y-2">
            <Input placeholder="Width" />
            <Input placeholder="Height" />
          </div>
        </div>
      </View.Show>
    </div>
  }
}

module HoverCard = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    <div class="flex h-40 items-center justify-center">
      <span
        class="relative inline-block"
        onMouseEnter={_ => Signal.set(open_, true)}
        onMouseLeave={_ => Signal.set(open_, false)}>
        <a class="font-medium text-neutral-900 underline decoration-neutral-300 underline-offset-4" href="#">
          <View.Text> "@ada" </View.Text>
        </a>
        <View.Show when_={Prop.signal(open_)}>
          <div class="absolute left-0 top-7 z-20 w-64 rounded-lg border border-neutral-200 bg-surface p-4 shadow-xl">
            <div class="flex items-center gap-3">
              <Avatar initials="AL" />
              <div>
                <p class="text-sm font-semibold text-neutral-900"> <View.Text> "Ada Lovelace" </View.Text> </p>
                <p class="text-xs text-neutral-500"> <View.Text> "First programmer" </View.Text> </p>
              </div>
            </div>
            <p class="mt-3 text-xs text-neutral-600"> <View.Text> "Wrote the first algorithm intended for a machine." </View.Text> </p>
          </div>
        </View.Show>
      </span>
    </div>
  }
}

module Sheet = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    <div class="relative flex h-64 w-full items-center justify-center overflow-hidden rounded-lg">
      <Button variant=#primary onClick={_ => Signal.set(open_, true)}> <View.Text> "Open sheet" </View.Text> </Button>
      <View.Show when_={Prop.signal(open_)}>
        <div class="absolute inset-0 z-10 bg-neutral-900/40" onClick={_ => Signal.set(open_, false)} />
        <div class="absolute right-0 top-0 z-20 flex h-full w-72 flex-col border-l border-neutral-200 bg-surface p-5 shadow-2xl">
          <h3 class="text-lg font-semibold text-neutral-900"> <View.Text> "Filters" </View.Text> </h3>
          <p class="mt-1 text-sm text-neutral-500"> <View.Text> "Refine the results shown in the list." </View.Text> </p>
          <div class="mt-auto flex justify-end">
            <Button variant=#primary onClick={_ => Signal.set(open_, false)}> <View.Text> "Apply" </View.Text> </Button>
          </div>
        </div>
      </View.Show>
    </div>
  }
}

module Drawer = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    <div class="relative flex h-64 w-full items-center justify-center overflow-hidden rounded-lg">
      <Button variant=#primary onClick={_ => Signal.set(open_, true)}> <View.Text> "Open drawer" </View.Text> </Button>
      <View.Show when_={Prop.signal(open_)}>
        <div class="absolute inset-0 z-10 bg-neutral-900/40" onClick={_ => Signal.set(open_, false)} />
        <div class="absolute bottom-0 left-0 z-20 w-full rounded-t-2xl border-t border-neutral-200 bg-surface p-5 shadow-2xl">
          <div class="mx-auto mb-4 h-1 w-10 rounded-full bg-neutral-300" />
          <h3 class="text-lg font-semibold text-neutral-900"> <View.Text> "Share" </View.Text> </h3>
          <p class="mt-1 text-sm text-neutral-500"> <View.Text> "Swipe down or tap the backdrop to dismiss." </View.Text> </p>
          <div class="mt-4 flex gap-2">
            <Button variant=#secondary onClick={_ => Signal.set(open_, false)}> <View.Text> "Copy link" </View.Text> </Button>
            <Button variant=#primary onClick={_ => Signal.set(open_, false)}> <View.Text> "Send" </View.Text> </Button>
          </div>
        </div>
      </View.Show>
    </div>
  }
}

module Toast = {
  @jsx.component
  let make = () => {
    let show = Signal.make(false)
    <div class="relative h-40 w-full max-w-md">
      <Button
        variant=#primary
        onClick={_ => {
          Signal.set(show, true)
          Ui.setTimeout(() => Signal.set(show, false), 2600)
        }}>
        <View.Text> "Show toast" </View.Text>
      </Button>
      <View.Show when_={Prop.signal(show)}>
        <div class="absolute bottom-2 right-2 flex w-72 items-start gap-3 rounded-lg border border-neutral-200 bg-surface p-3 shadow-xl">
          <span class="mt-0.5 font-semibold text-neutral-900"> <View.Text> "✓" </View.Text> </span>
          <div class="flex-1">
            <p class="text-sm font-medium text-neutral-900"> <View.Text> "Changes saved" </View.Text> </p>
            <p class="text-xs text-neutral-500"> <View.Text> "Your profile has been updated." </View.Text> </p>
          </div>
          <button class="text-sm text-neutral-500 hover:text-neutral-900" onClick={_ => Signal.set(show, false)}>
            <View.Text> "Undo" </View.Text>
          </button>
        </div>
      </View.Show>
    </div>
  }
}

module Table = {
  @jsx.component
  let make = () => {
    let rows = [
      ("INV-001", "Paid", "$250.00"),
      ("INV-002", "Pending", "$150.00"),
      ("INV-003", "Unpaid", "$350.00"),
    ]
    <div class="w-96 overflow-hidden rounded-lg border border-neutral-200">
      <table class="w-full text-sm">
        <thead class="bg-neutral-50 text-left text-xs uppercase tracking-wide text-neutral-500">
          <tr>
            <th class="px-4 py-2 font-medium"> <View.Text> "Invoice" </View.Text> </th>
            <th class="px-4 py-2 font-medium"> <View.Text> "Status" </View.Text> </th>
            <th class="px-4 py-2 text-right font-medium"> <View.Text> "Amount" </View.Text> </th>
          </tr>
        </thead>
        <tbody class="divide-y divide-neutral-100">
          <View.For
            each={Prop.static(rows)}
            render={row => {
              let (inv, status, amount) = row
              <tr class="text-neutral-700">
                <td class="px-4 py-2 font-medium text-neutral-900"> <View.Text> {inv} </View.Text> </td>
                <td class="px-4 py-2"> <Badge variant=#soft> <View.Text> {status} </View.Text> </Badge> </td>
                <td class="px-4 py-2 text-right tabular-nums"> <View.Text> {amount} </View.Text> </td>
              </tr>
            }}
          />
        </tbody>
      </table>
    </div>
  }
}

module DataTable = {
  type row = {name: string, role: string, status: string}
  @jsx.component
  let make = () => {
    let source = [
      {name: "Ada Lovelace", role: "Owner", status: "Active"},
      {name: "Grace Hopper", role: "Admin", status: "Active"},
      {name: "Alan Turing", role: "Member", status: "Invited"},
      {name: "Katherine Johnson", role: "Member", status: "Active"},
    ]
    let query = Signal.make("")
    let asc = Signal.make(true)
    let rows = Computed.make(() => {
      let q = Signal.get(query)->String.toLowerCase
      let filtered = source->Array.filter(r => r.name->String.toLowerCase->String.includes(q))
      let sorted = filtered->Array.toSorted((a, b) => String.compare(a.name, b.name))
      Signal.get(asc) ? sorted : sorted->Array.toReversed
    })
    <div class="w-[28rem] space-y-3">
      <div class="flex items-center justify-between">
        <Input
          extraClass="max-w-48"
          type_="search"
          placeholder="Filter people…"
          onInput={e => Signal.set(query, Ui.inputValue(e))}
        />
        <Button variant=#secondary onClick={_ => Signal.update(asc, v => !v)}>
          <View.Text> "Sort name " </View.Text>
          <View.Text> {Computed.make(() => Signal.get(asc) ? "↑" : "↓")} </View.Text>
        </Button>
      </div>
      <div class="overflow-hidden rounded-lg border border-neutral-200">
        <table class="w-full text-sm">
          <thead class="bg-neutral-50 text-left text-xs uppercase tracking-wide text-neutral-500">
            <tr>
              <th class="px-4 py-2 font-medium"> <View.Text> "Name" </View.Text> </th>
              <th class="px-4 py-2 font-medium"> <View.Text> "Role" </View.Text> </th>
              <th class="px-4 py-2 font-medium"> <View.Text> "Status" </View.Text> </th>
            </tr>
          </thead>
          <tbody class="divide-y divide-neutral-100">
            <View.For
              each={Prop.signal(rows)}
              by={r => r.name}
              render={r =>
                <tr class="text-neutral-700">
                  <td class="px-4 py-2 font-medium text-neutral-900"> <View.Text> {r.name} </View.Text> </td>
                  <td class="px-4 py-2"> <View.Text> {r.role} </View.Text> </td>
                  <td class="px-4 py-2"> <Badge variant=#soft> <View.Text> {r.status} </View.Text> </Badge> </td>
                </tr>}
            />
          </tbody>
        </table>
      </div>
    </div>
  }
}

module Chart = {
  @jsx.component
  let make = () => {
    let bars = [("Mon", 40), ("Tue", 72), ("Wed", 55), ("Thu", 88), ("Fri", 63), ("Sat", 30), ("Sun", 20)]
    <div class="w-96">
      <div class="flex h-40 items-end gap-2 border-b border-l border-neutral-200 p-2">
        <View.For
          each={Prop.static(bars)}
          render={item => {
            let (_l, v) = item
            <div class="flex flex-1 items-end justify-center">
              <div
                class="w-full rounded-t bg-neutral-900"
                style={"height:" ++ Int.toString(v) ++ "%"}
              />
            </div>
          }}
        />
      </div>
      <div class="mt-1 flex gap-2 px-2">
        <View.For
          each={Prop.static(bars)}
          render={item => {
            let (l, _v) = item
            <div class="flex-1 text-center text-xs text-neutral-400"> <View.Text> {l} </View.Text> </div>
          }}
        />
      </div>
    </div>
  }
}

module Carousel = {
  @jsx.component
  let make = () => {
    let idx = Signal.make(0)
    let slides = ["Slide 1", "Slide 2", "Slide 3"]
    let total = Array.length(slides)
    let track = Computed.make(() => "transform:translateX(-" ++ Int.toString(Signal.get(idx) * 100) ++ "%)")
    <div class="w-80">
      <div class="relative overflow-hidden rounded-lg border border-neutral-200">
        <div class="flex transition-transform duration-300" style={Prop.signal(track)}>
          <View.For
            each={Prop.static(slides)}
            render={s =>
              <div class="flex aspect-video w-80 shrink-0 items-center justify-center bg-neutral-100 text-lg font-medium text-neutral-500">
                <View.Text> {s} </View.Text>
              </div>}
          />
        </div>
        <button
          class="absolute left-2 top-1/2 flex size-8 -translate-y-1/2 items-center justify-center rounded-full border border-neutral-200 bg-surface/90 hover:bg-surface"
          onClick={_ => Signal.update(idx, i => i > 0 ? i - 1 : 0)}>
          <View.Text> "‹" </View.Text>
        </button>
        <button
          class="absolute right-2 top-1/2 flex size-8 -translate-y-1/2 items-center justify-center rounded-full border border-neutral-200 bg-surface/90 hover:bg-surface"
          onClick={_ => Signal.update(idx, i => i < total - 1 ? i + 1 : i)}>
          <View.Text> "›" </View.Text>
        </button>
      </div>
      <div class="mt-3 flex justify-center gap-1.5">
        <View.For
          each={Prop.static(Array.fromInitializer(~length=total, i => i))}
          render={i => {
            let cls = Computed.make(() =>
              "size-2 rounded-full transition-colors " ++ (Signal.get(idx) == i ? "bg-neutral-900" : "bg-neutral-300")
            )
            <span class={Prop.signal(cls)} />
          }}
        />
      </div>
    </div>
  }
}

module Combobox = {
  @jsx.component
  let make = () => {
    let all = ["Next.js", "SvelteKit", "Remix", "Astro", "Nuxt", "SolidStart", "Qwik City"]
    let query = Signal.make("")
    let open_ = Signal.make(false)
    let value = Signal.make("")
    let filtered = Computed.make(() => {
      let q = Signal.get(query)->String.toLowerCase
      all->Array.filter(o => o->String.toLowerCase->String.includes(q))
    })
    let display = Computed.make(() => {
      let v = Signal.get(value)
      v == "" ? "Select framework…" : v
    })
    <div class="relative w-64">
      <button
        class={Ui.inputBase ++ " flex items-center justify-between text-left"}
        onClick={_ => Signal.update(open_, v => !v)}>
        <View.Text> {display} </View.Text>
        <span class="text-neutral-400"> <View.Text> "⌄" </View.Text> </span>
      </button>
      <View.Show when_={Prop.signal(open_)}>
        <Backdrop onClose={() => Signal.set(open_, false)} />
        <div class="absolute z-20 mt-1 w-full rounded-md border border-neutral-200 bg-surface p-1 shadow-lg">
          <Input
            extraClass="mb-1"
            placeholder="Search…"
            onInput={e => Signal.set(query, Ui.inputValue(e))}
          />
          <ul class="max-h-40 overflow-y-auto">
            <View.For
              each={Prop.signal(filtered)}
              render={o =>
                <li>
                  <button
                    class="block w-full px-3 py-1.5 text-left text-sm text-neutral-700 hover:bg-neutral-100"
                    onClick={_ => {
                      Signal.set(value, o)
                      Signal.set(open_, false)
                    }}>
                    <View.Text> {o} </View.Text>
                  </button>
                </li>}
            />
          </ul>
        </div>
      </View.Show>
    </div>
  }
}

module Command = {
  @jsx.component
  let make = () => {
    let all = ["New file", "New folder", "Search", "Go to settings", "Toggle theme", "Sign out"]
    let query = Signal.make("")
    let filtered = Computed.make(() => {
      let q = Signal.get(query)->String.toLowerCase
      all->Array.filter(o => o->String.toLowerCase->String.includes(q))
    })
    <div class="w-80 overflow-hidden rounded-lg border border-neutral-200 shadow-sm">
      <input
        class="w-full border-b border-neutral-200 px-4 py-3 text-sm focus:outline-none"
        placeholder="Type a command…"
        onInput={e => Signal.set(query, Ui.inputValue(e))}
      />
      <ul class="max-h-52 overflow-y-auto p-1">
        <View.For
          each={Prop.signal(filtered)}
          render={o =>
            <li>
              <button class="flex w-full items-center gap-2 rounded px-3 py-2 text-left text-sm text-neutral-700 hover:bg-neutral-100">
                <span class="text-neutral-400"> <View.Text> "›" </View.Text> </span>
                <View.Text> {o} </View.Text>
              </button>
            </li>}
        />
      </ul>
    </div>
  }
}

module Calendar = {
  @jsx.component
  let make = () => {
    let selected = Signal.make(14)
    let days = Array.fromInitializer(~length=30, i => i + 1)
    let dow = ["S", "M", "T", "W", "T", "F", "S"]
    <div class="w-72 rounded-lg border border-neutral-200 p-3">
      <div class="mb-2 flex items-center justify-between px-1">
        <span class="text-sm font-medium text-neutral-900"> <View.Text> "July 2026" </View.Text> </span>
        <span class="text-xs text-neutral-400"> <View.Text> "‹  ›" </View.Text> </span>
      </div>
      <div class="grid grid-cols-7 gap-1 text-center">
        <View.For
          each={Prop.static(dow)}
          render={d => <span class="py-1 text-xs text-neutral-400"> <View.Text> {d} </View.Text> </span>}
        />
        <View.For
          each={Prop.static(days)}
          render={d => {
            let cls = Computed.make(() =>
              "flex size-8 items-center justify-center rounded-full text-sm transition-colors " ++ (
                Signal.get(selected) == d
                  ? "bg-neutral-900 text-neutral-0"
                  : "text-neutral-700 hover:bg-neutral-100"
              )
            )
            <button class={Prop.signal(cls)} onClick={_ => Signal.set(selected, d)}>
              <View.Text> {Int.toString(d)} </View.Text>
            </button>
          }}
        />
      </div>
    </div>
  }
}

module DatePicker = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    let day = Signal.make(14)
    let label = Computed.make(() => "July " ++ Int.toString(Signal.get(day)) ++ ", 2026")
    let days = Array.fromInitializer(~length=30, i => i + 1)
    <div class="relative w-64">
      <button
        class={Ui.inputBase ++ " flex items-center justify-between text-left"}
        onClick={_ => Signal.update(open_, v => !v)}>
        <View.Text> {label} </View.Text>
        <span class="text-neutral-400"> <View.Text> "📅" </View.Text> </span>
      </button>
      <View.Show when_={Prop.signal(open_)}>
        <Backdrop onClose={() => Signal.set(open_, false)} />
        <div class="absolute z-20 mt-1 w-64 rounded-lg border border-neutral-200 bg-surface p-3 shadow-xl">
          <div class="grid grid-cols-7 gap-1 text-center">
            <View.For
              each={Prop.static(days)}
              render={d => {
                let cls = Computed.make(() =>
                  "flex size-8 items-center justify-center rounded-full text-sm " ++ (
                    Signal.get(day) == d ? "bg-neutral-900 text-neutral-0" : "text-neutral-700 hover:bg-neutral-100"
                  )
                )
                <button
                  class={Prop.signal(cls)}
                  onClick={_ => {
                    Signal.set(day, d)
                    Signal.set(open_, false)
                  }}>
                  <View.Text> {Int.toString(d)} </View.Text>
                </button>
              }}
            />
          </div>
        </div>
      </View.Show>
    </div>
  }
}

module Resizable = {
  @jsx.component
  let make = () => {
    let split = Signal.make(55)
    let leftStyle = Computed.make(() => "width:" ++ Int.toString(Signal.get(split)) ++ "%")
    let rightStyle = Computed.make(() => "width:" ++ Int.toString(100 - Signal.get(split)) ++ "%")
    <div class="w-96 space-y-3">
      <div class="flex h-40 overflow-hidden rounded-lg border border-neutral-200">
        <div class="flex items-center justify-center bg-neutral-50 text-sm text-neutral-500" style={Prop.signal(leftStyle)}>
          <View.Text> "Panel A" </View.Text>
        </div>
        <div class="w-1.5 cursor-col-resize bg-neutral-200" />
        <div class="flex items-center justify-center bg-surface text-sm text-neutral-500" style={Prop.signal(rightStyle)}>
          <View.Text> "Panel B" </View.Text>
        </div>
      </div>
      <input
        type_="range"
        min="20"
        max="80"
        value={Prop.signal(Computed.make(() => Signal.get(split)->Int.toString))}
        class="w-full accent-neutral-900"
        onInput={e => Signal.set(split, Ui.inputValue(e)->Int.fromString->Option.getOr(50))}
      />
    </div>
  }
}

module Navbar = {
  @jsx.component
  let make = () =>
    <div class="w-full max-w-2xl rounded-lg border border-neutral-200 bg-surface">
      <div class="flex items-center justify-between px-4 py-3">
        <div class="flex items-center gap-6">
          <span class="font-semibold text-neutral-900"> <View.Text> "Acme" </View.Text> </span>
          <nav class="hidden gap-4 text-sm text-neutral-600 sm:flex">
            <a class="hover:text-neutral-900" href="#"> <View.Text> "Product" </View.Text> </a>
            <a class="hover:text-neutral-900" href="#"> <View.Text> "Pricing" </View.Text> </a>
            <a class="hover:text-neutral-900" href="#"> <View.Text> "Docs" </View.Text> </a>
          </nav>
        </div>
        <div class="flex items-center gap-2">
          <Button variant=#ghost> <View.Text> "Sign in" </View.Text> </Button>
          <Button variant=#primary> <View.Text> "Get started" </View.Text> </Button>
        </div>
      </div>
    </div>
}

module Menubar = {
  @jsx.component
  let make = () =>
    <div class="flex w-full max-w-lg items-center gap-1 rounded-lg border border-neutral-200 bg-surface p-1 text-sm">
      <View.For
        each={Prop.static(["File", "Edit", "View", "Help"])}
        render={m =>
          <button class="rounded px-3 py-1.5 text-neutral-700 hover:bg-neutral-100"> <View.Text> {m} </View.Text> </button>}
      />
    </div>
}

module NavigationMenu = {
  @jsx.component
  let make = () => {
    let open_ = Signal.make(false)
    <div class="relative w-full max-w-lg">
      <div class="flex items-center gap-1 rounded-lg border border-neutral-200 bg-surface p-1 text-sm">
        <button
          class="rounded px-3 py-1.5 text-neutral-700 hover:bg-neutral-100"
          onClick={_ => Signal.update(open_, v => !v)}>
          <View.Text> "Products ⌄" </View.Text>
        </button>
        <a class="rounded px-3 py-1.5 text-neutral-700 hover:bg-neutral-100" href="#"> <View.Text> "Pricing" </View.Text> </a>
        <a class="rounded px-3 py-1.5 text-neutral-700 hover:bg-neutral-100" href="#"> <View.Text> "Company" </View.Text> </a>
      </div>
      <View.Show when_={Prop.signal(open_)}>
        <Backdrop onClose={() => Signal.set(open_, false)} />
        <div class="absolute z-20 mt-1 grid w-96 grid-cols-2 gap-1 rounded-lg border border-neutral-200 bg-surface p-2 shadow-xl">
          <View.For
            each={Prop.static([
              ("Analytics", "Understand your traffic"),
              ("Automations", "Build no-code workflows"),
              ("Reports", "Share insights"),
              ("Integrations", "Connect your stack"),
            ])}
            render={item => {
              let (t, d) = item
              <a class="rounded-md p-3 hover:bg-neutral-50" href="#">
                <p class="text-sm font-medium text-neutral-900"> <View.Text> {t} </View.Text> </p>
                <p class="text-xs text-neutral-500"> <View.Text> {d} </View.Text> </p>
              </a>
            }}
          />
        </div>
      </View.Show>
    </div>
  }
}

module Sidebar = {
  @jsx.component
  let make = () =>
    <div class="flex h-56 w-56 flex-col rounded-lg border border-neutral-200 bg-neutral-50 p-2">
      <div class="px-2 py-1.5 text-sm font-semibold text-neutral-900"> <View.Text> "Workspace" </View.Text> </div>
      <nav class="mt-1 space-y-0.5 text-sm">
        <a class="block rounded-md bg-neutral-900 px-2 py-1.5 text-neutral-0" href="#"> <View.Text> "Dashboard" </View.Text> </a>
        <a class="block rounded-md px-2 py-1.5 text-neutral-700 hover:bg-neutral-100" href="#"> <View.Text> "Projects" </View.Text> </a>
        <a class="block rounded-md px-2 py-1.5 text-neutral-700 hover:bg-neutral-100" href="#"> <View.Text> "Reports" </View.Text> </a>
        <a class="block rounded-md px-2 py-1.5 text-neutral-700 hover:bg-neutral-100" href="#"> <View.Text> "Settings" </View.Text> </a>
      </nav>
    </div>
}

module LandingPage = {
  @jsx.component
  let make = () =>
    <div class="w-full max-w-2xl overflow-hidden rounded-lg border border-neutral-200 bg-surface">
      <div class="flex items-center justify-between border-b border-neutral-200 px-5 py-3">
        <span class="font-semibold text-neutral-900"> <View.Text> "Acme" </View.Text> </span>
        <Button variant=#primary> <View.Text> "Start free" </View.Text> </Button>
      </div>
      <div class="px-8 py-12 text-center">
        <Badge variant=#outline> <View.Text> "New · v2 is here" </View.Text> </Badge>
        <h2 class="mx-auto mt-4 max-w-md text-3xl font-bold tracking-tight text-neutral-900">
          <View.Text> "Ship your product faster" </View.Text>
        </h2>
        <p class="mx-auto mt-3 max-w-sm text-sm text-neutral-500">
          <View.Text> "One primary action, front and center — everything on the page builds toward it." </View.Text>
        </p>
        <div class="mt-6 flex justify-center gap-3">
          <Button variant=#primary> <View.Text> "Get started" </View.Text> </Button>
          <Button variant=#secondary> <View.Text> "Book a demo" </View.Text> </Button>
        </div>
      </div>
    </div>
}

module LinkEx = {
  @jsx.component
  let make = () =>
    <div class="max-w-sm space-y-3 text-sm text-neutral-700">
      <p>
        <View.Text> "Read our " </View.Text>
        <Link href="#"> <View.Text> "getting-started guide" </View.Text> </Link>
        <View.Text> " to begin." </View.Text>
      </p>
      <div class="flex gap-4">
        <Link href="#" variant=#muted> <View.Text> "Docs" </View.Text> </Link>
        <Link href="#" variant=#muted> <View.Text> "Pricing" </View.Text> </Link>
        <Link href="#" newTab=true> <View.Text> "Changelog ↗" </View.Text> </Link>
      </div>
    </div>
}

module IconButtonEx = {
  @jsx.component
  let make = () =>
    <div class="flex items-center gap-2">
      <IconButton label="Edit"> <View.Text> "✎" </View.Text> </IconButton>
      <IconButton label="Copy"> <View.Text> "⧉" </View.Text> </IconButton>
      <IconButton label="Delete"> <View.Text> "🗑" </View.Text> </IconButton>
      <IconButton label="More options" variant=#solid> <View.Text> "⋯" </View.Text> </IconButton>
    </div>
}

module Toolbar = {
  @jsx.component
  let make = () =>
    <div class="flex w-full max-w-xl items-center gap-1 rounded-lg border border-neutral-200 bg-surface p-1">
      <IconButton label="Bold"> <span class="font-bold"> <View.Text> "B" </View.Text> </span> </IconButton>
      <IconButton label="Italic"> <span class="italic"> <View.Text> "I" </View.Text> </span> </IconButton>
      <IconButton label="Underline"> <span class="underline"> <View.Text> "U" </View.Text> </span> </IconButton>
      <Separator orientation=#vertical extraClass="mx-1" />
      <IconButton label="Align left"> <View.Text> "⇤" </View.Text> </IconButton>
      <IconButton label="Align center"> <View.Text> "↔" </View.Text> </IconButton>
      <IconButton label="Align right"> <View.Text> "⇥" </View.Text> </IconButton>
      <div class="ml-auto">
        <Button variant=#primary> <View.Text> "Share" </View.Text> </Button>
      </div>
    </div>
}

module List = {
  @jsx.component
  let make = () => {
    let people = [
      ("Ada Lovelace", "@ada", "Owner", "AL"),
      ("Grace Hopper", "@grace", "Admin", "GH"),
      ("Alan Turing", "@alan", "Member", "AT"),
    ]
    <div class="w-80 divide-y divide-neutral-100 rounded-lg border border-neutral-200 bg-surface">
      <View.For
        each={Prop.static(people)}
        render={p => {
          let (name, handle, role, initials) = p
          <div class="flex items-center gap-3 px-4 py-3">
            <Avatar initials size="size-9 text-xs" />
            <div class="min-w-0 flex-1">
              <p class="truncate text-sm font-medium text-neutral-900"> <View.Text> {name} </View.Text> </p>
              <p class="text-xs text-neutral-500"> <View.Text> {handle} </View.Text> </p>
            </div>
            <Badge variant=#soft> <View.Text> {role} </View.Text> </Badge>
            <IconButton label="More"> <View.Text> "⋯" </View.Text> </IconButton>
          </div>
        }}
      />
    </div>
  }
}

module Footer = {
  @jsx.component
  let make = () => {
    let col = (title, items) =>
      <div class="space-y-2">
        <p class="text-xs font-semibold uppercase tracking-wide text-neutral-500"> <View.Text> {title} </View.Text> </p>
        <View.For
          each={Prop.static(items)}
          render={i =>
            <p> <Link href="#" variant=#muted extraClass="text-sm"> <View.Text> {i} </View.Text> </Link> </p>}
        />
      </div>
    <div class="w-full max-w-2xl rounded-lg border border-neutral-200 bg-surface p-6">
      <div class="grid grid-cols-3 gap-6">
        {col("Product", ["Features", "Pricing", "Changelog"])}
        {col("Company", ["About", "Blog", "Careers"])}
        {col("Legal", ["Privacy", "Terms"])}
      </div>
      <Separator extraClass="my-5" />
      <div class="flex items-center justify-between text-xs text-neutral-500">
        <View.Text> "© 2026 Acme, Inc." </View.Text>
        <div class="flex gap-3">
          <Link href="#" variant=#muted> <View.Text> "Twitter" </View.Text> </Link>
          <Link href="#" variant=#muted> <View.Text> "GitHub" </View.Text> </Link>
        </div>
      </div>
    </div>
  }
}

module Dashboard = {
  @jsx.component
  let make = () => {
    let stat = (label, value, delta) =>
      <div class={Ui.card ++ " p-4"}>
        <p class="text-xs text-neutral-500"> <View.Text> {label} </View.Text> </p>
        <p class="mt-1 text-2xl font-bold text-neutral-900"> <View.Text> {value} </View.Text> </p>
        <p class="mt-1 text-xs text-neutral-400"> <View.Text> {delta} </View.Text> </p>
      </div>
    let bars = [50, 72, 40, 88, 63, 45, 70]
    <div class="w-full max-w-2xl space-y-4">
      <div class="grid grid-cols-3 gap-4">
        {stat("Revenue", "$48.2k", "+12% MoM")}
        {stat("Active users", "3,190", "+4% MoM")}
        {stat("Churn", "1.8%", "−0.3% MoM")}
      </div>
      <div class={Ui.card ++ " p-4"}>
        <div class="mb-3 flex items-center justify-between">
          <p class="text-sm font-medium text-neutral-900"> <View.Text> "Signups this week" </View.Text> </p>
          <Badge variant=#soft> <View.Text> "Live" </View.Text> </Badge>
        </div>
        <div class="flex h-24 items-end gap-2">
          <View.For
            each={Prop.static(bars)}
            render={v => <div class="flex-1 rounded-t bg-neutral-900" style={"height:" ++ Int.toString(v) ++ "%"} />}
          />
        </div>
      </div>
    </div>
  }
}

module Settings = {
  @jsx.component
  let make = () => {
    let notifications = Signal.make(true)
    let marketing = Signal.make(false)
    let row = (text, sig) =>
      <div class="flex items-center justify-between">
        <span class="text-sm text-neutral-800"> <View.Text> {text} </View.Text> </span>
        <Switch on={sig} />
      </div>
    <div class="w-full max-w-lg space-y-5 rounded-lg border border-neutral-200 bg-surface p-6">
      <div>
        <h3 class="text-sm font-semibold text-neutral-900"> <View.Text> "Profile" </View.Text> </h3>
        <p class="text-xs text-neutral-500"> <View.Text> "Update your account details." </View.Text> </p>
      </div>
      <Field label="Display name" for_="set-name">
        <Input id="set-name" value="Ada Lovelace" />
      </Field>
      <Separator />
      <div class="space-y-3">
        {row("Product notifications", notifications)}
        {row("Marketing emails", marketing)}
      </div>
      <div class="flex justify-end gap-2">
        <Button variant=#ghost> <View.Text> "Cancel" </View.Text> </Button>
        <Button variant=#primary> <View.Text> "Save changes" </View.Text> </Button>
      </div>
    </div>
  }
}

module SignIn = {
  @jsx.component
  let make = () => {
    let remember = Signal.make(true)
    <div class="w-full max-w-sm space-y-5 rounded-lg border border-neutral-200 bg-surface p-6">
      <div class="text-center">
        <div class="mx-auto mb-2 flex size-9 items-center justify-center rounded-md bg-neutral-900 text-sm font-bold text-neutral-0">
          <View.Text> "U" </View.Text>
        </div>
        <h3 class="text-lg font-semibold text-neutral-900"> <View.Text> "Welcome back" </View.Text> </h3>
        <p class="text-sm text-neutral-500"> <View.Text> "Sign in to your account" </View.Text> </p>
      </div>
      <Field label="Email" for_="si-email">
        <Input id="si-email" type_="email" placeholder="you@example.com" />
      </Field>
      <Field label="Password" for_="si-pass">
        <Input id="si-pass" type_="password" placeholder="••••••••" />
      </Field>
      <div class="flex items-center justify-between text-sm">
        <div class="flex items-center gap-2">
          <input
            type_="checkbox"
            checked={Prop.signal(remember)}
            class="size-4 accent-neutral-900"
            onChange={e => Signal.set(remember, Ui.checked(e))}
          />
          <span class="text-neutral-700"> <View.Text> "Remember me" </View.Text> </span>
        </div>
        <Link href="#"> <View.Text> "Forgot?" </View.Text> </Link>
      </div>
      <Button variant=#primary extraClass="w-full"> <View.Text> "Sign in" </View.Text> </Button>
      <p class="text-center text-sm text-neutral-500">
        <View.Text> "No account? " </View.Text>
        <Link href="#"> <View.Text> "Create one" </View.Text> </Link>
      </p>
    </div>
  }
}

module Pricing = {
  @jsx.component
  let make = () => {
    let plan = (name, price, feats, recommended) => {
      let cardCls = recommended ? Ui.card ++ " p-5 ring-2 ring-neutral-900" : Ui.card ++ " p-5"
      <div class={cardCls}>
        <div class="flex items-center justify-between">
          <p class="text-sm font-semibold text-neutral-900"> <View.Text> {name} </View.Text> </p>
          {recommended ? <Badge variant=#solid> <View.Text> "Popular" </View.Text> </Badge> : View.null()}
        </div>
        <p class="mt-2">
          <span class="text-3xl font-bold text-neutral-900"> <View.Text> {price} </View.Text> </span>
          <span class="text-sm text-neutral-500"> <View.Text> "/mo" </View.Text> </span>
        </p>
        <ul class="mt-3 space-y-1 text-sm text-neutral-600">
          <View.For each={Prop.static(feats)} render={f => <li> <View.Text> {"✓ " ++ f} </View.Text> </li>} />
        </ul>
        <div class="mt-4">
          <Button variant={recommended ? #primary : #secondary} extraClass="w-full">
            <View.Text> "Choose" </View.Text>
          </Button>
        </div>
      </div>
    }
    <div class="grid w-full max-w-2xl grid-cols-3 gap-4">
      {plan("Starter", "$0", ["1 project", "Community support"], false)}
      {plan("Pro", "$12", ["Unlimited projects", "Priority support", "Analytics"], true)}
      {plan("Team", "$29", ["Everything in Pro", "SSO", "Audit log"], false)}
    </div>
  }
}

module Hero = {
  @jsx.component
  let make = () =>
    <div class="w-full max-w-2xl rounded-lg border border-neutral-200 bg-surface px-8 py-12 text-center">
      <Badge variant=#outline> <View.Text> "New · v2 is here" </View.Text> </Badge>
      <h2 class="mx-auto mt-4 max-w-lg text-4xl font-bold tracking-tight text-neutral-900">
        <View.Text> "Ship your product faster" </View.Text>
      </h2>
      <p class="mx-auto mt-3 max-w-md text-neutral-600">
        <View.Text> "The all-in-one toolkit to design, build, and launch — without the busywork." </View.Text>
      </p>
      <div class="mt-6 flex justify-center gap-3">
        <Button variant=#primary> <View.Text> "Get started" </View.Text> </Button>
        <Button variant=#secondary> <View.Text> "Book a demo" </View.Text> </Button>
      </div>
      <p class="mt-4 text-xs text-neutral-400"> <View.Text> "Trusted by 4,000+ teams · No credit card required" </View.Text> </p>
    </div>
}

module FeatureGrid = {
  @jsx.component
  let make = () => {
    let feats = [
      ("⚡", "Fast", "Ship in minutes with sensible defaults."),
      ("🔒", "Secure", "Encryption and SSO out of the box."),
      ("📈", "Scalable", "Grows from prototype to production."),
    ]
    <div class="grid w-full max-w-2xl grid-cols-3 gap-4">
      <View.For
        each={Prop.static(feats)}
        render={item => {
          let (ic, title, desc) = item
          <div class={Ui.card ++ " p-5"}>
            <div class="flex size-9 items-center justify-center rounded-md bg-neutral-100 text-lg"> <View.Text> {ic} </View.Text> </div>
            <p class="mt-3 text-sm font-semibold text-neutral-900"> <View.Text> {title} </View.Text> </p>
            <p class="mt-1 text-sm text-neutral-500"> <View.Text> {desc} </View.Text> </p>
          </div>
        }}
      />
    </div>
  }
}

module Testimonial = {
  @jsx.component
  let make = () =>
    <div class={Ui.card ++ " w-full max-w-lg p-6"}>
      <p class="text-lg leading-relaxed text-neutral-800">
        <View.Text> "“The first tool our whole team actually enjoys using. It paid for itself in a week.”" </View.Text>
      </p>
      <div class="mt-4 flex items-center gap-3">
        <Avatar initials="GH" size="size-10 text-sm" />
        <div>
          <p class="text-sm font-medium text-neutral-900"> <View.Text> "Grace Hopper" </View.Text> </p>
          <p class="text-xs text-neutral-500"> <View.Text> "VP Engineering, Acme" </View.Text> </p>
        </div>
      </div>
    </div>
}

module PricingTable = {
  @jsx.component
  let make = () => {
    let rows = [
      ("Projects", "1", "Unlimited", "Unlimited"),
      ("Support", "Community", "Priority", "Dedicated"),
      ("SSO", "–", "–", "✓"),
      ("Audit log", "–", "✓", "✓"),
    ]
    <div class="w-full max-w-2xl overflow-hidden rounded-lg border border-neutral-200">
      <table class="w-full text-sm">
        <thead class="bg-neutral-50">
          <tr>
            <th class="px-4 py-3 text-left text-xs uppercase tracking-wide text-neutral-500"> <View.Text> "Feature" </View.Text> </th>
            <th class="px-4 py-3 text-center font-medium"> <View.Text> "Starter" </View.Text> </th>
            <th class="px-4 py-3 text-center font-medium">
              <div class="flex items-center justify-center gap-2">
                <View.Text> "Pro" </View.Text>
                <Badge variant=#solid> <View.Text> "Popular" </View.Text> </Badge>
              </div>
            </th>
            <th class="px-4 py-3 text-center font-medium"> <View.Text> "Team" </View.Text> </th>
          </tr>
        </thead>
        <tbody class="divide-y divide-neutral-100 text-neutral-700">
          <View.For
            each={Prop.static(rows)}
            render={r => {
              let (feat, a, b, c) = r
              <tr>
                <td class="px-4 py-2 font-medium text-neutral-900"> <View.Text> {feat} </View.Text> </td>
                <td class="px-4 py-2 text-center"> <View.Text> {a} </View.Text> </td>
                <td class="px-4 py-2 text-center"> <View.Text> {b} </View.Text> </td>
                <td class="px-4 py-2 text-center"> <View.Text> {c} </View.Text> </td>
              </tr>
            }}
          />
          <tr>
            <td class="px-4 py-3" />
            <td class="px-4 py-3 text-center"> <Button variant=#secondary> <View.Text> "Choose" </View.Text> </Button> </td>
            <td class="px-4 py-3 text-center"> <Button variant=#primary> <View.Text> "Choose" </View.Text> </Button> </td>
            <td class="px-4 py-3 text-center"> <Button variant=#secondary> <View.Text> "Choose" </View.Text> </Button> </td>
          </tr>
        </tbody>
      </table>
    </div>
  }
}

module Faq = {
  @jsx.component
  let make = () => {
    let openId = Signal.make(0)
    let items = [
      (0, "Can I cancel anytime?", "Yes — cancel in one click, no questions asked."),
      (1, "Do you offer refunds?", "We offer a 30-day money-back guarantee."),
      (2, "Is there a free plan?", "Yes, the Starter plan is free forever."),
    ]
    <div class="w-full max-w-xl divide-y divide-neutral-200 rounded-lg border border-neutral-200">
      <View.For
        each={Prop.static(items)}
        render={item => {
          let (idx, q, a) = item
          let isOpen = Computed.make(() => Signal.get(openId) == idx)
          let mark = Computed.make(() => Signal.get(openId) == idx ? "−" : "+")
          <div>
            <button
              class="flex w-full items-center justify-between px-4 py-3 text-left text-sm font-medium text-neutral-800 hover:bg-neutral-50"
              onClick={_ => Signal.update(openId, c => c == idx ? -1 : idx)}>
              <View.Text> {q} </View.Text>
              <span class="text-neutral-400"> <View.Text> {mark} </View.Text> </span>
            </button>
            <View.Show when_={Prop.signal(isOpen)}>
              <p class="px-4 pb-3 text-sm text-neutral-500"> <View.Text> {a} </View.Text> </p>
            </View.Show>
          </div>
        }}
      />
    </div>
  }
}

module CtaSection = {
  @jsx.component
  let make = () =>
    <div class="w-full max-w-2xl rounded-lg bg-neutral-900 px-8 py-10 text-center text-neutral-0">
      <h2 class="text-2xl font-bold"> <View.Text> "Start building today" </View.Text> </h2>
      <p class="mt-2 text-sm text-neutral-300"> <View.Text> "Join thousands of teams shipping faster. Free for 14 days." </View.Text> </p>
      <div class="mx-auto mt-5 flex max-w-md gap-2">
        <input
          class="flex-1 rounded-md border border-neutral-700 bg-neutral-800 px-3 py-2 text-sm text-neutral-0 placeholder:text-neutral-500 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-white"
          placeholder="you@example.com"
        />
        <button class="rounded-md bg-surface px-4 py-2 text-sm font-medium text-neutral-900 hover:bg-neutral-200">
          <View.Text> "Get started" </View.Text>
        </button>
      </div>
    </div>
}

module IconEx = {
  @jsx.component
  let make = () => {
    let icons = ["🔍", "✎", "🗑", "⚙", "★", "♥", "⬇", "↗"]
    <div class="flex flex-wrap items-center gap-3 text-neutral-700">
      <View.For
        each={Prop.static(icons)}
        render={g =>
          <span class="flex size-9 items-center justify-center rounded-md border border-neutral-200 text-base"> <View.Text> {g} </View.Text> </span>}
      />
    </div>
  }
}

module LogoEx = {
  @jsx.component
  let make = () =>
    <div class="flex flex-wrap items-center gap-8">
      <div class="flex items-center gap-2">
        <span class="flex size-8 items-center justify-center rounded-md bg-neutral-900 text-sm font-bold text-neutral-0"> <View.Text> "U" </View.Text> </span>
        <span class="text-lg font-semibold tracking-tight text-neutral-900"> <View.Text> "Untitled" </View.Text> </span>
      </div>
      <span class="flex size-9 items-center justify-center rounded-lg bg-neutral-900 font-bold text-neutral-0"> <View.Text> "U" </View.Text> </span>
      <span class="text-xl font-bold tracking-tight text-neutral-900"> <View.Text> "ACME" </View.Text> </span>
    </div>
}

module LegendEx = {
  @jsx.component
  let make = () => {
    let series = [("Revenue", "bg-neutral-900"), ("Costs", "bg-neutral-400"), ("Profit", "bg-neutral-600")]
    <div class="flex items-center gap-5 text-sm text-neutral-700">
      <View.For
        each={Prop.static(series)}
        render={s => {
          let (label, sw) = s
          <div class="flex items-center gap-2">
            <span class={"size-3 rounded-sm " ++ sw} />
            <View.Text> {label} </View.Text>
          </div>
        }}
      />
    </div>
  }
}

module StatEx = {
  @jsx.component
  let make = () => {
    let spark = [40, 55, 45, 70, 60, 80, 72]
    <div class={Ui.card ++ " w-64 p-4"}>
      <div class="flex items-center justify-between">
        <p class="text-xs text-neutral-500"> <View.Text> "Monthly revenue" </View.Text> </p>
        <Badge variant=#soft> <View.Text> "▲ 12%" </View.Text> </Badge>
      </div>
      <p class="mt-1 text-3xl font-bold text-neutral-900"> <View.Text> "$48.2k" </View.Text> </p>
      <div class="mt-3 flex h-8 items-end gap-1">
        <View.For
          each={Prop.static(spark)}
          render={v => <div class="flex-1 rounded-sm bg-neutral-300" style={"height:" ++ Int.toString(v) ++ "%"} />}
        />
      </div>
    </div>
  }
}

module SearchEx = {
  @jsx.component
  let make = () => {
    let query = Signal.make("")
    let open_ = Signal.make(false)
    let all = ["Dashboard", "Settings", "Billing", "Team members", "API keys"]
    let filtered = Computed.make(() => {
      let q = Signal.get(query)->String.toLowerCase
      all->Array.filter(o => o->String.toLowerCase->String.includes(q))
    })
    let hasQuery = Computed.make(() => Signal.get(query) != "")
    <div class="relative w-72">
      <div class="flex items-center gap-2 rounded-md border border-neutral-300 bg-surface pl-3 pr-1">
        <span class="text-neutral-400"> <View.Text> "🔍" </View.Text> </span>
        <input
          class="flex-1 bg-transparent py-2 text-sm focus:outline-none"
          placeholder="Search…"
          onFocus={_ => Signal.set(open_, true)}
          onInput={e => {
            Signal.set(query, Ui.inputValue(e))
            Signal.set(open_, true)
          }}
        />
        <View.Show when_={Prop.signal(hasQuery)}>
          <IconButton label="Clear search" onClick={_ => Signal.set(query, "")}> <View.Text> "×" </View.Text> </IconButton>
        </View.Show>
      </div>
      <View.Show when_={Prop.signal(open_)}>
        <Backdrop onClose={() => Signal.set(open_, false)} />
        <ul class="absolute z-20 mt-1 w-full rounded-md border border-neutral-200 bg-surface py-1 shadow-lg">
          <View.For
            each={Prop.signal(filtered)}
            render={o =>
              <li>
                <button
                  class="block w-full px-3 py-1.5 text-left text-sm text-neutral-700 hover:bg-neutral-100"
                  onClick={_ => {
                    Signal.set(query, o)
                    Signal.set(open_, false)
                  }}>
                  <View.Text> {o} </View.Text>
                </button>
              </li>}
          />
        </ul>
      </View.Show>
    </div>
  }
}

module CommentEx = {
  @jsx.component
  let make = () => {
    let liked = Signal.make(false)
    let likeLabel = Computed.make(() => Signal.get(liked) ? "♥ Liked" : "♡ Like")
    <div class="w-full max-w-lg">
      <div class="flex gap-3">
        <Avatar initials="AT" size="size-9 text-xs" />
        <div class="flex-1">
          <div class="flex items-center gap-2">
            <span class="text-sm font-medium text-neutral-900"> <View.Text> "Alan Turing" </View.Text> </span>
            <Badge variant=#soft> <View.Text> "Author" </View.Text> </Badge>
            <span class="text-xs text-neutral-400"> <View.Text> "2h ago" </View.Text> </span>
          </div>
          <p class="mt-1 text-sm text-neutral-700">
            <View.Text> "Great write-up — the section on reuse really clicked for me. Shipping this to my team." </View.Text>
          </p>
          <div class="mt-2 flex gap-3 text-xs text-neutral-500">
            <button class="hover:text-neutral-900" onClick={_ => Signal.update(liked, v => !v)}> <View.Text> {likeLabel} </View.Text> </button>
            <button class="hover:text-neutral-900"> <View.Text> "Reply" </View.Text> </button>
          </div>
        </div>
      </div>
    </div>
  }
}

module AuthenticationEx = {
  @jsx.component
  let make = () => {
    let step = Signal.make(1)
    let stepLabel = Computed.make(() => "Step " ++ Int.toString(Signal.get(step)) ++ " of 2")
    let onStep1 = Computed.make(() => Signal.get(step) == 1)
    <div class="w-full max-w-sm rounded-lg border border-neutral-200 bg-surface p-6">
      <p class="text-xs text-neutral-400"> <View.Text> {stepLabel} </View.Text> </p>
      <View.Show
        when_={Prop.signal(onStep1)}
        fallback={
          <div class="mt-2 space-y-4">
            <h3 class="text-lg font-semibold text-neutral-900"> <View.Text> "Enter your code" </View.Text> </h3>
            <p class="text-sm text-neutral-500"> <View.Text> "We sent a 6-digit code to your email." </View.Text> </p>
            <Field label="Verification code" for_="auth-code"> <Input id="auth-code" placeholder="123456" /> </Field>
            <Button variant=#primary extraClass="w-full" onClick={_ => Signal.set(step, 1)}> <View.Text> "Verify" </View.Text> </Button>
          </div>
        }>
        <div class="mt-2 space-y-4">
          <h3 class="text-lg font-semibold text-neutral-900"> <View.Text> "Sign in" </View.Text> </h3>
          <Field label="Email" for_="auth-email"> <Input id="auth-email" type_="email" placeholder="you@example.com" /> </Field>
          <Field label="Password" for_="auth-pass"> <Input id="auth-pass" type_="password" placeholder="••••••••" /> </Field>
          <Button variant=#primary extraClass="w-full" onClick={_ => Signal.set(step, 2)}> <View.Text> "Continue" </View.Text> </Button>
        </div>
      </View.Show>
    </div>
  }
}

module OnboardingEx = {
  @jsx.component
  let make = () => {
    let step = Signal.make(1)
    let total = 3
    let pct = Computed.make(() => "height:100%;width:" ++ Int.toString(Signal.get(step) * 100 / total) ++ "%")
    let title = Computed.make(() =>
      switch Signal.get(step) {
      | 1 => "Welcome to Acme"
      | 2 => "Set up your workspace"
      | _ => "Invite your team"
      }
    )
    let body = Computed.make(() =>
      switch Signal.get(step) {
      | 1 => "Let's get you set up in a couple of steps."
      | 2 => "Name your workspace and pick a theme."
      | _ => "Add teammates to collaborate. You can skip this."
      }
    )
    let nextLabel = Computed.make(() => Signal.get(step) == total ? "Finish" : "Next")
    <div class="w-full max-w-md rounded-lg border border-neutral-200 bg-surface p-6">
      <div class="h-1.5 w-full overflow-hidden rounded-full bg-neutral-200">
        <div class="rounded-full bg-neutral-900 transition-all" style={Prop.signal(pct)} />
      </div>
      <h3 class="mt-4 text-lg font-semibold text-neutral-900"> <View.Text> {title} </View.Text> </h3>
      <p class="mt-1 text-sm text-neutral-500"> <View.Text> {body} </View.Text> </p>
      <div class="mt-5 flex justify-between">
        <Button variant=#ghost onClick={_ => Signal.update(step, s => s > 1 ? s - 1 : 1)}> <View.Text> "Back" </View.Text> </Button>
        <Button variant=#primary onClick={_ => Signal.update(step, s => s < total ? s + 1 : 1)}>
          <View.Text> {nextLabel} </View.Text>
        </Button>
      </div>
    </div>
  }
}

module CheckoutEx = {
  @jsx.component
  let make = () => {
    let items = [("Pro plan (annual)", "$120.00"), ("Add-on: Analytics", "$24.00")]
    <div class="grid w-full max-w-2xl gap-4 sm:grid-cols-2">
      <div class="space-y-4 rounded-lg border border-neutral-200 bg-surface p-5">
        <h3 class="text-sm font-semibold text-neutral-900"> <View.Text> "Payment details" </View.Text> </h3>
        <Field label="Card number" for_="co-card"> <Input id="co-card" placeholder="4242 4242 4242 4242" /> </Field>
        <div class="grid grid-cols-2 gap-3">
          <Field label="Expiry" for_="co-exp"> <Input id="co-exp" placeholder="MM/YY" /> </Field>
          <Field label="CVC" for_="co-cvc"> <Input id="co-cvc" placeholder="123" /> </Field>
        </div>
        <Button variant=#primary extraClass="w-full"> <View.Text> "Pay $144.00" </View.Text> </Button>
      </div>
      <div class="space-y-3 rounded-lg border border-neutral-200 bg-neutral-50 p-5">
        <h3 class="text-sm font-semibold text-neutral-900"> <View.Text> "Order summary" </View.Text> </h3>
        <ul class="space-y-2 text-sm">
          <View.For
            each={Prop.static(items)}
            render={it => {
              let (name, price) = it
              <li class="flex justify-between text-neutral-700">
                <View.Text> {name} </View.Text>
                <span class="tabular-nums"> <View.Text> {price} </View.Text> </span>
              </li>
            }}
          />
        </ul>
        <Separator />
        <div class="flex justify-between text-sm font-semibold text-neutral-900">
          <View.Text> "Total" </View.Text>
          <span class="tabular-nums"> <View.Text> "$144.00" </View.Text> </span>
        </div>
      </div>
    </div>
  }
}

let get = (id: string): option<View.node> =>
  switch id {
  | "button" => Some(<ButtonEx />)
  | "input" => Some(<InputEx />)
  | "textarea" => Some(<Textarea />)
  | "badge" => Some(<BadgeEx />)
  | "avatar" => Some(<AvatarEx />)
  | "checkbox" => Some(<Checkbox />)
  | "switch" => Some(<SwitchEx />)
  | "slider" => Some(<Slider />)
  | "progress" => Some(<Progress />)
  | "spinner" => Some(<SpinnerEx />)
  | "skeleton" => Some(<Skeleton />)
  | "separator" => Some(<SeparatorEx />)
  | "label" => Some(<Label />)
  | "kbd" => Some(<KbdEx />)
  | "typography" => Some(<Typography />)
  | "radio-group" => Some(<RadioGroup />)
  | "toggle" => Some(<Toggle />)
  | "toggle-group" => Some(<ToggleGroup />)
  | "aspect-ratio" => Some(<AspectRatio />)
  | "scroll-area" => Some(<ScrollArea />)
  | "input-otp" => Some(<InputOtp />)
  | "card" => Some(<Card />)
  | "alert" => Some(<AlertEx />)
  | "tabs" => Some(<TabsEx />)
  | "accordion" => Some(<AccordionEx />)
  | "collapsible" => Some(<CollapsibleEx />)
  | "dialog" => Some(<DialogEx />)
  | "alert-dialog" => Some(<AlertDialog />)
  | "tooltip" => Some(<TooltipEx />)
  | "breadcrumb" => Some(<Breadcrumb />)
  | "pagination" => Some(<Pagination />)
  | "empty-state" => Some(<EmptyState />)
  | "field" => Some(<FieldEx />)
  | "form" => Some(<Form />)
  | "button-group" => Some(<ButtonGroup />)
  | "input-group" => Some(<InputGroup />)
  | "select" => Some(<SelectEx />)
  | "dropdown-menu" => Some(<DropdownMenu />)
  | "context-menu" => Some(<ContextMenu />)
  | "popover" => Some(<Popover />)
  | "hover-card" => Some(<HoverCard />)
  | "sheet" => Some(<Sheet />)
  | "drawer" => Some(<Drawer />)
  | "toast" => Some(<Toast />)
  | "table" => Some(<Table />)
  | "data-table" => Some(<DataTable />)
  | "chart" => Some(<Chart />)
  | "carousel" => Some(<Carousel />)
  | "combobox" => Some(<Combobox />)
  | "command" => Some(<Command />)
  | "calendar" => Some(<Calendar />)
  | "date-picker" => Some(<DatePicker />)
  | "resizable" => Some(<Resizable />)
  | "navbar" => Some(<Navbar />)
  | "menubar" => Some(<Menubar />)
  | "navigation-menu" => Some(<NavigationMenu />)
  | "sidebar" => Some(<Sidebar />)
  | "landing-page" => Some(<LandingPage />)
  | "link" => Some(<LinkEx />)
  | "icon-button" => Some(<IconButtonEx />)
  | "toolbar" => Some(<Toolbar />)
  | "list" => Some(<List />)
  | "footer" => Some(<Footer />)
  | "dashboard" => Some(<Dashboard />)
  | "settings" => Some(<Settings />)
  | "sign-in" => Some(<SignIn />)
  | "pricing" => Some(<Pricing />)
  | "hero" => Some(<Hero />)
  | "feature-grid" => Some(<FeatureGrid />)
  | "testimonial" => Some(<Testimonial />)
  | "pricing-table" => Some(<PricingTable />)
  | "faq" => Some(<Faq />)
  | "cta-section" => Some(<CtaSection />)
  | "icon" => Some(<IconEx />)
  | "logo" => Some(<LogoEx />)
  | "legend" => Some(<LegendEx />)
  | "stat" => Some(<StatEx />)
  | "search" => Some(<SearchEx />)
  | "comment" => Some(<CommentEx />)
  | "authentication" => Some(<AuthenticationEx />)
  | "onboarding" => Some(<OnboardingEx />)
  | "checkout" => Some(<CheckoutEx />)
  | _ => None
  }
