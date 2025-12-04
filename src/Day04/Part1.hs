module Day04.Part1 where

import GHC.Arr

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
testInput = "..@@.@@@@.\n\
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
parse = toArray . map parseLine . filter (/="") . lines

parseLine :: String -> [Bool]
parseLine = map (=='@')

-- NOTE: list must be array-shaped (rows of equal length and at least 1 row)
toArray :: [[a]] -> Array (Int, Int) a
toArray list = do
  let rows = length list
  let columns = length (head list)
  let indeces = cartProd [1..rows] [1..columns]
  array ((1,1), (rows,columns)) $ zip indeces $ concat list

-- see https://stackoverflow.com/a/4119758
cartProd :: [a] -> [b] -> [(a,b)]
cartProd xs ys = [(x,y) | x <- xs, y <- ys]

-- Algorithm

solve :: Problem -> Solution
solve = error "unimplented"
