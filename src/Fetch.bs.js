'use strict';


function other(m) {
  return m;
}

var Method = /* module */[
  /* get */"GET",
  /* head */"HEAD",
  /* post */"POST",
  /* put */"PUT",
  /* delete */"DELETE",
  /* connect */"CONNECT",
  /* options */"OPTIONS",
  /* trace */"TRACE",
  /* patch */"PATCH",
  /* other */other
];

var ReferrerPolicy = /* module */[
  /* none */"",
  /* noReferrer */"no-referrer",
  /* noReferrerWhenDowngrade */"no-referrer-when-downgrade",
  /* sameOrigin */"same-origin",
  /* origin */"origin",
  /* strictOrigin */"strict-origin",
  /* originWhenCrossOrigin */"origin-when-cross-origin",
  /* strictOriginWhenCrossOrigin */"strict-origin-when-cross-origin",
  /* unsafeUrl */"unsafe-url"
];

var RequestType = /* module */[
  /* none */"",
  /* audio */"audio",
  /* font */"font",
  /* image */"image",
  /* script */"script",
  /* style */"style",
  /* track */"track",
  /* video */"video"
];

var RequestDestination = /* module */[
  /* none */"",
  /* document */"document",
  /* embed */"embed",
  /* font */"font",
  /* image */"image",
  /* manifest */"manifest",
  /* media */"media",
  /* object_ */"object",
  /* report */"report",
  /* script */"script",
  /* serviceWorker */"serviceworker",
  /* sharedWorker */"sharedworder",
  /* style */"style",
  /* worker */"worker",
  /* xslt */"xslt"
];

var RequestMode = /* module */[
  /* navigate */"navigate",
  /* sameOrigin */"same-origin",
  /* noCORS */"no-cors",
  /* cors */"cors"
];

var RequestCredentials = /* module */[
  /* omit */"omit",
  /* sameOrigin */"same-origin",
  /* include_ */"include"
];

var RequestCache = /* module */[
  /* default */"default",
  /* noStore */"no-store",
  /* reload */"reload",
  /* noCache */"no-cache",
  /* forceCache */"force-cache",
  /* onlyIfCached */"only-if-cached"
];

var RequestRedirect = /* module */[
  /* follow */"follow",
  /* error */"error",
  /* manual */"manual"
];

var HeadersInit = /* module */[];

var Headers = /* module */[];

var BodyInit = /* module */[];

var Response = /* module */[];

var Body = [];

var RequestInit = [(function (prim, prim$1, prim$2, prim$3, prim$4, prim$5, prim$6, prim$7, prim$8, prim$9, prim$10, _) {
      var tmp = { };
      if (prim) {
        tmp.method = prim[0];
      }
      if (prim$1) {
        tmp.headers = prim$1[0];
      }
      if (prim$2) {
        tmp.body = prim$2[0];
      }
      if (prim$3) {
        tmp.referrer = prim$3[0];
      }
      if (prim$4) {
        tmp.referrerPolicy = prim$4[0];
      }
      if (prim$5) {
        tmp.mode = prim$5[0];
      }
      if (prim$6) {
        tmp.credentials = prim$6[0];
      }
      if (prim$7) {
        tmp.cache = prim$7[0];
      }
      if (prim$8) {
        tmp.redirect = prim$8[0];
      }
      if (prim$9) {
        tmp.integrity = prim$9[0];
      }
      if (prim$10) {
        tmp.keepalive = prim$10[0];
      }
      return tmp;
    })];

function Request_000(prim) {
  return prim.method;
}

function Request_001(prim) {
  return prim.type;
}

function Request_002(prim) {
  return prim.destination;
}

function Request_003(prim) {
  return prim.referrerPolicy;
}

function Request_004(prim) {
  return prim.mode;
}

function Request_005(prim) {
  return prim.credentials;
}

function Request_006(prim) {
  return prim.cache;
}

function Request_007(prim) {
  return prim.redirect;
}

var Request = [
  Request_000,
  Request_001,
  Request_002,
  Request_003,
  Request_004,
  Request_005,
  Request_006,
  Request_007
];

exports.Method = Method;
exports.ReferrerPolicy = ReferrerPolicy;
exports.RequestType = RequestType;
exports.RequestDestination = RequestDestination;
exports.RequestMode = RequestMode;
exports.RequestCredentials = RequestCredentials;
exports.RequestCache = RequestCache;
exports.RequestRedirect = RequestRedirect;
exports.HeadersInit = HeadersInit;
exports.Headers = Headers;
exports.BodyInit = BodyInit;
exports.Body = Body;
exports.RequestInit = RequestInit;
exports.Request = Request;
exports.Response = Response;
/* No side effect */
