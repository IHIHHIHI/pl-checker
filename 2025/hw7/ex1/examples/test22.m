(* 22. recursion with pair *)

(rec f x =>
  ifp (x + (-1)) then (
    (rec g y =>
      (ifp y.2 then
        ((g (y.1, (y.2 + (-1)))) + (y.1))
      else
        0)
    ) (x, f (x + (-1)))
  )
  else 
    1
) 3
