(* testcase 12 : higher order function *)

(fn f => f (fn p => (fn a => 1 + a + (p 10)))) (fn ff => ((ff (fn q => ifp q then (q + 200) else (q + 100))) 1000) + 10000)
