(* Public testcase 5 : fibonacci with recursion. *)

(rec fib x => (ifp x then (ifp (x + (-1)) then (fib (x + (-2)) + fib (x + (-1))) else 1) else 0)) 8

(* Output : 21 *)
