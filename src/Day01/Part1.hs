module Day01.Part1 where

-- import Debug.Trace

run :: IO String
run = do
  input <- readFile "inputs/day01-part1.txt"
  let parsed = parse input
  let solved = solve parsed
  return $ show solved

testInput :: String
testInput =
  "L68\n\
  \L30\n\
  \R48\n\
  \L5\n\
  \R60\n\
  \L55\n\
  \L1\n\
  \L99\n\
  \R14\n\
  \L82"

type Problem = [Int]

type Solution = Int

-- Parser

parse :: String -> Problem
parse input = map parseMove $ filter (/= "") $ lines input

parseMove :: String -> Int
parseMove ('R' : n) = read n
parseMove ('L' : n) = -(read n)
parseMove _ = error "invalid move"

-- Algorithm

doMove :: Int -> Int -> Int
doMove pos move = (((pos + move) `mod` 100) + 100) `mod` 100

updateState :: (Int, Int) -> Int -> (Int, Int)
updateState (rotations, pos) move = do
  let newPos = doMove pos move
  if newPos == 0
    then
      (rotations + 1, newPos)
    else
      (rotations, newPos)

solve :: Problem -> Solution
solve = fst . foldl updateState (0, 50)
