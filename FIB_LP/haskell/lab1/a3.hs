insert :: [Int] -> Int -> [Int]
insert [] x = [x]
insert (x:xs) nou
 |nou> x = x:(insert xs nou)
 |otherwise= nou:(x:xs) 
 
isort :: [Int] -> [Int]
isort [] = []
isort (x:xs) = insert (isort xs) x 

remove :: [Int] -> Int -> [Int]
remove [] x = []
remove (x:xs) el
 |el==x = xs
 |True = x:remove xs el 


ssort :: [Int] -> [Int]
ssort [] = []
ssort xs = n: ssort (remove xs n)
 where n= minimum xs

merge :: [Int] -> [Int] -> [Int] 
merge [] [] = []
merge [] x = x
merge x [] = x
merge (x:xs) (y:ys)  
 |x>y = y:(merge (x:xs) ys)
 |otherwise = x:(merge xs (y:ys))

msort :: [Int] -> [Int]
msort [] = [] 
msort (x:xs) = merge [x] (msort xs) 

qsort :: [Int] -> [Int]
qsort [] = []
qsort (x:xs) = qsort small ++ mid ++ qsort large
 where small=[y |y<-xs, y<x]
       mid=[y |y<-xs, y==x]++[x]
       large=[y |y<-xs, y>x]

genQsort :: Ord a => [a] -> [a] 
genQsort [] = []
genQsort (x:xs) = genQsort small ++ (x:genQsort large)
 where small= [y |y<-xs,y <= x]
       large= [y | y<-xs, y > x]