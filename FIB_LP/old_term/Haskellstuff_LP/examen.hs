

mconcat2::[[a]]->[a] 
mconcat2 = foldr (++) [] 

fold2r::(a -> b -> c -> c) -> c ->[a] -> [b] -> c 
fold2r fun ini [] []= ini
fold2r fun ini [] y = ini
fold2r fun ini x [] = ini
fold2r fun ini (x:xs)(y:ys)=  fun x y (fold2r fun ini xs ys)

--mconcat::[[a]]->[a]
--mconcat
--concat3::[[[a]]]->[a]
--concat3 = foldr (\a b-> (mconcat2 a)++ (mconcat2 )

mix:: [a] -> [a] -> [a]
mix [] [] = []
mix [] x = x
mix x [] = x
mix (x:xs) (y:ys) = x:y:(mix xs ys) 


