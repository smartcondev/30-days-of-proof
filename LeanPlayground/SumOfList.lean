def sumOfList (l : List Int) : Int :=
  match l with
  | [] => 0
  | x :: xs => x + sumOfList xs
