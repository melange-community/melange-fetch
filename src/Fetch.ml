type body
type bodyInit
type headers
type headersInit
type response
type request
type requestInit
type abortController
type signal

(* external *)
type arrayBuffer (* TypedArray *)
type bufferSource (* Web IDL, either an arrayBuffer or arrayBufferView *)
type formData (* XMLHttpRequest *)
type readableStream (* Streams *)
type urlSearchParams (* URL *)
type blob
type file

module AbortSignal = struct
  type t = signal

  external aborted : t -> bool = "aborted" [@@mel.get]
  external reason : t -> string Js.Nullable.t = "reason" [@@mel.get]
end

module AbortController = struct
  type t = abortController

  external signal : t -> signal = "signal" [@@mel.get]
  external abort : t -> unit = "abort" [@@mel.send]
  external make : unit -> t = "AbortController" [@@mel.new]
end

type requestMethod =
  | Get
  | Head
  | Post
  | Put
  | Delete
  | Connect
  | Options
  | Trace
  | Patch
  | Other of string

let encodeRequestMethod
  =
  (* internal *)
  function
  | Get -> "GET"
  | Head -> "HEAD"
  | Post -> "POST"
  | Put -> "PUT"
  | Delete -> "DELETE"
  | Connect -> "CONNECT"
  | Options -> "OPTIONS"
  | Trace -> "TRACE"
  | Patch -> "PATCH"
  | Other method_ -> method_

let decodeRequestMethod
  =
  (* internal *)
  function
  | "GET" -> Get
  | "HEAD" -> Head
  | "POST" -> Post
  | "PUT" -> Put
  | "DELETE" -> Delete
  | "CONNECT" -> Connect
  | "OPTIONS" -> Options
  | "TRACE" -> Trace
  | "PATCH" -> Patch
  | method_ -> Other method_

type referrerPolicy =
  | None
  | NoReferrer
  | NoReferrerWhenDowngrade
  | SameOrigin
  | Origin
  | StrictOrigin
  | OriginWhenCrossOrigin
  | StrictOriginWhenCrossOrigin
  | UnsafeUrl

let encodeReferrerPolicy
  =
  (* internal *)
  function
  | NoReferrer -> "no-referrer"
  | None -> ""
  | NoReferrerWhenDowngrade -> "no-referrer-when-downgrade"
  | SameOrigin -> "same-origin"
  | Origin -> "origin"
  | StrictOrigin -> "strict-origin"
  | OriginWhenCrossOrigin -> "origin-when-cross-origin"
  | StrictOriginWhenCrossOrigin -> "strict-origin-when-cross-origin"
  | UnsafeUrl -> "unsafe-url"

let decodeReferrerPolicy
  =
  (* internal *)
  function
  | "no-referrer" -> NoReferrer
  | "" -> None
  | "no-referrer-when-downgrade" -> NoReferrerWhenDowngrade
  | "same-origin" -> SameOrigin
  | "origin" -> Origin
  | "strict-origin" -> StrictOrigin
  | "origin-when-cross-origin" -> OriginWhenCrossOrigin
  | "strict-origin-when-cross-origin" -> StrictOriginWhenCrossOrigin
  | "unsafe-url" -> UnsafeUrl
  | e -> raise (Failure ("Unknown referrerPolicy: " ^ e))

type requestType =
  | None (* default? unknown? just empty string in spec *)
  | Audio
  | Font
  | Image
  | Script
  | Style
  | Track
  | Video

let decodeRequestType
  =
  (* internal *)
  function
  | "audio" -> Audio
  | "" -> None
  | "font" -> Font
  | "image" -> Image
  | "script" -> Script
  | "style" -> Style
  | "track" -> Track
  | "video" -> Video
  | e -> raise (Failure ("Unknown requestType: " ^ e))

type requestDestination =
  | None (* default? unknown? just empty string in spec *)
  | Document
  | Embed
  | Font
  | Image
  | Manifest
  | Media
  | Object
  | Report
  | Script
  | ServiceWorker
  | SharedWorker
  | Style
  | Worker
  | Xslt

let decodeRequestDestination
  =
  (* internal *)
  function
  | "document" -> Document
  | "" -> None
  | "embed" -> Embed
  | "font" -> Font
  | "image" -> Image
  | "manifest" -> Manifest
  | "media" -> Media
  | "object" -> Object
  | "report" -> Report
  | "script" -> Script
  | "serviceworker" -> ServiceWorker
  | "sharedworder" -> SharedWorker
  | "style" -> Style
  | "worker" -> Worker
  | "xslt" -> Xslt
  | e -> raise (Failure ("Unknown requestDestination: " ^ e))

type requestMode =
  | Navigate
  | SameOrigin
  | NoCORS
  | CORS

let encodeRequestMode
  =
  (* internal *)
  function
  | Navigate -> "navigate"
  | SameOrigin -> "same-origin"
  | NoCORS -> "no-cors"
  | CORS -> "cors"

let decodeRequestMode
  =
  (* internal *)
  function
  | "navigate" -> Navigate
  | "same-origin" -> SameOrigin
  | "no-cors" -> NoCORS
  | "cors" -> CORS
  | e -> raise (Failure ("Unknown requestMode: " ^ e))

type requestCredentials =
  | Omit
  | SameOrigin
  | Include

let encodeRequestCredentials
  =
  (* internal *)
  function
  | Omit -> "omit"
  | SameOrigin -> "same-origin"
  | Include -> "include"

let decodeRequestCredentials
  =
  (* internal *)
  function
  | "omit" -> Omit
  | "same-origin" -> SameOrigin
  | "include" -> Include
  | e -> raise (Failure ("Unknown requestCredentials: " ^ e))

type requestCache =
  | Default
  | NoStore
  | Reload
  | NoCache
  | ForceCache
  | OnlyIfCached

let encodeRequestCache
  =
  (* internal *)
  function
  | Default -> "default"
  | NoStore -> "no-store"
  | Reload -> "reload"
  | NoCache -> "no-cache"
  | ForceCache -> "force-cache"
  | OnlyIfCached -> "only-if-cached"

let decodeRequestCache
  =
  (* internal *)
  function
  | "default" -> Default
  | "no-store" -> NoStore
  | "reload" -> Reload
  | "no-cache" -> NoCache
  | "force-cache" -> ForceCache
  | "only-if-cached" -> OnlyIfCached
  | e -> raise (Failure ("Unknown requestCache: " ^ e))

type requestRedirect =
  | Follow
  | Error
  | Manual

let encodeRequestRedirect
  =
  (* internal *)
  function
  | Follow -> "follow"
  | Error -> "error"
  | Manual -> "manual"

let decodeRequestRedirect
  =
  (* internal *)
  function
  | "follow" -> Follow
  | "error" -> Error
  | "manual" -> Manual
  | e -> raise (Failure ("Unknown requestRedirect: " ^ e))

module HeadersInit = struct
  type t = headersInit

  external make : < .. > Js.t -> t = "%identity"
  external makeWithDict : string Js.Dict.t -> t = "%identity"
  external makeWithArray : (string * string) array -> t = "%identity"
end

module Headers = struct
  type t = headers

  external make : t = "Headers" [@@mel.new]
  external makeWithInit : headersInit -> t = "Headers" [@@mel.new]

  external append : string -> string -> (t[@mel.this]) -> unit = "append"
  [@@mel.send]

  external delete : string -> (t[@mel.this]) -> unit = "delete" [@@mel.send]
  (* entries *)
  (* very experimental *)

  external get : string -> (t[@mel.this]) -> string option = "get"
  [@@mel.send] [@@mel.return { null_to_opt }]

  external has : string -> (t[@mel.this]) -> bool = "has" [@@mel.send]
  (* keys *)
  (* very experimental *)

  external set : string -> string -> (t[@mel.this]) -> unit = "set" [@@mel.send]
  (* values *)
  (* very experimental *)
end

module BodyInit = struct
  type t = bodyInit

  external make : string -> t = "%identity"
  external makeWithBlob : blob -> t = "%identity"
  external makeWithBufferSource : bufferSource -> t = "%identity"
  external makeWithFormData : formData -> t = "%identity"
  external makeWithUrlSearchParams : urlSearchParams -> t = "%identity"
end

module Body = struct
  module Impl (T : sig
      type t
    end) =
  struct
    external body : T.t -> readableStream = "body" [@@mel.get]
    external bodyUsed : T.t -> bool = "bodyUsed" [@@mel.get]

    external arrayBuffer : T.t -> arrayBuffer Js.Promise.t = "arrayBuffer"
    [@@mel.send]

    external blob : T.t -> blob Js.Promise.t = "blob" [@@mel.send]
    external formData : T.t -> formData Js.Promise.t = "formData" [@@mel.send]
    external json : T.t -> Js.Json.t Js.Promise.t = "json" [@@mel.send]
    external text : T.t -> string Js.Promise.t = "text" [@@mel.send]
  end

  type t = body

  include Impl (struct
      type nonrec t = t
    end)
end

module RequestInit = struct
  type t = requestInit

  let map f = function
    (* internal *)
    | Some v -> Some (f v)
    | None -> None

  external make :
     ?_method:string
    -> ?headers:headersInit
    -> ?body:bodyInit
    -> ?referrer:string
    -> ?referrerPolicy:string
    -> ?mode:string
    -> ?credentials:string
    -> ?cache:string
    -> ?redirect:string
    -> ?integrity:string
    -> ?keepalive:bool
    -> ?signal:signal
    -> unit
    -> requestInit
    = ""
  [@@mel.obj]

  let make
        ?(method_ : requestMethod option)
        ?(headers : headersInit option)
        ?(body : bodyInit option)
        ?(referrer : string option)
        ?(referrerPolicy : referrerPolicy = None)
        ?(mode : requestMode option)
        ?(credentials : requestCredentials option)
        ?(cache : requestCache option)
        ?(redirect : requestRedirect option)
        ?(integrity : string = "")
        ?(keepalive : bool option)
        ?(signal : signal option)
    =
    make
      ?_method:(map encodeRequestMethod method_)
      ?headers
      ?body
      ?referrer
      ~referrerPolicy:(encodeReferrerPolicy referrerPolicy)
      ?mode:(map encodeRequestMode mode)
      ?credentials:(map encodeRequestCredentials credentials)
      ?cache:(map encodeRequestCache cache)
      ?redirect:(map encodeRequestRedirect redirect)
      ~integrity
      ?keepalive
      ?signal
end

module Request = struct
  type t = request

  include Body.Impl (struct
      type nonrec t = t
    end)

  external make : string -> t = "Request" [@@mel.new]
  external makeWithInit : string -> requestInit -> t = "Request" [@@mel.new]
  external makeWithRequest : t -> t = "Request" [@@mel.new]
  external makeWithRequestInit : t -> requestInit -> t = "Request" [@@mel.new]
  external method_ : t -> string = "method" [@@mel.get]

  let method_ : t -> requestMethod =
   fun self -> decodeRequestMethod (method_ self)

  external url : t -> string = "url" [@@mel.get]
  external headers : t -> headers = "headers" [@@mel.get]
  external type_ : t -> string = "type" [@@mel.get]

  let type_ : t -> requestType = fun self -> decodeRequestType (type_ self)

  external destination : t -> string = "destination" [@@mel.get]

  let destination : t -> requestDestination =
   fun self -> decodeRequestDestination (destination self)

  external referrer : t -> string = "referrer" [@@mel.get]
  external referrerPolicy : t -> string = "referrerPolicy" [@@mel.get]

  let referrerPolicy : t -> referrerPolicy =
   fun self -> decodeReferrerPolicy (referrerPolicy self)

  external mode : t -> string = "mode" [@@mel.get]

  let mode : t -> requestMode = fun self -> decodeRequestMode (mode self)

  external credentials : t -> string = "credentials" [@@mel.get]

  let credentials : t -> requestCredentials =
   fun self -> decodeRequestCredentials (credentials self)

  external cache : t -> string = "cache" [@@mel.get]

  let cache : t -> requestCache = fun self -> decodeRequestCache (cache self)

  external redirect : t -> string = "redirect" [@@mel.get]

  let redirect : t -> requestRedirect =
   fun self -> decodeRequestRedirect (redirect self)

  external integrity : t -> string = "integrity" [@@mel.get]
  external keepalive : t -> bool = "keepalive" [@@mel.get]
  external signal : t -> signal = "signal" [@@mel.get]
end

module Response = struct
  type t = response

  include Body.Impl (struct
      type nonrec t = t
    end)

  external error : unit -> t = "error"
  external redirect : string -> t = "redirect"
  external redirectWithStatus : string -> int (* enum-ish *) -> t = "redirect"
  external headers : t -> headers = "headers" [@@mel.get]
  external ok : t -> bool = "ok" [@@mel.get]
  external redirected : t -> bool = "redirected" [@@mel.get]
  external status : t -> int = "status" [@@mel.get]
  external statusText : t -> string = "statusText" [@@mel.get]
  external type_ : t -> string = "type" [@@mel.get]
  external url : t -> string = "url" [@@mel.get]
  external clone : t -> t = "clone" [@@mel.send]
end

module FormData = struct
  module EntryValue = struct
    type t

    let classify : t -> [> `String of string | `File of file ] =
     fun t ->
      if Js.typeof t = "string"
      then `String (Obj.magic t)
      else `File (Obj.magic t)
  end

  module Iterator = Iterator

  type t = formData

  external make : unit -> t = "FormData" [@@mel.new]

  external append : string -> string -> (t[@mel.this]) -> unit = "append"
  [@@mel.send]

  external delete : string -> (t[@mel.this]) -> unit = "delete" [@@mel.send]

  external get : string -> (t[@mel.this]) -> EntryValue.t option = "get"
  [@@mel.send]

  external getAll : string -> (t[@mel.this]) -> EntryValue.t array = "getAll"
  [@@mel.send]

  external set : string -> string -> (t[@mel.this]) -> unit = "set" [@@mel.send]
  external has : string -> (t[@mel.this]) -> bool = "has" [@@mel.send]
  external keys : t -> string Iterator.t = "keys" [@@mel.send]
  external values : t -> EntryValue.t Iterator.t = "values" [@@mel.send]

  external appendObject :
     string
    -> < .. > Js.t
    -> ?filename:string
    -> (t[@mel.this])
    -> unit
    = "append"
  [@@mel.send]

  external appendBlob :
     string
    -> blob
    -> ?filename:string
    -> (t[@mel.this])
    -> unit
    = "append"
  [@@mel.send]

  external appendFile :
     string
    -> file
    -> ?filename:string
    -> (t[@mel.this])
    -> unit
    = "append"
  [@@mel.send]

  external setObject :
     string
    -> < .. > Js.t
    -> ?filename:string
    -> (t[@mel.this])
    -> unit
    = "set"
  [@@mel.send]

  external setBlob :
     string
    -> blob
    -> ?filename:string
    -> (t[@mel.this])
    -> unit
    = "set"
  [@@mel.send]

  external setFile :
     string
    -> file
    -> ?filename:string
    -> (t[@mel.this])
    -> unit
    = "set"
  [@@mel.send]

  external entries : t -> (string * EntryValue.t) Iterator.t = "entries"
  [@@mel.send]
end

external fetch : string -> response Js.Promise.t = "fetch"

external fetchWithInit :
   string
  -> requestInit
  -> response Js.Promise.t
  = "fetch"

external fetchWithRequest : request -> response Js.Promise.t = "fetch"

external fetchWithRequestInit :
   request
  -> requestInit
  -> response Js.Promise.t
  = "fetch"
