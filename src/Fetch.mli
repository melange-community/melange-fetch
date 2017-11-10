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

module Method : sig
  type t = string

  val get : t
  val head : t
  val post : t
  val put : t
  val delete : t
  val connect : t
  val options : t
  val trace : t
  val patch : t
  val other : string -> t
end

module ReferrerPolicy : sig
  type t = string

  val none : t
  val noReferrer : t
  val noReferrerWhenDowngrade : t
  val sameOrigin : t
  val origin : t
  val strictOrigin : t
  val originWhenCrossOrigin : t
  val strictOriginWhenCrossOrigin : t
  val unsafeUrl : t
end

module RequestType : sig
  type t = string

  val none : t
  val audio : t
  val font : t
  val image : t
  val script : t
  val style : t
  val track : t
  val video : t
end

module RequestDestination : sig
  type t = string

  val none : t
  val document : t
  val embed : t
  val font : t
  val image : t
  val manifest : t
  val media : t
  val object_ : t
  val report : t
  val script : t
  val serviceWorker : t
  val sharedWorker : t
  val style : t
  val worker : t
  val xslt : t
end

module RequestMode : sig
  type t = string

  val navigate : t
  val sameOrigin : t
  val noCORS : t
  val cors : t
end

module RequestCredentials : sig
  type t = string

  val omit : t
  val sameOrigin  : t
  val include_  : t
end

module RequestCache : sig
  type t = string

  val default : t
  val noStore : t
  val reload : t
  val noCache : t
  val forceCache : t
  val onlyIfCached : t
end

module RequestRedirect : sig
  type t = string

  val follow : t
  val error : t
  val manual : t
end

module HeadersInit : sig
  type t = headersInit

  external make : < .. > Js.t -> t = "%identity"
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
    unit -> t
end

module Request : sig
  type t = request

  external make : string -> t = "Request" [@@bs.new]
  external makeWithInit : string -> requestInit -> t = "Request" [@@bs.new]
  external makeWithRequest : t -> t = "Request" [@@bs.new]
  external makeWithRequestInit : t -> requestInit -> t = "Request" [@@bs.new]

  val method_: t -> Method.t
  external url : t -> string = ""[@@bs.get]
  external headers : t -> headers = "" [@@bs.get]
  val type_: t -> RequestType.t
  val destination: t -> RequestDestination.t
  external referrer : t -> string = "" [@@bs.get]
  val referrerPolicy: t -> ReferrerPolicy.t
  val mode: t -> RequestMode.t
  val credentials: t -> RequestCredentials.t
  val cache: t -> RequestCache.t
  val redirect: t -> RequestRedirect.t
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