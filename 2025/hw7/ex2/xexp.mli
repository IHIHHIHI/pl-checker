(*
 * SNU 4190.310 Programming Languages
 * M0 Language Definition and Interpreter
 *)

type xexp =
  | Num of int
  | Var of id
  | Fn of id * xexp
  | Fnr of id * id * xexp
  | App of xexp * xexp
  | Ifp of xexp * xexp * xexp
  | Add of xexp * xexp
  | Pair of xexp * xexp (* (e, e) *)
  | Fst of xexp (*   e.1  *)
  | Snd of xexp (*   e.2  *)
  | Raise of xexp
  | Handle of xexp * string * xexp

and id = string

type closure
type value = N of int | P of value * value | C of closure

val run : xexp -> value
val print : xexp -> unit
