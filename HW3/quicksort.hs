-- 1. quicksort in haskell

quicksort :: Ord a => [a] -> [a]

quicksort [] = []
quicksort (x : xs) = quicksort (filter (< x) xs) ++ filter (== x) (x : xs) ++ quicksort (filter (> x) xs)