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

type Problem = Rolls

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

type Rolls = Array (Int, Int) Bool

type Neighbours = Array (Int, Int) (Maybe Int)

type Idx = (Int, Int)

type Bounds = (Idx, Idx)

offset :: Idx -> Idx -> Idx
offset (a1, b1) (a2, b2) = (a1 + a2, b1 + b2)

offsetArr :: Idx -> Array Idx a -> Array Idx a
offsetArr o arr = ixmap (bounds arr) (offset o) arr

subArr :: Bounds -> Array Idx a -> Array Idx a
subArr r = ixmap r id

-- NOTE: kernel must have odd width and height!
-- NOTE: arr must already have been expaned to fit kernel!
applyKernel :: Array Idx (b -> c) -> Array Idx b -> Idx -> Array Idx c
applyKernel kernel arr pivot = do
  let (kb1, kb2) = bounds kernel
  let windowBounds = (offset pivot kb1, offset pivot kb2)
  let window = subArr windowBounds arr
  listArray (bounds window) [f a | (f, a) <- zip (elems kernel) (elems window)]

neighboursKernel :: Array Idx (Bool -> Bool)
neighboursKernel = listArray ((-1, -1), (1, 1)) (repeat id) // [((0, 0), const False)]

overlay :: Array Idx a -> Array Idx a -> Array Idx a
overlay base over = base // assocs over

expand :: Int -> a -> Array Idx a -> Array Idx a
expand width defaultValue arr = do
  let ((i1, j1), (i2, j2)) = bounds arr
  let expandedBounds = ((i1 - width, j1 - width), (i2 + width, j2 + width))
  let zeros = listArray expandedBounds $ repeat defaultValue
  overlay zeros arr

calcNeighbours :: Rolls -> Neighbours
calcNeighbours arr = do
  let expanded = expand 1 False arr
  let applyNeighboursKernel = applyKernel neighboursKernel expanded
  let calcNumNeighbours = length . filter id . elems . applyNeighboursKernel
  let rollIndices = [i | (i, b) <- assocs arr, b]
  listArray (bounds arr) (repeat Nothing) // [(i, Just $ calcNumNeighbours i) | i <- rollIndices]

reachable :: Rolls -> [Idx]
reachable arr = [i | (i, Just n) <- assocs $ calcNeighbours arr, n < 4]

nRolls :: Rolls -> Int
nRolls = length . filter id . elems

solve :: Problem -> Solution
solve = length . filter (maybe False (< 4)) . elems . calcNeighbours
