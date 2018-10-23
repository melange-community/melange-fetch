'use strict';

var Fetch = require("../src/Fetch.js");
var Js_json = require("bs-platform/lib/js/js_json.js");
var Belt_Option = require("bs-platform/lib/js/belt_Option.js");
var Js_primitive = require("bs-platform/lib/js/js_primitive.js");

fetch("/api/hellos/1").then((function (prim) {
          return prim.text();
        })).then((function (text) {
        return Promise.resolve((console.log(text), /* () */0));
      }));

fetch("/api/hello", Fetch.RequestInit[/* make */0](/* Post */2, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(/* () */0)).then((function (prim) {
          return prim.text();
        })).then((function (text) {
        return Promise.resolve((console.log(text), /* () */0));
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

fetch("/api/hello", Fetch.RequestInit[/* make */0](/* Post */2, {
              "Content-Type": "application/json"
            }, Js_primitive.some(JSON.stringify(payload)), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(/* () */0)).then((function (prim) {
        return prim.json();
      }));

/*  Not a pure module */
