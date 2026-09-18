# Ejercicio 2

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
