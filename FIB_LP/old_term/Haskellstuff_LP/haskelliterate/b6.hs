ones :: [Integer] 
ones = 1:ones 

nats :: [Integer] 
nats = iterate (+1) 0
  
ints :: [Integer] 
ints = 0:(map foo ints) 
  where foo= (\x -> if(x>0) then (-x) else (-x +1) )

triangulars :: [Integer] 
triangulars = map foo nats 
 where  foo = (\x-> quot (x * (x+1)) 2) 
 
factorials :: [Integer]
factorials = map factorial nats 

factorial :: Integer-> Integer 
factorial 0 = 1
factorial 1= 1
factorial n = n * factorial (n-1) 

fibs :: [Integer] 
fibs = [fst x| x<- (iterate foo (0,1))] 
 where foo = (\(a,b) -> (b,a+b))

primes :: [Integer] 
primes = discard $ tail $ tail nats 
 where discard (x:xs) = x: discard [ v | v<-xs, mod v x /= 0]

--sentit comu 
--hammings :: [Integer]
--hammings = filter bhamming (tail nats)
merge:: [Integer] -> [Integer] -> [Integer] 
merge [] a = a 
merge a [] = a 
merge (a:as) (b:bs) 
 |a<b = a:(merge as (b:bs)) 
 |a== b = a:(merge as bs)
 |otherwise = b: (merge (a:as) bs)
 
hammings:: [Integer]
hammings = 1: merge (map (2*) hammings)
 (merge (map (3*) hammings)
 (map (5*) hammings))



bhamming :: Integer-> Bool 
bhamming 1 = True 
bhamming x 
 |mod x 2==0 = bhamming (quot x 2) 
 |mod x 3 == 0 = bhamming (quot x 3) 
 |mod x 5 == 0 = bhamming (quot x 5) 
 |otherwise = False 


lookNsay :: [Integer] 
lookNsay = iterate sillyfoo 1 


sillyfoo :: Integer -> Integer 
sillyfoo x = toInteger $  read(addseparator $ show x) 

--donat "1" -> "11" 
addseparator :: String -> String 
addseparator [] = [] 
addseparator (x:xs) = treated ++ (addseparator untreated) 
 where 
  treated= answer (takeWhile (==x) (x:xs) ) 
  untreated = (dropWhile (==x) xs)

--transformación  1 ->11, 2222->42
answer :: String -> String
answer s= show (toInteger (length s)*10 +   (read [ head s]))


flattennumbers (x:xs) = x+(flattennumbers xs) * 10

tartaglia :: [[Integer]]
tartaglia = iterate ((1:).nexttart) [1]

nexttart :: [Integer] -> [Integer] 
nexttart ( x : y : xs) = (x+y):nexttart(y:xs) 
nexttart (x:xs) = [1] 
nexttart [] = [1]