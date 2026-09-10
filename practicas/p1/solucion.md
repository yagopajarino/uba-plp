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

## Ejercicio 4

Busco generar la lista infinita de todos los pares de naturales. Para esto voy a usar la definición de listas por comprensión de Haskell

```hs
paresDeNat::[(Int,Int)]
paresDeNat = [(x,n-x) | n <- [0..], x <- [0..n]]
```

Probando en ghci

```hs
ghci> take 20 paresDeNat
[(0,0),(0,1),(1,0),(0,2),(1,1),(2,0),(0,3),(1,2),(2,1),(3,0),(0,4),(1,3),(2,2),(3,1),(4,0),(0,5),(1,4),(2,3),(3,2),(4,1)]
````

## Ejercicio 5

La definición

```hs
pitagóricas :: [(Integer, Integer, Integer)]
pitagóricas = [(a, b, c) | a <- [1..], b <-[1..], c <- [1..], a^2 + b^2 == c^2]
```
No es útil porque la ejecución de haskell va a fijar a = 1, b = 1 y luego va a usar todos los posibles valores de c entre 1 e infinito para armar las triplas. Como para a = 1, b = 1 no existe ningún valor entero de c que cumpla la restricción, no va a devolver ningún resultado.

Tener más de un generador de enteros infinitos en una definición de listas por comprensión no es una buena idea.

```hs
pitagóricas :: [(Integer, Integer, Integer)]
pitagóricas = [(a,b,c) | c <- [1..], a <- [1..c], b <- [a..c], a^2 + b^2 == c^2]
```

## Ejercicio 6

```hs
listasQueSuman :: Int -> [[Int]]
listasQueSuman 0 = [[]]
listasQueSuman n | n > 0 =
                [x : xs | x <- [1..n], xs <- listasQueSuman (n-x)]
```

## Ejercicio 7
```hs
listasDeEnteros :: [[Int]]
listasDeEnteros = concatMap listasQueSuman [1..]
````

## Ejercicio 8

### I

```hs
menosDe5Letras :: [String] -> [String]
menosDe5Letras = filter (\palabra -> length palabra < 5)

getAprobados :: [Int] -> [Bool]
getAprobados = map (\nota -> nota > 6)

paresAlCuadrado :: [Int] -> [Int]
paresAlCuadrado = map (^2) . filter even
```

### II

```hs
sumf :: (Foldable t, Num a) => t a -> a
sumf = foldr (+) 0

elemf :: (Foldable t, Eq a) => a -> t a -> Bool
elemf x = foldr (\y rec -> y == x || rec) False

(++) :: [a] -> [a] -> [a]
(++) xs = foldr (:) xs

filterf :: (a -> Bool) -> [a] -> [a]
filterf p = foldr (\x rec -> if p x then x : rec else rec) []

mapf :: (a -> b) -> [a] -> [b]
mapf f = foldr (\x rec -> f x : rec) []
````

### III

```hs
mejorSegún :: (a -> a -> Bool) -> [a] -> a
mejorSegún p = foldr1 (\x rec -> if p x rec then x else rec)
```

## Ejercicio 10

```hs
sacarUna :: Eq a => a -> [a] -> [a]
sacarUna n = recr (\x xs rec -> if x == n then xs else x:rec) []
```

No se puede usar foldr porque necesitamos la cola de la lista para devolver en el caso que hayamos encontrado el elemento que queremos sacar. En foldr solamente podemos acceder al elemento actual y al resultado recursivo.

```hs
insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado n = recr (\x xs rec -> if n < x then n : x : xs else x : rec) []
```

## Ejercicio 11

`elementosEnPosicionesPares` usa esquema de recursión global dado que en el llamado recursivo lo hace sobre un argumento calculado sobre `xs`

`entrelazar` es estructural porque solo accede a la cola de a lista en el llamado recursivo y en el resto de la función solo lo combina con calculos sobre `x`. La rescribo usando `foldr`

```hs
entrelazar :: [a] -> [a] -> [a]
entrelazar = foldr (\x rec -> \ys -> if null ys then x : rec [] else x : head ys : rec (tail ys)) id
````

`slowSort` hace dos llamados recursivos: global

`sufijos` es primitiva, accede a la cola de la lista fuera del llamado recursivo. La reescribo usando recr

```hs
sufijos :: [a] -> [[a]]
sufijos = recr (\x xs rec -> (x:xs) : rec) [[]]
````

## Ejercicio 12

### I
```hs
mapPares :: (a -> b -> c) -> [(a, b)] -> [c]
mapPares f = map (uncurry f)
```

### II
```hs
armarPares :: [a] -> [b] -> [(a,b)]
armarPares = foldr paso (const [])
    where
        paso = \x rec -> \ys -> case ys of
                []      -> []
                (y:ys') -> (x,y) : rec ys'
```

### III

```hs
mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f xs ys = mapPares f (armarPares xs ys)
```

Chequeo que hace los mismo que zipWith

```hs
ghci> zipWith (+) [1,2,3,4] [1,1,1,1]
[2,3,4,5]
ghci> mapDoble (+) [1,2,3,4] [1,1,1,1]
[2,3,4,5]
````

## Ejercicio 14

```hs
foldNat ::  (Int -> b -> b)
            -> b
            -> Int
            -> b
foldNat fRec fBase x = case x of
                            0 -> fBase
                            n -> fRec n (foldNat fRec fBase (n-1))

potencia :: Int -> Int -> Int
potencia n = foldNat (\i rec -> n * rec) 1
```

## Ejercicio 15
```hs
genLista :: a -> (a -> a) -> Integer -> [a]
genLista inicial step n = foldNat (\_ rec -> \x -> x : rec (step x)) (const []) n inicial

desdeHasta :: Integer -> Integer -> [Integer]
desdeHasta x y = genLista x (+1) (y-x)
```

## Ejercicio 16

Primero defino el esquema de recursión estructural en el tipo Polinomio, para cada posible constructor defino un handler para ser aplicado en la recursión.
```hs
recPolinomio :: b                           -- X
            -> (a -> b)                     -- Cte
            -> (b -> b -> b)                -- Suma
            -> (b -> b -> b)                -- Prod
            -> Polinomio a                  -- Entrada
            -> b                            -- Resultado
recPolinomio fx fcte fsuma fprod p = case p of
                                        X           -> fx
                                        Cte n       -> fcte n
                                        Suma i d    -> fsuma (rec i) (rec d)
                                        Prod i d    -> fprod (rec i) (rec d)
                                        where rec = recPolinomio fx fcte fsuma fprod
````
Uso el `recPolinomio` para definir la evaluación, en el caso de suma y prod es fácil ver que solo tengo que sumar y multiplicar los resultados recursivos. En el caso de Cte, uso la funcion `id` para que devuelva el valor usado en el constructor Cte.
````hs
evaluar :: Num a => a -> Polinomio a -> a
evaluar x = recPolinomio x id (+) (*)
```

```hs
ghci> evaluar 2 (Cte 8)
8
ghci> evaluar 2 (Suma (X) (Cte 3))
5
ghci> evaluar 3 (Prod (Cte 5) (X))
15
```
