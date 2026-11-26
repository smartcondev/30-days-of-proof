import LeanPlayground

def main : IO Unit := do
  IO.println "30 Days of Proof: a few verified (and soon-to-be verified) functions"
  IO.println s!"maxOfList [3, -7, 9, 4]          = {repr (maxOfList [3, -7, 9, 4])}"
  IO.println s!"maxOfList []                     = {repr (maxOfList [])}"
  IO.println s!"sumOfList [3, -7, 9, 4]          = {sumOfList [3, -7, 9, 4]}"
  IO.println s!"listContains [3, -7, 9, 4] 9     = {listContains [3, -7, 9, 4] 9}"
  IO.println s!"insertionSort [7, 4, 3, 8, 1]    = {insertionSort [7, 4, 3, 8, 1]}"
