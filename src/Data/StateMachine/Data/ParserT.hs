module Data.StateMachine.Data.ParserT where

import Text.Parsec hiding (State)
import Text.Parsec.String

import Data.StateMachine.Data.Types
import Data.SPL


parserTransformation :: Parsec String () (Transformation StateMachine)
parserTransformation =
  parseInitialState <|>
  parseStates  


parseStates :: Parsec String () (Transformation StateMachine)
parseStates =
  string "setInitialState" >> many space >> string "("
  >> pStates >>= \ns -> string ")" >>
  return (setStates ns)


parseInitialState :: Parsec String () (Transformation StateMachine)
parseInitialState =
  string "setStates" >> many space >> string "("
  >> parseState >>= \s -> string ")" >>
  return (setInitialState s)


parseState :: Parsec String () State
parseState =
  string "\"" >> many1 letter >>= \c -> string "\"" >> return (State c)


pStates =
  try (parseState >>= \n -> char ',' >> pStates >>= \ns -> return (n:ns))
  <|>
  (parseState >>= \r -> return [r])
  

