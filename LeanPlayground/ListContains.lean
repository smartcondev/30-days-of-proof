def listContains (l : List Int) (n : Int) : Bool :=
  match l with
  | [] => false
  | x :: xs => if x = n then true else listContains xs n
