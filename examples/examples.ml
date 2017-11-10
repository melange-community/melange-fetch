let _ =
  Js.Promise.(Fetch.(
    fetch "/api/hellos/1"
    |> then_ Response.text
    |> then_ (fun text -> print_endline text |> resolve)
  ))

let _ =
  Js.Promise.(Fetch.(
    fetchWithInit "/api/hello" (RequestInit.make ~_method:Method.post ())
    |> then_ Response.text
    |> then_ (fun text -> print_endline text |> resolve)
  ))

let _ =
  Js.Promise.(Fetch.(
    fetch "/api/fruit"
    (* assume server returns `["apple", "banana", "pear", ...]` *)
    |> then_ Response.json
    |> then_ (fun json -> Js.Json.decodeArray json |> resolve)
    |> then_ (fun opt -> Js.Option.getExn opt |> resolve)
    |> then_ (fun items ->
        items |> Js.Array.map (fun item ->
                    item |> Js.Json.decodeString
                         |> Js.Option.getExn)
              |> resolve)
  ))
