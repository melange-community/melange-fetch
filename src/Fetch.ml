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

module Method = struct
  type t = string

  let get = "GET"
  let head = "HEAD"
  let post = "POST"
  let put = "PUT"
  let delete = "DELETE"
  let connect = "CONNECT"
  let options = "OPTIONS"
  let trace = "TRACE"
  let patch = "PATCH"
  let other m = m
end

module ReferrerPolicy = struct
  type t = string

  let none = ""
  let noReferrer = "no-referrer"
  let noReferrerWhenDowngrade = "no-referrer-when-downgrade"
  let sameOrigin = "same-origin"
  let origin = "origin"
  let strictOrigin = "strict-origin"
  let originWhenCrossOrigin = "origin-when-cross-origin"
  let strictOriginWhenCrossOrigin = "strict-origin-when-cross-origin"
  let unsafeUrl = "unsafe-url"
end

module RequestType = struct
  type t = string

  let none = ""
  let audio = "audio"
  let font = "font"
  let image = "image"
  let script = "script"
  let style = "style"
  let track = "track"
  let video = "video"
end

module RequestDestination = struct
  type t = string

  let none = ""
  let document = "document"
  let embed = "embed"
  let font = "font"
  let image = "image"
  let manifest = "manifest"
  let media = "media"
  let object_ = "object"
  let report = "report"
  let script = "script"
  let serviceWorker = "serviceworker"
  let sharedWorker = "sharedworder"
  let style = "style"
  let worker = "worker"
  let xslt = "xslt"
end

module RequestMode = struct
  type t = string

  let navigate = "navigate"
  let sameOrigin = "same-origin"
  let noCORS = "no-cors"
  let cors = "cors"
end

module RequestCredentials = struct
  type t = string

  let omit = "omit"
  let sameOrigin  = "same-origin"
  let include_  = "include"
end

module RequestCache = struct
  type t = string

  let default = "default"
  let noStore = "no-store"
  let reload = "reload"
  let noCache = "no-cache"
  let forceCache = "force-cache"
  let onlyIfCached = "only-if-cached"
end

module RequestRedirect = struct
  type t = string

  let follow = "follow"
  let error = "error"
  let manual = "manual"
end

module HeadersInit = struct
  type t = headersInit

  external make : < .. > Js.t -> t = "%identity"
  external makeWithArray : (string * string) array -> t = "%identity"
end

module Headers = struct
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

module BodyInit = struct
  type t = bodyInit

  external make : string -> t = "%identity"
  external makeWithBlob : blob -> t = "%identity"
  external makeWithBufferSource : bufferSource -> t = "%identity"
  external makeWithFormData : formData -> t = "%identity"
  external makeWithUrlSearchParams : urlSearchParams -> t = "%identity"
end

module Body = struct
  module Impl(T: sig type t end) = struct
    external body : T.t -> readableStream = "" [@@bs.get]
    external bodyUsed : T.t -> bool = "" [@@bs.get]

    external arrayBuffer : arrayBuffer Js.Promise.t = "" [@@bs.send.pipe: T.t]
    external blob : blob Js.Promise.t = "" [@@bs.send.pipe: T.t]
    external formData : formData Js.Promise.t = "" [@@bs.send.pipe: T.t]
    external json : Js.Json.t Js.Promise.t = "" [@@bs.send.pipe: T.t]
    external text : string Js.Promise.t = "" [@@bs.send.pipe: T.t]
  end

  type t = body
  include Impl(struct type nonrec t = t end)
end

module RequestInit = struct
  type t = requestInit

  external make :
    ?_method:Method.t ->
    ?headers:headersInit ->
    ?body:bodyInit ->
    ?referrer:string ->
    ?referrerPolicy:ReferrerPolicy.t ->
    ?mode:RequestMode.t ->
    ?credentials:RequestCredentials.t ->
    ?cache:RequestCache.t ->
    ?redirect:RequestRedirect.t ->
    ?integrity:string ->
    ?keepalive:Js.boolean ->
    unit -> requestInit = "" [@@bs.obj]
end

module Request = struct
  type t = request

  include Body.Impl(struct type nonrec t = t end)

  external make : string -> t = "Request" [@@bs.new]
  external makeWithInit : string -> requestInit -> t = "Request" [@@bs.new]
  external makeWithRequest : t -> t = "Request" [@@bs.new]
  external makeWithRequestInit : t -> requestInit -> t = "Request" [@@bs.new]

  external method_ : t -> string = "method" [@@bs.get]
  (*let method_: t -> requestMethod = fun self -> decodeRequestMethod (method_ self)*)
  external url : t -> string = ""[@@bs.get]
  external headers : t -> headers = "" [@@bs.get]
  external type_ : t -> RequestType.t = "type" [@@bs.get]
  external destination : t -> RequestDestination.t = "" [@@bs.get]
  external referrer : t -> string = "" [@@bs.get]
  external referrerPolicy : t -> ReferrerPolicy.t = "" [@@bs.get]
  external mode : t -> RequestMode.t = "" [@@bs.get]
  external credentials : t -> RequestCredentials.t = "" [@@bs.get]
  external cache : t -> RequestCache.t = "" [@@bs.get]
  external redirect : t -> RequestRedirect.t = "" [@@bs.get]
  external integrity : t -> string = "" [@@bs.get]
  external keepalive : t -> bool = "" [@@bs.get]
end

module Response = struct
  type t = response

  include Body.Impl(struct type nonrec t = t end)

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
end


external fetch : string -> response Js.Promise.t = "" [@@bs.val]
external fetchWithInit : string -> requestInit -> response Js.Promise.t = "fetch" [@@bs.val]
external fetchWithRequest : request -> response Js.Promise.t = "fetch" [@@bs.val]
external fetchWithRequestInit : request -> requestInit -> response Js.Promise.t = "fetch" [@@bs.val]