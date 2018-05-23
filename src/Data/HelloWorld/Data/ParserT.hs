module Data.HelloWorld.Data.ParserT where

import Text.Parsec
import Text.Parsec.String

import Data.HelloWorld.Data.Types

import Data.SPL


hwParser :: Parsec String () (Transformation HwAsset)
hwParser = string "setMessage(\"" >> many1 letter >>= \s -> string "\")" >> return (setMessage s)
