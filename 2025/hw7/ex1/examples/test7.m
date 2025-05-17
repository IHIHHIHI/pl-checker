(* Public testcase 7 : Recursion and high order function *)

(fn f => f (f 4))
(rec sum x => (ifp x then (sum (x + (-1)) + x) else 0))

(* Output : 55 *)
