# Ejercicio 15
```hs
genLista :: a -> (a -> a) -> Integer -> [a]
genLista inicial step n = foldNat (\_ rec -> \x -> x : rec (step x)) (const []) n inicial

desdeHasta :: Integer -> Integer -> [Integer]
desdeHasta x y = genLista x (+1) (y-x)
```
