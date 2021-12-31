flatten :: [[Int]] -> [Int]
flatten = foldr (++) [] 

myLength :: String -> Int
myLength = foldl (\x _ -> x+1) 0 

myReverse :: [Int] -> [Int] 
myReverse = foldl (\list x-> x:list) []

countIn :: [[Int]] -> Int -> [Int] 
countIn x y =  map length (map  (filter (==y) )  x)

firstWord :: String -> String 
firstWord s = takeWhile (/=' ') ( dropWhile (==' ') s ) 