myLength :: [Int] -> Int
myLength [] =0
myLength (x: xs) = (myLength xs) +1


myMaximum :: [Int] -> Int
myMaximum [x] = x
myMaximum (x:xs)
	| x > myMaximum xs = x
	|otherwise = myMaximum xs 
	
	
average :: [Int] -> Float
average [] = 0
average xs =  (sum (map fromIntegral xs)) / fromIntegral(myLength xs)

buildPalindrome:: [Int]-> [Int]
buildPalindrome xs= palindrome(xs) ++ xs


palindrome :: [Int]-> [Int]
palindrome xs
  |null(xs) =[]
  |otherwise = last(xs) : palindrome(init xs)

flatten :: Num a => [[a]]-> [a] 
flatten xs
   |null(xs) = []
   |otherwise = (head xs) ++ flatten( tail xs)
   
remove :: [Int]-> [Int]-> [Int]
remove [] ys = []
remove xs [] = xs
remove (x:xs) ys 
   |elem x ys =remove xs ys
   |otherwise =  x : remove  xs ys
   

oddsNevens :: [Int] -> ([Int],[Int]) 
oddsNevens [] = ([],[])
oddsNevens xs = ([ x |x <- xs, odd x ], [x|x <- xs ,  not (odd x)])



