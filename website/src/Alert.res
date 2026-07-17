// Alert — an inline message drawing attention to contextual information. The
// `variant` type comes from the archetype's `## API` contract (Contracts.res),
// so the compiler enforces the spec's allowed severities. Monochrome baseline:
// severity is conveyed by fill weight, not hue.
@jsx.component
let make = (
  ~variant: Contracts.Alert.variant=#info,
  ~title: string,
  ~description: string,
  ~icon: string="",
) => {
  // Severity comes from the semantic status roles; the surface stays neutral so
  // editing a status token recolors just the border + icon.
  let border = switch variant {
  | #info => "border-border"
  | #success => "border-status-success"
  | #warning => "border-status-warning"
  | #danger => "border-status-danger"
  }
  let iconColor = switch variant {
  | #info => "text-muted"
  | #success => "text-status-success"
  | #warning => "text-status-warning"
  | #danger => "text-status-danger"
  }
  <div role="alert" class={"flex gap-3 rounded-lg border bg-surface p-4 text-sm text-ink " ++ border}>
    <View.Show when_={Prop.static(icon != "")}>
      <span class={"font-semibold " ++ iconColor}> <View.Text> icon </View.Text> </span>
    </View.Show>
    <div>
      <p class="font-medium text-ink"> <View.Text> title </View.Text> </p>
      <p class="text-muted"> <View.Text> description </View.Text> </p>
    </div>
  </div>
}
