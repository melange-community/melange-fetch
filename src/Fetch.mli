type body
type bodyInit
type headers
type headersInit
type response
type request
type requestInit

(* external *)
type arrayBuffer (* TypedArray *)
type bufferSource (* Web IDL, either an arrayBuffer or arrayBufferView *)
type formData (* XMLHttpRequest *)
type readableStream (* Streams *)
type urlSearchParams (* URL *)
type abortController
type signal

(** File API *)

type blob
type file

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

module AbortSignal : sig
  type t = signal

  external aborted : t -> bool = "aborted" [@@mel.get]
  
  
  external reason : t -> string Js.Nullable.t = "reason" [@@mel.get]
  (** A JavaScript value that indicates the abort reason, or undefined,
      if not aborted. *)
end

module AbortController : sig
  (* Experimental API *)
  type t = abortController

  (* Experimental API *)
  external signal : t -> signal = "signal" [@@mel.get]

  (* Experimental API *)
  external abort : unit = "abort" [@@mel.send.pipe: t]

  (* Experimental API *)
  external make : unit -> t = "AbortController" [@@mel.new]
end

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

type requestType =
  | None (* default? unknown? just empty string in spec *)
  | Audio
  | Font
  | Image
  | Script
  | Style
  | Track
  | Video

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

type requestMode =
  | Navigate
  | SameOrigin
  | NoCORS
  | CORS

type requestCredentials =
  | Omit
  | SameOrigin
  | Include

type requestCache =
  | Default
  | NoStore
  | Reload
  | NoCache
  | ForceCache
  | OnlyIfCached

type requestRedirect =
  | Follow
  | Error
  | Manual

module HeadersInit : sig
  type t = headersInit

  external make : < .. > Js.t -> t = "%identity"
  external makeWithDict : string Js.Dict.t -> t = "%identity"
  external makeWithArray : (string * string) array -> t = "%identity"
end

module Headers : sig
  type t = headers

  external make : t = "Headers" [@@mel.new]
  external makeWithInit : headersInit -> t = "Headers" [@@mel.new]
  external append : string -> string -> unit = "append" [@@mel.send.pipe: t]
  external delete : string -> unit = "delete" [@@mel.send.pipe: t]
  (* entries *)
  (* very experimental *)

  external get : string -> string option = "get"
  [@@mel.send.pipe: t] [@@mel.return { null_to_opt }]

  external has : string -> bool = "has" [@@mel.send.pipe: t]
  (* keys *)
  (* very experimental *)

  external set : string -> string -> unit = "set" [@@mel.send.pipe: t]
  (* values *)
  (* very experimental *)
end

module BodyInit : sig
  type t = bodyInit

  external make : string -> t = "%identity"
  external makeWithBlob : blob -> t = "%identity"
  external makeWithBufferSource : bufferSource -> t = "%identity"
  external makeWithFormData : formData -> t = "%identity"
  external makeWithUrlSearchParams : urlSearchParams -> t = "%identity"
end

module Body : sig
  type t = body

  external body : t -> readableStream = "body" [@@mel.get]
  external bodyUsed : t -> bool = "bodyUsed" [@@mel.get]

  external arrayBuffer : arrayBuffer Js.Promise.t = "arrayBuffer"
  [@@mel.send.pipe: t]

  external blob : blob Js.Promise.t = "blob" [@@mel.send.pipe: t]
  external formData : formData Js.Promise.t = "formData" [@@mel.send.pipe: t]
  external json : Js.Json.t Js.Promise.t = "json" [@@mel.send.pipe: t]
  external text : string Js.Promise.t = "text" [@@mel.send.pipe: t]
end

module RequestInit : sig
  type t = requestInit

  val make :
     ?method_:requestMethod
    -> ?headers:headersInit
    -> ?body:bodyInit
    -> ?referrer:string
    -> ?referrerPolicy:referrerPolicy
    -> ?mode:requestMode
    -> ?credentials:requestCredentials
    -> ?cache:requestCache
    -> ?redirect:requestRedirect
    -> ?integrity:string
    -> ?keepalive:bool
    -> ?signal:signal
    -> unit
    -> t
end

module Request : sig
  type t = request

  external make : string -> t = "Request" [@@mel.new]
  external makeWithInit : string -> requestInit -> t = "Request" [@@mel.new]
  external makeWithRequest : t -> t = "Request" [@@mel.new]
  external makeWithRequestInit : t -> requestInit -> t = "Request" [@@mel.new]
  val method_ : t -> requestMethod
  external url : t -> string = "url" [@@mel.get]
  external headers : t -> headers = "headers" [@@mel.get]
  val type_ : t -> requestType
  val destination : t -> requestDestination
  external referrer : t -> string = "referrer" [@@mel.get]
  val referrerPolicy : t -> referrerPolicy
  val mode : t -> requestMode
  val credentials : t -> requestCredentials
  val cache : t -> requestCache
  val redirect : t -> requestRedirect
  external integrity : t -> string = "integrity" [@@mel.get]
  external keepalive : t -> bool = "keepalive" [@@mel.get]
  external signal : t -> signal = "signal" [@@mel.get]

  (* Body Impl *)
  external body : t -> readableStream = "body" [@@mel.get]
  external bodyUsed : t -> bool = "bodyUsed" [@@mel.get]

  external arrayBuffer : arrayBuffer Js.Promise.t = "arrayBuffer"
  [@@mel.send.pipe: t]

  external blob : blob Js.Promise.t = "blob" [@@mel.send.pipe: t]
  external formData : formData Js.Promise.t = "formData" [@@mel.send.pipe: t]
  external json : Js.Json.t Js.Promise.t = "json" [@@mel.send.pipe: t]
  external text : string Js.Promise.t = "text" [@@mel.send.pipe: t]
end

module Response : sig
  type t = response

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
  external clone : t = "clone" [@@mel.send.pipe: t]

  (* Body.Impl *)
  external body : t -> readableStream = "body" [@@mel.get]
  external bodyUsed : t -> bool = "bodyUsed" [@@mel.get]

  external arrayBuffer : arrayBuffer Js.Promise.t = "arrayBuffer"
  [@@mel.send.pipe: t]

  external blob : blob Js.Promise.t = "blob" [@@mel.send.pipe: t]
  external formData : formData Js.Promise.t = "formData" [@@mel.send.pipe: t]
  external json : Js.Json.t Js.Promise.t = "json" [@@mel.send.pipe: t]
  external text : string Js.Promise.t = "text" [@@mel.send.pipe: t]
end

module FormData : sig
  module EntryValue : sig
    type t
    (** This represents a
        {{:https://developer.mozilla.org/en-US/docs/Web/API/FormDataEntryValue}
          FormDataEntryValue}. *)

    val classify : t -> [> `String of string | `File of file ]
    (** [classify entryValue] safely casts the [entryValue] to its correct
        runtime type. *)
  end

  module Iterator = Iterator

  type t = formData

  external make : unit -> t = "FormData" [@@mel.new]
  external append : string -> string -> unit = "append" [@@mel.send.pipe: t]
  external delete : string -> unit = "delete" [@@mel.send.pipe: t]
  external get : string -> EntryValue.t option = "get" [@@mel.send.pipe: t]
  external getAll : string -> EntryValue.t array = "getAll" [@@mel.send.pipe: t]
  external set : string -> string -> unit = "set" [@@mel.send.pipe: t]
  external has : string -> bool = "has" [@@mel.send.pipe: t]
  external keys : t -> string Iterator.t = "keys" [@@mel.send]
  external values : t -> EntryValue.t Iterator.t = "values" [@@mel.send]

  external appendObject :
     string
    -> < .. > Js.t
    -> ?filename:string
    -> unit
    = "append"
  [@@mel.send.pipe: t]
  (** This is for React Native compatibility purposes *)

  external appendBlob : string -> blob -> ?filename:string -> unit = "append"
  [@@mel.send.pipe: t]

  external appendFile : string -> file -> ?filename:string -> unit = "append"
  [@@mel.send.pipe: t]

  external setObject : string -> < .. > Js.t -> ?filename:string -> unit = "set"
  [@@mel.send.pipe: t]
  (** This is for React Native compatibility purposes *)

  external setBlob : string -> blob -> ?filename:string -> unit = "set"
  [@@mel.send.pipe: t]

  external setFile : string -> file -> ?filename:string -> unit = "set"
  [@@mel.send.pipe: t]

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
