# Gel'fond's transcendence criterion in Waldschmidt's 1971 form

A Lean 4 and Mathlib proof of gel'fond's transcendence criterion, prepared for the [Palomar
registry](https://palomar-registry.org/). It is a self-contained extract of the library
[carlok/diaz-modulus-lean](https://github.com/carlok/diaz-modulus-lean), which is the canonical
home of the proofs.

## Results

- `TranscendenceCriterion.transcendence_criterion`: **Gel'fond's transcendence criterion**
  (Waldschmidt 1971). Let `σ₂ ≤ σ₁` be increasing functions tending to infinity with `σᵢ(x + 1) ≤
  aᵢ σᵢ(x)`. If for every large `N` there is a non-zero integer polynomial `P_N` of degree at
  most `σ₂(N)` and height at most `exp σ₁(N)` with `|P_N(α)| < exp(-C σ₁(N) σ₂(N))`, where `C =
  max(10 + ε, (4 + ε) a₁ a₂)`, then `α` is algebraic. Source: Waldschmidt 1971 (Gel'fond's
  criterion).

## Layout

- `Challenge.lean`: the statements, with deliberate `sorry`, importing Mathlib only.
- `Solution.lean`: the same statements, proved by the library theorems.
- `Diaz/`: the 8 library modules the proofs need, copied from diaz-modulus-lean at
  `59d5a598c292` and changed only for the Lean module system (`module`, `public import`,
  `@[expose] public section`). Paths and namespaces are the library's.
- `comparator.json`, `formalization.yaml`: the Palomar submission metadata.

## Build

```bash
lake exe cache get && lake build
```

Lean 4.35.0, Mathlib v4.35.0. `scripts/verify-comparator.sh` runs the toolchain's
`lake comparator` the way Palomar does.

## Related

- The six exponentials theorem from the same library is registered separately as
  [PALOMAR-2026-11-22-000020](https://palomar-registry.org/entry?id=PALOMAR-2026-11-22-000020&version=1).
- Submissions go to https://submit.palomar-registry.org/.

## Authorship

Claude agents (Anthropic) wrote the Lean statements and proofs under Carlo Perassi's direction;
see `formalization.yaml` and the library's `docs/method.md`. Licence: Apache-2.0.
