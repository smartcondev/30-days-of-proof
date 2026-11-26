# 30 Days of Proof

A 30-day challenge to learn **formal verification** by doing it: writing specifications for small programs in [Lean 4](https://lean-lang.org/) and proving, with machine-checked proofs, that the programs meet them.

> Formal verification means proving that a program matches its specification, for **every** input, not just the ones we test.

The focus of these 30 days is the part most people find hardest: **writing and reading good specs**. Proofs come second. Where Lean's automation (`grind`, `fun_induction`) can do the routine work, I let it, and I learn the manual techniques at the points where automation gets stuck.

## The method

Every function in this repo goes through the same loop:

1. **State the requirement in plain English.** What should the function do?
2. **Write a first spec in Lean**, with `sorry` in place of the proof.
3. **Try to break it.** Find a *wrong* function that still satisfies the spec. If one exists, the spec is too weak.
4. **Strengthen the spec** until no wrong function gets through.
5. **Test it** on examples with `#eval` before trying to prove anything.
6. **Prove it.** Try automation first. When it fails, break the goal into smaller goals and find the missing fact, usually a helper lemma.
7. **Write down where I got stuck** and what got me unstuck. That log is the real output of the challenge.

## What's in this repo

All files live in [`LeanPlayground/`](LeanPlayground). The proofs use core Lean only, with no Mathlib.

| File | Function | Status |
|---|---|---|
| [`MyAbs.lean`](LeanPlayground/MyAbs.lean) | Absolute value of an integer | ✅ Verified |
| [`MyMax.lean`](LeanPlayground/MyMax.lean) | Larger of two integers | ✅ Verified |
| [`MaxOfList.lean`](LeanPlayground/MaxOfList.lean) | Largest value of a list (with `foldl`) | ✅ Verified |
| [`MaxOfListRec.lean`](LeanPlayground/MaxOfListRec.lean) | Largest value of a list (recursive) | 🔨 Implemented, spec next |
| [`SumOfList.lean`](LeanPlayground/SumOfList.lean) | Sum of a list (recursive) | 🔨 Implemented, spec next |
| [`SumOfListFold.lean`](LeanPlayground/SumOfListFold.lean) | Sum of a list (with `foldl`) | 🔨 Implemented, spec next |
| [`ListContains.lean`](LeanPlayground/ListContains.lean) | Whether a list contains an integer | 🔨 Implemented, spec next |
| [`InsertionSort.lean`](LeanPlayground/InsertionSort.lean) | Sorting a list into ascending order | 🔨 Implemented, spec next |

### Example: the spec of `maxOfList`

`maxOfList` returns `none` for an empty list and `some m`, where `m` is the largest value, otherwise. Its spec has three parts, and each one rules out a different wrong function:

| Proposition | Rules out |
|---|---|
| `maxOfList l = none ↔ l = []` | a function that never returns an answer |
| `maxOfList l = some m → m ∈ l` | a function that invents a number not in the list |
| `maxOfList l = some m → ∀ y ∈ l, y ≤ m` | a function that returns the wrong element, such as the first one |

Drop any one of them and a wrong function passes. All three are proved in [`MaxOfList.lean`](LeanPlayground/MaxOfList.lean), along with the helper lemmas about `foldl` they need.

## The 30-day plan

### Week 1: Foundations
- [x] `myAbs`: first complete spec and proof
- [x] `myMax`: specs with conditions (`b ≤ a → ...`)
- [x] `maxOfList` with `foldl`: a three-part spec, helper lemmas and induction

### Week 2: Lists and loops
- [ ] `maxOfListRec`: prove the **same spec** for the recursive version, and compare the proofs
- [ ] `sumOfList` and `sumOfListFold`: prove that both agree, and that `sum (xs ++ ys) = sum xs + sum ys`
- [ ] `listContains`: prove `listContains l n = true ↔ n ∈ l`, connecting a `Bool` computation to a `Prop`

### Week 3: Classic algorithms
- [ ] `insertionSort`: the output is sorted **and** is a permutation of the input (either part alone lets a wrong function through)
- [ ] Binary search: soundness ("if it returns an index, the target is there") and completeness ("if the target is there, it finds it")
- [ ] Maximum subarray (Kadane's algorithm): a real test of loop invariants

### Week 4: Consolidate and share
- [ ] Clean up every proof and add a short comment explaining its key idea
- [ ] Write up the findings: what each proof needed, where automation failed, and why
- [ ] Turn the "where I got stuck" notes into a map of the concepts a beginner needs to verify code like this

## Lessons so far

- **A spec is only as good as its weakest part.** Asking "what wrong function would pass this?" is the most useful habit in verification.
- **"If … then …" specs can be satisfied by doing nothing.** A function that never returns `some m` passes every `maxOfList l = some m → ...` claim vacuously. A spec needs a part that forces an answer.
- **Proving a loop needs a claim about every state of the loop.** For `foldl`, the helper lemma has to hold for *every* starting value, because the starting value changes at each step.
- **Automation does the routine steps. Breaking the problem down is still my job.** `grind` closes most goals once I've chosen the right helper lemma and induction.

## Building

You need [Lean 4](https://lean-lang.org/), installed with `elan`. This project uses Lean **4.33.1**, set in [`lean-toolchain`](lean-toolchain).

```bash
lake build              # builds the project and checks every proof
lake exe lean_playground   # runs a few of the functions
```

If `lake build` succeeds, every proof in the repo has been checked by Lean. The GitHub Actions workflow runs the same build on every push.

## Resources

- [Theorem Proving in Lean 4](https://lean-lang.org/theorem_proving_in_lean4/)
- [Functional Programming in Lean](https://lean-lang.org/functional_programming_in_lean/)
