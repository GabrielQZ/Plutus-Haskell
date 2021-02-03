-- Haskell Basics
-- Haskell is a staticly typed language: this means variable checks can be done at compile time, variables can not change type either

--output a simple string to terminal
-- main = putStrLn "0110101001110101 Beep Boop"

-- this can be written in the interactive compiler to define a factorial function: 
-- let fac n = if n == 0 then 1 else n * fac (n-1)

-- define a factorial function
-- you can define outputs for single inputs
fac 0 = 1
-- or parameterized inputs
fac n = n * fac (n-1)
--outputs factorial of 77 to terminal
main = print (fac 77)
