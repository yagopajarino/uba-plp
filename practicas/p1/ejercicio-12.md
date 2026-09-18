# Ejercicio 12

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
