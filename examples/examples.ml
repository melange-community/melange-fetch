open Bs_fetch

module Promise = struct
  type ('a, 'e) t = ('a, 'e) Js.promise

  external andThen : ('a -> ('b, 'f) t) -> ('b, 'f) t = "then" [@@bs.send.pipe: ('a, 'e) t]
  external then_ : ('a -> 'b) -> ('b, 'f) t = "then" [@@bs.send.pipe: ('a, 'e) t]
end

module Option = struct
  let unwrapUnsafely = function
    | Some v -> v
    | None -> raise (Invalid_argument "unwrapUnsafely called on None");  
end

let _ =
  Promise.(
    fetch "/api/hellos/1"
    |> andThen Response.text
    |> then_ print_endline
  )

let _ =
  Promise.(
    fetchWithInit "/api/hello" (RequestInit.make ~method_:Post ())
    |> andThen Response.text
    |> then_ print_endline
  )

let _ =
  Promise.(
    fetch "/api/fruit"
    (* assume server returns `["apple", "banana", "pear", ...]` *)
    |> andThen Response.json
    |> then_ Js.Json.arrayOfJSON
    |> then_ Option.unwrapUnsafely
    |> then_ (Js.Array.map
        (fun item ->
          item |> Js.Json.stringOfJSON |> Option.unwrapUnsafely))
  )