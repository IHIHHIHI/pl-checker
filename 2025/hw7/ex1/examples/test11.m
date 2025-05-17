(* testcase 11 : ifp *)

ifp ((fn x => x + 1) (-1)) then 0 else ((fn y => y + 3) 0)
