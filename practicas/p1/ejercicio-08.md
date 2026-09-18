# Ejercicio 8

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
