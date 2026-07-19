// Full-page compositions assembled entirely from the spec components, to
// show how the catalogue composes into real screens. Everything here is
// token-driven (semantic utilities — bg-surface, text-ink, bg-action…), so
// switching the theme from the top bar re-skins every mock live.

// A chip that links to a spec's detail page — names the parts a mock is
// built from.
module Chip = {
  @jsx.component
  let make = (~id) =>
    <Router.Link
      to={"/a/" ++ id}
      class="inline-flex items-center rounded-full border border-border bg-surface px-2 py-0.5 text-xs text-muted transition-colors hover:border-neutral-400 hover:text-ink">
      <View.Text> id </View.Text>
    </Router.Link>
}

// A lightweight browser-window frame so a mock reads as a real screen. Takes a
// render thunk (not children) so the mock can be instantiated twice — once
// inline, once in the fullscreen overlay — the same way the detail-page preview
// re-instantiates its example.
module Frame = {
  @jsx.component
  let make = (~label: string, ~render: unit => View.node) => {
    let full = Signal.make(false)
    // Close fullscreen on Escape while it is open.
    Effect.run(() => Signal.get(full) ? Some(Ui.onEscape(() => Signal.set(full, false))) : None)
    <div class="overflow-hidden rounded-xl border border-border bg-surface shadow-md">
      <div class="flex items-center gap-2 border-b border-border bg-paper px-3 py-2">
        <span class="size-2.5 rounded-full bg-neutral-300" />
        <span class="size-2.5 rounded-full bg-neutral-300" />
        <span class="size-2.5 rounded-full bg-neutral-300" />
        <div class="ml-2 flex-1">
          <span class="inline-block rounded-md bg-surface px-3 py-0.5 text-xs text-muted ring-1 ring-inset ring-border">
            <View.Text> label </View.Text>
          </span>
        </div>
        <button
          class="shrink-0 rounded-md px-2 py-0.5 text-xs font-medium text-muted transition-colors hover:bg-action-subtle hover:text-ink"
          onClick={_ => Signal.set(full, true)}>
          <span class="inline-flex items-center gap-1">
            <Icon name="maximize" size=#xs />
            <View.Text> "Fullscreen" </View.Text>
          </span>
        </button>
      </div>
      <div class="max-h-[36rem] overflow-y-auto"> {render()} </div>
      <View.Show when_={Prop.signal(full)}>
        <div class="fixed inset-0 z-50 flex flex-col bg-paper">
          <div class="flex h-12 shrink-0 items-center justify-between border-b border-border bg-surface px-4">
            <span class="text-xs text-muted"> <View.Text> label </View.Text> </span>
            <span class="flex items-center gap-2">
              <span class="hidden items-center gap-1 text-xs text-muted sm:flex">
                <Kbd> <View.Text> "esc" </View.Text> </Kbd>
                <View.Text> "to exit" </View.Text>
              </span>
              <Button variant=#secondary size=#sm onClick={_ => Signal.set(full, false)}>
                <Icon name="x" size=#sm />
                <View.Text> "Close" </View.Text>
              </Button>
            </span>
          </div>
          <div class="flex-1 overflow-y-auto"> {render()} </div>
        </div>
      </View.Show>
    </div>
  }
}

// ------------------------------------------------------------------ Landing --
module Landing = {
  @jsx.component
  let make = () => {
    let navLink = label =>
      <a class="text-sm text-muted transition-colors hover:text-ink" href="#"> <View.Text> label </View.Text> </a>
    let feature = (icon, title, desc) =>
      <div class="rounded-2xl border border-border bg-surface p-5 shadow-sm">
        <div class="flex size-9 items-center justify-center rounded-lg bg-action-subtle text-action"> <Icon name=icon /> </div>
        <p class="mt-3 text-sm font-semibold text-ink"> <View.Text> title </View.Text> </p>
        <p class="mt-1 text-sm text-muted"> <View.Text> desc </View.Text> </p>
      </div>
    let plan = (name, price, feats, popular) =>
      <div class={"rounded-2xl border bg-surface p-5 " ++ (popular ? "border-action ring-1 ring-action" : "border-border")}>
        <div class="flex items-center justify-between">
          <p class="text-sm font-semibold text-ink"> <View.Text> name </View.Text> </p>
          {popular ? <Badge variant=#solid> <View.Text> "Popular" </View.Text> </Badge> : View.null()}
        </div>
        <p class="mt-2">
          <span class="text-3xl font-bold text-ink"> <View.Text> price </View.Text> </span>
          <span class="text-sm text-muted"> <View.Text> "/mo" </View.Text> </span>
        </p>
        <ul class="mt-3 space-y-1 text-sm text-muted">
          <View.For
            each={Prop.static(feats)}
            render={f =>
              <li class="flex items-center gap-2">
                <Icon name="check" size=#sm extraClass="text-status-success" />
                <View.Text> {f} </View.Text>
              </li>}
          />
        </ul>
        <div class="mt-4">
          <Button variant={popular ? #primary : #secondary} extraClass="w-full"> <View.Text> "Choose plan" </View.Text> </Button>
        </div>
      </div>
    <div class="bg-paper text-ink">
      // navbar
      <header class="flex items-center justify-between border-b border-border bg-surface px-6 py-3">
        <div class="flex items-center gap-2">
          <span class="flex size-7 items-center justify-center rounded-lg bg-action text-xs font-bold text-on-action"> <View.Text> "A" </View.Text> </span>
          <span class="text-sm font-semibold"> <View.Text> "Acme" </View.Text> </span>
        </div>
        <nav class="hidden items-center gap-6 sm:flex">
          {navLink("Product")} {navLink("Pricing")} {navLink("Docs")}
        </nav>
        <div class="flex items-center gap-3">
          <span class="hidden sm:block"> <Link href="#" variant=#muted extraClass="text-sm"> <View.Text> "Sign in" </View.Text> </Link> </span>
          <Button size=#sm> <View.Text> "Start free" </View.Text> </Button>
        </div>
      </header>
      // hero
      <section class="hero-wash px-6 py-14 text-center">
        <Badge variant=#outline> <View.Text> "New · v2 is here" </View.Text> </Badge>
        <h1 class="mx-auto mt-4 max-w-xl text-4xl font-bold tracking-tight"> <View.Text> "Ship your product faster" </View.Text> </h1>
        <p class="mx-auto mt-3 max-w-md text-muted"> <View.Text> "The all-in-one toolkit to design, build, and launch — without the busywork." </View.Text> </p>
        <div class="mt-6 flex justify-center gap-3">
          <Button size=#lg> <View.Text> "Get started" </View.Text> </Button>
          <Button variant=#secondary size=#lg> <View.Text> "Book a demo" </View.Text> </Button>
        </div>
        <p class="mt-4 text-xs text-muted"> <View.Text> "Trusted by 4,000+ teams · No credit card required" </View.Text> </p>
      </section>
      // features
      <section class="grid gap-4 px-6 py-10 sm:grid-cols-3">
        {feature("zap", "Fast", "Ship in minutes with sensible defaults.")}
        {feature("lock", "Secure", "Encryption and SSO out of the box.")}
        {feature("trending-up", "Scalable", "Grows from prototype to production.")}
      </section>
      // testimonial
      <section class="px-6 pb-10">
        <div class="mx-auto max-w-lg rounded-2xl border border-border bg-surface p-6 shadow-sm">
          <p class="text-lg leading-relaxed"> <View.Text> "“The first tool our whole team actually enjoys using. It paid for itself in a week.”" </View.Text> </p>
          <div class="mt-4 flex items-center gap-3">
            <Avatar initials="GH" size="size-10 text-sm" />
            <div>
              <p class="text-sm font-medium"> <View.Text> "Grace Hopper" </View.Text> </p>
              <p class="text-xs text-muted"> <View.Text> "VP Engineering, Acme" </View.Text> </p>
            </div>
          </div>
        </div>
      </section>
      // pricing
      <section class="px-6 pb-10">
        <h2 class="mb-5 text-center text-2xl font-bold tracking-tight"> <View.Text> "Simple, transparent pricing" </View.Text> </h2>
        <div class="grid gap-4 sm:grid-cols-3">
          {plan("Starter", "$0", ["1 project", "Community support"], false)}
          {plan("Pro", "$12", ["Unlimited projects", "Priority support", "Analytics"], true)}
          {plan("Team", "$29", ["Everything in Pro", "SSO", "Audit log"], false)}
        </div>
      </section>
      // cta
      <section class="px-6 pb-10">
        <div class="rounded-2xl bg-action px-8 py-10 text-center text-on-action">
          <h2 class="text-2xl font-bold"> <View.Text> "Start building today" </View.Text> </h2>
          <p class="mx-auto mt-2 max-w-md text-sm opacity-80"> <View.Text> "Join thousands of teams shipping faster. Free for 14 days." </View.Text> </p>
          <div class="mt-5"> <Button variant=#secondary size=#lg> <View.Text> "Create your account" </View.Text> </Button> </div>
        </div>
      </section>
      // footer
      <footer class="border-t border-border px-6 py-8 text-sm text-muted">
        <div class="flex flex-wrap items-center justify-between gap-3">
          <span> <View.Text> "© 2026 Acme, Inc." </View.Text> </span>
          <div class="flex gap-4">
            <a class="hover:text-ink" href="#"> <View.Text> "Privacy" </View.Text> </a>
            <a class="hover:text-ink" href="#"> <View.Text> "Terms" </View.Text> </a>
            <a class="hover:text-ink" href="#"> <View.Text> "Status" </View.Text> </a>
          </div>
        </div>
      </footer>
    </div>
  }
}

// ---------------------------------------------------------------- Dashboard --
module Dashboard = {
  @jsx.component
  let make = () => {
    let navItem = (label, active) =>
      <a
        href="#"
        class={"block rounded-lg px-3 py-1.5 text-sm transition-colors " ++ (active ? "bg-action text-on-action" : "text-muted hover:bg-action-subtle hover:text-ink")}>
        <View.Text> label </View.Text>
      </a>
    let stat = (label, value, delta) =>
      <div class="rounded-2xl border border-border bg-surface p-4 shadow-sm">
        <p class="text-xs text-muted"> <View.Text> label </View.Text> </p>
        <p class="mt-1 text-2xl font-bold text-ink"> <View.Text> value </View.Text> </p>
        <p class="mt-1 text-xs text-muted"> <View.Text> delta </View.Text> </p>
      </div>
    let bars = [50, 72, 40, 88, 63, 45, 70, 58]
    let people = [
      ("Ada Lovelace", "Owner", "Active"),
      ("Alan Turing", "Member", "Invited"),
      ("Grace Hopper", "Admin", "Active"),
    ]
    <div class="flex bg-paper text-ink">
      // sidebar
      <aside class="hidden w-48 shrink-0 border-r border-border bg-surface p-3 sm:block">
        <div class="mb-4 flex items-center gap-2 px-1">
          <span class="flex size-6 items-center justify-center rounded-md bg-action text-[10px] font-bold text-on-action"> <View.Text> "A" </View.Text> </span>
          <span class="text-sm font-semibold"> <View.Text> "Acme" </View.Text> </span>
        </div>
        <nav class="space-y-0.5">
          {navItem("Overview", true)} {navItem("Customers", false)} {navItem("Reports", false)} {navItem("Settings", false)}
        </nav>
      </aside>
      // main
      <div class="min-w-0 flex-1">
        <header class="flex items-center justify-between border-b border-border bg-surface px-5 py-3">
          <div>
            <p class="text-sm font-semibold"> <View.Text> "Overview" </View.Text> </p>
            <p class="text-xs text-muted"> <View.Text> "Last 7 days" </View.Text> </p>
          </div>
          <div class="flex items-center gap-3">
            <span class="hidden rounded-lg border border-border bg-paper px-3 py-1.5 text-sm text-muted sm:inline-block"> <View.Text> "Search…" </View.Text> </span>
            <Avatar initials="YO" size="size-8 text-xs" />
          </div>
        </header>
        <div class="space-y-4 p-5">
          <div class="grid grid-cols-3 gap-4">
            {stat("Revenue", "$48.2k", "+12% MoM")}
            {stat("Active users", "3,190", "+4% MoM")}
            {stat("Churn", "1.8%", "−0.3% MoM")}
          </div>
          <div class="rounded-2xl border border-border bg-surface p-4 shadow-sm">
            <div class="mb-3 flex items-center justify-between">
              <p class="text-sm font-medium"> <View.Text> "Signups this week" </View.Text> </p>
              <Badge variant=#soft> <View.Text> "Live" </View.Text> </Badge>
            </div>
            <div class="flex h-28 items-end gap-2">
              <View.For each={Prop.static(bars)} render={v => <div class="flex-1 rounded-t bg-action" style={"height:" ++ Int.toString(v) ++ "%"} />} />
            </div>
          </div>
          <div class="overflow-hidden rounded-2xl border border-border bg-surface shadow-sm">
            <table class="w-full text-sm">
              <thead class="bg-paper text-left text-xs uppercase tracking-wide text-muted">
                <tr>
                  <th class="px-4 py-2 font-medium"> <View.Text> "Name" </View.Text> </th>
                  <th class="px-4 py-2 font-medium"> <View.Text> "Role" </View.Text> </th>
                  <th class="px-4 py-2 font-medium"> <View.Text> "Status" </View.Text> </th>
                </tr>
              </thead>
              <tbody class="divide-y divide-border">
                <View.For
                  each={Prop.static(people)}
                  render={p => {
                    let (name, role, status) = p
                    <tr>
                      <td class="px-4 py-2.5 font-medium"> <View.Text> name </View.Text> </td>
                      <td class="px-4 py-2.5 text-muted"> <View.Text> role </View.Text> </td>
                      <td class="px-4 py-2.5">
                        {status == "Active"
                          ? <Badge variant=#soft> <View.Text> status </View.Text> </Badge>
                          : <Badge variant=#outline> <View.Text> status </View.Text> </Badge>}
                      </td>
                    </tr>
                  }}
                />
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  }
}

// --------------------------------------------------------------------- Auth --
module Auth = {
  @jsx.component
  let make = () => {
    let remember = Signal.make(true)
    <div class="hero-wash flex items-center justify-center bg-paper px-6 py-14 text-ink">
      <div class="w-full max-w-sm space-y-5 rounded-2xl border border-border bg-surface p-6 shadow-md">
        <div class="text-center">
          <div class="mx-auto mb-2 flex size-9 items-center justify-center rounded-lg bg-action text-sm font-bold text-on-action"> <View.Text> "A" </View.Text> </div>
          <h3 class="text-lg font-semibold"> <View.Text> "Welcome back" </View.Text> </h3>
          <p class="text-sm text-muted"> <View.Text> "Sign in to your Acme account" </View.Text> </p>
        </div>
        <Field label="Email" for_="sc-email"> <Input id="sc-email" type_="email" placeholder="you@example.com" /> </Field>
        <Field label="Password" for_="sc-pass"> <Input id="sc-pass" type_="password" placeholder="••••••••" /> </Field>
        <div class="flex items-center justify-between text-sm">
          <Switch on={remember} label="Remember me" />
          <Link href="#"> <View.Text> "Forgot?" </View.Text> </Link>
        </div>
        <Button extraClass="w-full"> <View.Text> "Sign in" </View.Text> </Button>
        <p class="text-center text-sm text-muted">
          <View.Text> "No account? " </View.Text>
          <Link href="#"> <View.Text> "Create one" </View.Text> </Link>
        </p>
      </div>
    </div>
  }
}

// ----------------------------------------------------------------- Settings --
module SettingsPage = {
  @jsx.component
  let make = () => {
    let tz = Signal.make("UTC · GMT+0")
    let role = Signal.make("Admin")
    let productN = Signal.make(true)
    let pushN = Signal.make(false)
    let weekly = Signal.make(true)
    let nav = (label, active) =>
      <a
        href="#"
        class={"block rounded-lg px-3 py-1.5 text-sm transition-colors " ++ (active ? "bg-action text-on-action" : "text-muted hover:bg-action-subtle hover:text-ink")}>
        <View.Text> label </View.Text>
      </a>
    let toggle = (title, desc, sig) =>
      <div class="flex items-center justify-between gap-4">
        <div>
          <p class="text-sm font-medium text-ink"> <View.Text> title </View.Text> </p>
          <p class="text-xs text-muted"> <View.Text> desc </View.Text> </p>
        </div>
        <Switch on={sig} />
      </div>
    <div class="bg-paper text-ink">
      <header class="border-b border-border bg-surface px-6 py-4">
        <h1 class="text-lg font-semibold"> <View.Text> "Settings" </View.Text> </h1>
        <p class="text-xs text-muted"> <View.Text> "Manage your profile and preferences" </View.Text> </p>
      </header>
      <div class="mx-auto grid max-w-3xl gap-8 px-6 py-8 sm:grid-cols-[11rem_1fr]">
        <nav class="space-y-0.5">
          {nav("Profile", true)} {nav("Account", false)} {nav("Notifications", false)} {nav("Billing", false)}
        </nav>
        <div class="space-y-6">
          <div class="flex items-center gap-4">
            <Avatar initials="AL" size="size-14 text-lg" />
            <Button variant=#secondary size=#sm> <View.Text> "Change photo" </View.Text> </Button>
          </div>
          <Field label="Display name" for_="st-name"> <Input id="st-name" value="Ada Lovelace" /> </Field>
          <Field label="Email" for_="st-email"> <Input id="st-email" type_="email" value="ada@acme.com" /> </Field>
          <div class="grid gap-4 sm:grid-cols-2">
            <div>
              <label class="mb-1.5 block text-sm font-medium text-ink"> <View.Text> "Timezone" </View.Text> </label>
              <Select value={tz} options=["UTC · GMT+0", "CET · GMT+1", "EST · GMT−5", "PST · GMT−8"] />
            </div>
            <div>
              <label class="mb-1.5 block text-sm font-medium text-ink"> <View.Text> "Role" </View.Text> </label>
              <Select value={role} options=["Admin", "Member", "Viewer"] />
            </div>
          </div>
          <Separator />
          <div class="space-y-4">
            <h2 class="text-sm font-semibold text-ink"> <View.Text> "Notifications" </View.Text> </h2>
            {toggle("Product updates", "News about features and releases.", productN)}
            {toggle("Push notifications", "Get notified on your devices.", pushN)}
            {toggle("Weekly digest", "A summary of activity every Monday.", weekly)}
          </div>
          <div class="flex justify-end gap-2 border-t border-border pt-4">
            <Button variant=#ghost> <View.Text> "Cancel" </View.Text> </Button>
            <Button> <View.Text> "Save changes" </View.Text> </Button>
          </div>
        </div>
      </div>
    </div>
  }
}

// ----------------------------------------------------------------- Checkout --
module Checkout = {
  @jsx.component
  let make = () => {
    let items = [
      ("Pro plan · annual", "$120.00"),
      ("Priority support", "$40.00"),
      ("Extra seats (2)", "$24.00"),
    ]
    <div class="bg-paper text-ink">
      <header class="border-b border-border bg-surface px-6 py-4">
        <div class="mx-auto flex max-w-4xl items-center gap-2">
          <span class="flex size-6 items-center justify-center rounded-md bg-action text-[10px] font-bold text-on-action"> <View.Text> "A" </View.Text> </span>
          <span class="text-sm font-semibold"> <View.Text> "Acme Checkout" </View.Text> </span>
        </div>
      </header>
      <div class="mx-auto grid max-w-4xl gap-8 px-6 py-8 lg:grid-cols-[1fr_20rem]">
        <div class="space-y-6">
          <div class="space-y-4">
            <h2 class="text-sm font-semibold"> <View.Text> "Contact" </View.Text> </h2>
            <Field label="Email" for_="co-email"> <Input id="co-email" type_="email" placeholder="you@example.com" /> </Field>
          </div>
          <div class="space-y-4">
            <h2 class="text-sm font-semibold"> <View.Text> "Payment" </View.Text> </h2>
            <Field label="Card number" for_="co-card"> <Input id="co-card" placeholder="1234 5678 9012 3456" /> </Field>
            <div class="grid grid-cols-2 gap-4">
              <Field label="Expiry" for_="co-exp"> <Input id="co-exp" placeholder="MM / YY" /> </Field>
              <Field label="CVC" for_="co-cvc"> <Input id="co-cvc" placeholder="123" /> </Field>
            </div>
            <Field label="Name on card" for_="co-name"> <Input id="co-name" placeholder="Ada Lovelace" /> </Field>
          </div>
        </div>
        <aside class="h-fit rounded-2xl border border-border bg-surface p-5 shadow-sm">
          <h2 class="text-sm font-semibold"> <View.Text> "Order summary" </View.Text> </h2>
          <ul class="mt-3 space-y-2 text-sm">
            <View.For
              each={Prop.static(items)}
              render={it => {
                let (name, price) = it
                <li class="flex justify-between gap-3">
                  <span class="text-muted"> <View.Text> name </View.Text> </span>
                  <span class="text-ink"> <View.Text> price </View.Text> </span>
                </li>
              }}
            />
          </ul>
          <div class="mt-3 flex items-center gap-2">
            <Badge variant=#soft> <View.Text> "SAVE20" </View.Text> </Badge>
            <span class="text-xs text-muted"> <View.Text> "−$20.00 applied" </View.Text> </span>
          </div>
          <Separator extraClass="my-4" />
          <div class="flex items-center justify-between">
            <span class="text-sm text-muted"> <View.Text> "Total" </View.Text> </span>
            <span class="text-lg font-bold text-ink"> <View.Text> "$164.00" </View.Text> </span>
          </div>
          <Button extraClass="mt-4 w-full"> <View.Text> "Pay $164.00" </View.Text> </Button>
          <p class="mt-2 flex items-center justify-center gap-1 text-center text-xs text-muted">
          <Icon name="lock" size=#xs />
          <View.Text> "Secured by Acme Pay" </View.Text> </p>
        </aside>
      </div>
    </div>
  }
}

// ------------------------------------------------------------------ Article --
module Article = {
  @jsx.component
  let make = () => {
    let tab = Signal.make("guide")
    let faq = Signal.make(["ship"])
    let isGuide = Computed.make(() => Signal.get(tab) == "guide")
    let isChangelog = Computed.make(() => Signal.get(tab) == "changelog")
    <div class="bg-paper text-ink">
      <div class="mx-auto max-w-2xl px-6 py-10">
        <Badge variant=#outline> <View.Text> "Guide" </View.Text> </Badge>
        <h1 class="mt-4 text-3xl font-bold tracking-tight"> <View.Text> "Getting started with Acme" </View.Text> </h1>
        <div class="mt-3 flex items-center gap-3 text-sm">
          <Avatar initials="GH" size="size-8 text-xs" />
          <span class="font-medium"> <View.Text> "Grace Hopper" </View.Text> </span>
          <span class="text-muted"> <View.Text> "· Jul 18, 2026 · 5 min read" </View.Text> </span>
        </div>
        <div class="mt-6"> <Tabs value={tab} tabs=[("guide", "Guide"), ("changelog", "Changelog")] /> </div>
        <View.Show when_={Prop.signal(isGuide)}>
          <div class="mt-6 space-y-4 text-[15px] leading-relaxed text-neutral-700">
            <p> <View.Text> "Acme takes you from idea to production without the busywork. This guide covers the core concepts and the fastest path to your first deploy." </View.Text> </p>
            <Alert variant=#info title="Before you begin" description="You'll need a free account and the Acme CLI installed." />
            <p> <View.Text> "Install the CLI, authenticate, and initialize your first project. Everything ships with sensible defaults you can override later." </View.Text> </p>
          </div>
        </View.Show>
        <View.Show when_={Prop.signal(isChangelog)}>
          <div class="mt-6 space-y-3 text-[15px] leading-relaxed text-neutral-700">
            <p> <span class="font-semibold text-ink"> <View.Text> "v2.1 " </View.Text> </span> <View.Text> "— Faster builds and a redesigned dashboard." </View.Text> </p>
            <p> <span class="font-semibold text-ink"> <View.Text> "v2.0 " </View.Text> </span> <View.Text> "— New pricing, SSO, and audit logs." </View.Text> </p>
          </div>
        </View.Show>
        <h2 class="mt-10 text-lg font-semibold"> <View.Text> "FAQ" </View.Text> </h2>
        <div class="mt-3">
          <Accordion
            value={faq}
            items=[
              ("ship", "How fast can I ship?", "Most teams deploy their first project within an hour."),
              ("cancel", "Can I cancel anytime?", "Yes — one click, no questions asked."),
              ("stack", "Does it work with my stack?", "Acme is framework-agnostic and integrates with common CI providers."),
            ]
          />
        </div>
        <Separator extraClass="my-8" />
        <p class="text-sm text-muted">
          <View.Text> "Related: " </View.Text>
          <Link href="#"> <View.Text> "CLI reference" </View.Text> </Link>
          <View.Text> " · " </View.Text>
          <Link href="#"> <View.Text> "Deploy guide" </View.Text> </Link>
        </p>
      </div>
    </div>
  }
}

// A showcase entry: title, one-liner, the parts it's composed from, and the mock.
module Entry = {
  @jsx.component
  let make = (~title: string, ~desc: string, ~url: string, ~ids: array<string>, ~render: unit => View.node) =>
    <section class="mt-12">
      <h2 class="text-xl font-semibold tracking-tight text-ink"> <View.Text> title </View.Text> </h2>
      <p class="mt-1 max-w-2xl text-sm text-muted"> <View.Text> desc </View.Text> </p>
      <div class="mt-3 flex flex-wrap items-center gap-1.5">
        <span class="mr-1 text-xs font-medium uppercase tracking-wide text-neutral-400"> <View.Text> "Composed from" </View.Text> </span>
        <View.For each={Prop.static(ids)} render={id => <Chip id />} />
      </div>
      <div class="mt-4"> <Frame label={url} render /> </div>
    </section>
}

@jsx.component
let make = () =>
  <div class="mx-auto max-w-5xl px-5 py-12 sm:px-8">
    <Badge variant=#outline> <View.Text> "Examples" </View.Text> </Badge>
    <h1 class="mt-4 text-4xl font-bold tracking-tight text-ink sm:text-5xl"> <View.Text> "Composed in the wild" </View.Text> </h1>
    <p class="mt-4 max-w-2xl text-lg leading-relaxed text-muted">
      <View.Text> "Full pages assembled entirely from the spec components — the same reusable pieces documented in the catalogue. Open the " </View.Text>
      <button
        class="text-ink underline decoration-neutral-300 underline-offset-4 hover:decoration-neutral-900"
        onClick={_ => Settings.open_->Signal.set(true)}>
        <View.Text> "theme settings" </View.Text>
      </button>
      <View.Text> " and watch every mock re-skin live, or open any one fullscreen. Nothing here is hardcoded — it all reads the design tokens." </View.Text>
    </p>

    <Entry
      title="Marketing landing page"
      desc="A conversion page: identity and nav, a hero, a feature grid, social proof, pricing, a call to action, and a footer."
      url="acme.com"
      ids=["navbar", "hero", "feature-grid", "testimonial", "pricing-table", "cta-section", "footer", "button", "badge", "avatar"]
      render={() => <Landing />}
    />

    <Entry
      title="Application dashboard"
      desc="A signed-in surface: a sidebar, a top bar, a row of stats, a chart, and a data table of teammates."
      url="app.acme.com/overview"
      ids=["sidebar", "navbar", "stat", "chart", "data-table", "avatar", "badge"]
      render={() => <Dashboard />}
    />

    <Entry
      title="Account settings"
      desc="A profile and preferences screen: section nav, avatar, form fields, selects, and notification toggles."
      url="app.acme.com/settings"
      ids=["settings", "field", "input", "select", "switch", "separator", "avatar", "button"]
      render={() => <SettingsPage />}
    />

    <Entry
      title="Checkout"
      desc="A payment flow: contact and card fields beside a live order summary with a discount and total."
      url="acme.com/checkout"
      ids=["checkout", "field", "input", "badge", "separator", "button"]
      render={() => <Checkout />}
    />

    <Entry
      title="Docs article"
      desc="A content page: title and byline, tabs, a callout, an FAQ accordion, and related links."
      url="docs.acme.com/guide"
      ids=["typography", "tabs", "alert", "accordion", "link", "avatar", "badge"]
      render={() => <Article />}
    />

    <Entry
      title="Sign in"
      desc="A focused authentication screen built from the form primitives."
      url="acme.com/login"
      ids=["sign-in", "field", "input", "switch", "button", "link"]
      render={() => <Auth />}
    />
  </div>
