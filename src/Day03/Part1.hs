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

allButLast :: Int -> [a] -> [a]
allButLast n list = take (length list - n) list

getHighestJolt :: Int -> [Int] -> Int
getHighestJolt 0 _ = 0
getHighestJolt nBatteries list = do
  let n = nBatteries - 1
  let currDigitIndex = argmaximum $ allButLast n list
  let digit = list !! currDigitIndex
  digit * 10 ^ n + getHighestJolt (nBatteries - 1) (drop (currDigitIndex + 1) list)

solve :: Problem -> Solution
solve = sum . map (getHighestJolt 2)
