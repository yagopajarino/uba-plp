# Ejercicio 2

Lo pruebo por inducción estructural sobre la fórmula.

### Caso base

Si `P` es una variable proposicional, ya es una fórmula que no utiliza ningún conectivo. Por lo tanto, se puede escribir usando solamente `¬` y `∨`.

### Paso inductivo

Supongo que `P` y `Q` cumplen la propiedad, es decir, que pueden reescribirse como fórmulas equivalentes que usan solamente `¬` y `∨`.

Tengo que probar que también puedo reescribir las fórmulas construidas a partir de ellas.

#### Caso `¬P`

Por hipótesis inductiva, `P` se puede reescribir usando solamente `¬` y `∨`. Entonces, al anteponerle una negación, `¬P` también queda escrita usando solamente esos conectivos.

#### Caso `P ∨ Q`

Por hipótesis inductiva, tanto `P` como `Q` se pueden reescribir usando solamente `¬` y `∨`. Por lo tanto, su disyunción `P ∨ Q` también.

#### Caso `P ∧ Q`

Una conjunción es falsa cuando `P` o `Q` es falsa. Por lo tanto, es verdadera exactamente cuando no ocurre que `P` sea falsa o que `Q` sea falsa:

```txt
P ∧ Q ≡ ¬(¬P ∨ ¬Q)
```

Lo verifico mediante una tabla de verdad:

| `P` | `Q` | `P ∧ Q` | `¬P` | `¬Q` | `¬P ∨ ¬Q` | `¬(¬P ∨ ¬Q)` |
|:---:|:---:|:-------:|:----:|:----:|:-----------:|:--------------:|
| V | V | V | F | F | F | V |
| V | F | F | F | V | V | F |
| F | V | F | V | F | V | F |
| F | F | F | V | V | V | F |

Luego, puedo reescribir `P ∧ Q` como `¬(¬P ∨ ¬Q)`, que utiliza solamente `¬` y `∨`.

#### Caso `P ⇒ Q`

La implicación `P ⇒ Q` es falsa solamente cuando `P` es verdadera y `Q` es falsa. Usando el caso anterior, `P ∧ ¬Q` coincide con la fórmula `¬P ∨ Q`:

```txt
P ⇒ Q ≡ ¬P ∨ Q
```

Lo verifico mediante una tabla de verdad:

| `P` | `Q` | `P ⇒ Q` | `¬P` | `¬P ∨ Q` |
|:---:|:---:|:-------:|:----:|:--------:|
| V | V | V | F | V |
| V | F | F | F | F |
| F | V | V | V | V |
| F | F | V | V | V |

Luego, puedo reescribir `P ⇒ Q` como `¬P ∨ Q`, que utiliza solamente `¬` y `∨`.

Como todos los constructores preservan la propiedad, por inducción estructural cualquier fórmula construida con `¬`, `∧`, `∨` y `⇒` puede reescribirse como una fórmula equivalente que use solamente `¬` y `∨`.
