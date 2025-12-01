import Test.HUnit
import System.IO.Unsafe

import Template
import Day01.Part1
import Day01.Part2

main :: IO ()
main = do
  _ <- runTestTT tests
  return ()

tests :: Test
tests = TestList [
    TestLabel "template" template,
    TestLabel "day01part1" day01part1,
    TestLabel "day01part2" day01part2
  ]

template :: Test
template = TestCase (assertEqual "template" "1" (unsafePerformIO Template.run))

day01part1 :: Test
day01part1 = TestCase (assertEqual "day01part1" "1059" (unsafePerformIO Day01.Part1.run))

day01part2 :: Test
day01part2 = TestCase (assertEqual "day01part2" "6305" (unsafePerformIO Day01.Part2.run))
