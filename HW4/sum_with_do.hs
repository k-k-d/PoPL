sumRecurse :: IO Int                -- recursive function that evaluates and returns sum
sumRecurse = do
    n <- read <$> getLine           -- converts the string in the IO monad to int (IO Int) and unboxes it into n as Int
    if n == -1                      -- if sequence ends add 0
    then
        return 0
    else do                         -- otherwise recurse
        s <- sumRecurse             -- s gets the result of the next recursions unboxed as Int
        return (n + s)              -- add the current recursion n and the future recursions result n and box it by a return

summationWithDo :: IO ()            -- the function to be called
summationWithDo = do
    s <- sumRecurse                 -- get result from the sumRecurse function and print it
    print s                         -- prints integers