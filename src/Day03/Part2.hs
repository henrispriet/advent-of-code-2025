module Day03.Part2 where

import Day03.Part1 ({-testInput,-} parse, getHighestJolt)

-- import Debug.Trace

run :: IO String
run = do
  input <- readFile "inputs/day03-part1.txt"
  -- let input = testInput
  let parsed = parse input
  -- print parsed
  let solved = solve parsed
  return $ show solved

type Problem = [[Int]]

type Solution = Int

-- Algorithm

solve :: Problem -> Solution
solve = sum . map (getHighestJolt 12)
