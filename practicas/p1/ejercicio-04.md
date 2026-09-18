# Ejercicio 4

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
