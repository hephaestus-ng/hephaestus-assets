module Data.SourceCode.Data.ParserA where

import Text.Parsec
import Text.Parsec.String

import Data.SourceCode.Data.Types
import Data.SPL


parserAssetBase :: Parsec String () ComponentModel
parserAssetBase =
  many1 parseComponents >>= \cs -> blanks >>
  return (ComponentModel cs [] [] [] [])


parseComponents :: Parsec String () Component
parseComponents =
  many1 letter >>= \t  -> string " => [" >>
  files        >>= \fs -> blanks         >>
  return (t, fs)


files =
  try (manyTill anyChar (try (char ',')) >>= \f -> blanks >> files >>= \fs -> return (f:fs))
  <|>
  (manyTill anyChar (try (char ']')) >>= \f -> blanks >> return [f])


blanks = many (space <|> newline <|> tab)
