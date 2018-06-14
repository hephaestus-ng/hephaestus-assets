module Data.SourceCode.Data.ParserT where

import Text.Parsec
import Text.Parsec.String

import Data.SourceCode.Data.Types
import Data.SPL


parserSourceCode :: Parsec String () (Transformation ComponentModel)
parserSourceCode =
  parseSelect <|>
  parseDefine <|>
  parseRemove


parseSelect :: Parsec String () (Transformation ComponentModel)
parseSelect =
  string "select" >> many space >> string "("
  >> names >>= \ns -> string ")" >>
  return (selectComponents ns)


parseDefine :: Parsec String () (Transformation ComponentModel)
parseDefine =
  string "define" >> many space >> string "("
  >> parseName >>= \tag -> string ")" >>
  return (define tag)


parseRemove :: Parsec String () (Transformation ComponentModel)
parseRemove =
  string "remove" >> many space >> string "("
  >> names >>= \rs -> string ")" >>
  return (removeComponents rs)


parseName :: Parsec String () String
parseName =
  string "\"" >> many1 letter >>= \c -> string "\"" >> return c


names =
  try (parseName >>= \n -> char ',' >> names >>= \ns -> return (n:ns))
  <|>
  (parseName >>= \r -> return [r])
