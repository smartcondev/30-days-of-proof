def maxOfListRec (l : List Int) : Option Int :=
  match l with
  | [] => none
  | x :: xs =>
    match maxOfListRec xs with
    | none => some x
    | some m => some (max x m)
