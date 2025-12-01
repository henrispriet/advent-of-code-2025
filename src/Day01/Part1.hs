module Day01.Part1 where

-- import Debug.Trace

solve :: IO ()
solve = do
    input <- readFile "inputs/day01-part1.txt"
    let parsed = parse input
    let solution = algo parsed
    print solution

testInput :: String
testInput = "L68\n\
\L30\n\
\R48\n\
\L5\n\
\R60\n\
\L55\n\
\L1\n\
\L99\n\
\R14\n\
\L82"

-- Parser

parse :: String -> [Int]
parse input = map parseMove $ filter (/= "") $ lines input

parseMove :: String -> Int
parseMove ('R':n) = read n
parseMove ('L':n) = - (read n)
parseMove _ = error "invalid move"

-- Algorithm

doMove :: Int -> Int -> Int
doMove pos move = (pos + move + 100) `mod` 100

updateState :: (Int, Int) -> Int -> (Int, Int)
updateState (rotations, pos) move =
    let
        newPos = doMove pos move
    in
    if newPos == 0 then
        (rotations + 1, newPos)
    else
        (rotations, newPos)

calcMoves :: [Int] -> (Int, Int)
calcMoves = foldl updateState (0, 50)

algo :: [Int] -> Int
algo = fst . calcMoves
