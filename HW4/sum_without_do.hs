sumRecurse2 :: IO Int                                   -- recursive function that evaluates and returns sum
sumRecurse2 = (read <$> getLine :: IO Int) >>= (\n ->   -- replacing do with traditional binds and lambda functions
    if n == -1                                          -- converts the string in the IO monad to int (IO Int) and unboxes it into n as Int
    then return 0                                       -- if sequence box 0 and send to previous function call
    else sumRecurse2 >>= (\s ->                         -- s gets the result of the next recursions unboxed as Int
        return(n + s)))                                 -- add the current recursion n and the future recursions result n and box it by a return

summationWithoutDo :: IO ()                             -- the function to be called
summationWithoutDo = sumRecurse2 >>= print              -- get result from the sumRecurse function and print it