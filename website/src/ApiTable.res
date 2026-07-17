// Renders an archetype's machine-readable `## API` contract: the prop table,
// slots, accessibility expectations, states, and token roles. The same contract
// drives the generated prop types (Contracts.res) and the conformance check, so
// what you read here is provably what the implementation exposes.

module Section = {
  @jsx.component
  let make = (~title: string, ~children: View.node) =>
    <div class="mt-6">
      <h3 class="text-xs font-semibold uppercase tracking-wide text-neutral-500">
        <View.Text> title </View.Text>
      </h3>
      <div class="mt-2"> {children} </div>
    </div>
}

let code = (v: string) =>
  <code
    class="rounded bg-neutral-100 px-1.5 py-0.5 font-mono text-xs text-neutral-800">
    <View.Text> v </View.Text>
  </code>

@jsx.component
let make = (~api: ArchetypesData.apiContract) =>
  <section class="mt-10 rounded-2xl border border-neutral-200 bg-surface p-6">
    <div class="flex items-center gap-2">
      <h2 class="text-lg font-semibold tracking-tight text-neutral-900">
        <View.Text> "API" </View.Text>
      </h2>
      <Badge variant=#outline> <View.Text> "contract" </View.Text> </Badge>
    </div>
    <p class="mt-1 text-sm text-neutral-500">
      <View.Text>
        "The skin-agnostic interface. Prop types are generated from this block and the implementation is checked against it."
      </View.Text>
    </p>

    <View.Show when_={Prop.static(Array.length(api.props) > 0)}>
      <Section title="Props">
        <div class="overflow-x-auto">
          <table class="w-full border-collapse text-sm">
            <thead>
              <tr class="border-b border-neutral-200 text-left text-xs uppercase tracking-wide text-neutral-400">
                <th class="py-2 pr-4 font-medium"> <View.Text> "Name" </View.Text> </th>
                <th class="py-2 pr-4 font-medium"> <View.Text> "Type" </View.Text> </th>
                <th class="py-2 pr-4 font-medium"> <View.Text> "Default" </View.Text> </th>
                <th class="py-2 font-medium"> <View.Text> "Description" </View.Text> </th>
              </tr>
            </thead>
            <tbody>
              <View.For
                each={Prop.static(api.props)}
                render={p =>
                  <tr class="border-b border-neutral-100 align-top">
                    <td class="py-2 pr-4"> {code(p.name)} </td>
                    <td class="py-2 pr-4">
                      {switch p.type_ {
                      | "enum" =>
                        <span class="flex flex-wrap gap-1">
                          <View.For
                            each={Prop.static(p.values)}
                            render={v =>
                              <Badge variant=#soft> <View.Text> v </View.Text> </Badge>}
                          />
                        </span>
                      | other => code(other)
                      }}
                    </td>
                    <td class="py-2 pr-4">
                      <View.Show
                        when_={Prop.static(p.default != "")} fallback={View.text("—")}>
                        {code(p.default)}
                      </View.Show>
                    </td>
                    <td class="py-2 text-neutral-600">
                      <View.Text> {p.description} </View.Text>
                    </td>
                  </tr>}
              />
            </tbody>
          </table>
        </div>
      </Section>
    </View.Show>

    <View.Show when_={Prop.static(Array.length(api.slots) > 0)}>
      <Section title="Slots">
        <ul class="space-y-1 text-sm">
          <View.For
            each={Prop.static(api.slots)}
            render={sl =>
              <li class="flex flex-wrap items-baseline gap-2">
                {code(sl.name)}
                <View.Show when_={Prop.static(sl.required)}>
                  <span class="text-xs font-medium text-neutral-500">
                    <View.Text> "required" </View.Text>
                  </span>
                </View.Show>
                <span class="text-neutral-600">
                  <View.Text> {sl.description} </View.Text>
                </span>
              </li>}
          />
        </ul>
      </Section>
    </View.Show>

    <div class="grid gap-6 sm:grid-cols-2">
      <View.Show when_={Prop.static(api.role != "" || Array.length(api.keyboard) > 0)}>
        <Section title="Accessibility">
          <ul class="space-y-1.5 text-sm text-neutral-600">
            <View.Show when_={Prop.static(api.role != "")}>
              <li class="flex items-center gap-2">
                <span class="text-neutral-400"> <View.Text> "role" </View.Text> </span>
                {code(api.role)}
              </li>
            </View.Show>
            <View.Show when_={Prop.static(Array.length(api.keyboard) > 0)}>
              <li class="flex flex-wrap items-center gap-1.5">
                <span class="text-neutral-400"> <View.Text> "keys" </View.Text> </span>
                <View.For
                  each={Prop.static(api.keyboard)}
                  render={k => <Kbd> <View.Text> k </View.Text> </Kbd>}
                />
              </li>
            </View.Show>
            <View.Show when_={Prop.static(Array.length(api.announces) > 0)}>
              <li class="flex flex-wrap items-center gap-1.5">
                <span class="text-neutral-400"> <View.Text> "announces" </View.Text> </span>
                <View.For
                  each={Prop.static(api.announces)}
                  render={a => code(a)}
                />
              </li>
            </View.Show>
          </ul>
        </Section>
      </View.Show>

      <View.Show when_={Prop.static(Array.length(api.states) > 0)}>
        <Section title="States">
          <div class="flex flex-wrap gap-1.5">
            <View.For
              each={Prop.static(api.states)}
              render={st => <Badge variant=#outline> <View.Text> st </View.Text> </Badge>}
            />
          </div>
        </Section>
      </View.Show>
    </div>

    <View.Show when_={Prop.static(Array.length(api.tokens) > 0)}>
      <Section title="Tokens">
        <div class="flex flex-wrap gap-1.5">
          <View.For
            each={Prop.static(api.tokens)}
            render={t => code(t)}
          />
        </div>
      </Section>
    </View.Show>
  </section>
