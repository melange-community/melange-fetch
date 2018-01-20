'use strict';

var Fetch     = require("../src/Fetch.bs.js");
var Js_json   = require("bs-platform/lib/js/js_json.js");
var Js_option = require("bs-platform/lib/js/js_option.js");

fetch("/api/hellos/1").then((function (prim) {
          return prim.text();
        })).then((function (text) {
        return Promise.resolve((console.log(text), /* () */0));
      }));

fetch("/api/hello", Fetch.RequestInit[/* make */0](/* Some */[Fetch.Method[/* post */2]], /* None */0, /* None */0, /* None */0, /* None */0, /* None */0, /* None */0, /* None */0, /* None */0, /* None */0, /* None */0, /* () */0)).then((function (prim) {
          return prim.text();
        })).then((function (text) {
        return Promise.resolve((console.log(text), /* () */0));
      }));

fetch("/api/fruit").then((function (prim) {
              return prim.json();
            })).then((function (json) {
            return Promise.resolve(Js_json.decodeArray(json));
          })).then((function (opt) {
          return Promise.resolve(Js_option.getExn(opt));
        })).then((function (items) {
        return Promise.resolve(items.map((function (item) {
                          return Js_option.getExn(Js_json.decodeString(item));
                        })));
      }));

/*  Not a pure module */
