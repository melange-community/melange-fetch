open Bs_fetch

module Option = struct
  let unwrapUnsafely = function
    | Some v -> v
    | None -> raise (Invalid_argument "unwrapUnsafely called on None");  
end

let _ =
  Js.Promise.(
    fetch "/api/hellos/1"
    |> then_ Response.text
    |> then_ (fun text -> print_endline text |> resolve)
  )

let _ =
  Js.Promise.(
    fetchWithInit "/api/hello" (RequestInit.make ~method_:Post ())
    |> then_ Response.text
    |> then_ (fun text -> print_endline text |> resolve)
  )

let _ =
  Js.Promise.(
    fetch "/api/fruit"
    (* assume server returns `["apple", "banana", "pear", ...]` *)
    |> then_ Response.json
    |> then_ (fun json -> Js.Json.decodeArray json |> resolve)
    |> then_ (fun opt -> Option.unwrapUnsafely opt |> resolve)
    |> then_ (fun items ->
        items |> Js.Array.map (fun item ->
                    item |> Js.Json.decodeString
                         |> Option.unwrapUnsafely)
              |> resolve)
  )
