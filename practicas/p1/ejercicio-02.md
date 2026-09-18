# Ejercicio 2

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
