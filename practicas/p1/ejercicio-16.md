# Ejercicio 16

Primero defino el esquema de recursión estructural en el tipo Polinomio, para cada posible constructor defino un handler para ser aplicado en la recursión.
```hs
recPolinomio :: b                           -- X
            -> (a -> b)                     -- Cte
            -> (b -> b -> b)                -- Suma
            -> (b -> b -> b)                -- Prod
            -> Polinomio a                  -- Entrada
            -> b                            -- Resultado
recPolinomio fx fcte fsuma fprod p = case p of
                                        X           -> fx
                                        Cte n       -> fcte n
                                        Suma i d    -> fsuma (rec i) (rec d)
                                        Prod i d    -> fprod (rec i) (rec d)
                                        where rec = recPolinomio fx fcte fsuma fprod
````
Uso el `recPolinomio` para definir la evaluación, en el caso de suma y prod es fácil ver que solo tengo que sumar y multiplicar los resultados recursivos. En el caso de Cte, uso la funcion `id` para que devuelva el valor usado en el constructor Cte.
````hs
evaluar :: Num a => a -> Polinomio a -> a
evaluar x = recPolinomio x id (+) (*)
```

```hs
ghci> evaluar 2 (Cte 8)
8
ghci> evaluar 2 (Suma (X) (Cte 3))
5
ghci> evaluar 3 (Prod (Cte 5) (X))
15
```
