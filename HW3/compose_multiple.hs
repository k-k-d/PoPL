-- 5. compose multiple functions

compose_multiple :: [t -> t] -> t -> t

-- compose_multiple [] c = c
-- compose_multiple (f : fs) c = f (compose_multiple fs c)



-- can be implemented in a shorter way using higher order functions (foldr)

compose_multiple fs c = foldr (\f x -> f x) c fs