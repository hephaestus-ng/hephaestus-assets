module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"



f :: Int -> [Int] -> [Int]
f n arr = [ x | x <- arr, x < n ]
