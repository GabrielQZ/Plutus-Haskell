-- Basics of Tuples in Haskell

-- create a basic Tuple
basicTuple :: ([Char], Double)
basicTuple = ("Hello Dev", 3.14)
-- as you can see this tuple contains three diffrent types and can have infinitly more

-- fst function
-- this function returns the first element in a tuple
firstElm :: [Char]
firstElm = fst basicTuple -- returns "Hello Dev"


-- snd function
-- this function returns the second element in a tuple
secondElm :: Double
secondElm = snd basicTuple -- returns "3.14"

-- creating a tuple from two list
-- to do this I will utilze the 'zip' function
-- this will take two ordered list that corispond stake pool names to the number of blocks produced in their lifetime 
pools :: [[Char]]
pools = ["AIR", "FIRE", "TORO", "IOHK", "OCEAN"]
blocks :: [Integer]
blocks = [1, 32, 2, 1421, 142]

stakePoolTuple :: [([Char], Integer)]
stakePoolTuple = zip pools blocks

main :: IO ()
main = print stakePoolTuple
