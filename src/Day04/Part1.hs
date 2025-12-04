module Day04.Part1 where

import GHC.Arr

-- import Debug.Trace

run :: IO String
run = do
  input <- readFile "inputs/day04-part1.txt"
  -- let input = testInput
  let parsed = parse input
  -- print parsed
  let solved = solve parsed
  return $ show solved

testInput :: String
testInput =
  "..@@.@@@@.\n\
  \@@@.@.@.@@\n\
  \@@@@@.@.@@\n\
  \@.@@@@..@.\n\
  \@@.@@@@.@@\n\
  \.@@@@@@@.@\n\
  \.@.@.@.@@@\n\
  \@.@@@.@@@@\n\
  \.@@@@@@@@.\n\
  \@.@.@@@.@."

type Problem = Array (Int, Int) Bool

type Solution = Int

-- Parser

parse :: String -> Problem
parse = toArray . map parseLine . filter (/= "") . lines

parseLine :: String -> [Bool]
parseLine = map (== '@')

-- NOTE: list must be array-shaped (rows of equal length and at least 1 row)
toArray :: [[a]] -> Array (Int, Int) a
toArray list = do
  let rows = length list
  let columns = length (head list)
  listArray ((1, 1), (rows, columns)) $ concat list

-- Algorithm

subArray :: (Ix j) => (j, j) -> Array j e -> Array j e
subArray r = ixmap r id

applyKernel :: Array (Int, Int) Bool -> (Int, Int) -> Int
applyKernel arr pos = do
  let (i, j) = pos
  let r = ((i - 1, j - 1), (i + 1, j + 1))
  let window = subArray r $ arr // [(pos, False)]
  count id . elems $ window

numSurrounding :: Array (Int, Int) Bool -> [Int]
numSurrounding arr = do
  let ((i1, j1), (i2, j2)) = bounds arr
  let expandedBounds = ((i1 - 1, j1 - 1), (i2 + 1, j2 + 1))
  let zeros = listArray expandedBounds $ repeat False
  let expanded = zeros // assocs arr
  let rollIndeces = map fst . filter snd $ assocs arr
  map (applyKernel expanded) rollIndeces

count :: (a -> Bool) -> [a] -> Int
count f = length . filter f

solve :: Problem -> Solution
solve = count (< 4) . numSurrounding
