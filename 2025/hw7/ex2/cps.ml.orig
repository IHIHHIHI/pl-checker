(*
 * SNU 4190.310 Programming Languages
 * Homework "Continuation Passing Style" Skeleton
 *)

open Xexp

let count = ref 0

let new_name () =
  let _ = count := !count + 1 in
  "x_" ^ string_of_int !count

let rec alpha_conv exp subst =
  match exp with
  | Num n -> Num n
  | Var x -> ( try Var (List.assoc x subst) with Not_found -> Var x)
  | Fn (x, e) ->
      let x' = new_name () in
      let subst' = (x, x') :: subst in
      Fn (x', alpha_conv e subst')
  | Fnr (f, x, e) ->
      let x' = new_name () in
      let f' = new_name () in
      let subst' = (f, f') :: (x, x') :: subst in
      Fnr (f', x', alpha_conv e subst')
  | App (e1, e2) -> App (alpha_conv e1 subst, alpha_conv e2 subst)
  | Ifp (e1, e2, e3) ->
      Ifp (alpha_conv e1 subst, alpha_conv e2 subst, alpha_conv e3 subst)
  | Add (e1, e2) -> Add (alpha_conv e1 subst, alpha_conv e2 subst)
  | Pair (e1, e2) -> Pair (alpha_conv e1 subst, alpha_conv e2 subst)
  | Fst e -> Fst (alpha_conv e subst)
  | Snd e -> Snd (alpha_conv e subst)
  | Raise e -> Raise (alpha_conv e subst)
  | Handle (e1, x, e2) ->
      let x' = new_name () in
      let subst' = (x, x') :: subst in
      Handle (alpha_conv e1 subst, x', alpha_conv e2 subst')

(* TODO : Complete this function *)
let rec xcps' exp =
  let k_h = new_name () in
  match exp with
  (* Constant expressions *)
  | Num n -> Fn (k_h, (* Fill in here *) )
  | Var x -> Fn (k_h, (* Fill in here *) )
  | Fn (x, e) -> Fn (k_h, (* Fill in here *) )
  | Fnr (f, x, e) Fn (k_h, (* Fill in here *) )
   (*Non constant expressions *)
  | App (e1, e2) -> Fn (k_h, (* Fill in here *) )
  | Ifp (e1, e2, e3) -> Fn (k_h, (* Fill in here *) )
  | Add (e1, e2) ->
      let v1 = new_name () in
      let v2 = new_name () in
      Fn
        ( k_h,
          App
            ( xcps' e1,
              Pair
                ( Fn
                    ( v1,
                      App
                        ( xcps' e2,
                          Pair
                            ( Fn (v2, App (Fst (Var k_h), Add (Var v1, Var v2))),
                              Snd (Var k_h) ) ) ),
                  Snd (Var k_h) ) ) )
| Pair (e1, e2) -> Fn (k_h, (* Fill in here *) )
| Fst e -> Fn (k_h, (* Fill in here *) )
| Snd e -> Fn (k_h, (* Fill in here *) )
| Raise e -> Fn (k_h, (* Fill in here *) )
| Handle (e1, x, e2) -> Fn (k_h, (* Fill in here *) )

let xcps exp = xcps' (alpha_conv exp [])
