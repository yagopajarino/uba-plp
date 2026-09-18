# Ejercicio 7

Dadas las siguientes funciones:

```hs
nub :: Eq a => [a] -> [a]
{N0} nub [] = []
{N1} nub (x:xs) = x : filter (\y -> x /= y) (nub xs)

union :: Eq a => [a] -> [a] -> [a]
{U0} union xs ys = nub (xs ++ ys)

intersect :: Eq a => [a] -> [a] -> [a]
{I0} intersect xs ys = filter (\e -> elem e ys) xs
```

Indicar si las siguientes propiedades son verdaderas o falsas. Si son verdaderas, realizar una demostracion. Si son falsas, presentar un contraejemplo.

## I

```txt
Eq a => ∀ xs::[a] . ∀ e::a . ∀ p::a -> Bool .
elem e xs && p e = elem e (filter p xs)
```

Parece tener sentido. Lo pruebo por induccion estructural sobre `xs`.

Defino:

```txt
P(xs): elem e xs && p e = elem e (filter p xs)
```

### Caso base

Busco probar `P([])`:

```txt
elem e [] && p e
= False && p e                 {E0}
= False                        {Bool}
```

Por otro lado:

```txt
elem e (filter p [])
= elem e []                    {F0}
= False                        {E0}
```

Luego vale el caso base.

### Paso inductivo

Busco probar `P(xs) => P(x:xs)`.

Defino la hipotesis inductiva:

```txt
{HI} elem e xs && p e = elem e (filter p xs)
```

Busco probar:

```txt
elem e (x:xs) && p e = elem e (filter p (x:xs))
```

Empiezo por el lado izquierdo:

```txt
elem e (x:xs) && p e
= ((e == x) || elem e xs) && p e                       {E1}
= ((e == x) && p e) || (elem e xs && p e)               {Bool}
= ((e == x) && p e) || elem e (filter p xs)             {HI}
```

Ahora miro el lado derecho:

```txt
elem e (filter p (x:xs))
= elem e (if p x then x : filter p xs else filter p xs) {F1}
```

Divido en casos:

Si vale `p x`, entonces por congruencia, como `e == x`, tambien vale `p e`. Por lo tanto:

```txt
elem e (x : filter p xs)
= (e == x) || elem e (filter p xs)                      {E1}
= ((e == x) && p e) || elem e (filter p xs)
```

Si no vale `p x`, entonces `p x = False`. En ese caso:

```txt
elem e (filter p xs)
= False || elem e (filter p xs)                         {Bool}
= ((e == x) && p e) || elem e (filter p xs)
```

Luego vale la propiedad.

## II

```txt
Eq a => ∀ xs::[a] . ∀ e::a .
elem e xs = elem e (nub xs)
```

`nub` elimina duplicados, asi que tiene sentido que no cambie la pertenencia. Lo pruebo por induccion estructural sobre `xs`.

Defino:

```txt
P(xs): elem e xs = elem e (nub xs)
```

### Caso base

```txt
elem e []
= elem e (nub [])       {N0}
```

Luego vale el caso base.

### Paso inductivo

Busco probar `P(xs) => P(x:xs)`.

Defino la hipotesis inductiva:

```txt
{HI} elem e xs = elem e (nub xs)
```

Busco probar:

```txt
elem e (x:xs) = elem e (nub (x:xs))
```

Por definicion:

```txt
elem e (x:xs)
= (e == x) || elem e xs                         {E1}
= (e == x) || elem e (nub xs)                   {HI}
```

Del otro lado:

```txt
elem e (nub (x:xs))
= elem e (x : filter (\y -> x /= y) (nub xs))   {N1}
= (e == x) || elem e (filter (\y -> x /= y) (nub xs)) {E1}
```

Por el inciso anterior, con `p = \y -> x /= y`, queda:

```txt
elem e (filter (\y -> x /= y) (nub xs))
= elem e (nub xs) && (x /= e)
```

Entonces:

```txt
elem e (nub (x:xs))
= (e == x) || (elem e (nub xs) && x /= e)
= (e == x) || elem e (nub xs)
```

Luego vale por hipotesis inductiva. Por lo tanto vale la propiedad para toda lista.

## III

```txt
Eq a => ∀ xs::[a] . ∀ ys::[a] . ∀ e::a .
elem e (union xs ys) = elem e xs || elem e ys
```

Esta propiedad es verdadera.

```txt
elem e (union xs ys)
= elem e (nub (xs ++ ys))       {U0}
= elem e (xs ++ ys)             {II}
= elem e xs || elem e ys        {propiedad de elem sobre ++}
```

## IV

```txt
Eq a => ∀ xs::[a] . ∀ ys::[a] . ∀ e::a .
elem e (intersect xs ys) = elem e xs && elem e ys
```

Esta propiedad tambien es verdadera.

```txt
elem e (intersect xs ys)
= elem e (filter (\z -> elem z ys) xs)       {I0}
= elem e xs && elem e ys                     {I}
```

## V

```txt
Eq a => ∀ xs::[a] . ∀ ys::[a] .
length (union xs ys) = length xs + length ys
```

Es falsa. Contraejemplo:

```txt
xs = [1,2,3]
ys = [1]

length (union xs ys)
= length [1,2,3]
= 3

length xs + length ys
= 3 + 1
= 4
```

## VI

```txt
Eq a => ∀ xs::[a] . ∀ ys::[a] .
length (union xs ys) <= length xs + length ys
```

Esta es verdadera. `union xs ys = nub (xs ++ ys)`, y `nub` solo borra elementos repetidos, nunca agrega elementos nuevos. Entonces el largo de `nub (xs ++ ys)` es menor o igual que el largo de `xs ++ ys`.

```txt
length (union xs ys)
= length (nub (xs ++ ys))       {U0}
<= length (xs ++ ys)
= length xs + length ys
```
