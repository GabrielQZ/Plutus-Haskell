-- Haskell functions can return strings, very simply wrap the text in ""

returnMyName = "gabriel"
--this function simply returns my name as a string


--on way to write an if, else if, else function
acronymConvert1 :: [Char] -> [Char]
acronymConvert1 acronym = 
  if acronym == "PoS" then "Proof of Stake" 
  else if acronym == "PoW" then "Proof of Work" 
  else "Have not seen that protocall before"

--second way to write the same function
acronymConvert2 :: [Char] -> [Char]
acronymConvert2 acronym
  | acronym == "PoS" = "Proof of Stake"
  | acronym == "PoW" = "Proof of Work"
  | otherwise = "Have not seen that protocall before"

main = print (acronymConvert2 "PoW")