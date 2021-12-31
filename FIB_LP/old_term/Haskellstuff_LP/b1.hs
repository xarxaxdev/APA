eql :: [Int] -> [Int] -> Bool 
eql x y= x==y

prod :: [Int] -> Int
prod [] = 1
prod xs = product xs



prodOfEvens :: [Int] -> Int 
prodOfEvens [] = 1 
prodOfEvens xs = product( filter even xs)



powersOf2 :: [Int]
powersOf2 = (map ( 2 ^) [0,1..])




scalarProduct :: [Float] -> [Float] -> Float
scalarProduct x y= sum (zipWith (*) x y)


