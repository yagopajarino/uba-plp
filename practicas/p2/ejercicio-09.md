# Ejercicio 9

Demostrar que la funcion `potencia`, definida en la practica 1 usando `foldNat`, funciona correctamente mediante induccion en el exponente.

Recordemos las definiciones:

```hs
foldNat :: (Integer -> b -> b) -> b -> Integer -> b
foldNat fRec fBase x = case x of
  0 -> fBase
  n -> fRec n (foldNat fRec fBase (n - 1))

potencia :: Integer -> Integer -> Integer
potencia x = foldNat (\i rec -> x * rec) 1
```

Busco probar:

```txt
∀ x::Integer . ∀ n::Nat . potencia x n = x^n
```

Hago induccion sobre el exponente `n`.

Defino:

```txt
P(n): potencia x n = x^n
```

## Caso base

Busco probar `P(0)`:

```txt
potencia x 0 = x^0
```

```txt
potencia x 0
= foldNat (\i rec -> x * rec) 1 0          {potencia}
= 1                                        {F0}
= x^0                                      {potencia}
```

Luego vale el caso base.

## Paso inductivo

Busco probar:

```txt
∀ n::Nat . P(n) => P(n + 1)
```

Defino la hipotesis inductiva:

```txt
{HI} potencia x n = x^n
```

Busco probar:

```txt
potencia x (n + 1) = x^(n + 1)
```

```txt
potencia x (n + 1)
= foldNat (\i rec -> x * rec) 1 (n + 1)                         {potencia}
= (\i rec -> x * rec) (n + 1) (foldNat (\i rec -> x * rec) 1 n)  {F1}
= x * foldNat (\i rec -> x * rec) 1 n                            {β}
= x * potencia x n                                               {potencia}
= x * x^n                                                        {HI}
= x^(n + 1)                                                      {potencia}
```

Por lo tanto vale el paso inductivo.

Entonces, por induccion en `n`, queda probado:

```txt
∀ x::Integer . ∀ n::Nat . potencia x n = x^n
```
