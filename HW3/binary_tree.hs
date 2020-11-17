-- 6. a. defining a datastructure for binary trees

data BinaryTree a = Node a (BinaryTree a) (BinaryTree a) | Nil deriving Show

-- 6. b. a map function for binary trees

mapTree :: (a -> b) -> BinaryTree a -> BinaryTree b

mapTree _ Nil = Nil
mapTree f (Node a l r) = Node (f a) (mapTree f l) (mapTree f r)

-- 6. c. a fold function for binary trees

foldTree :: (a -> b -> b -> b) -> b -> BinaryTree a -> b

foldTree _ i Nil = i
foldTree f i (Node a l r) = f a (foldTree f i l) (foldTree f i r)