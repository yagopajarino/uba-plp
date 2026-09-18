# Ejercicio 13

## Definiciones usadas

```hs
data Polinomio a
  = X
  | Cte a
  | Suma (Polinomio a) (Polinomio a)
  | Prod (Polinomio a) (Polinomio a)

foldPoli :: b
         -> (a -> b)
         -> (b -> b -> b)
         -> (b -> b -> b)
         -> Polinomio a
         -> b
foldPoli fx fcte fsuma fprod p = case p of
  X        -> fx
  Cte n    -> fcte n
  Suma i d -> fsuma (rec i) (rec d)
  Prod i d -> fprod (rec i) (rec d)
  where rec = foldPoli fx fcte fsuma fprod

evaluar :: Num a => a -> Polinomio a -> a
evaluar n = foldPoli n id (+) (*)

derivado :: Num a => Polinomio a -> Polinomio a
derivado poli = case poli of
  X        -> Cte 1
  Cte _    -> Cte 0
  Suma p q -> Suma (derivado p) (derivado q)
  Prod p q -> Suma (Prod (derivado p) q) (Prod (derivado q) p)

sinConstantesNegativas :: Num a => Polinomio a -> Bool
sinConstantesNegativas = foldPoli True (>= 0) (&&) (&&)

esRaiz :: Num a => a -> Polinomio a -> Bool
esRaiz n p = evaluar n p == 0
```

## I. `foldPoli X Cte Suma Prod = id`

Tiene sentido porque en el `fold` lo único que voy a usar es aplicar los constructores.

Por extensionalidad alcanza con ver que, para todo `p :: Polinomio a`,

```txt
foldPoli X Cte Suma Prod p = id p
```

Lo pruebo por inducción estructural en `p`. Defino:

```txt
P(p): foldPoli X Cte Suma Prod p = id p
```

### Casos base

**Caso `X`.** Quiero probar `P(X)`:

```txt
foldPoli X Cte Suma Prod X
= X                         {foldPoli}
= id X                      {id}
```

**Caso `Cte a`.** Quiero probar `P(Cte a)`:

```txt
foldPoli X Cte Suma Prod (Cte a)
= Cte a                     {foldPoli}
= id (Cte a)                {id}
```

### Paso inductivo

Supongo que valen `P(x)` y `P(y)`, y pruebo `P(Suma x y)` y `P(Prod x y)`.

**Caso `Suma x y`.**

```txt
foldPoli X Cte Suma Prod (Suma x y)
= Suma (foldPoli X Cte Suma Prod x)
       (foldPoli X Cte Suma Prod y)       {foldPoli}
= Suma x y                               {HI en x e y}
= id (Suma x y)                          {id}
```

El caso `Prod x y` es análogo, usando `Prod` en lugar de `Suma`.

## II. `esRaiz r p => esRaiz r (Prod p q)`

Lo pruebo por inducción estructural en el polinomio `p`. Defino:

```txt
P(p): esRaiz r p => esRaiz r (Prod p q)
```

### Casos base

**Caso `X`.** Quiero probar:

```txt
esRaiz r X => esRaiz r (Prod X q)
```

Desarrollo el antecedente:

```txt
esRaiz r X
= evaluar r X == 0                    {esRaiz}
= foldPoli r id (+) (*) X == 0         {evaluar}
= r == 0                              {foldPoli}
```

Si `r /= 0`, la premisa es falsa y vale la implicación. Si `r = 0`, pruebo el consecuente:

```txt
esRaiz r (Prod X q)
= evaluar r (Prod X q) == 0                      {esRaiz}
= foldPoli r id (+) (*) (Prod X q) == 0          {evaluar}
= f X * f q == 0                                {foldPoli}
= 0 * f q == 0                                  {f X = evaluar r X = 0}
= 0 == 0
```

donde `f = foldPoli r id (+) (*)`.

**Caso `Cte a`.** Quiero probar:

```txt
esRaiz r (Cte a) => esRaiz r (Prod (Cte a) q)
```

Desarrollo el antecedente:

```txt
esRaiz r (Cte a)
= evaluar r (Cte a) == 0                {esRaiz}
= foldPoli r id (+) (*) (Cte a) == 0    {evaluar}
= id a == 0                            {foldPoli}
= a == 0                               {id}
```

Si `a /= 0`, la premisa es falsa. Si `a = 0`, pruebo el consecuente:

```txt
esRaiz r (Prod (Cte a) q)
= evaluar r (Prod (Cte a) q) == 0                  {esRaiz}
= foldPoli r id (+) (*) (Prod (Cte a) q) == 0      {evaluar}
= f (Cte a) * f q == 0                            {foldPoli}
= 0 * f q == 0                                    {f (Cte a) = evaluar r (Cte a) = 0}
= 0 == 0
```

donde `f = foldPoli r id (+) (*)`.

### Paso inductivo

Supongo que valen `P(x)` y `P(y)`, y pruebo `P(Suma x y)` y `P(Prod x y)`.

**Caso `Suma x y`.** Quiero probar:

```txt
esRaiz r (Suma x y) => esRaiz r (Prod (Suma x y) q)
```

Asumo que vale `esRaiz r (Suma x y)` y desarrollo el consecuente:

```txt
esRaiz r (Prod (Suma x y) q)
= evaluar r (Prod (Suma x y) q) == 0              {esRaiz}
= foldPoli r id (+) (*) (Prod (Suma x y) q) == 0  {evaluar}
= f (Suma x y) * f q == 0                        {foldPoli}
= 0 * f q == 0                                  {esRaiz r (Suma x y)}
= 0 == 0
```

donde `f = foldPoli r id (+) (*)`. El caso `Prod x y` es análogo. Luego queda probado para todo polinomio.

## III - ToDo

## IV - ToDo
