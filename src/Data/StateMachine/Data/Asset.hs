module Data.StateMachine.Data.Asset where

import Data.StateMachine.Data.ParserT
import Data.StateMachine.Data.Types

import SPL


instance Asset StateMachine = 
  initialize = init

  parserT = parserTranformation

  export = undefined




init = StateMachine (State 1) [(State 1)] [t]

t :: Transition
t s s = State $ s+s