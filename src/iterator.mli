(** We need to bind to JavaScript Iterators for FormData functionality.
    But ideally this binding should be moved into BuckleScript itself.

    @see {{: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Iteration_protocols}} *)

module Next : sig
  type 'a t

  external done_ : _ t -> bool option = "done" [@@bs.get]
  external value : 'a t -> 'a option = "value" [@@bs.get] [@@bs.return nullable]
end

type 'a t

val forEach : f:('a -> unit [@bs]) -> 'a t -> unit
(** [forEach ~f iterator] runs [f] on each item returned by the
    [iterator]. This is not defined by the platform but a convenience
    function. *)

external next : 'a t -> 'a Next.t = "next" [@@bs.send]
