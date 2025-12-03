module Day03.Part1 where

import Data.Function
import Data.List

-- import Debug.Trace

run :: IO String
run = do
  input <- readFile "inputs/day03-part1.txt"
  -- let input = testInput
  let parsed = parse input
  -- print parsed
  let solved = solve parsed
  return $ show solved

testInput :: String
testInput =
  "987654321111111\n\
  \811111111111119\n\
  \234234234234278\n\
  \818181911112111"

type Problem = [[Int]]

type Solution = Int

-- Parser

parse :: String -> Problem
parse = map parseLine . filter (/= "") . lines

parseLine :: String -> [Int]
parseLine = map $ read . singleton

-- Algorithm

-- necessary because Data.List.maximumBy chooses the rightmost element as a tiebreak
maximumBy' :: (a -> a -> Ordering) -> [a] -> a
maximumBy' f = maximumBy f . reverse

argmaximum :: Ord a => [a] -> Int
argmaximum list = fst $ maximumBy' (compare `on` snd) $ zip [0..] list

getHighestJolt :: [Int] -> Int
getHighestJolt list = do
  let len = length list
  let firstDigitIndex = argmaximum $ take (len - 1) list
  let secondDigitIndex' = argmaximum $ drop (firstDigitIndex + 1) list
  let secondDigitIndex = firstDigitIndex + 1 + secondDigitIndex'
  (list !! firstDigitIndex) * 10 + (list !! secondDigitIndex)

solve :: Problem -> Solution
solve = sum . map getHighestJolt
