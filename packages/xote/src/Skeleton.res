// Skeleton — a pulsing placeholder block that mirrors content while it loads.
// Compose several to sketch a layout. Implements the `skeleton` spec.
@jsx.component
let make = (~shape: Contracts.Skeleton.shape=#text, ~extraClass: string="") => {
  let shapeCls = switch shape {
  | #text => "h-3 rounded"
  | #circle => "rounded-full"
  | #rect => "rounded-lg"
  }
  <div class={"animate-pulse bg-neutral-200 " ++ shapeCls ++ (extraClass == "" ? "" : " " ++ extraClass)} />
}
