# Ejercicio 3

Sean `τ`, `σ`, `ρ` y `ζ` proposiciones tales que `τ ⇒ σ` es una tautología y `ρ ⇒ ζ` es una contradicción. Determinar si las siguientes proposiciones son tautologías, contradicciones o contingencias:

1. `(τ ⇒ σ) ∨ (ρ ⇒ ζ)`
2. `(τ ⇒ ρ) ∨ (σ ⇒ ζ)`
3. `(ρ ⇒ σ) ∨ (ζ ⇒ σ)`

## Recordatorio

Una fórmula es una **tautología** si resulta verdadera en todas las interpretaciones. Por ejemplo, `P ∨ ¬P` es verdadera sin importar el valor de `P`.

Una fórmula es una **contradicción** si resulta falsa en todas las interpretaciones. Por ejemplo, `P ∧ ¬P` es siempre falsa.

Una fórmula es una **contingencia** si es verdadera en algunas interpretaciones y falsa en otras. Por ejemplo, `P ∧ Q` puede ser verdadera o falsa según los valores de `P` y `Q`.

## Hipótesis

Como `τ ⇒ σ` es una tautología, su valor es siempre `V`. En particular, no puede ocurrir que `τ` sea verdadera y `σ` sea falsa.

Como `ρ ⇒ ζ` es una contradicción, su valor es siempre `F`. Una implicación es falsa únicamente cuando su antecedente es verdadero y su consecuente es falso. Por lo tanto, en toda interpretación:

```txt
ρ = V
ζ = F
```

## I. `(τ ⇒ σ) ∨ (ρ ⇒ ζ)`

Por las hipótesis:

```txt
(τ ⇒ σ) ∨ (ρ ⇒ ζ)
= V ∨ F
= V
```

La fórmula es una **tautología**.

## II. `(τ ⇒ ρ) ∨ (σ ⇒ ζ)`

Sabemos que `ρ = V`. Por lo tanto, `τ ⇒ ρ` siempre es verdadera, independientemente del valor de `τ`:

```txt
(τ ⇒ ρ) ∨ (σ ⇒ ζ)
= V ∨ (σ ⇒ ζ)
= V
```

La fórmula es una **tautología**.

## III. `(ρ ⇒ σ) ∨ (ζ ⇒ σ)`

Sabemos que `ζ = F`. Una implicación con antecedente falso siempre es verdadera, por lo que `ζ ⇒ σ` vale `V` independientemente del valor de `σ`:

```txt
(ρ ⇒ σ) ∨ (ζ ⇒ σ)
= (ρ ⇒ σ) ∨ V
= V
```

La fórmula es una **tautología**.
