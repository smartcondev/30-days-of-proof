def maxOfList (l : List Int) : Option Int :=
match l with
  | [] => none
  | x::xs => some (xs.foldl max x)

/-
maxOfList is expected to:
1. Return none if the list is empty.
2. Return some m if the list is non-empty, where m is the largest value of that list.

A number m is the largest value of a list l when two things are true:

1. m is one of the elements of l.
2. m is greater than or equal to every element of l.

This leads to three propositions that we need to prove:

1. maxOfList returns none if and only if the list is empty. This covers both halves of the first expectation: an empty list gives none, and a non-empty list never does.
2. If maxOfList returns some m, then m is an element of the list.
3. If maxOfList returns some m, then m is greater than or equal to every element of the list.
-/

-- The theorem below verify our first prop about maxOfList
theorem maxOfList_none : ∀ (l : List Int), maxOfList l = none ↔ l = [] := by
  intro l
  constructor
  . intro h
    cases l with
    | nil => rfl
    | cons x xs =>
      unfold maxOfList at h
      simp at h
  · intro h
    rw [h]
    rfl


-- A theorem written to help prove another theorem is called a helper lemma.

theorem foldl_max_mem : ∀ (xs : List Int) (x : Int), List.foldl max x xs = x ∨ List.foldl max x xs ∈ xs := by
  intro xs
  induction xs with
    | nil =>
      intro x
      left
      rfl
    | cons y ys ih =>
      intro x
      show List.foldl max (max x y) ys = x ∨ List.foldl max (max x y) ys ∈ y :: ys
      cases ih (max x y) with
      | inl h =>
        rw [h]
        rw [Int.max_def]
        split
        . right
          simp
        . left
          rfl
      | inr h =>
        right
        exact List.mem_cons_of_mem y h

theorem maxOfList_isMember : ∀ (l : List Int) (m : Int), maxOfList l = some m → m ∈ l := by
  intro l m h
  cases l with
  | nil =>
    unfold maxOfList at h
    simp at h
  | cons x xs =>
    unfold maxOfList at h
    simp at h
    cases foldl_max_mem xs x with
    | inl h2 =>
      rw [← h, h2]
      simp
    | inr h2 =>
      rw [← h]
      exact List.mem_cons_of_mem x h2

/-- Helper lemma 1: the walk's result is at least its starting value. -/
theorem foldl_max_ge_start : ∀ (xs : List Int) (x : Int), x ≤ List.foldl max x xs := by
  intro xs
  induction xs with
    | nil =>
      intro x
      simp
    | cons y ys ih =>
      intro x
      show x ≤ List.foldl max (max x y) ys
      have h := ih (max x y)
      omega

/-- Helper lemma 2: the walk's result is at least every element of the list. -/
theorem foldl_max_ge_all : ∀ (xs : List Int) (x : Int), ∀ z ∈ xs, z ≤ List.foldl max x xs := by
  intro xs
  induction xs with
    | nil =>
      intro x z hz
      cases hz
    | cons y ys ih =>
      intro x z hz
      show z ≤ List.foldl max (max x y) ys
      cases List.mem_cons.mp hz with
      | inl h =>
        have h2 := foldl_max_ge_start ys (max x y)
        omega
      | inr h =>
        exact ih (max x y) z h

theorem maxOfList_isGreatest : ∀ (l : List Int) (m : Int), maxOfList l = some m → ∀ y ∈ l, y ≤ m := by
  intro l m h y hy
  cases l with
  | nil =>
    unfold maxOfList at h
    simp at h
  | cons x xs =>
    unfold maxOfList at h
    simp at h
    rw [← h]
    cases List.mem_cons.mp hy with
    | inl h2 =>
      have h3 := foldl_max_ge_start xs x
      omega
    | inr h2 =>
      exact foldl_max_ge_all xs x y h2



-- The complete specification of maxOfList, combining all three propositions.
theorem maxOfList_spec : ∀ (l : List Int),
    (maxOfList l = none ↔ l = []) ∧
    (∀ (m : Int), maxOfList l = some m → m ∈ l ∧ ∀ y ∈ l, y ≤ m) := by
  intro l
  constructor
  · exact maxOfList_none l
  · intro m h
    constructor
    · exact maxOfList_isMember l m h
    · exact maxOfList_isGreatest l m h
