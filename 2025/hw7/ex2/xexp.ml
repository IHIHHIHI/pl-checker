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

type value = N of int | P of value * value | C of closure
and closure = fexpr * env
and fexpr = Fun of id * xexp | FnrFun of id * id * xexp
and env = id -> value

type result =
  | Val of value
  (* Value *)
  | Exn of value (* Exception *)

exception Unhandled of string
exception RunError of string
exception TypeError of string

let bind e x v y = if y = x then v else e y
let getNum = function N n -> n | _ -> raise (TypeError "not an int")

let getPair = function
  | P (a, b) -> (a, b)
  | _ -> raise (TypeError "not a pair")

let getClosure = function C c -> c | _ -> raise (TypeError "not a function")

let rec eval env exp =
  match exp with
  | Num n -> Val (N n)
  | Var x -> Val (env x)
  | Fn (x, e) -> Val (C (Fun (x, e), env))
  | Fnr (f, x, e) -> Val (C (FnrFun (f, x, e), env))
  | App (e1, e2) -> (
      (* e2 must be evaluated only if e1 is evaluated to a value *)
      match eval env e1 with
      | Val v1 -> (
          match eval env e2 with
          | Val v2 -> (
              let c, env' = getClosure v1 in
              match c with
              | Fun (x, e) -> eval (bind env' x v2) e
              | FnrFun (f, x, e) ->
                  let env'' = bind env' x v2 in
                  let env''' = bind env'' f v1 in
                  eval env''' e)
          | Exn w -> Exn w)
      | Exn w -> Exn w)
  | Ifp (e1, e2, e3) -> (
      match eval env e1 with
      | Val v -> if getNum v > 0 then eval env e2 else eval env e3
      | Exn w -> Exn w)
  | Add (e1, e2) -> (
      match eval env e1 with
      | Val v1 -> (
          match eval env e2 with
          | Val v2 -> Val (N (getNum v1 + getNum v2))
          | Exn w -> Exn w)
      | Exn w -> Exn w)
  | Pair (e1, e2) -> (
      match eval env e1 with
      | Val v1 -> (
          match eval env e2 with Val v2 -> Val (P (v1, v2)) | Exn w -> Exn w)
      | Exn w -> Exn w)
  | Fst e -> (
      match eval env e with Val v -> Val (fst (getPair v)) | Exn w -> Exn w)
  | Snd e -> (
      match eval env e with Val v -> Val (snd (getPair v)) | Exn w -> Exn w)
  | Raise e -> ( match eval env e with Val v -> Exn v | Exn w -> Exn w)
  | Handle (e1, x, e2) -> (
      (* e2 must be evaluated only if e1 is evaluated to an exception *)
      match eval env e1 with
      | Val v1 -> Val v1
      | Exn w ->
          let env' = bind env x w in
          eval env' e2)

let emptyEnv x = raise (RunError ("unbound id: " ^ x))

let run : xexp -> value =
 fun exp -> match eval emptyEnv exp with Exn w -> N 2024 | Val v -> v

let ps = print_string
let nl = print_newline

let indent i =
  let rec iter = function
    | 0 -> ()
    | n ->
        ps " ";
        iter (n - 1)
  in
  nl ();
  iter i

let rec pp n = function
  | Num i -> print_int i
  | Var s -> ps s
  | Fn (x, e) -> (
      ps ("fn " ^ x ^ " => ");
      match e with
      | Ifp _ ->
          indent (n + 1);
          pp (n + 1) e
      | _ -> pp n e)
  | Fnr (f, x, e) ->
      ps ("rec " ^ f ^ " " ^ x ^ " => ");
      pp n e
  | App (e, e') ->
      ps "(";
      pp n e;
      ps ") (";
      pp n e';
      ps ")"
  | Ifp (e1, e2, e3) ->
      ps "ifp ";
      pp n e1;
      ps " then ";
      indent (n + 1);
      pp (n + 1) e2;
      indent n;
      ps "else";
      indent (n + 1);
      pp (n + 1) e3
  | Add (e1, e2) ->
      ps "(";
      pp n e1;
      ps " + ";
      pp n e2;
      ps ")"
  | Pair (e1, e2) ->
      ps "(";
      pp n e1;
      ps ", ";
      pp n e2;
      ps ")"
  | Fst e ->
      pp n e;
      ps ".1"
  | Snd e ->
      pp n e;
      ps ".2"
  | Raise e ->
      ps "raise (";
      pp n e;
      ps ")"
  | Handle (e1, x, e2) ->
      ps "(";
      pp n e1;
      ps ") ";
      ps ("handle " ^ x ^ " (");
      pp n e2;
      ps ")"

let print = pp 0
