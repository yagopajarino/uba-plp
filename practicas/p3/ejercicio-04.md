# Ejercicio 4

Probar que cualquier fórmula que sea una tautología contiene un `¬` o un `⇒`.

## Demostración

Lo pruebo por contrarrecíproco. Es decir, voy a demostrar:

> Si una fórmula no contiene `¬` ni `⇒`, entonces no es una tautología.

Si la fórmula no contiene `¬` ni `⇒`, está formada únicamente por variables proposicionales y los conectivos `∨` y `∧`.

Considero la interpretación en la que todas las variables proposicionales toman el valor `F`.

Para esta interpretación:

```txt
A ∧ B = F ∧ F = F
A ∨ B = F ∨ F = F
```

Por lo tanto, sin importar cuántos conectivos y variables proposicionales tenga la fórmula, si todas sus variables son falsas, la fórmula completa también es falsa.

Entonces encontramos una interpretación en la cual la fórmula es falsa. En consecuencia, la fórmula no puede ser una tautología.

Por contrarrecíproco, toda tautología contiene al menos un `¬` o un `⇒`.
