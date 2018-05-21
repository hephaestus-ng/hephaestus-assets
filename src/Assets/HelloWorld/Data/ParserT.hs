module HelloWorld.Data.ParserT where

import Text.Parsec
import Text.Parsec.String

import HelloWorld.Data.Types

import Data.SPL

-- ParserT -> this would go on Parser/Transformation.hs
hwParser :: Parsec String () (Transformation HwAsset)
hwParser = string "setMessage(\"" >> many1 letter >>= \s -> string "\")" >> return (setMessage s)
