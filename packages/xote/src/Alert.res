// Alert — an inline message drawing attention to contextual information. The
// `variant` type comes from the spec's `## API` contract (Contracts.res),
// so the compiler enforces the spec's allowed severities. Severity is conveyed
// by the semantic status hues (and the glyph, so color is never the only cue).
@jsx.component
let make = (
  ~variant: Contracts.Alert.variant=#info,
  ~title: string,
  ~description: string,
  ~icon: string="",
) => {
  // A per-variant default glyph, used when no explicit `icon` name is given.
  let iconName = icon == ""
    ? switch variant {
      | #info => "info"
      | #success => "check-circle"
      | #warning => "alert-triangle"
      | #danger => "alert-circle"
      }
    : icon
  // Severity comes from the semantic status roles; the surface stays neutral so
  // editing a status token recolors just the border + icon.
  let border = switch variant {
  | #info => "border-status-info"
  | #success => "border-status-success"
  | #warning => "border-status-warning"
  | #danger => "border-status-danger"
  }
  let iconColor = switch variant {
  | #info => "text-status-info"
  | #success => "text-status-success"
  | #warning => "text-status-warning"
  | #danger => "text-status-danger"
  }
  <div role="alert" class={"flex gap-3 rounded-lg border bg-surface p-4 text-sm text-ink " ++ border}>
    <span class={"mt-0.5 " ++ iconColor}> <Icon name=iconName /> </span>
    <div>
      <p class="font-medium text-ink"> <View.Text> title </View.Text> </p>
      <p class="text-muted"> <View.Text> description </View.Text> </p>
    </div>
  </div>
}
