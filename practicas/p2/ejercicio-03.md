# Ejercicio 3

### I

```txt
∀ xs::[a] . length (duplicar xs) = 2 * length xs

Lo pruebo por inducción estructural en la lista xs
Defino el predicado unario; para todo x::[a], P(x): length (duplicar x) = 2 * length x

Caso base x = []
Busco probar P([]): length (duplicar []) = 2 * length []

length (duplicar [])
= length []                     {D0}
= 0                             {L0}
= 2 * 0                         {INT}
= 2 * length []                 {L0}

Paso inductivo
Busco probar que P(xs) => P(x:xs)
Defino mi {HI} length (duplicar xs) = 2 * length xs

Luego busco probar que vale P(x:xs): length (duplicar (x:xs)) = 2 * length (x:xs)

length (duplicar (x:xs))
= length(x : x : duplicar xs)               {D1}
= 1 + length(x : duplicar xs)               {L1}
= 1 + 1 + length(duplicar xs)               {L1}
= 1 + 1 + 2 * length xs                     {HI}
= 2 + 2 * length xs
= 2 * (1 + length xs)                       
= 2 * length (x:xs)                         {L1}
```

### II

```txt
∀ xs::[a] . ∀ ys::[a] . length (xs ++ ys) = length xs + length ys

Lo pruebo por inducción estructural en listas. Defino mi predicado unicario

Para todo xs::[a]. P(xs): para todo ys::[a], length(xs ++ ys) = length xs + length ys

Notar que en este caso hay un para todo adentro del predicado unario, para simplificar no los vuelvo a escribir.

Caso base xs = []
P([]): length([] ++ ys) = length [] + length ys

length([] ++ ys)
= length ys                 {++0}
= 0 + length ys             {INT}
= length [] + length ys     {L0}

Caso inductivo
En este caso busco probar que P(xs) => P(x:xs)
Defino mi {HI} length (xs ++ ys) = length xs + length ys

Busco probar P(x:xs): length ((x:xs) ++ ys) = length (x:xs) + length ys
length ((x:xs) ++ ys)
= length (x : (xs ++ ys))             {++1}
= 1 + length (xs ++ ys)               {L1}
= 1 + length xs + length ys           {HI}
= length (x:xs) + length ys           {L1}

Queda probado el paso inductivo y por lo tanto queda probada la propiedad para cualquier listas xs::[a] ys::[as]
```

### III

```txt
∀ xs::[a] . ∀ x::a . [x] ++ xs = x:xs

Por comodidad voy a hacer un renombre xs por ys

∀ ys::[a] . ∀ x::a . (x:[]) ++ ys = x:ys

(x:[]) ++ ys
= x : ([] ++ ys)        {++1}
= x : ys                {++0}
```

### IV

```txt
∀ xs::[a] . xs ++ [] = xs

Lo pruebo por inducción estructural en listas
Defino P(xs): xs ++ [] = xs

Caso base xs = []
P([]): [] ++ [] = []

[] ++ []
= []      {++0}

Paso inductivo
Busco probar que P(xs) => P(x:xs)
Defino {HI} xs ++ [] = xs

Busco probar P(x:xs): (x:xs) ++ [] = (x:xs)

(x:xs) ++ []
= x : (xs ++ [])            {++1}
= (x:xs)                    {HI}

Luego el paso inductivo vale. Por ende la propiedad vale para toda lista
```

### V

```txt
∀ xs::[a] . ∀ ys::[a] . ∀ zs::[a] . (xs ++ ys) ++ zs = xs ++ (ys ++ zs)

Lo pruebo por inducción estructural en la lista xs
Defino el predicado unario P(xs): para todo ys, zs :: [a]. (xs ++ ys) ++ zs = xs ++ (ys ++ zs)
En adelante no escribo por cuantificadores

Caso base xs = []
Busco probar que vale P([]): ([] ++ ys) ++ zs = [] ++ (ys ++ zs)

([] ++ ys) ++ zs
= ys ++ zs              {++0}
= [] ++ (ys ++ zs)      {++0}

Paso inductivo
En este caso busco probar que vale P(xs) => P(x:xs)
Defino {HI} (xs ++ ys) ++ zs = xs ++ (ys ++ zs)

Busco probar P(x:xs): ((x:xs) ++ ys) ++ zs = (x:xs) ++ (ys ++ zs)

((x:xs) ++ ys) ++ zs
= (x : (xs ++ ys)) ++ zs        {++1}
= x : ((xs ++ ys) ++ zs)        {++1}
= x : (xs ++ (ys ++ zs))        {HI}
= (x:xs) ++ (ys ++ zs)          {++1}

Luego vale el paso inductivo y por lo tanto por inducción en listas vale la propiedad para toda lista
```

### VI

```txt
∀ xs::[a] . ∀ f::(a->b) . length (map f xs) = length xs

Uso las sgtes reglas sobre map, vistas en clase

{M0} map f [] = []
{M1} map f (x : xs) = f x : map f xs

Por inducción estructural en la lista xs
Defino mi predicado unario P(xs): length (map f xs) = length xs

Caso base xs = []
Busco probar que vale P([]): length (map f []) = length []

length (map f [])
= length []           {M0}

Paso inductivo
Busco probar que vale P(xs) => P(x:xs)
Defino {HI} length (map f xs) = length xs

Busco probar P(x:xs): length (map f (x:xs)) = length (x:xs)
length (map f (x:xs))
= length (f x : map f xs)         {M1}
= 1 + length (map f xs)           {L1}
= 1 + length xs                   {HI}
= length  (x:xs)                  {L1}

Luego vale el paso inductivo y por inducción estructural vale la propiedad para toda lista
```
