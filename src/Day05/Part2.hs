module Day05.Part2 where

import Data.Ix
import Day05.Part1 (testInput)
import qualified Day05.Part1 (parse)

import Debug.Trace

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

rangeIntersection :: Range -> Range -> Range
rangeIntersection (i1, j1) (i2, j2) = (max i1 i2, min j1 j2)

rangeUnion :: Range -> Range -> MultiRange
rangeUnion r1 r2
  | rangeSize (rangeIntersection r1 r2) == 0 = [r1, r2]
  | otherwise = do
    let (i1, j1) = r1
    let (i2, j2) = r2
    [(min i1 i2, max i1 i2 - 1), (max i1 i2, min j1 j2), (min j1 j2 + 1, max j1 j2)]

rangeSub :: Range -> Range -> Range
rangeSub r1 r2
  -- no intersection
  | rangeSize (rangeIntersection r1 r2) == 0 = r1
  -- r1 is left of r2
  | fst (rangeIntersection r1 r2) == fst r2 = (fst r1, fst r2 - 1)
  -- r1 is right of r2
  | fst (rangeIntersection r1 r2) == fst r1 = (snd r2 + 1, snd r1)
  | otherwise = error "bad stuff"

multiRangeUnion :: MultiRange -> Range -> MultiRange
multiRangeUnion [] r = [r]
multiRangeUnion (mr:mrs) r
  | rangeSize r == 0 = (mr:mrs)
  | otherwise = mr : multiRangeUnion mrs (r `rangeSub` mr)

multiRangeSize :: MultiRange -> Int
multiRangeSize = sum . map rangeSize

type MultiRange = [Range]

pairs :: [a] -> [(a, a)]
pairs [] = []
pairs (x : xs) = map (x,) xs ++ pairs xs

solve :: Problem -> Solution
solve = multiRangeSize . traceShowId . foldl multiRangeUnion []
