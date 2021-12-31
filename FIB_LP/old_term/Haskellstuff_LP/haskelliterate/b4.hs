myFoldl :: (a -> b -> a) -> a -> [b] -> a 
myFoldl f val [] = val
myFoldl f val (x:xs) =  myFoldl f (f val x) xs 



myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr f y [] = y
myFoldr f y (x:xs) =  f x (myFoldr f y xs) 

apply :: (a-> a) -> a -> Integer -> a
apply f a 0 = a 
apply f a n = f (apply f a (n-1))

myIterate :: (a -> a) -> a -> [a] 
myIterate f x = map (apply f x) [0..]

myUntil :: (a -> Bool) -> (a -> a) -> a -> a
myUntil comp f a 
 |  comp a =  a 
 | otherwise = myUntil comp f (f a) 

myMap :: (a -> b) -> [a] -> [b]
myMap f list = [f a | a<-list ]

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f list = [ a | a<- list , f a]

myAll :: (a -> Bool) -> [a] -> Bool
myAll f list  = and [f a | a<-list ] 

myAny :: (a -> Bool) -> [a] -> Bool
myAny f list = or [f a| a <- list ] 

myZip :: [a] -> [b] -> [(a, b)]
myZip [] _ = [] 
myZip _ [] = [] 
myZip x y = ((head x) , (head y)):(myZip (tail x) (tail y))

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f x y = map (uncurry f) zipped
 where zipped = myZip x y 






