-- if you need a specific part of a list,
-- Haskell has some built in commands to query parts of a list

-- note on an empty list these will produce runtime exception errors

-- head if the first element in a list (left)
-- last is the last element (right)
-- tail is all the elements except the head
-- init is all the elements except the last

orgList :: [Integer]
orgList = [1,2,3]

headElm :: Integer
headElm = head orgList -- returns 1

lastElm :: Integer
lastElm = last orgList -- returns 3

tailElm :: [Integer]
tailElm = tail orgList -- returns [2,3]

initElm :: [Integer]
initElm = init orgList -- returns [1,2]

-- getting the length of a list is a simple function called as 'length' and takes a list as an arg
-- ex.
listLen :: Int
listLen = length [1,2,3,4,5] -- returns 5

-- if applicable mathimatical operations can be preformed on all element of a list
-- the operations available are: sum & product
listSum :: Integer
listSum = sum orgList

listProd :: Integer
listProd = product orgList

-- the 'null' function takes a list as an arg and returns a boolean on wether the list is empty or not
isNull :: Bool
isNull = null [] -- returns True

isNotNull :: Bool
isNotNull = null [1] -- returns False

-- take & drop

-- the take function accepts an int and a list as args
-- this will work like the slice function in JS and return the first n number of elements in a list and produce a new list
taken :: [Integer]
taken = take 2 orgList -- returns [1,2]

-- drop will remove n number of elements and produce a list with the remaining elements
dropped :: [Integer]
dropped = drop 2 orgList -- returns [3]

-- note taking or dropping more elements than present will NOT produce an exception

-- maximum & minimum
-- simply returns the largest or smallest element in a list
minInList :: Integer
minInList = minimum orgList

maxInList :: Integer
maxInList = maximum orgList

-- searching for elements
-- using the 'elem' function in an infix manner will return a boolean wether a element exist in a list
-- ex.
twoExist :: Bool
twoExist = 2 `elem` orgList -- returns True

main :: IO ()
main = print listProd