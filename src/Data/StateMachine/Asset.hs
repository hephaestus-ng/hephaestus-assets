module Data.StateMachine.Asset where

import Data.StateMachine.ParserT
import Data.StateMachine.Types

import SPL


instance Asset StateMachine = 
  initialize = init

  parserT = parserTranformations

  export = 




init = StateMachine (State 1) [(State 1)] [t]

t :: Transition
t s s = State $ s+s