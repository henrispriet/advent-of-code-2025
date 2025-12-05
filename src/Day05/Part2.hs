module Day05.Part2 where

import Data.Ix
import Day05.Part1 (testInput)
import qualified Day05.Part1 (parse)

-- import Debug.Trace

run :: IO String
run = do
  input <- readFile "inputs/day05-part1.txt"
  -- let input = testInput
  let parsed = parse input
  -- print parsed
  let solved = solve parsed
  return $ show solved

type Range = (Int, Int)

type Problem = [Range]

type Solution = Int

-- Parser

parse :: String -> Problem
parse = fst . Day05.Part1.parse

-- Algorithm

rangeIntersection :: (Ord a, Ord b) => (a, b) -> (a, b) -> (a, b)
rangeIntersection (i1, j1) (i2, j2) = (max i1 i2, min j1 j2)

pairs :: [a] -> [(a, a)]
pairs [] = []
pairs (x : xs) = map (x,) xs ++ pairs xs

solve :: Problem -> Solution
solve ranges = sum (map rangeSize ranges) - sum (map (rangeSize . uncurry rangeIntersection) (pairs ranges))
