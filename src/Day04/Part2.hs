module Day04.Part2 where

import GHC.Arr
import Day04.Part1 (testInput, parse, reachable, nRolls)

-- import Debug.Trace

run :: IO String
run = do
  -- input <- readFile "inputs/day04-part1.txt"
  let input = testInput
  let parsed = parse input
  -- print parsed
  let solved = solve parsed
  return $ show solved

type Problem = Array (Int, Int) Bool

type Solution = Int

-- Algorithm

removeReachable :: Array (Int, Int) Bool -> Array (Int, Int) Bool
removeReachable arr
  | null (reachable arr) = arr
  | otherwise = removeReachable $ arr // map (,False) (reachable arr)

solve :: Problem -> Solution
solve p = nRolls p - nRolls (removeReachable p)
