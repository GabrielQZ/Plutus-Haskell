
-- lists in Haskell need to be of the same type

intList :: [Integer]
intList = [1,2,3,7]

-- a string is just a list of Chars (characters)
myStr :: [Char]
myStr = "Hello Computer"

-- using ':t' in the interactive compiler you can return the type of a variable
-- ex. :t myString returns

-- string/list concatination is done through the ++ operator
firstHalfStr :: [Char]
firstHalfStr = "Hello"
secondHalfStr :: [Char]
secondHalfStr = [' ', 'W', 'o', 'r', 'l', 'd']

-- when concatinating one can write their [Char] written out or using the "" simpler syntax
message :: [Char]
message = firstHalfStr ++ secondHalfStr

-- use ++ when order of the join matters (appending to end), 
-- and it is computionally more expensive than the alternitive
-- the alternitive is to use ':' 
-- this appends a list element to the begining of a list
-- the syntax structures is *new item* : *List*
myIncompleteName = "ohn"
myCompleteName = 'J' : myIncompleteName
-- using list concatination is not destructive of the first list
-- and therefore must be captured by a new variable or the first variable must be reassigned

-- a multiples of ++ and : can be used in a single expression, 
-- use ++ to concat many strings or lists and use : to concat single elements to a list
completeMessage = message ++ ", my name is" ++ myCompleteName ++ "."

-- : is used to concat subElements to a larger structure ++ is used to concat two alike structures 
-- ie. String ++ String, Char : [Char]

-- : requires that the last argument be the larger structure, for example
charList = 'v' : 'a' : 'l' : 'i' : 'd' : []; 
-- without the final [] there will be an error because v,a,l, and i can not be placed within 'd' but the chars can be places within an empty list

-- list can also use comparision operators
-- [1,2,5] > [1,2,3]  returns True
-- "abc" < "acd"      returns True
-- "value" == "value" returns True

-- comparisions are done by value and memeory pointers are not what's being compared

main :: IO ()
main = putStrLn message  