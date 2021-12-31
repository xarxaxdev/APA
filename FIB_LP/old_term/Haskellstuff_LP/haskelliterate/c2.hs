data Queue a = Queue [a] [a]
    deriving (Show)


create :: Queue a
create = Queue [] [] 

push :: a -> Queue a -> Queue a
push x (Queue start end) = (Queue start (x:end)) 

pop :: Queue a -> Queue a 
pop (Queue [] []) = (Queue [] [])
pop (Queue [] list) = (Queue (tail (reverse list)) [])
pop (Queue (x:xs) list) = (Queue xs list)

top :: Queue a -> a
top (Queue [] list ) = last list
top (Queue (x:xs) _ ) = x 

empty :: Queue a -> Bool
empty (Queue [] []) = True 
empty _ = False 

--iguals :: Eq a Queue a -> Queue a -> Bool 
--iguals (Queue [] []) (Queue [] []) = True 
--iguals (Queue (x:xs) []) (Queue [] []) = False
--iguals (Queue [] []) (Queue (x:xs) []) = False
--iguals (Queue (x:xs) []) (Queue (y:ys) []) = 
-- (x==y) && (iguals (Queue xs []) (Queue ys []))
--iguals (Queue a a2) (Queue b b2) =
 --iguals (Queue (a++ reverse a2) []) 
 --(Queue (b++reverse b2) [] )


instance Eq a => Eq (Queue a) where 
 (Queue [] [])== (Queue [] []) = True 
 (Queue (x:xs) []) == (Queue [] []) = False
 (Queue [] []) == (Queue (x:xs) []) = False
 (Queue (x:xs) []) == (Queue (y:ys) []) = 
  (x==y) && ( (Queue xs []) == (Queue ys []))
 (Queue a a2) == (Queue b b2) =
   (Queue (a++ reverse a2) []) == (Queue (b++reverse b2) [] ) 



