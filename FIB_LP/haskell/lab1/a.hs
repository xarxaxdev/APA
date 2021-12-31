
absValue::Integer ->Integer
absValue n
  |n < 0 = - n
  |otherwise = n
  

power::Integer-> Integer->Integer
power n m
  | m == 0 = 1
  |otherwise = (power n (m-1)) *n 
  

 
isPrime::Integer -> Bool
isPrime n = null[ x | x <- [2..h - 1], mod n x  == 0]
	where h= (max [1..] n)
--slowFib::Integer->Integer
--slowFib na
-- |n==1 =n
-- |otherwise= slowFib(n-1)
max [Integer]  Integer->Integer
max xs n = tail[x:xs|]

