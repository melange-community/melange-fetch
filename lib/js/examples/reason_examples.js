'use strict';

var Fetch = require("../src/Fetch.js");
var Js_json = require("bs-platform/lib/js/js_json.js");
var Belt_Option = require("bs-platform/lib/js/belt_Option.js");
var Caml_option = require("bs-platform/lib/js/caml_option.js");

fetch("/api/hellos/1").then((function (prim) {
          return prim.text();
        })).then((function (text) {
        return Promise.resolve((console.log(text), undefined));
      }));

fetch("/api/hello", Fetch.RequestInit.make(/* Post */2, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(undefined)).then((function (prim) {
          return prim.text();
        })).then((function (text) {
        return Promise.resolve((console.log(text), undefined));
      }));

fetch("/api/fruit").then((function (prim) {
              return prim.json();
            })).then((function (json) {
            return Promise.resolve(Js_json.decodeArray(json));
          })).then((function (opt) {
          return Promise.resolve(Belt_Option.getExn(opt));
        })).then((function (items) {
        return Promise.resolve(items.map((function (item) {
                          return Belt_Option.getExn(Js_json.decodeString(item));
                        })));
      }));

var payload = { };

payload["hello"] = "world";

fetch("/api/hello", Fetch.RequestInit.make(/* Post */2, {
              "Content-Type": "application/json"
            }, Caml_option.some(JSON.stringify(payload)), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(undefined)).then((function (prim) {
        return prim.json();
      }));

var formData = new FormData();

formData.append("image0", {
      type: "image/jpg",
      uri: "path/to/it",
      name: "image0.jpg"
    }, undefined);

fetch("/api/upload", Fetch.RequestInit.make(/* Post */2, {
              Accept: "*"
            }, Caml_option.some(formData), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(undefined)).then((function (prim) {
        return prim.json();
      }));

/*  Not a pure module */
