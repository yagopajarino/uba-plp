# Ejercicio 3

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
