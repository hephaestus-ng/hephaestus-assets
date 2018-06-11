module Data.StateMachine.Data.Asset where

import Data.StateMachine.Data.ParserT
import Data.StateMachine.Data.Types

import Data.SPL


instance Asset StateMachine where
  initialize = Product $ initState

  parserT    = parserTransformation

  export     = undefined




initState = StateMachine (State "") [(State "")] [t]

t :: Transition
t (State s) = State s