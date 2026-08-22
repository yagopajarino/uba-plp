-- Ejercicio 2

valorAbsoluto :: Float -> Float
valorAbsoluto x = if x < 0 then x * (-1) else x

bisiesto :: Int -> Bool
bisiesto año = (rem año 4 == 0 && rem año 100 /= 0) || rem año 400 == 0

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n-1)

cantDivisoresPrimos :: Int -> Int
cantDivisoresPrimos 1 = 0
cantDivisoresPrimos x = cantDivisoresPrimosEnRango x [2..x]

cantDivisoresPrimosEnRango :: Int -> [Int] -> Int
cantDivisoresPrimosEnRango _ [] = 0
cantDivisoresPrimosEnRango n (x:xs) =
    if rem n x == 0
        then 1 + cantDivisoresPrimosEnRango (eliminarTodasLasApariciones n x) xs
        else cantDivisoresPrimosEnRango n xs

eliminarTodasLasApariciones :: Int -> Int -> Int
eliminarTodasLasApariciones n x =
    if rem n x == 0
        then eliminarTodasLasApariciones (div n x) x
        else n

-- Ejercicio 3

inverso :: Float -> Maybe Float
inverso 0 = Nothing
inverso n = Just (1/n)

aEntero :: Either Int Bool -> Int
aEntero (Left n) = n
aEntero (Right True) = 1
aEntero (Right False) = 0

-- Ejercicio 4

limpiar :: String -> String -> String
limpiar xs [] = []
limpiar xs (y:ys) =
    if elem y xs
        then limpiar xs ys
        else y : limpiar xs ys

difPromedio :: [Float] -> [Float]
difPromedio xs = calcularDiferencias (average xs) xs

calcularDiferencias :: Float -> [Float] -> [Float]
calcularDiferencias avg [] = []
calcularDiferencias avg (x:xs) = (x - avg) : calcularDiferencias avg xs

average :: [Float] -> Float
average xs = sum xs / fromIntegral (length xs)

todosIguales :: [Int] -> Bool
todosIguales [] = True
todosIguales [x] = True
todosIguales (x:y:ys) = x == y && todosIguales ys

-- O usando all
-- todosIguales [] = True
-- todosIguales (x:xs) = all (==x) xs

-- Ejercicio 5
data AB a = Nil | Bin (AB a) a (AB a) deriving Show

vacioAB :: AB a -> Bool
vacioAB Nil = True
vacioAB _ = False

negacionAB :: AB Bool -> AB Bool
negacionAB Nil = Nil
negacionAB (Bin i True d) = Bin (negacionAB i) False (negacionAB d)
negacionAB (Bin i False d) = Bin (negacionAB i) True (negacionAB d)

productoAB :: AB Int -> Int
productoAB Nil = 1
productoAB (Bin i n d) = productoAB i * n * productoAB d
