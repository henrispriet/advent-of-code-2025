import Day01.Part1
import Day01.Part2
import Day02.Part1
import Day02.Part2
import Day03.Part1
import Day03.Part2
import Day04.Part1
import Day04.Part2
import Day05.Part1
import System.IO.Unsafe
import Template
import Test.HUnit

main :: IO ()
main = do
  _ <- runTestTT tests
  return ()

tests :: Test
tests =
  TestList
    [ TestLabel "day01part1" day01part1,
      TestLabel "day01part2" day01part2,
      TestLabel "day02part1" day02part1,
      TestLabel "day02part2" day02part2,
      TestLabel "day03part1" day03part1,
      TestLabel "day03part2" day03part2,
      TestLabel "day04part1" day04part1,
      TestLabel "day04part2" day04part2,
      TestLabel "day05part1" day05part1,
      TestLabel "template" template
    ]

template :: Test
template = TestCase (assertEqual "template" "1" (unsafePerformIO Template.run))

day01part1 :: Test
day01part1 = TestCase (assertEqual "day01part1" "1059" (unsafePerformIO Day01.Part1.run))

day01part2 :: Test
day01part2 = TestCase (assertEqual "day01part2" "6305" (unsafePerformIO Day01.Part2.run))

day02part1 :: Test
day02part1 = TestCase (assertEqual "day02part1" "23560874270" (unsafePerformIO Day02.Part1.run))

day02part2 :: Test
day02part2 = TestCase (assertEqual "day02part2" "44143124633" (unsafePerformIO Day02.Part2.run))

day03part1 :: Test
day03part1 = TestCase (assertEqual "day03part1" "17493" (unsafePerformIO Day03.Part1.run))

day03part2 :: Test
day03part2 = TestCase (assertEqual "day03part2" "173685428989126" (unsafePerformIO Day03.Part2.run))

day04part1 :: Test
day04part1 = TestCase (assertEqual "day04part1" "1602" (unsafePerformIO Day04.Part1.run))

day04part2 :: Test
day04part2 = TestCase (assertEqual "day04part2" "9518" (unsafePerformIO Day04.Part2.run))

day05part1 :: Test
day05part1 = TestCase (assertEqual "day05part1" "525" (unsafePerformIO Day05.Part1.run))
