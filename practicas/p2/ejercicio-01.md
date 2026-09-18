# Ejercicio 1

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
