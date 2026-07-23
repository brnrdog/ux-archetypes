[@@@warning "-a"]

(* Shared monochrome design tokens (Tailwind class strings) and small DOM
   helpers used across the reativa example implementations — the OCaml
   counterpart of @prescriptive/xote's [Ui] module.

   The class strings are the same token-driven Tailwind utilities the Xote
   components use (bg-action, text-on-action, border-status-*, …) so editing a
   token re-themes both implementations identically. *)

open Reativa

(* ----- DOM helpers (Melange FFI) ----- *)

(* window.setTimeout — used to defer property writes to freshly-rendered nodes
   (indeterminate, innerHTML) a tick, so the node exists when we look it up. *)
external set_timeout : (unit -> unit) -> int -> unit = "setTimeout"

(* Read the [checked] property off an event's target (checkbox / radio). *)
external checked_of : Dom.t -> bool = "checked" [@@mel.get]
let checked (ev : Dom.event) : bool = checked_of (Dom.target ev)

(* Read the current value of an input/textarea/select from a DOM event. *)
let input_value (ev : Dom.event) : string = Dom.target_value ev

(* [indeterminate] has no HTML attribute — it is property-only, so it can't be
   expressed as a JSX/attribute and is set on the node after render. *)
external set_indeterminate : Dom.t -> bool -> unit = "indeterminate" [@@mel.set]

let set_indeterminate_by_id id v =
  set_timeout
    (fun () -> match Dom.by_id id with Some el -> set_indeterminate el v | None -> ())
    0

(* Inline SVG has to be injected as markup: reativa's [Dom.create_element] uses
   [document.createElement] (HTML namespace), so an [<svg>] built through the
   View layer would not render. Icons set their markup via [innerHTML] on a host
   [<span>] instead, which the browser parses in the SVG namespace and which
   still inherits [currentColor] from the surrounding text. *)
external set_inner_html : Dom.t -> string -> unit = "innerHTML" [@@mel.set]

let set_inner_html_by_id id html =
  set_timeout
    (fun () -> match Dom.by_id id with Some el -> set_inner_html el html | None -> ())
    0

(* preventDefault, for form submit handlers. *)
let prevent_default = Dom.prevent_default

(* ----- Buttons ----- *)
(* Composed from the semantic color roles (bg-action, text-on-action,
   bg-status-danger, …) so editing those tokens re-themes every control. Split
   into layout core, size, and color so the Button element composes variant ×
   size. *)
let btn_core =
  "inline-flex items-center justify-center rounded-lg font-medium transition-colors \
   focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-action \
   focus-visible:ring-offset-2 focus-visible:ring-offset-surface \
   disabled:opacity-40 disabled:pointer-events-none"
let btn_lg = "gap-2 px-5 py-2.5 text-base"
let btn_md = "gap-2 px-4 py-2 text-sm"
let btn_sm = "gap-1 px-2.5 py-1 text-xs"
let btn_primary_colors = "bg-action text-on-action hover:bg-action-hover"
let btn_secondary_colors = "border border-border bg-surface text-ink hover:bg-action-subtle"
let btn_ghost_colors = "text-ink hover:bg-action-subtle"
let btn_destructive_colors = "bg-status-danger text-on-action hover:opacity-90"

(* ----- Surfaces ----- *)
let card = "rounded-2xl border border-border bg-surface shadow-sm"
let input_base =
  "w-full rounded-lg border border-border bg-surface px-3 py-2 text-sm text-ink \
   placeholder:text-muted focus-visible:outline-none focus-visible:ring-2 \
   focus-visible:ring-action focus-visible:ring-offset-0"
let label = "block text-sm font-medium text-ink"
let muted = "text-muted"

(* Append an extra class string only when non-empty (mirrors the Xote helper). *)
let cx base extra = if extra = "" then base else base ^ " " ^ extra