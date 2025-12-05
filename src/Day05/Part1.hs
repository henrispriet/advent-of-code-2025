module Day05.Part1 where

import Data.Bifunctor
import Data.Ix
import Day02.Part1 (parseRange)

-- import Debug.Trace

run :: IO String
run = do
  input <- readFile "inputs/day05-part1.txt"
  -- let input = testInput
  let parsed = parse input
  -- print parsed
  let solved = solve parsed
  return $ show solved

testInput :: String
testInput = "3-5\n\
\10-14\n\
\16-20\n\
\12-18\n\
\\n\
\1\n\
\5\n\
\8\n\
\11\n\
\17\n\
\32"

type Range = (Int, Int)

type Problem = ([Range], [Int])

type Solution = Int

-- Parser

parse :: String -> Problem
parse = bimap parseRanges (parseIds . filter (/="")) . break (=="") . lines

parseIds :: [String] -> [Int]
parseIds = map read

parseRanges :: [String] -> [Range]
parseRanges = map parseRange

-- Algorithm

solve :: Problem -> Solution
solve (ranges, ids) = length . filter (\i -> any (`inRange` i) ranges) $ ids
