--1

mconcat'::[[a]] -> [a]
mconcat' xs = [ x| y<- xs, x<- y]

concat3:: [[[a]]] -> [a]
concat3 xs = mconcat (map mconcat xs)

--falta el 2 foldr

--3
mix:: [a] -> [a] -> [a] 
mix [] x = x
mix x [] = x
mix (x:xs) (y:ys) = x:y:(mix xs ys)

lmix:: [Int] -> [a] -> [a]
lmix [] sol = sol
lmix (x:xs) sol = lmix xs (mix f s)
 where (f,s) = splitAt x sol

--4
dPascal :: Int ->[Integer]
dPascal v =until (myfoo (toInteger v)) (foo 0) [1,2..]
 where myfoo = (\x list2 ->x+1 == head (tail list2))

foo:: Integer -> [Integer] -> [Integer]
foo _ [] = []
foo old (x:xs) = (x+old): foo (x+old) xs 


--5

data BTree a = Empty | Node a (BTree a) (BTree a)
 deriving Show

buildTreeF :: [[a]] -> BTree a
buildTreeF [] = Empty 
buildTreeF [[]] = Empty
buildTreeF list = Node (head$head$list)  (buildTreeF left) (buildTreeF righ)
 where  (left, righ) = fakeuncurry$ spliterate (tail list)


--parte probando de rellenar la izquierda de un arbol
splittree :: [a]-> Int -> ([a],[a])
splittree (x:y:xs) 0 = ([x], [y])
splittree (x:ys) 0 = ([x], [])
splittree xs depth = if(depth > length xs)
 then (xs , [])
 else (take (depth*2) xs, drop (depth*2) xs)

spliterate:: [[a]] -> [([a],[a])]
spliterate supalist = zipWith splittree supalist [0..]

--parte a la mitad una lista
splithalf :: [a] -> ([a],[a])
splithalf xs = ((take n xs) , (drop n xs))
 where n =quot (length xs) 2

--dado un [([a],[b])] junta cada lado por separado
--para que la constructora de arboles lo pueda usar
fakeuncurry :: [([a],[b])] ->([[a]],[[b]])
fakeuncurry xs = (left, righ)
 where left = foldr (:) [] (map fst xs)
       righ = foldr (:) [] (map snd xs)

class Lit a where
 unary ::  a -> a 
 binary :: a -> a -> a
 list :: [a] -> a

data Expr a = Val a | Unary (Expr a) | Binary (Expr a ) (Expr a) 
 | List [Expr a] deriving Show

eval ::( Lit a) => (Expr a) -> a
eval (Val e) = e 
eval (Unary e) = unary $ eval e
eval (Binary e1 e2) = binary (eval e1) (eval e1)
eval (List elist) = list$ map eval elist

instance Lit Int where
 unary = negate
 binary x y= x+y  
 list = sum

