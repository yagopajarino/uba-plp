# Ejercicio 11

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
