# Ejercicio 5

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
