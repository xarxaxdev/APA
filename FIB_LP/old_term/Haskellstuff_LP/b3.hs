myMap :: (a -> b) -> [a] -> [b]
myMap fun list = [ fun y | y<- list ]

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter fun list = [ y | y<-list, fun y ]


myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c] 
myZipWith f xs ys = [f x y | (x,y) <- zip xs ys]

thingify :: [Int] -> [Int] -> [(Int, Int)] 
thingify xs ys= [ (x,y) | x<-xs , y<- ys, (mod x y)==0]

factors :: Int -> [Int] 
factors numero = [ x| x<-[1..numero] , mod numero x==0]
