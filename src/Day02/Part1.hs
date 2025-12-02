module Day02.Part1 where

import Data.Ix
import GHC.Float

-- import Debug.Trace

run :: IO String
run = do
  input <- readFile "inputs/day02-part1.txt"
  -- let input = testInput
  let parsed = parse input
  -- print parsed
  let solved = solve parsed
  return $ show solved

testInput :: String
testInput = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

type Problem = [(Int, Int)]

type Solution = Int

-- Parser

parse :: String -> Problem
parse = map parseRange . split (== ',')

-- see https://stackoverflow.com/a/4981265
split :: (Char -> Bool) -> String -> [String]
split p s = case dropWhile p s of
  "" -> []
  s' -> w : split p s''
    where
      (w, s'') = break p s'

parseRange :: String -> (Int, Int)
parseRange str = do
  let list = split (== '-') str
  let begin = head list
  let end = last list
  (read begin, read end)

-- Algorithm

numDigits :: Int -> Int
numDigits num = floorFloat $ logBase 10.0 (int2Float num) + 1

-- digits must be multiple of repetitions for this function to give a useful result!!
genKey :: Int -> Int -> Int
genKey repetitions digits = do
  let expNumerators = range (0, repetitions - 1)
  let expFrac n = digits `div` repetitions * n
  sum $ map (\n -> 10 ^ expFrac n) expNumerators

-- digits must be multiple of repetitions for this function to give a useful result!!
genRange :: Int -> Int -> [Int]
genRange repetitions digits = do
  let e = digits `div` repetitions
  range (10 ^ (e - 1), 10 ^ e - 1)

genInvalidIds :: Int -> Int -> [Int]
genInvalidIds repetitions digits
  | digits `mod` repetitions == 0 =
      map (* genKey repetitions digits) $ genRange repetitions digits
  | otherwise = []

genInvalidIdsInRange :: (Int, Int) -> [Int]
genInvalidIdsInRange (begin, end) = do
  let inNumRange = inRange (begin, end)
  let digitRange = range (numDigits begin, numDigits end)
  concatMap (filter inNumRange . genInvalidIds 2) digitRange

solve :: Problem -> Solution
solve = sum . concatMap genInvalidIdsInRange
