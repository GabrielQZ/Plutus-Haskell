-- list comprehesion basics

-- multiples of a range greater than a miniumum value
minValue :: Integer
minValue = 10

newList1 :: [Integer]
newList1 = [x*2 | x <- [1..10], x*2 >= minValue]
-- newList will become [10, 12, 14, 16, 18, 20]
-- first a list is generated with values 1 to 10
-- then they are all multiplied by 2
-- finally a predicate is used to filter numbers that are less than 'minValue'

-- multiple predicates
-- more than one predicate can be used but they are implement in a AND context when using ',' to seperate them
-- so all predicates must return true for the value to end up in the final list
newList2 :: [Integer]
newList2 = [x | x <- [1..7], x /= 2, x /= 5, x /= 6]
-- this will first create a list from 1 to 7 
-- then filter out values equal to 2, 5, and 6

-- AND and OR in predicates
-- to use AND with predicates use ',' to seperate
-- to implement OR use '||'
-- note the first predicate will always have ',' to seperate from the list generating part of code
newList3 :: [Double]
newList3 = [ x | x <- [1..100], x * 3 < 20 || x / 3 > 20, x /= 3]
-- this will return all numbers that are...
-- lt 20 when mult. by 3 
-- OR gt 20 when div. by 3 
-- AND not equal to 3

-- using IF ELSE in list comp.
-- this example will use a function that takes a list as an arg and produces a new list base on the first using conditional statements
-- gradeStudents :: [[Integer]] -> [[Char]]
gradeStudents :: (Ord a, Num a, Show a) => [a] -> [[Char]]
gradeStudents grades = [if grade > 70 then "You passed with a grade of: "++ show grade else "You failed" | grade <- grades]

studentGrades :: [Integer]
studentGrades = [50,60..100]

studentsReport :: [[Char]]
studentsReport = gradeStudents studentGrades

-- comprehension of multiple list
-- this example will generate every word combinations by drawing from 3 unique list
list1 :: [[Char]]
list1 = ["red", "green", "blue"]
list2 :: [[Char]]
list2 = ["1", "2", "3"]
list3 :: [[Char]]
list3 = ["ADA", "ETH", "BTC"]

allCombos :: [[Char]]
allCombos = [one ++ "-" ++ two ++ "-" ++ three | one <- list1, two <- list2, three <- list3]
-- this operation is equivielent to creating a tripple nested for loop to create each combination


-- custom length function
-- the length function built into Haskell is good, this is just for learning how to work with list better
myLenFunc :: Num a => [t] -> a
myLenFunc inputList = sum [1 | _ <- inputList]


main :: IO ()
main = print studentsReport