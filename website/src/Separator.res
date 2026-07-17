// Separator — a hairline divider, horizontal or vertical. Reused by menus, cards,
// and toolbars.
@jsx.component
let make = (~orientation: Contracts.Separator.orientation=#horizontal, ~extraClass: string="") => {
  let base = switch orientation {
  | #horizontal => "h-px w-full bg-neutral-200"
  | #vertical => "h-4 w-px bg-neutral-200"
  }
  <div class={base ++ (extraClass == "" ? "" : " " ++ extraClass)} role="separator" />
}
