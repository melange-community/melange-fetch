module Next = struct
  type 'a t

  external done_ : _ t -> bool option = "done" [@@bs.get]
  external value : 'a t -> 'a option = "value" [@@bs.get] [@@bs.return nullable]
end

type 'a t

external next : 'a t -> 'a Next.t = "next" [@@bs.send]

let rec forEach ~f t =
  let item = next t in
  match Next.(done_ item, value item) with
  | Some true, Some value -> f value [@bs]
  | Some true, None -> ()
  | (Some false | None), Some value ->
    f value [@bs];
    forEach ~f t
  | (Some false | None), None -> forEach ~f t
