module Day02.Part1 where

import Data.Ix
import GHC.Float

-- import Debug.Trace

run :: IO String
run = do
  -- input <- readFile "inputs/dayxx-partx.txt"
  let input = testInput
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

calcExp :: Int -> Int
calcExp num = ceilingFloat $ logBase 10.0 (int2Float num) / 2

calcNDigits :: Int -> Int
calcNDigits num = floorFloat $ logBase 10.0 (int2Float num)

getInvalidIds :: (Int, Int) -> [Int]
getInvalidIds (begin, end) = do
  -- TODO: better name for  e and d
  let e = calcExp begin
  let d = 10 ^ e
  let toCheck = map (* (d + 1)) $ range (begin `div` d, end `div` d)
  filter (\x -> inRange (begin, end) x && calcExp x == e) toCheck

solve :: Problem -> Solution
solve p = sum $ concatMap getInvalidIds p
