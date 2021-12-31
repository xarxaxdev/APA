eql :: [Int] -> [Int] -> Bool
eql x y = x==y

prod :: [Int] -> Int
prod x= foldr (*) 1 x

prodOfEvens :: [Int] -> Int 
prodOfEvens x= prod (filter even x)

prod2 :: Int-> Int
prod2 0 = 1
prod2 x = 2* prod2 (x-1)

powersOf2 :: [Int] 
powersOf2 = map (2^) [0,1..]

scalarProduct :: [Float] -> [Float] -> Float
scalarProduct x y= sum (zipWith (*) x y)