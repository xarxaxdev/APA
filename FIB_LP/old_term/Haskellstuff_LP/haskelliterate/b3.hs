myMap :: (a -> b) -> [a] -> [b] 
myMap f a = [f b|b<-a] 

myFilter :: (a -> Bool) -> [a] -> [a] 
myFilter f a = [ b | b <- a , f b]

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c] 
myZipWith f a b = [f x y| (x , y) <-(zip a b)] 

thingify :: [Int] -> [Int] -> [(Int, Int)] 
thingify a b = [ (x,y) | x<-a, y<-b, mod x y == 0] 
--thingify a b = myZipWith ( ,) a b

factors :: Int -> [Int] 
factors x = [ y | y <- [1..x], mod x y == 0]