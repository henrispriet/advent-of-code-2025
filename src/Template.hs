-- module DayXX.PartX where
module Template where

-- import Debug.Trace

run :: IO String
run = do
  -- input <- readFile "inputs/dayxx-partx.txt"
  let input = testInput
  let parsed = parse input
  let solved = solve parsed
  return $ show solved

testInput :: String
testInput = "1"

type Problem = Int

type Solution = Int

-- Parser

parse :: String -> Problem
parse = read

-- Algorithm

solve :: Problem -> Solution
solve = id
