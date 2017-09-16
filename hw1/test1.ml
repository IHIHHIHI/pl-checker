(* Exercise 1. merge *)
open Ex1
open Testlib

module TestEx1: TestEx =
  struct
    let exnum = 1

    type testcase =
      | MERGE of int list * int list * int list

    let runner (tc: testcase): bool =
      match tc with
      | MERGE (l1, l2, o) -> merge(l1, l2) = o

    let testcases: testcase list =
      [ MERGE ([3;2;1], [6;5;4], [6;5;4;3;2;1])
      ; MERGE ([-1;-2;-3;-4;-5], [5;3;0;-6], [5;3;0;-1;-2;-3;-4;-5;-6])
      ; MERGE ([], [], [])
      ; MERGE ([1], [], [1])
      ; MERGE ([], [1], [1])
      ; MERGE ([5;4;3;2;1], [], [5;4;3;2;1])
      ; MERGE ([], [5;4;3;2;1], [5;4;3;2;1])
      ; MERGE ([10;8;6;4;2;0;-2;-4;-6;-8;-10], [9;7;5;3;1;-1;-3;-5;-7;-9], [10;9;8;7;6;5;4;3;2;1;0;-1;-2;-3;-4;-5;-6;-7;-8;-9;-10])
      ]
  end

open TestEx1
let _ = wrapper testcases runner exnum
