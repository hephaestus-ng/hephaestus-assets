module ParserT where

import Text.Parsec
import Text.Parsec.String

import Data.StateMachine.Data.Types
import Data.SPL


parserTransformation :: Parsec String () (Transformation StateMachine)
parserTransformation =
  parseSelect <|>
  parseDefine <|>
  parseRemove


parseInitialState :: Parsec String () (Transformation StateMachine)
parseSelect =
  string "setInitialState" >> many space >> string "("
  >> names >>= \ns -> string ")" >>
  return (setInitialState ns)


parseStates :: Parsec String () (Transformation StateMachine)
parseDefine =
  string "setStates" >> many space >> string "("
  >> parseName >>= \tag -> string ")" >>
  return (define tag)


parseRemove :: Parsec String () (Transformation StateMachine)
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
  

