

data Tree a = Node a (Tree a) (Tree a) | Empty deriving (Show)


size :: Tree a -> Int 
size Empty = 0 
size (Node _ t1 t2)  = 1 + (size t1) + (size t2) 

height :: Tree a -> Int 
height Empty = 0 
height ( Node _ t1 t2) = 1 + (maximum [(height t1),(height t2)])

equal :: Eq a => Tree a -> Tree a -> Bool 
equal Empty Empty = True
equal Empty _ = False 
equal _ Empty = False 
equal (Node x t11 t12) (Node y t21 t22) =
 ( x== y) && (equal t11 t21) && (equal t12 t22) 

isomorphic :: Eq a => Tree a -> Tree a -> Bool 
isomorphic Empty Empty = True 
isomorphic Empty _ = False 
isomorphic _ Empty = False 
isomorphic (Node x t11 t12) (Node y t21 t22) = 
 (x == y) && (posib1  || posib2) 
  where posib1 = (isomorphic t11 t21) && (isomorphic t12 t22)  
        posib2 = (isomorphic t11 t22) && (isomorphic t12 t21)



preOrder :: Tree a -> [a] 
preOrder Empty = [] 
preOrder (Node x t1 t2) =  x : (preOrder t1)++ (preOrder t2)  


postOrder :: Tree a -> [a] 
postOrder Empty = [] 
postOrder (Node x t1 t2) = (postOrder t1) ++ (postOrder t2) ++ [x]

inOrder :: Tree a -> [a] 
inOrder Empty = [] 
inOrder (Node x t1 t2) = (inOrder  t1) ++ [x] ++ (inOrder  t2)


--pseudo cua
breadthFirst :: Tree a -> [a]
breadthFirst t = bfs [t]

bfs :: [Tree a] -> [a]
bfs [] = []
bfs (Empty:ts) = bfs ts
bfs ((Node x ex dx):ts) = x : bfs (ts ++ [ex,dx])

build :: Eq a => [a] -> [a] -> Tree a
build [] [] = Empty
build [x] [y] = Node x (Empty) (Empty) 
--build [] [] = Empty 
build [] (x:xs) = Node x (build xs []) (Empty)
build (x:xs) [] = Node x (build xs []) (Empty)
build (x:xs) ys = Node x 
 (build leftpre leftin)
 (build rightpre rightin)
 where leftin = takeWhile (/= x) ys
       rightin = tail ( dropWhile(/= x) ys ) 
       (leftpre,rightpre) = splitAt (length leftin) ( xs)


overlap :: (a -> a -> a) -> Tree a -> Tree a -> Tree a 
overlap f Empty Empty = Empty
overlap f Empty t = t 
overlap f t Empty = t 
overlap f (Node a t11 t12) (Node b t21 t22)=
 Node (f a b) (overlap f t11 t21) (overlap f t12 t22)
