-- using a concept called 'ranges' Haskell provides a shortcut for creating a list contains all elements between two points
-- use .. to indicate a range

cenRange :: [Integer]
cenRange = [1..100]

lastThree :: [Integer]
lastThree = drop 97 cenRange -- returns [98,99,100]

-- ranges also work with charaters
-- this list operator will produce a String (Char list),
-- but if the range is say from y to c it will not produce "yzavc", it will just produce an empty string
alphaRange :: [Char]
alphaRange = ['g'..'q']

-- ranges in steps
-- ranges can also produce an itterating sequence of elements in a given interval
-- this allows a range of numbers to count by n (n is always an Int)
-- n is calculated by the diffrence of the first and second number in the list
-- in this example the two numbers are 0 & 3, since the diffrence is 3,
-- the list will start at 0 and count up by 3 until it reaches 27
countByThree :: [Integer]
countByThree = [0,3..27]

-- if the first number is greater than the second the 'step' will be negitive, effecticley counting backwards
countDown :: [Integer]
countDown = [5,4..1] -- returns [5,4,3,2,1]

-- note you can use floats in ranges but as computers often handle floats with slight unpredicitbility it is not recomended and can often be avoided

-- generating an infinite list
-- making this list is as simple as making a range with no set end
infititeList :: [Integer]
infititeList = [1..] -- returns [1,2,3........(forever)] 

-- use case for infinite list
-- using the take function an infinite list can be used to generate a list whoes size can not be predetirmined
multiplesWanted :: Int
multiplesWanted = 7

multiplesOfSeven :: [Integer]
multiplesOfSeven = take multiplesWanted [0,7..]

-- cycle function
-- using 'cycle' a list can be repeated infintly. This means there should always a limit to how large the list can grow 
manyMultsOfSeven :: [Integer]
manyMultsOfSeven = take 100 (cycle multiplesOfSeven)

-- repeat function
-- repeats a single element
manySevens :: [Integer]
manySevens = take 7 $ repeat 7  

-- replicate function 
-- this function can serve as an alternitive to the use case of repeat above. 
-- if the purpose of 'repeat' will be to just take from the created infinite list, replicate can be used to simplify syntax
-- structure; $ replicate number-of-replications element-to-be-replicated
manySevens2 :: [Integer]
manySevens2 = replicate 7 7
-- this does the same thing as the example for repeat

main :: IO ()
main = print manyMultsOfSeven