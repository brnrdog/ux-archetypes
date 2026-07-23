[@@@warning "-a"]

(* Icon — renders a named glyph from [Icons] as inline SVG. Color and weight are
   inherited from the surrounding text (stroke=currentColor), so an icon sits
   naturally beside a label. [size] maps to the optical size scale; pass [label]
   to give a meaningful icon an accessible name — omit it and the icon is
   treated as decorative and hidden from assistive tech.

   reativa's View layer creates nodes with [document.createElement] (HTML
   namespace), which can't produce a rendering [<svg>]; so the glyph is injected
   as [innerHTML] on a host [<span>] (see [Ui.set_inner_html_by_id]), which the
   browser parses in the SVG namespace and which still inherits [currentColor].
   Callers use it as a plain function: [Icon.make ~name:"check" ()].

   The host span is built inside a [View.dyn] region so the innerHTML is
   scheduled at *insert* time (with a fresh id) rather than at build time — an
   icon inside an initially-hidden region (e.g. a Newsletter success state) then
   still gets its markup when the region is first shown. *)

open Reativa

(* Fresh host ids so multiple icons of the same name never collide. *)
let counter = ref 0

let make ?(size : Contracts.Icon.size = `md) ?(label = "") ?(extra_class = "") ~name () =
  let dims =
    match size with
    | `xs -> "size-3"
    | `sm -> "size-4"
    | `md -> "size-5"
    | `lg -> "size-6"
    | `xl -> "size-8"
  in
  let body = match Icons.get name with Some b -> b | None -> [] in
  let meaningful = label <> "" in
  (* Meaningful icons expose an img role + accessible name; decorative ones are
     hidden so assistive tech doesn't announce them beside their label. *)
  let role_attrs =
    if meaningful then "role=\"img\" aria-label=\"" ^ label ^ "\"" else "aria-hidden=\"true\""
  in
  let extra = if extra_class = "" then "" else " " ^ extra_class in
  let markup = Icons.svg ~dims ~extra ~role_attrs body in
  View.dyn (fun () ->
      incr counter;
      let id = "prescriptive-reativa-icon-" ^ string_of_int !counter in
      Ui.set_inner_html_by_id id markup;
      View.element ~attrs:[ View.Attr.id (View.static id) ] "span" [])