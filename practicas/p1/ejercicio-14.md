# Ejercicio 14

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
