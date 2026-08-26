# Práctica I – Programación Funcional

## Ejercicio 1

Me piden definir el tipo de cada función e indicar cuáles de ellas no están currificadas y en tal caso definir la función currificada corresondiente

Por simplicidad, voy a trabajar unicamente con tipos Float, incluso en los casos en los que el tipo sea extensible por [Type classes](https://serokell.io/blog/haskell-typeclasses)

### `max2`
```hs
max2 :: (Float, Float) -> Float
max2 (x, y) | x >= y = x
            | otherwise = y
```
Está no está currificada dado que recibe el par ordernado y devuelve un Float, la currifico

```hs
max2 :: Float -> Float -> Float
max2 = \x y ->  if x >= y then x else y
````

### `normaVectorial`
```hs
normaVectorial :: (Float, Float) -> Float
normaVectorial (x, y) = sqrt (x^2 + y^2)
```

Tampoco está currificada, la currifico
```hs
normaVectorial :: Float -> Float -> Float
normaVectorial x y = sqrt (x^2 + y^2)
```

Como `normaVectorial` está currificada puedo usar aplicación parcial como:

```hs
-- Defino una nueva función que deja fijo el primer parametro de normaVectorial
normaVectorialDesde3 :: Float -> Float
normaVectorialDesde3 = normaVectorial 3
```

### `subtract`
```hs
subtract :: Float -> Float -> Float 
subtract = flip (-)
````

El subtract es de tipo `Float -> Float` y el flip lo único que hace es cambiar el orden de los argumentos

> [!NOTE]
> Veamos el tipo de la función `flip`
> ```hs
> ghci> :t flip
> flip :: (a -> b -> c) -> b -> a -> c 
> ```
> Recibe una función y dos argumentos, da vuelta los argumentos y devuelve el resultado de aplicar la función

Luego este caso es una aplicación parcial del flip en la que se define la función a utiliza y lo único que va a pedir la nueva función son los argumentos sobre los cuales aplicar la función

### `predecesor`

```hs
predecesor :: Float -> Float
predecesor = subtract 1
```
Es una aplicación parcial de la función recién definida


### `evaluarEnCero`

```hs
evaluarEnCero :: (Float -> a) -> a
evaluarEnCero = \f -> f 0
````
Tengo una lamnda qeu recibe una función `f` como argumento, que está aplicada a `0` luego debe recibir un `Float` como argumento. No se que devuelve `f` luego uso un tipo genérico `a`

### `dosVeces`

```hs
dosVeces :: (a -> a) -> a -> a
dosVeces = \f -> f . f
```
En este caso primero tomo una función que luego es compuesta con sí misma, y la función dosVeces devuelve la aplicación de la función pasada como parámetro compuesta con si misma sobre un argumento

### `flipAll`

> [!NOTE]
> Vemos el tipo de map
> ```hs
> ghci> :t map
> map :: (a -> b) -> [a] -> [b]
> ````
> Toma una función y devuelve una función que espera una lista como argumento y aplica la función a cada elemento de la lista

```hs
flipAll :: [(a -> b -> c)] -> [b -> a -> c]
flipAll = map flip
```

Es una aplicación parcial de la función map, luego esperamos que el tipo tenga `[a]->[b]`. Pero como la función pasada al map es un flip entonces necesariamente todos los elementos de la lista deben ser del tipo `(a -> b -> c)`, luego el flip devuelve la lista con las funciones que resultan de flipear todos sus argumentos.

### `flipRaro` 

```hs
flipRaro :: b -> (a -> b -> c) -> (a -> c)
flipRaro = flip flip
````

## Ejercicio 2

Me piden definir la función `curry` que dada una función de dos argumentos devuelve su versión currificada

```hs
curry f = (\x -> \y -> f(x,y))
```

Por ejemplo si defino una función que recibe una tupla de enteros `suma2` currificada queda:

```hs
suma2 (x,y) = x + y
suma2Curry = curry2 suma2 -- uso curry2 para no colisionar con ghci

suma2 (2,3) == suma2Curry 2 3 -- True
````

`uncurry` ahora toma una función currificada de dos argumentos y devuelve su versión no currificada
```hs
uncurry f = \(x,y) -> f x y
```

Con el mismo ejemplo de antes

```hs
suma2 x y = x + y
suma2Uncurry = uncurry2 suma2

suma2 2 3 == suma2Uncurry (2,3)
````

No se puede definir una función general `curryN` dado que el tipo debería aceptar tuplas de ditintos tamaños, y en haskell no existe el tipo generico de tuplas de N elementos, luego cada curry cambia su tipo dependiendo la cantidad de argumentos que toma la función a currificar.

## Ejercicio 3

```hs
listaDesde x = x : (listaDesde (x+1))
esMultiploDe10 n = mod n 10 == 0
takeHastaMultiploDe10 [] = []
takeHastaMultiploDe10 (x:xs) = if esMultiploDe10 x then [] else x : (takeHastaMultiploDe10 xs)
```

Reducción paso a paso usando evaluación lazy

```hs
takeHastaMultiploDe10 (listaDesde 29) -- reduce listaDesde 29
takeHastaMultiploDe10 (29 : (listaDesde (30))) -- evaluo takeHastaMultiploDe10
if esMultiploDe10 29 then [] else 29 : (takeHastaMultiploDe10 (listaDesde 30))
if mod 29 10 == 0 then [] else 29 : (takeHastaMultiploDe10 (listaDesde 30))
29 : takeHastaMultiploDe10 (listaDesde 30) -- reduce listaDesde 30 
29 : takeHastaMultiploDe10 (30 : (listaDesde 31))
29 : if esMultiploDe10 30 then [] else 30 : (takeHastaMultiploDe10 (listaDesde 31)
29 : if mod 39 10 == 0 then [] else 30 : (takeHastaMultiploDe10 (listaDesde 31)
29 : []
```

Verifico usando ghci
```hs
ghci> takeHastaMultiploDe10 (listaDesde 29)
[29]
```
