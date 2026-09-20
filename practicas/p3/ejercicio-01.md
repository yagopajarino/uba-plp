# Ejercicio 1

Determinar el valor de verdad de las siguientes proposiciones sabiendo que:

```txt
P = V
Q = V
S = F
T = F
```

## I. `¬P ∨ Q`

```txt
¬P ∨ Q
= ¬V ∨ V
= F ∨ V
= V
```

Por lo tanto, la proposición es **verdadera**.

## II. `P ∨ (S ∧ T) ∨ Q`

```txt
P ∨ (S ∧ T) ∨ Q
= V ∨ (F ∧ F) ∨ V
= V ∨ F ∨ V
= V
```

Por lo tanto, la proposición es **verdadera**.

## III. `¬(Q ∨ S)`

```txt
¬(Q ∨ S)
= ¬(V ∨ F)
= ¬V
= F
```

Por lo tanto, la proposición es **falsa**.

## IV. `(¬P ∨ S) ⇔ (¬P ∧ ¬S)`

Desarrollo el bicondicional como dos implicaciones:

```txt
(¬P ∨ S) ⇔ (¬P ∧ ¬S)
= ((¬P ∨ S) ⇒ (¬P ∧ ¬S)) ∧ ((¬P ∧ ¬S) ⇒ (¬P ∨ S))
= ((¬V ∨ F) ⇒ (¬V ∧ ¬F)) ∧ ((¬V ∧ ¬F) ⇒ (¬V ∨ F))
= ((F ∨ F) ⇒ (F ∧ V)) ∧ ((F ∧ V) ⇒ (F ∨ F))
= (F ⇒ F) ∧ (F ⇒ F)
= V ∧ V
= V
```

Por lo tanto, la proposición es **verdadera**.

## V. `(P ∨ S) ∧ (T ∨ Q)`

```txt
(P ∨ S) ∧ (T ∨ Q)
= (V ∨ F) ∧ (F ∨ V)
= V ∧ V
= V
```

Por lo tanto, la proposición es **verdadera**.

## VI. `((P ∨ S) ∧ (T ∨ Q)) ⇔ (P ∨ (S ∧ T) ∨ Q)`

Desarrollo el bicondicional como dos implicaciones:

```txt
((P ∨ S) ∧ (T ∨ Q)) ⇔ (P ∨ (S ∧ T) ∨ Q)

= (((P ∨ S) ∧ (T ∨ Q)) ⇒ (P ∨ (S ∧ T) ∨ Q))
  ∧
  ((P ∨ (S ∧ T) ∨ Q) ⇒ ((P ∨ S) ∧ (T ∨ Q)))

= (((V ∨ F) ∧ (F ∨ V)) ⇒ (V ∨ (F ∧ F) ∨ V))
  ∧
  ((V ∨ (F ∧ F) ∨ V) ⇒ ((V ∨ F) ∧ (F ∨ V)))

= ((V ∧ V) ⇒ (V ∨ F ∨ V))
  ∧
  ((V ∨ F ∨ V) ⇒ (V ∧ V))

= (V ⇒ V) ∧ (V ⇒ V)
= V ∧ V
= V
```

Por lo tanto, la proposición es **verdadera**.

## VII. `¬Q ∧ ¬S`

```txt
¬Q ∧ ¬S
= ¬V ∧ ¬F
= F ∧ V
= F
```

Por lo tanto, la proposición es **falsa**.
