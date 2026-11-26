def insertSorted (y : Int) (l : List Int) : List Int :=
  match l with
  | [] => [y]
  | x :: xs => if y ≤ x then y :: x :: xs else x :: insertSorted y xs

def insertionSort (l : List Int) : List Int :=
  match l with
  | [] => []
  | x :: xs => insertSorted x (insertionSort xs)
