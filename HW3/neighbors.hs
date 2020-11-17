-- 3. neighbors of an element in a 2D array

neighbors :: (Ord a1, Num a1, Ord a2, Num a2) => a1 -> a2 -> [(a1, a2)]

neighbors a1 a2 = quicksort (
    filter (\(x, y) -> x >= 0 && x < 10 && y >= 0 && y < 10 && (x, y) /= (a1, a2)) (
        foldr ((++) . (\(x, y) -> [(x, y-1), (x, y), (x, y+1)])) [] [(a1-1, a2), (a1, a2), (a1+1, a2)]))



-- problem statement mandates using only higher order functions
-- but can be implemented in a shorter way using list comprehension

-- neighbors a1 a2 = quicksort (
    -- filter (\(x, y) -> (x >= 0 && x < 10 && y >= 0 && y < 10) && ((x, y) /= (a1, a2))) [(x, y) | x <- [a1-1, a1, a1+1], y <- [a2-1, a2, a2+1]])






-- quicksort in haskell (from question 1)

quicksort :: Ord a => [a] -> [a]

quicksort [] = []
quicksort (x : xs) = quicksort (filter (< x) xs) ++ filter (== x) (x : xs) ++ quicksort (filter (> x) xs)