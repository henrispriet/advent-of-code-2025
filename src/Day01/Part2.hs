module Day01.Part2 where

import Day01.Part1 ({-testInput,-} parse, updateState)

-- import Debug.Trace

run :: IO ()
run = do
  input <- readFile "inputs/day01-part1.txt"
  -- let input = testInput
  let parsed = parse input
  let solution = algo parsed
  print solution

-- Algorithm

remainderTillZero :: Int -> Int -> Int
remainderTillZero pos direction
  | pos == 0 && direction < 0 = -100
  | pos == 0 && direction > 0 = 100
  | direction < 0 = -pos
  | direction > 0 = 100 - pos
  | otherwise = error "direction is zero"

partitionMove :: Int -> Int -> (Int, Int)
partitionMove _ 0 = (0, 0)
partitionMove pos move = do
  let remainder = remainderTillZero pos move
  if abs move <= abs remainder
    then
      (move, 0)
    else
      (remainder, move - remainder)

updateStateInParts :: (Int, Int) -> Int -> (Int, Int)
updateStateInParts state 0 = state
updateStateInParts state move = do
  let pos = snd state
  let (part, remainder) = partitionMove pos move
  let newState = updateState state part
  updateStateInParts newState remainder

algo :: [Int] -> Int
algo = fst . foldl updateStateInParts (0, 50)
