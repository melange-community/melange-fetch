'use strict';

var Curry = require("bs-platform/lib/js/curry.js");
var Caml_option = require("bs-platform/lib/js/caml_option.js");
var Caml_builtin_exceptions = require("bs-platform/lib/js/caml_builtin_exceptions.js");

var $$AbortController = { };

function encodeRequestMethod(method_) {
  if (typeof method_ !== "number") {
    return method_[0];
  }
  switch (method_) {
    case /* Get */0 :
        return "GET";
    case /* Head */1 :
        return "HEAD";
    case /* Post */2 :
        return "POST";
    case /* Put */3 :
        return "PUT";
    case /* Delete */4 :
        return "DELETE";
    case /* Connect */5 :
        return "CONNECT";
    case /* Options */6 :
        return "OPTIONS";
    case /* Trace */7 :
        return "TRACE";
    case /* Patch */8 :
        return "PATCH";
    
  }
}

function encodeReferrerPolicy(param) {
  switch (param) {
    case /* None */0 :
        return "";
    case /* NoReferrer */1 :
        return "no-referrer";
    case /* NoReferrerWhenDowngrade */2 :
        return "no-referrer-when-downgrade";
    case /* SameOrigin */3 :
        return "same-origin";
    case /* Origin */4 :
        return "origin";
    case /* StrictOrigin */5 :
        return "strict-origin";
    case /* OriginWhenCrossOrigin */6 :
        return "origin-when-cross-origin";
    case /* StrictOriginWhenCrossOrigin */7 :
        return "strict-origin-when-cross-origin";
    case /* UnsafeUrl */8 :
        return "unsafe-url";
    
  }
}

function encodeRequestMode(param) {
  switch (param) {
    case /* Navigate */0 :
        return "navigate";
    case /* SameOrigin */1 :
        return "same-origin";
    case /* NoCORS */2 :
        return "no-cors";
    case /* CORS */3 :
        return "cors";
    
  }
}

function encodeRequestCredentials(param) {
  switch (param) {
    case /* Omit */0 :
        return "omit";
    case /* SameOrigin */1 :
        return "same-origin";
    case /* Include */2 :
        return "include";
    
  }
}

function encodeRequestCache(param) {
  switch (param) {
    case /* Default */0 :
        return "default";
    case /* NoStore */1 :
        return "no-store";
    case /* Reload */2 :
        return "reload";
    case /* NoCache */3 :
        return "no-cache";
    case /* ForceCache */4 :
        return "force-cache";
    case /* OnlyIfCached */5 :
        return "only-if-cached";
    
  }
}

function encodeRequestRedirect(param) {
  switch (param) {
    case /* Follow */0 :
        return "follow";
    case /* Error */1 :
        return "error";
    case /* Manual */2 :
        return "manual";
    
  }
}

var HeadersInit = { };

var $$Headers = { };

var BodyInit = { };

function map(f, v) {
  if (v !== undefined) {
    return Caml_option.some(Curry._1(f, Caml_option.valFromOption(v)));
  }
  
}

function make(method_, headers, body, referrer, referrerPolicyOpt, mode, credentials, cache, redirect, integrityOpt, keepalive, signal) {
  var referrerPolicy = referrerPolicyOpt !== undefined ? referrerPolicyOpt : /* None */0;
  var integrity = integrityOpt !== undefined ? integrityOpt : "";
  var partial_arg = integrity;
  var partial_arg$1 = map(encodeRequestRedirect, redirect);
  var partial_arg$2 = map(encodeRequestCache, cache);
  var partial_arg$3 = map(encodeRequestCredentials, credentials);
  var partial_arg$4 = map(encodeRequestMode, mode);
  var partial_arg$5 = encodeReferrerPolicy(referrerPolicy);
  var partial_arg$6 = map(encodeRequestMethod, method_);
  return (function (param) {
      var tmp = { };
      if (partial_arg$6 !== undefined) {
        tmp.method = Caml_option.valFromOption(partial_arg$6);
      }
      if (headers !== undefined) {
        tmp.headers = Caml_option.valFromOption(headers);
      }
      if (body !== undefined) {
        tmp.body = Caml_option.valFromOption(body);
      }
      if (referrer !== undefined) {
        tmp.referrer = Caml_option.valFromOption(referrer);
      }
      if (partial_arg$5 !== undefined) {
        tmp.referrerPolicy = Caml_option.valFromOption(partial_arg$5);
      }
      if (partial_arg$4 !== undefined) {
        tmp.mode = Caml_option.valFromOption(partial_arg$4);
      }
      if (partial_arg$3 !== undefined) {
        tmp.credentials = Caml_option.valFromOption(partial_arg$3);
      }
      if (partial_arg$2 !== undefined) {
        tmp.cache = Caml_option.valFromOption(partial_arg$2);
      }
      if (partial_arg$1 !== undefined) {
        tmp.redirect = Caml_option.valFromOption(partial_arg$1);
      }
      if (partial_arg !== undefined) {
        tmp.integrity = Caml_option.valFromOption(partial_arg);
      }
      if (keepalive !== undefined) {
        tmp.keepalive = Caml_option.valFromOption(keepalive);
      }
      if (signal !== undefined) {
        tmp.signal = Caml_option.valFromOption(signal);
      }
      return tmp;
    });
}

function method_(self) {
  var method_$1 = self.method;
  switch (method_$1) {
    case "CONNECT" :
        return /* Connect */5;
    case "DELETE" :
        return /* Delete */4;
    case "GET" :
        return /* Get */0;
    case "HEAD" :
        return /* Head */1;
    case "OPTIONS" :
        return /* Options */6;
    case "PATCH" :
        return /* Patch */8;
    case "POST" :
        return /* Post */2;
    case "PUT" :
        return /* Put */3;
    case "TRACE" :
        return /* Trace */7;
    default:
      return /* Other */[method_$1];
  }
}

function type_(self) {
  var e = self.type;
  switch (e) {
    case "" :
        return /* None */0;
    case "audio" :
        return /* Audio */1;
    case "font" :
        return /* Font */2;
    case "image" :
        return /* Image */3;
    case "script" :
        return /* Script */4;
    case "style" :
        return /* Style */5;
    case "track" :
        return /* Track */6;
    case "video" :
        return /* Video */7;
    default:
      throw [
            Caml_builtin_exceptions.failure,
            "Unknown requestType: " + e
          ];
  }
}

function destination(self) {
  var e = self.destination;
  switch (e) {
    case "" :
        return /* None */0;
    case "document" :
        return /* Document */1;
    case "embed" :
        return /* Embed */2;
    case "font" :
        return /* Font */3;
    case "image" :
        return /* Image */4;
    case "manifest" :
        return /* Manifest */5;
    case "media" :
        return /* Media */6;
    case "object" :
        return /* Object */7;
    case "report" :
        return /* Report */8;
    case "script" :
        return /* Script */9;
    case "serviceworker" :
        return /* ServiceWorker */10;
    case "sharedworder" :
        return /* SharedWorker */11;
    case "style" :
        return /* Style */12;
    case "worker" :
        return /* Worker */13;
    case "xslt" :
        return /* Xslt */14;
    default:
      throw [
            Caml_builtin_exceptions.failure,
            "Unknown requestDestination: " + e
          ];
  }
}

function referrerPolicy(self) {
  var e = self.referrerPolicy;
  switch (e) {
    case "" :
        return /* None */0;
    case "no-referrer" :
        return /* NoReferrer */1;
    case "no-referrer-when-downgrade" :
        return /* NoReferrerWhenDowngrade */2;
    case "origin" :
        return /* Origin */4;
    case "origin-when-cross-origin" :
        return /* OriginWhenCrossOrigin */6;
    case "same-origin" :
        return /* SameOrigin */3;
    case "strict-origin" :
        return /* StrictOrigin */5;
    case "strict-origin-when-cross-origin" :
        return /* StrictOriginWhenCrossOrigin */7;
    case "unsafe-url" :
        return /* UnsafeUrl */8;
    default:
      throw [
            Caml_builtin_exceptions.failure,
            "Unknown referrerPolicy: " + e
          ];
  }
}

function mode(self) {
  var e = self.mode;
  switch (e) {
    case "cors" :
        return /* CORS */3;
    case "navigate" :
        return /* Navigate */0;
    case "no-cors" :
        return /* NoCORS */2;
    case "same-origin" :
        return /* SameOrigin */1;
    default:
      throw [
            Caml_builtin_exceptions.failure,
            "Unknown requestMode: " + e
          ];
  }
}

function credentials(self) {
  var e = self.credentials;
  switch (e) {
    case "include" :
        return /* Include */2;
    case "omit" :
        return /* Omit */0;
    case "same-origin" :
        return /* SameOrigin */1;
    default:
      throw [
            Caml_builtin_exceptions.failure,
            "Unknown requestCredentials: " + e
          ];
  }
}

function cache(self) {
  var e = self.cache;
  switch (e) {
    case "default" :
        return /* Default */0;
    case "force-cache" :
        return /* ForceCache */4;
    case "no-cache" :
        return /* NoCache */3;
    case "no-store" :
        return /* NoStore */1;
    case "only-if-cached" :
        return /* OnlyIfCached */5;
    case "reload" :
        return /* Reload */2;
    default:
      throw [
            Caml_builtin_exceptions.failure,
            "Unknown requestCache: " + e
          ];
  }
}

function redirect(self) {
  var e = self.redirect;
  switch (e) {
    case "error" :
        return /* Error */1;
    case "follow" :
        return /* Follow */0;
    case "manual" :
        return /* Manual */2;
    default:
      throw [
            Caml_builtin_exceptions.failure,
            "Unknown requestRedirect: " + e
          ];
  }
}

var $$Request = {
  method_: method_,
  type_: type_,
  destination: destination,
  referrerPolicy: referrerPolicy,
  mode: mode,
  credentials: credentials,
  cache: cache,
  redirect: redirect
};

var $$Response = { };

function classify(t) {
  if (typeof t === "string") {
    return /* `String */[
            -976970511,
            t
          ];
  } else {
    return /* `File */[
            781515420,
            t
          ];
  }
}

var EntryValue = {
  classify: classify
};

var $$FormData = {
  EntryValue: EntryValue,
  Iterator: undefined
};

var Body = { };

var RequestInit = {
  make: make
};

exports.$$AbortController = $$AbortController;
exports.HeadersInit = HeadersInit;
exports.$$Headers = $$Headers;
exports.BodyInit = BodyInit;
exports.Body = Body;
exports.RequestInit = RequestInit;
exports.$$Request = $$Request;
exports.$$Response = $$Response;
exports.$$FormData = $$FormData;
/* No side effect */
