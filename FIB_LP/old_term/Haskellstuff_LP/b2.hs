

flatten :: [[Int]] -> [Int]
flatten = foldr (\l l2 ->l++l2 ) []


myLength :: String -> Int
myLength = foldl (\x _ -> x+1) 0

myReverse :: [Int] -> [Int]
myReverse = foldl (\list x-> x:list) []



countIn :: [[Int]] -> Int -> [Int] 
countIn list x = map (count x) list

count :: Int-> [Int] -> Int
count x list = length [y | y<-list , x==y]


firstWord :: String -> String 
firstWord s = takeWhile (/=' ') ( dropWhile (==' ') s ) 
