data BST a = E | N a (BST a) (BST a) deriving (Show)
 
insert :: Ord a => BST a -> a -> BST a
insert (E) x = N x (E)  (E) 
insert (N sumthin left right) x
 |x>sumthin = (N sumthin left (insert right x))
 |x<sumthin = (N sumthin (insert left x) right)
 |otherwise = (N sumthin left right) 


create :: Ord a => [a] -> BST a
create list = foldl insert (E) list

remove :: Ord a => BST a -> a -> BST a
remove (E) _ = (E)
remove (N a left right) x
 |x>a = (N a left (remove right x))
 |x<a = (N a (remove left x) right)
 |isnull left && isnull right = (E)
-- |not $ isnull left && 
 |isnull right= left -- a parti de aqui estic provant de substituir a
-- |not $ isnull right  && isnull left= right
 |isnull left= right
 |otherwise = create allchildren 
 where  (N element l r) = left
        allchildren= elements left ++ elements right
 
isnull :: BST a-> Bool
isnull (E) = True
isnull x = False

contains :: Ord a => BST a -> a -> Bool
contains (E) _ = False
contains (N cur left right) x =
 (cur == x ) || (contains left x) || (contains right x)

getmax :: BST a -> a
getmax (N x _ (E)) = x
getmax (N x _ r) = getmax r

getmin :: BST a -> a
getmin (N x (E) _) = x
getmin (N _ l _) = getmin l

size :: BST a -> Int
size (E) = 0
size (N _ left right) =1+(size left) + (size right)

elements :: BST a -> [a]
elements (E) = []
elements (N x l r) = (elements l) ++ [x] ++ (elements r)
