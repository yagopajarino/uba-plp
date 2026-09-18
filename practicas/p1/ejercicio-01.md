# Ejercicio 1

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
