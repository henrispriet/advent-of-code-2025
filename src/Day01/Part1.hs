module Day01.Part1 where

-- import Debug.Trace

solve :: IO ()
solve = print $ calcPassword [50, 3, -4, 1, -6]

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

calcPassword :: [Int] -> Int
calcPassword = fst . calcMoves
