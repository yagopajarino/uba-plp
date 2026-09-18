# Ejercicio 6

```txt
Dadas las siguientes funciones:

zip :: [a] -> [b] -> [(a,b)]
{Z0} zip = foldr (\x rec ys ->
                    if null ys
                    then []
                    else (x, head ys) : rec (tail ys))
                  (const [])

zip' :: [a] -> [b] -> [(a,b)]
{Z'0} zip' []       ys = []
{Z'1} zip' (x:xs)   ys = if null ys then [] else (x, head ys) : zip' xs (tail ys)

Demostrar que zip = zip' utilizando inducción estructural y el principio de extensionalidad.
```

Busco probar que `zip = zip'`.

Por extensionalidad funcional, alcanza con probar:

```txt
∀ xs::[a] . ∀ ys::[b] . zip xs ys = zip' xs ys
```

Hago inducción estructural sobre la lista `xs`.

Defino el predicado:

```txt
P(xs): ∀ ys::[b] . zip xs ys = zip' xs ys
```

Para abreviar, defino:

```txt
f = \x rec ys ->
      if null ys
      then []
      else (x, head ys) : rec (tail ys)
```

### Caso base

Busco probar `P([])`:

```txt
∀ ys::[b] . zip [] ys = zip' [] ys
```

```txt
zip [] ys
= foldr f (const []) [] ys                                      {Z0}
= (const []) ys                                                 {F0}
= []                                                            {CONST}
```

Por otro lado:

```txt
zip' [] ys
= []                                                            {Z'0}
```

Luego vale el caso base.

### Paso inductivo

Busco probar:

```txt
∀ xs::[a] . ∀ x::a . P(xs) => P(x:xs)
```

Defino la hipótesis inductiva:

```txt
{HI} ∀ ys::[b] . zip xs ys = zip' xs ys
```

Busco probar `P(x:xs)`:

```txt
∀ ys::[b] . zip (x:xs) ys = zip' (x:xs) ys
```

Entonces:

```txt
zip (x:xs) ys
= foldr f (const []) (x:xs) ys                                  {Z0}
= f x (foldr f (const []) xs) ys                                {F1}
= if null ys
  then []
  else (x, head ys) : (foldr f (const []) xs) (tail ys)          {B}
= if null ys
  then []
  else (x, head ys) : zip xs (tail ys)                           {Z0}
= if null ys
  then []
  else (x, head ys) : zip' xs (tail ys)                          {HI}
= zip' (x:xs) ys                                                 {Z'1}
```

Luego vale el paso inductivo.

Por inducción estructural sobre `xs`, vale:

```txt
∀ xs::[a] . ∀ ys::[b] . zip xs ys = zip' xs ys
```

Por extensionalidad funcional, concluyo:

```txt
zip = zip'
```
