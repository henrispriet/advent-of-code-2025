module Day01.Part2 where

import Day01.Part1 ({-testInput,-} parse)

-- import Debug.Trace

solve :: IO ()
solve = do
  input <- readFile "inputs/day01-part1.txt"
  -- let input = testInput
  let parsed = parse input
  let solution = algo parsed
  print solution

-- Algorithm

-- idem part 1 but ensures 0 <= output < 100
doMove' :: Int -> Int -> Int
doMove' pos move = (((pos + move) `mod` 100) + 100) `mod` 100

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

-- idem part 1 but uses doMove'
updateState' :: (Int, Int) -> Int -> (Int, Int)
updateState' (rotations, pos) move = do
  let newPos = doMove' pos move
  if newPos == 0
    then
      (rotations + 1, newPos)
    else
      (rotations, newPos)

updateStateInParts :: (Int, Int) -> Int -> (Int, Int)
updateStateInParts state 0 = state
updateStateInParts state move = do
  let pos = snd state
  let (part, remainder) = partitionMove pos move
  let newState = updateState' state part
  updateStateInParts newState remainder

calcMoves :: [Int] -> (Int, Int)
calcMoves = foldl updateStateInParts (0, 50)

algo :: [Int] -> Int
algo = fst . calcMoves
