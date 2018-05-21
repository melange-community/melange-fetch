type body
type bodyInit
type headers
type headersInit
type response
type request
type requestInit

(* external *)
type arrayBuffer (* TypedArray *)
type blob (* FileAPI *)
type bufferSource (* Web IDL, either an arrayBuffer or arrayBufferView *)
type formData (* XMLHttpRequest *)
type readableStream (* Streams *)
type urlSearchParams (* URL *)

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

  external make : t = "Headers" [@@bs.new]
  external makeWithInit : headersInit -> t = "Headers" [@@bs.new]

  external append : string -> string = "" [@@bs.send.pipe: t]
  external delete : string = "" [@@bs.send.pipe: t]
  (* entries *) (* very experimental *)
  external get : string -> string option = "" [@@bs.send.pipe: t] [@@bs.return {null_to_opt}]
  external has : string -> bool = "" [@@bs.send.pipe: t]
  (* keys *) (* very experimental *)
  external set : string -> string -> unit = "" [@@bs.send.pipe: t]
  (* values *) (* very experimental *)
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

  external body : t -> readableStream = "" [@@bs.get]
  external bodyUsed : t -> bool = "" [@@bs.get]

  external arrayBuffer : arrayBuffer Js.Promise.t = "" [@@bs.send.pipe: t]
  external blob : blob Js.Promise.t = "" [@@bs.send.pipe: t]
  external formData : formData Js.Promise.t = "" [@@bs.send.pipe: t]
  external json : Js.Json.t Js.Promise.t = "" [@@bs.send.pipe: t]
  external text : string Js.Promise.t = "" [@@bs.send.pipe: t]
end

module RequestInit : sig
  type t = requestInit

  val make :
    ?method_:requestMethod ->
    ?headers:headersInit ->
    ?body:bodyInit ->
    ?referrer:string ->
    ?referrerPolicy:referrerPolicy ->
    ?mode:requestMode ->
    ?credentials:requestCredentials ->
    ?cache:requestCache ->
    ?redirect:requestRedirect ->
    ?integrity:string ->
    ?keepalive:bool ->
    unit -> t
end

module Request : sig
  type t = request

  external make : string -> t = "Request" [@@bs.new]
  external makeWithInit : string -> requestInit -> t = "Request" [@@bs.new]
  external makeWithRequest : t -> t = "Request" [@@bs.new]
  external makeWithRequestInit : t -> requestInit -> t = "Request" [@@bs.new]

  val method_: t -> requestMethod
  external url : t -> string = ""[@@bs.get]
  external headers : t -> headers = "" [@@bs.get]
  val type_: t -> requestType
  val destination: t -> requestDestination
  external referrer : t -> string = "" [@@bs.get]
  val referrerPolicy: t -> referrerPolicy
  val mode: t -> requestMode
  val credentials: t -> requestCredentials
  val cache: t -> requestCache
  val redirect: t -> requestRedirect
  external integrity : t -> string = "" [@@bs.get]
  external keepalive : t -> bool = "" [@@bs.get]

  (* Body Impl *)
  external body : t -> readableStream = "" [@@bs.get]
  external bodyUsed : t -> bool = "" [@@bs.get]

  external arrayBuffer : arrayBuffer Js.Promise.t = "" [@@bs.send.pipe: t]
  external blob : blob Js.Promise.t = "" [@@bs.send.pipe: t]
  external formData : formData Js.Promise.t = "" [@@bs.send.pipe: t]
  external json : Js.Json.t Js.Promise.t = "" [@@bs.send.pipe: t]
  external text : string Js.Promise.t = "" [@@bs.send.pipe: t]
end

module Response : sig
  type t = response

  external error : unit -> t = "" [@@bs.val]
  external redirect : string -> t = "" [@@bs.val]
  external redirectWithStatus : string -> int (* enum-ish *) -> t = "redirect" [@@bs.val]
  external headers : t -> headers = "" [@@bs.get]
  external ok : t -> bool = "" [@@bs.get]
  external redirected : t -> bool = "" [@@bs.get]
  external status : t -> int = "" [@@bs.get]
  external statusText : t -> string = "" [@@bs.get]
  external _type : t -> string = "" [@@bs.get]
  external url : t -> string = "" [@@bs.get]

  external clone : t = "" [@@bs.send.pipe: t]

  (* Body.Impl *)
  external body : t -> readableStream = "" [@@bs.get]
  external bodyUsed : t -> bool = "" [@@bs.get]

  external arrayBuffer : arrayBuffer Js.Promise.t = "" [@@bs.send.pipe: t]
  external blob : blob Js.Promise.t = "" [@@bs.send.pipe: t]
  external formData : formData Js.Promise.t = "" [@@bs.send.pipe: t]
  external json : Js.Json.t Js.Promise.t = "" [@@bs.send.pipe: t]
  external text : string Js.Promise.t = "" [@@bs.send.pipe: t]
end

external fetch : string -> response Js.Promise.t = "" [@@bs.val]
external fetchWithInit : string -> requestInit -> response Js.Promise.t = "fetch" [@@bs.val]
external fetchWithRequest : request -> response Js.Promise.t = "fetch" [@@bs.val]
external fetchWithRequestInit : request -> requestInit -> response Js.Promise.t = "fetch" [@@bs.val]