# Ejercicio 6

```hs
listasQueSuman :: Int -> [[Int]]
listasQueSuman 0 = [[]]
listasQueSuman n | n > 0 =
                [x : xs | x <- [1..n], xs <- listasQueSuman (n-x)]
```
