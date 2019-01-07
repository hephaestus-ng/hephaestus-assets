module Data.StateMachine.Data.ParserT where

import Text.Parsec hiding (State)
import Text.Parsec.String

import Data.StateMachine.Data.Types
import Data.SPL


parserStateMachine :: Parsec String () (Transformation StateMachine)
parserStateMachine =
  parseAddState <|>
  parseAddTransition


parseAddState :: Parsec String () (Transformation StateMachine)
parseAddState =
  string "addState" >> many space >> string "("
  >> parseState >>= \ns -> string ")" >>
  return (addState ns)


-- parseRemoveState :: Parsec String () (Transformation StateMachine)
-- parseInitialState =
--   string "removeState" >> many space >> string "("
--   >> parseState >>= \s -> string ")" >>
--   return (removeState s)


parseAddTransition :: Parsec String () (Transformation StateMachine)
parseAddTransition =
  string "addTransition" >> many space >> string "("
  >> parseTransition >>= \t -> string ")" >>
  return (addTransition t)


parseState :: Parsec String () State
parseState =
  string "\"" >> many1 letter >>= \c -> string "\"" >> return (State c)


parseTransition :: Parsec String () Transition
parseTransition =
  many1 letter >>= \s -> string "," >>
  many1 letter >>= \e -> string "," >>
  many1 letter >>= \c -> string "," >>
  many1 letter >>= \a -> string "," >>
  many1 letter >>= \t ->
  return (State s, c, t)


-- pStates =
--   try (parseState >>= \n -> char ',' >> pStates >>= \ns -> return (n:ns))
--   <|>
--   (parseState >>= \r -> return [r])
