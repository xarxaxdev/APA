absValue :: Int -> Int
absValue x 
 | x < 0 = -x
 |otherwise =x

power :: Int -> Int -> Int 
power x 0 = 1
power x y = ( power x (y-1))*x 


isPrime :: Int -> Bool
isPrime 0 = False 
isPrime 1 = False 
isPrime x = and [( mod x n)/=0 | n<-allnums ]
 where allnums= [2.. ( mysqrt 1 x)] 
 
mysqrt :: Int -> Int -> Int
mysqrt cand x
 |(cand + 1) *(cand +1)>x = cand
 | otherwise  = mysqrt (cand+1) x

slowFib :: Int -> Int
slowFib 0 = 0 
slowFib 1 = 1
slowFib x = slowFib (x-1) + slowFib (x-2)

--retorna el n-éssim numero de la serie FIB
quickFib :: Int -> Int 
quickFib n = fst (fib2 n) 

--retorna la tupla amb el n i n+1 
fib2 :: Int -> (Int, Int) 
fib2 0 = (0,1) 
fib2 n= (f2, f2+f1) 
 where (f1,f2) = fib2 (n-1) --ha de calcular tots
 --els anteriors igual, pero ho fa en una linea





 