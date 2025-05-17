(*
 * SNU 4190.310 Programming Languages
 * M0 Language Definition and Interpreter
 *)

type nexp =
  | Num of int
  | Var of id
  | Fn of id * nexp
  | Fnr of id * id * nexp
  | App of nexp * nexp
  | Ifp of nexp * nexp * nexp
  | Add of nexp * nexp
  | Pair of nexp * nexp (* (e, e) *)
  | Fst of nexp (*   e.1  *)
  | Snd of nexp (*   e.2  *)

and id = string

type closure
type value = N of int | P of value * value | C of closure

val run : nexp -> value
val print : nexp -> unit
