-- In Haskell functions with two parameters can be called in a prefix or infix manner

-- when calling a functions the function name is typically supplied first then the arguments are supplied after a space and seperated by a space

--prefix
a :: Integer
a = div 10 2

--infix
b :: Integer
b = 10 `div` 2

-- succ is used to evaluate the successor of a number (equivilent to ++)
c :: Integer
c = succ b

main :: IO ()
main = print (a + b - c)
-- expected output: 4 ( 5 + 5 - 6)