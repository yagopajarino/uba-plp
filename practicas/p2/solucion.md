# Práctica 2: Razonamiento Ecuacional e Inducción Estructural

## Ejercicio 1

### I

```txt
∀ p::(a,b) . intercambiar (intercambiar p) = p

Por Lema de generación de pares, existen x,y tales que p = (x,y). Luego busco probar

intercambiar (intercambiar (x,y)) = (x,y)
= intercambiar ((y,x)) = (x,y)                {I}
= (x,y)                                       {I}
```

### II

```txt
∀ p::(a,(b,c)) . asociarD (asociarI p) = p

Por lema de generación de pares (x2) existen x,y,z tales que p = (x, (y,z)) luego busco probar

asociarD (asociarI (x, (y,z))) = (x, (y,z))
= asociarD(((x,y), z))                        {AI}
= (x, (y,z))                                  {AD}
```

### III

```txt
∀ p::Either a b . espejar (espejar p) = p

Por lema de genración, se que existen x, y tales que p = Left x o Right y. Divido en casos

Caso A p = Left x
espejar (espejar (Left x)) = Left x
espejar (Right x)                             {EL}
Left x                                        {ER}

Caso B p = Right x
espejar (espejar Right x) = Right x
espejar (Left x)                              {ER}
Right x                                       {EL}
```

### IV

```txt
∀ f::a->b->c . ∀ x::a . ∀ y::b . flip (flip f) x y = f x y

flip (flip f) x y = f x y
= flip f y x                                  {FLIP}
= f x y                                       {FLIP}
```

### V

```txt
∀ f::a->b->c . ∀ x::a . ∀ y::b . curry (uncurry f) x y = f x y

curry (uncurry f) x y = f x y
= uncurry f (x,y)                           {CURRY}
= f x y                                     {UNCURRY}
```

## Ejercicio 2

Rdo. principio de Exntensionalidad funcional

Sean $f, g :: a \rightarrow b$

Si $f = g$ entonces $(\forall x :: a. f x = g x)$

Por lo tanto,
Si $(\forall :: a. f x = g x)$ entonces $f = g$

### I

```txt
flip . flip = id

Por extensionalidad funcional, probar que flip.flip = id es lo mismo que probar que para todo f :: (a->b->c) vale que flip . flip f x y = id f x y

flip . flip (f x y) = id (f y x)
= flip (flip f x y)                             {COMP}
= flip f y x                                    {FLIP}
= f x y                                         {FLIP}
```

### II

```txt
∀ f::(a,b)->c . uncurry (curry f) = f

Por extensionalidad funcional, probar que uncurry (curry f) = f es lo mismo que probar que para todo x :: a, y :: b vale que uncurry (curry f) x y = f x y 

uncurry (curry f x y) = f x y
= uncurry f (x,y)                              {CURRY}
= f x y                                        {UNCURRY}
```

### III

```txt
flip const = const id

Por extensionalidad funcional, probar flip const = const id es lo mismo que probar que para todo x,y vale flip const x y = const id x y

(flip const) x y = const id x y
= const y x                                   {FLIP}
= y

Derivando del otro lado,
const id x y
= id y                                        {CONST}
= y                                           {ID}
```

### IV

```txt
∀ f::a->b . ∀ g::b->c . ∀ h::c->d . ((h . g) . f) = (h . (g . f))
con la de nición usual de la composición: (.) f g x = f (g x).

Por extensiondalidad, 
((h . g) . f) x = (h . (g . f)) x
= (.) (h . g) f x                             {DEF (.)}
= (h . g) (f x)                               {(.)}
= (.) h g (f x)                               {DEF (.)}
= h (g (f x))                                 {(.)}

Del otro lado
(h . (g . f)) x
= (.) h (g . f) x                             {DEF (.)}  
= h ((g . f) x)                               {(.)}
= h ((.) g f x)                               {DEF (.)}
= h (g (f x))                                 {(.)}
```

## Ejercicio 3

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

## Ejercicio 6

Ver [2.6](./2.6.pdf)
