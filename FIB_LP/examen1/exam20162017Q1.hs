mergelist :: Ord a => [[a]] -> [a]
mergelist = foldr merge []

merge :: Ord a => [a]-> [a]-> [a]
merge [] x = x
merge x  [] = x
merge (x:xs) (y:ys) 
 |x>y = y: merge (x:xs) ys
 |x<y = x: merge xs (y:ys)
 |True = x: merge xs ys


mults :: [Integer] -> [Integer]
--mults list = 1:mergelist [iterate (+x) x| x <- list]  
mults l = 1: mergelist (map(\x ->map (*x) (mults l)) l )



data Procs a = End | Skip (Procs a) | Unary (a->a) (Procs a) | 
          Binary (a->a->a) (Procs a) 

exec :: [a] -> (Procs a) -> [a] 
exec [] _ = []
exec x End = x
exec (x:xs) (Skip p) = x: exec xs p
--reemplaça x amb (f x) i segueix executant
exec (x:xs) (Unary f p) = exec ((f x): xs ) p 
exec (x:y:rest) (Binary f p) = exec ((f x y):rest) p
exec [x] (Binary f p) = exec [(f x x)] p 

class Container c where
 emptyC :: c a -> Bool
 lengthC :: c a -> Int
 firstC :: c a -> a 
 popC :: c a -> c a

instance Container ([]) where
 emptyC = null
 lengthC = length
 firstC = head  -- /firstC x _ : x
 popC = tail 

data Tree a = Empty | Node a [Tree a] deriving Show 
 
instance Container Tree where
 emptyC Empty = True
 emptyC _ = False
 lengthC Empty = 0 
 lengthC (Node _ ts) = 1+  (sum $ map lengthC  ts)
 firstC (Node x _) = x
 --popC Empty = Empty
 popC (Node _ []) = Empty 
 popC (Node _ ((Node b nextb):ts) ) = (Node b (nextb ++ts) )	
 popC (Node _ (Empty: ts)) = (popC xs)-- (Node x (tail ts))
   where xs = (Node (firstC $ head ts) (tail ts))
-- popC (Node _ xs) 
--  |null next = --lista vacia, hemos acabao 
--  where next= (until (! emptyC) tail xs)
--  (Node x bs)= head ts
  
 
	


iterator :: Container c => c a -> [a] 
iterator xs = if (not $ emptyC  xs) 
 then firstC xs : (iterator $ popC xs)
 else []
--iterator _ = []

--Node 7 [Node 6 [Node 3 [],Empty,Node 6 []],Node 1 [],Node 12 [Node 9 []],Node 5 [Empty,Empty,Node 8 [],Node 9 [],Node 1 []]]
