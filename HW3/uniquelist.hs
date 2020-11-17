-- 2. list of unique elements

uniq :: Eq a => [a] -> [a]

uniq [] = []
uniq (x : xs) = x : uniq (filter (/= x) xs)