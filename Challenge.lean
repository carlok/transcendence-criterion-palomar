module

public import Mathlib

public section

/-!
# Gel'fond's transcendence criterion in Waldschmidt's 1971 form

The statements below are the results this repository registers. Each is stated with Mathlib's
own notions and nothing defined here; each `sorry` is deliberate, and `Solution.lean` proves
the same statement from the library under `Diaz/`.

## `TranscendenceCriterion.transcendence_criterion`

**Gel'fond's transcendence criterion** (Waldschmidt 1971). Let `σ₂ ≤ σ₁` be increasing
functions tending to infinity with `σᵢ(x + 1) ≤ aᵢ σᵢ(x)`. If for every large `N` there is a
non-zero integer polynomial `P_N` of degree at most `σ₂(N)` and height at most `exp σ₁(N)` with
`|P_N(α)| < exp(-C σ₁(N) σ₂(N))`, where `C = max(10 + ε, (4 + ε) a₁ a₂)`, then `α` is
algebraic.

* Heights are absolute values of coefficients: `|((P N).coeff i : ℝ)| ≤ exp (σ₁ N)` for every
  `i`.
* `hσ₁t`, `hσ₂t` are `Tendsto σᵢ atTop atTop`; `hgrowth₁`, `hgrowth₂` are the growth bounds for
  `x > 0`.
* `hP_small` is the smallness of `‖aeval α (P N)‖` for every `N > N₀`; the conclusion is
  `IsAlgebraic ℚ α`.
* Source: Waldschmidt 1971 (Gel'fond's criterion).
-/

namespace TranscendenceCriterion

open Filter Topology

/-- **Gel'fond's transcendence criterion** (Waldschmidt 1971). Let `σ₂ ≤ σ₁` be increasing
functions tending to infinity with `σᵢ(x + 1) ≤ aᵢ σᵢ(x)`. If for every large `N` there is a
non-zero integer polynomial `P_N` of degree at most `σ₂(N)` and height at most `exp σ₁(N)` with
`|P_N(α)| < exp(-C σ₁(N) σ₂(N))`, where `C = max(10 + ε, (4 + ε) a₁ a₂)`, then `α` is
algebraic. -/
theorem transcendence_criterion
    (α : ℂ) (ε : ℝ) (hε : 0 < ε)
    (σ₁ σ₂ : ℝ → ℝ) (hσ₁ : StrictMono σ₁) (hσ₂ : StrictMono σ₂)
    (hσ₁t : Tendsto σ₁ atTop atTop) (hσ₂t : Tendsto σ₂ atTop atTop)
    (a₁ a₂ : ℝ) (ha₁ : 1 ≤ a₁) (ha₂ : 1 ≤ a₂)
    (h₂₁ : ∀ x : ℝ, 0 < x → σ₂ x ≤ σ₁ x)
    (hgrowth₁ : ∀ x : ℝ, 0 < x → σ₁ (x + 1) ≤ a₁ * σ₁ x)
    (hgrowth₂ : ∀ x : ℝ, 0 < x → σ₂ (x + 1) ≤ a₂ * σ₂ x)
    (N₀ : ℕ) (P : ℕ → Polynomial ℤ)
    (hP_ne : ∀ N : ℕ, N₀ < N → P N ≠ 0)
    (hP_height : ∀ N : ℕ, N₀ < N → ∀ i : ℕ, |((P N).coeff i : ℝ)| ≤ Real.exp (σ₁ N))
    (hP_deg : ∀ N : ℕ, N₀ < N → ((P N).natDegree : ℝ) ≤ σ₂ N)
    (hP_small : ∀ N : ℕ, N₀ < N →
      ‖Polynomial.aeval α (P N)‖ <
        Real.exp (-(max (10 + ε) ((4 + ε) * (a₁ * a₂)) * σ₁ N * σ₂ N))) :
    IsAlgebraic ℚ α := by
  sorry

end TranscendenceCriterion
