-- 4. number of words in a string

wordsCount :: String -> Int

wordsCount x = foldr (\_ b -> b+1) 0 $ words x



-- madanted to use a higher order function (foldr)