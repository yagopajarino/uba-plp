# Ejercicio 10

```hs
sacarUna :: Eq a => a -> [a] -> [a]
sacarUna n = recr (\x xs rec -> if x == n then xs else x:rec) []
```

No se puede usar foldr porque necesitamos la cola de la lista para devolver en el caso que hayamos encontrado el elemento que queremos sacar. En foldr solamente podemos acceder al elemento actual y al resultado recursivo.

```hs
insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado n = recr (\x xs rec -> if n < x then n : x : xs else x : rec) []
```
