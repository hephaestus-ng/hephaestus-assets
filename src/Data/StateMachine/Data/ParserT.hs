module Data.StateMachine.Data.ParserT where

import Text.Parsec
import Text.Parsec.String

import Data.StateMachine.Data.Types
import Data.SPL


parserTransformation :: Parsec String () (Transformation StateMachine)
parserTransformation =
  parseInitialState <|>
  parseStates       <|>


parseInitialState :: Parsec String () (Transformation StateMachine)
parseSelect =
  string "setInitialState" >> many space >> string "("
  >> names >>= \ns -> string ")" >>
  return (setInitialState ns)


parseStates :: Parsec String () (Transformation StateMachine)
parseDefine =
  string "setStates" >> many space >> string "("
  >> parseName >>= \tag -> string ")" >>
  return (setStates tag)


names =
  try (parseName >>= \n -> char ',' >> names >>= \ns -> return (n:ns))
  <|>
  (parseName >>= \r -> return [r])
  

