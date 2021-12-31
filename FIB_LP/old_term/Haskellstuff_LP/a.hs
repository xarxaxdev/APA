absValue::Integer ->Integer
absValue n
  |n < 0 = - n
  |otherwise = n
  

power::Integer-> Integer->Integer
power n m
  | m == 0 = 1
  |otherwise = (power n (m-1)) *n 
  

 
isPrime::Integer -> Bool
isPrime n = null[ x | x <- [2..h], mod n x  == 0]
   where h= candidate n 2

candidate:: Integer -> Integer->Integer
candidate n m 
  |(m+1)*(m+1)> n =m
  |otherwise = candidate n (m+ 1)




