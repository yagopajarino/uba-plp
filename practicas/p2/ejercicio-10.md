# Ejercicio 10

Dadas las funciones `altura` y `cantNodos` definidas en la practica 1 para arboles binarios, demostrar:

```txt
∀ x::AB a . altura x <= cantNodos x
```

Recordemos el tipo de arboles binarios:

```hs
data AB a = Nil | Bin (AB a) a (AB a)
```

Y el esquema de recursion estructural:

```hs
foldAB :: b -> (b -> a -> b -> b) -> AB a -> b
foldAB fNil fBin arb = case arb of
  Nil       -> fNil
  Bin i r d -> fBin (rec i) r (rec d)
  where rec = foldAB fNil fBin
```

Las funciones quedan definidas como:

```hs
altura :: AB a -> Int
altura = foldAB 0 (\reci _ recd -> 1 + max reci recd)

cantNodos :: AB a -> Int
cantNodos = foldAB 0 (\reci _ recd -> 1 + reci + recd)
```

Ahora busco probar:

```txt
∀ ab::AB a . altura ab <= cantNodos ab
```

Lo pruebo por induccion estructural en el tipo `AB`.

Defino:

```txt
P(x): altura x <= cantNodos x
```

## Caso base

Busco probar `P(Nil)`:

```txt
altura Nil <= cantNodos Nil
```

```txt
altura Nil
= 0                          {altura}

cantNodos Nil
= 0                          {cantNodos}
```

Luego:

```txt
0 <= 0
```

Por lo tanto vale el caso base.

## Paso inductivo

Busco probar:

```txt
∀ i d::AB a . ∀ r::a . P(i) && P(d) => P(Bin i r d)
```

Defino las hipotesis inductivas:

```txt
{HI1} altura i <= cantNodos i
{HI2} altura d <= cantNodos d
```

Busco probar:

```txt
altura (Bin i r d) <= cantNodos (Bin i r d)
```

Desarrollo el lado izquierdo:

```txt
altura (Bin i r d)
= foldAB 0 (\reci _ recd -> 1 + max reci recd) (Bin i r d)  {altura}
= 1 + max (foldAB 0 f i) (foldAB 0 f d)                     {foldAB}
= 1 + max (altura i) (altura d)
```

donde:

```txt
f = \reci _ recd -> 1 + max reci recd
```

Desarrollo el lado derecho:

```txt
cantNodos (Bin i r d)
= foldAB 0 (\reci _ recd -> 1 + reci + recd) (Bin i r d)    {cantNodos}
= 1 + (foldAB 0 g i) + (foldAB 0 g d)                       {foldAB}
= 1 + cantNodos i + cantNodos d
```

donde:

```txt
g = \reci _ recd -> 1 + reci + recd
```

Entonces alcanza con probar:

```txt
1 + max (altura i) (altura d) <= 1 + cantNodos i + cantNodos d
```

Por las hipotesis inductivas:

```txt
altura i <= cantNodos i
altura d <= cantNodos d
```

Ademas:

```txt
max (altura i) (altura d) <= altura i + altura d
```

Luego:

```txt
1 + max (altura i) (altura d)
<= 1 + altura i + altura d
<= 1 + cantNodos i + cantNodos d
```

Por lo tanto:

```txt
altura (Bin i r d) <= cantNodos (Bin i r d)
```

Como se queria probar.
