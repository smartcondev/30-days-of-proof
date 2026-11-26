def myMax (a b : Int) : Int :=
  if b < a then a else b



theorem myMax_left : ∀ a b : Int, b ≤ a → myMax a b = a := by
  intro a b h
  unfold myMax
  split
  · rfl
  · omega

theorem myMax_right : ∀ a b : Int, a ≤ b → myMax a b = b := by
  intro a b h
  unfold myMax
  split
  · omega
  · rfl

theorem myMax_spec : ∀ a b : Int,
    (b ≤ a → myMax a b = a) ∧ (a ≤ b → myMax a b = b) := by
  intro a b
  constructor
  · exact myMax_left a b
  · exact myMax_right a b


theorem myMax_spec2 : ∀ a b : Int,
    (b ≤ a → myMax a b = a) ∧ (a ≤ b → myMax a b = b) := by
  intro a b
  constructor
  · intro h
    unfold myMax
    split
    · rfl
    · omega
  · intro h
    unfold myMax
    split
    · omega
    · rfl
