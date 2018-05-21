# bs-fetch

Low-level bindings to fetch for [BuckleScript](https://github.com/bucklescript/bucklescript).

[![npm](https://img.shields.io/npm/v/bs-fetch.svg)](https://npmjs.org/bs-fetch)
[![Issues](https://img.shields.io/github/issues/reasonml-community/bs-fetch.svg)](https://github.com/reasonml-community/bs-fetch/issues)
[![Last Commit](https://img.shields.io/github/last-commit/reasonml-community/bs-fetch.svg)]()
[![Size](https://img.shields.io/github/size/reasonml-community/bs-fetch/lib/js/src/Fetch.js.svg)]()

`bs-fetch` is intended as a thin layer atop the JS API, upon which more high-level and idiomatic libraries can be made. Once such a library has been established, these bindings will likely be refactored to be even thinner.

## Example

```reason
Js.Promise.(
  Fetch.fetch("/api/hellos/1")
  |> then_(Fetch.Response.text)
  |> then_(text => print_endline(text) |> resolve)
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
See usage examples in [`ocaml_examples.ml`](https://github.com/reasonml-community/bs-fetch/blob/master/examples/ocaml_examples.ml) and [`reason_examples.re`](https://github.com/reasonml-community/bs-fetch/blob/master/examples/reason_examples.re). The source is a [single file](https://github.com/reasonml-community/bs-fetch/blob/master/src/Fetch.ml)!

## Node.js polyfill

`fetch` is a Web API that isn't available out-of-the-box in Node.js, and will therefore need to be polyfilled. [isomorphic-fetch](https://github.com/matthew-andrews/isomorphic-fetch) one such polyfill that seems to work well. Just install it via npm and add `[%raw "require('isomorphic-fetch')"]` to the top of your main file, but be aware that there are some subtle differences and even parts that are missing entirely. 

## Changes

### 0.3.0
* Added `HeadersInit.makeWithDict` so as to be able to make headers in OCaml too
* Require `bs-platform` >= 3.0.0 due to internal dependency on Js.boolean that has now been removed

### 0.2.0
* Rename `Bs_fetch` module to `Fetch`. `Bs_fetch` is kept around as an alias for backwards compatibility, but should be considered deprecated.
