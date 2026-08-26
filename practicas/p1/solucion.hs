import Prelude hiding (subtract)

-- Ejercicio 1

max2 :: Float -> Float -> Float
max2 = \x y -> if x >= y then x else y

normaVectorial :: Float -> Float -> Float
normaVectorial x y = sqrt (x^2 + y^2)

-- Defino una nueva funcion que deja fijo el primer parametro de normaVectorial
normaVectorialDesde3 :: Float -> Float
normaVectorialDesde3 = normaVectorial 3

subtract :: Float -> Float -> Float
subtract = flip (-)

predecesor :: Float -> Float
predecesor = subtract 1

evaluarEnCero :: (Float -> a) -> a
evaluarEnCero = \f -> f 0

dosVeces :: (a -> a) -> a -> a
dosVeces = \f -> f . f

flipAll :: [(a -> b -> c)] -> [b -> a -> c]
flipAll = map flip

flipRaro :: b -> (a -> b -> c) -> (a -> c)
flipRaro = flip flip

-- Ejercicio 2

curry2 :: ((a, b) -> c) -> a -> b -> c
curry2 f = \x -> \y -> f (x, y)

uncurry2 :: (a -> b -> c) -> (a, b) -> c
uncurry2 f = \(x, y) -> f x y

-- Ejemplos del apunte:
-- suma2 (x,y) = x + y
-- suma2Curry = curry2 suma2
-- suma2 (2,3) == suma2Curry 2 3
--
-- suma2 x y = x + y
-- suma2Uncurry = uncurry2 suma2
-- suma2 2 3 == suma2Uncurry (2,3)

-- Ejercicio 3

listaDesde :: Integer -> [Integer]
listaDesde x = x : listaDesde (x + 1)

esMultiploDe10 :: Integer -> Bool
esMultiploDe10 n = mod n 10 == 0

takeHastaMultiploDe10 :: [Integer] -> [Integer]
takeHastaMultiploDe10 [] = []
takeHastaMultiploDe10 (x:xs) =
  if esMultiploDe10 x
    then []
    else x : takeHastaMultiploDe10 xs
