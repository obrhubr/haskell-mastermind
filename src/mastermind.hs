{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
import           Control.Monad
import           Data.List

data Record = Record
    { secret :: [Int]
    , list   :: [((Int, Int), [Int])]
    }
    deriving Show

getBlackPins :: [Int] -> [Int] -> Int
getBlackPins (a : as) (b : bs) | null as   = compare
                               | otherwise = compare + getBlackPins as bs
    where compare = if a == b then 1 else 0

checkForPin :: Int -> Int -> Int
checkForPin a b | a == b    = 1
                | otherwise = 0

getWhitePins :: [Int] -> [Int] -> Int
getWhitePins (a : as) allb@(b : bs)
    | null as   = result
    | otherwise = result + getWhitePins as (delete a allb)
    where result = if sum (map (checkForPin a) allb) == 0 then 0 else 1

getComparison :: [Int] -> [Int] -> (Int, Int)
getComparison array1 array2 = (blackPins, whitePins)
  where
    blackPins = getBlackPins array1 array2
    whitePins = getWhitePins array1 array2

digits :: Integer -> [Int]
digits n = map (\x -> read [x] :: Int) (show n)

generateSeq :: [[Int]]
generateSeq =
    [ [a, b, c, d]
    | a <- [1 .. 8]
    , b <- [1 .. 8]
    , c <- [1 .. 8]
    , d <- [1 .. 8]
    ]

checkNewSeqOldSeq :: [Int] -> ((Int, Int), [Int]) -> Int
checkNewSeqOldSeq a ((bp, wp), b) =
    if getComparison a b == (bp, wp) then 0 else 1

checkNewSeq :: [Int] -> [((Int, Int), [Int])] -> Bool
checkNewSeq a b | null b    = True
                | otherwise = sum (map (checkNewSeqOldSeq a) b) == 0

readAsArray :: String -> [Int]
readAsArray = map (\x -> read [x] :: Int)

playGame :: Record -> Int
playGame a = do
    let val = head [ seq | seq <- generateSeq, checkNewSeq seq (list a) ]
    {- print val -}

    {- Uncomment to let it determine the W and B pins itself -}
    let (bp, wp) = getComparison val (secret a)

    {- Uncomment to manually enter the W and B pins for each test -}
    {- input <- getLine
    let arInput = readAsArray input
    let wp      = arInput !! 1
    let bp      = head arInput -}

    {- print (bp, wp) -}

    let result = if bp < 4
            then playGame (Record (secret a) (list a ++ [((bp, wp), val)]))
            else length (list a) + 1 {- (Record (secret a) (list a ++ [((5, 5), val)])) -}
    result

playAllGames :: [[Int]] -> [Int] -> [Int]
playAllGames (p:ps) results
    | null ps = results ++ [playGame (Record p [])]
    | otherwise = playAllGames ps (results ++ [playGame (Record p [])])

main :: IO ()
main = do
    let games = playAllGames (take 10000 generateSeq) []
    print $ fromIntegral (sum games) / fromIntegral (length games)
