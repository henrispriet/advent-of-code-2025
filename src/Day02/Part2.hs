module Day02.Part2 where

import Data.Ix
import Data.List
import Day02.Part1 ({-testInput,-} numDigits, parse, genInvalidIds)

-- import Debug.Trace

run :: IO String
run = do
  input <- readFile "inputs/day02-part1.txt"
  -- let input = testInput
  let parsed = parse input
  -- print parsed
  let solved = solve parsed
  return $ show solved

type Problem = [(Int, Int)]

type Solution = Int

-- Algorithm

zipf :: (a -> b -> c) -> (a,b) -> c
zipf f (a, b) = f a b

-- see https://stackoverflow.com/a/16109302
rmdups :: (Ord a) => [a] -> [a]
rmdups = map head . group . sort

genInvalidIdsInRange :: (Int, Int) -> [Int]
genInvalidIdsInRange (begin, end) = do
  let inNumRange = inRange (begin, end)
  let digitRange = range (numDigits begin, numDigits end)
  let repRange d = range (2, d)
  let repDigitPairs = concatMap (\d -> map (, d) $ repRange d ) digitRange
  rmdups $ concatMap (filter inNumRange . zipf genInvalidIds) repDigitPairs

solve :: Problem -> Solution
solve = sum . concatMap genInvalidIdsInRange
