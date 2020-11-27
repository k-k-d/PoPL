import Control.Monad.State(StateT, get, evalState, MonadState(state), State)
import Control.Monad.Identity(Identity)

fibonacci :: Int -> Int                 -- this is the function to be called
fibonacci n
        | n < 0 = error "fibonacci: negative number"
        | otherwise = head $ evalState fibonacciGen (0, 1, n, [0])      -- the nth fibonacci number is the head of the list returned by evalState

fibonacciState :: State (Int, Int, Int, [Int]) ()                       -- defines the next state
fibonacciState = state (\(a, b, n, d) -> ((), (b, a + b, n - 1, b : d)))

fibonacciGen :: StateT (Int, Int, Int, [Int]) Identity [Int]        -- decrements n and calls the state transition till n is 0
fibonacciGen = do
    (_, _, n, x) <- get
    if n /= 0 then do
        fibonacciState
        fibonacciGen
    else
        return x