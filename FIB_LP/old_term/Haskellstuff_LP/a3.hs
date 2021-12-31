insert :: [Int] -> Int -> [Int] 
insert [] x = [x]
insert (y:ys) x
 |x>y = y: insert  ys x
 |otherwise = x:y:ys

isort :: [Int] -> [Int]
isort [] = []
isort (x:xs) = insert (isort xs) x



remove :: [Int] -> Int -> [Int]
remove [] x = []
remove (y:ys) x
 | x==y = ys
 | otherwise = y: (remove  ys x)


ssort :: [Int] -> [Int] 
ssort [] = []
ssort xs = (minimum xs) : ssort (remove xs (minimum xs) )


merge :: [Int] -> [Int] -> [Int]
merge [] xs = xs
merge xs [] = xs
merge (x:xs) (y:ys)
 |x>y = y: merge (x:xs) ys
 |otherwise= x: merge xs (y:ys)

msort :: [Int] -> [Int]
msort [] = []
msort (x:xs)= merge  [x] (msort xs)

qsort :: [Int] -> [Int]
qsort [] = []
qsort (x:xs) = qsort small ++ (x : qsort large)
   where small = [y | y <- xs, y <= x]
         large = [y | y <- xs, y > x]


genQsort :: Ord a => [a] -> [a]
genQsort []= []
genQsort (x:xs) = genQsort small ++ (x:genQsort large)
    where small= [ y | y <-xs , y<= x]
          large= [ y | y <- xs, y>x]




