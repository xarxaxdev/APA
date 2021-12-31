countIf :: (Int -> Bool) -> [Int] -> Int
countIf f xs = foldl myfoo 0 (map f xs) 
   where myfoo= (\x y -> if y then x + 1 else x)

pam :: [Int] -> [Int -> Int] -> [[Int]] 
pam int f = [map fu int| fu<-f ]


pam2 :: [Int] -> [Int -> Int] -> [[Int]] 
pam2 x f = [[fs xs | fs<-f] | xs<-x]  

filterFoldl :: (Int -> Bool) -> (Int -> Int -> Int) -> Int -> [Int] -> Int 
filterFoldl bool foo base list = foldl foo base (filter bool list)


insert :: (Int -> Int -> Bool) -> [Int] -> Int -> [Int] 
insert foo [] el = [el] 
insert foo (x:xs) el 
 | foo el x = el: x : xs 
 | otherwise = x: (insert foo xs el )

insertionSort :: (Int -> Int -> Bool) -> [Int] -> [Int] 
insertionSort _ [] = []
insertionSort f list = foldl (insert f ) [] list  

