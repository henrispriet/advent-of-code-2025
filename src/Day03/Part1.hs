module Day03.Part1 where

import Data.List

-- import Debug.Trace

run :: IO String
run = do
  -- input <- readFile "inputs/dayxx-partx.txt"
  let input = testInput
  let parsed = parse input
  print parsed
  let solved = solve parsed
  return $ show solved

testInput :: String
testInput = "987654321111111\n\
\811111111111119\n\
\234234234234278\n\
\818181911112111"

type Problem = [[Int]]

type Solution = Int

-- Parser

parse :: String -> Problem
parse = map parseLine . lines

parseLine :: String -> [Int]
parseLine = map $ read . singleton

-- Algorithm

solve :: Problem -> Solution
solve = error "not implemented"
