def sumOfListFold (l : List Int) : Int :=
  l.foldl (· + ·) 0
