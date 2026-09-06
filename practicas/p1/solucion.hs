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

-- Ejercicio 4
paresDeNat::[(Integer,Integer)]
paresDeNat = [(x,n-x) | n <- [0..], x <- [0..n]]

-- Ejercicio 5
-- pitagóricas :: [(Integer, Integer, Integer)]
-- pitagóricas = [(a, b, c) | a <- [1..], b <-[1..], c <- [1..], a^2 + b^2 == c^2]

pitagóricas :: [(Integer, Integer, Integer)]
pitagóricas = [(a,b,c) | c <- [1..], a <- [1..c], b <- [a..c], a^2 + b^2 == c^2]

-- Ejercicio 6
listasQueSuman :: Int -> [[Int]]
listasQueSuman 0 = [[]]
listasQueSuman n | n > 0 =
                [x : xs | x <- [1..n], xs <- listasQueSuman (n-x)]

-- Ejercicio 7
listasDeEnteros :: [[Int]]
listasDeEnteros = concatMap listasQueSuman [1..]

-- Ejercicio 8
-- I
menosDe5Letras :: [String] -> [String]
menosDe5Letras = filter (\palabra -> length palabra < 5)

getAprobados :: [Int] -> [Bool]
getAprobados = map (\nota -> nota > 6)

paresAlCuadrado :: [Int] -> [Int]
paresAlCuadrado = map (^2) . filter even

-- II
sumf :: (Foldable t, Num a) => t a -> a
sumf = foldr (+) 0

elemf :: (Foldable t, Eq a) => a -> t a -> Bool
elemf x = foldr (\y rec -> y == x || rec) False

-- (++) :: [a] -> [a] -> [a]
-- (++) xs = foldr (:) xs

filterf :: (a -> Bool) -> [a] -> [a]
filterf p = foldr (\x rec -> if p x then x : rec else rec) []

mapf :: (a -> b) -> [a] -> [b]
mapf f = foldr (\x rec -> f x : rec) []

-- III
mejorSegún :: (a -> a -> Bool) -> [a] -> a
mejorSegún p = foldr1 (\x rec -> if p x rec then x else rec)

-- Ejercicio 10
recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x : xs) = f x xs (recr f z xs)

sacarUna :: Eq a => a -> [a] -> [a]
sacarUna n = recr (\x xs rec -> if x == n then xs else x:rec) []

insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado n = recr (\x xs rec -> if n < x then n : x : xs else x : rec) []

-- Ejercicio 11
entrelazar :: [a] -> [a] -> [a]
entrelazar = foldr (\x rec -> \ys -> if null ys then x : rec [] else x : head ys : rec (tail ys)) id

sufijos :: [a] -> [[a]]
sufijos = recr (\x xs rec -> (x:xs) : rec) [[]]

-- Ejercicio 12
mapPares :: (a -> b -> c) -> [(a, b)] -> [c]
mapPares f = map (uncurry f)

armarPares :: [a] -> [b] -> [(a,b)]
-- armarPares [] = const []
-- armarPares (x:xs) = \ys -> if null ys then [] else (x, head ys) : armarPares xs (tail ys)

-- Usando foldr
armarPares = foldr paso (const [])
    where
        paso = \x rec -> \ys -> case ys of
                []      -> []
                (y:ys') -> (x,y) : rec ys'

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f xs ys = mapPares f (armarPares xs ys)

-- Ejercicio 14
foldNat ::  (Integer -> b -> b)
            -> b
            -> Integer
            -> b
foldNat fRec fBase x = case x of
                            0 -> fBase
                            n -> fRec n (foldNat fRec fBase (n-1))

potencia :: Integer -> Integer -> Integer
potencia n = foldNat (\i rec -> n * rec) 1

-- Ejercicio 15
genLista :: a -> (a -> a) -> Integer -> [a]
genLista inicial step n = foldNat (\_ rec -> \x -> x : rec (step x)) (const []) n inicial

desdeHasta :: Integer -> Integer -> [Integer]
desdeHasta x y = genLista x (+1) (y-x)
