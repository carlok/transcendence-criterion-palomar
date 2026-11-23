module

public import Mathlib
public import Diaz.Mirror.transcendence_criterion

public section

/-!
# Proved solution

The proved counterparts of the declarations stated in `Challenge.lean`. Comparator checks that
each has the same name and type as its counterpart there and depends on no axiom beyond
`propext`, `Quot.sound` and `Classical.choice`. Each is the library theorem named beside it,
whose statement is the same up to unfolding the library's abbreviations.

* `TranscendenceCriterion.transcendence_criterion`: `Diaz.transcendence_criterion`
-/

namespace TranscendenceCriterion

open Filter Topology

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
    IsAlgebraic ℚ α :=
  Diaz.transcendence_criterion α ε hε σ₁ σ₂ hσ₁ hσ₂ hσ₁t hσ₂t a₁ a₂ ha₁ ha₂ h₂₁ hgrowth₁ hgrowth₂ N₀ P hP_ne hP_height hP_deg hP_small

end TranscendenceCriterion
