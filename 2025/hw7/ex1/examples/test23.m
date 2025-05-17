(* 23. recursion with high order function *)

(fn f => f (f 5))
(rec sum x => (ifp x then (sum (x + (-1)) + x) else 0))
