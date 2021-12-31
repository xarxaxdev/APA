myLength:: (Integral a)=> [a]-> a
myLength xs
  |null( xs) = 0
  |otherwise =myLength(tail xs)+1

myMaximum :: [Int] -> Int
myMaximum xs=maximum xs

average::(Fractional a)=> [a] -> a
average xs =(sum xs) / fromIntegral  (length xs)

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


primeDivisors :: Int -> [Int]
primeDivisors 1 = 1
primeDivisors x 	
