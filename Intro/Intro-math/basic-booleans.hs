-- In Haskell booleans are written with uppercase first letters 
-- True and False

-- Haskell uses typicall conventions for  AND and OR; && and ||

-- the not opertator in Haskell is litterally 'not'

-- not True  returns False

trueValue = (not True || not (False && True))

equalityCheck = 3.14 == 3.14

-- Haskel uses / to indicate NOT in the equality operator
inequalityCheck = 7 /= 42

-- Strings when compared are compared by value and not by memory pointers so 
strA = "hello dev"
strB = "hello dev"
strEquality = strA == strB -- returns True

main :: IO ()
main = print strEquality