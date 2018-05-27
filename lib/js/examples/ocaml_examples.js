'use strict';

var Fetch = require("../src/Fetch.js");
var Js_dict = require("bs-platform/lib/js/js_dict.js");
var Js_json = require("bs-platform/lib/js/js_json.js");
var Belt_Option = require("bs-platform/lib/js/belt_Option.js");

fetch("/api/hellos/1").then((function (prim) {
          return prim.text();
        })).then((function (text) {
        return Promise.resolve((console.log(text), /* () */0));
      }));

fetch("/api/hello", Fetch.RequestInit[/* make */0](/* Some */[/* Post */2], /* None */0, /* None */0, /* None */0, /* None */0, /* None */0, /* None */0, /* None */0, /* None */0, /* None */0, /* None */0)(/* () */0)).then((function (prim) {
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

fetch("/api/hello", Fetch.RequestInit[/* make */0](/* Some */[/* Post */2], /* Some */[Js_dict.fromList(/* :: */[
                    /* tuple */[
                      "Content-Type",
                      "application/json"
                    ],
                    /* [] */0
                  ])], /* Some */[JSON.stringify(payload)], /* None */0, /* None */0, /* None */0, /* None */0, /* None */0, /* None */0, /* None */0, /* None */0)(/* () */0)).then((function (prim) {
        return prim.json();
      }));

/*  Not a pure module */
