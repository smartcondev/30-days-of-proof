
def myAbs (n : Int) : Int :=
  if n < 0 then -n else n



theorem myAbs_neg_five : myAbs (-5) = 5 := by
  rfl


theorem myAbs_nonneg : ∀ (n : Int), myAbs n >= 0 := by
  intro n
  unfold myAbs
  split
  . omega
  . omega

theorem myAbs_complete_spec : ∀ (n : Int), (myAbs n >= 0 ) ∧ (myAbs n = n ∨ myAbs n = -n) := by
  intro n
  constructor
  . exact myAbs_nonneg n
  . unfold myAbs
    split
    . right
      rfl
    . left
      rfl


theorem myAbs_spec : ∀ (n : Int), (n < 0 → myAbs n = -n) ∧ (0 ≤ n → myAbs n = n) := by
  intro n
  grind [myAbs]
