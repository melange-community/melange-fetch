# Bindings to fetch for [BuckleScript](https://github.com/bucklescript/bucklescript).

## Example

```ml
(* OCaml *)
let _ =
  Js.Promise.(
    fetch "/api/hellos/1"
    |> then_ Response.text
    |> then_ (fun text -> print_endline text |> resolve)
  )
```

```reason
/* Reason */
Js.Promise.(
  fetch "/api/hellos/1"
  |> then_ Response.text
  |> then_ (fun text => print_endline text |> resolve)
);
```

## Installation

```sh
npm install --save bs-fetch
```

Then add `bs-fetch` to `bs-dependencies` in your `bsconfig.json`:
```js
{
  ...
  "bs-dependencies": ["bs-fetch"]
}
```

## Usage
See usage examples in [`examples/examples.ml`](https://github.com/reasonml-community/bs-fetch/blob/master/examples/examples.ml). The source is a [single file](https://github.com/reasonml-community/bs-fetch/blob/master/src/bs_fetch.ml)!

## Changes

### 0.2.0
* Rename `Bs_fetch` module to `Fetch`. `Bs_fetch` is kept around as an alias for backwards compatibility, but should be considered deprecated.
