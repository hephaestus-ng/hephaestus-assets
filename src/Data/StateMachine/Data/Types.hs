module Data.StateMachine.Types where

import Data.SPL

data State = State String

type Transition = State -> State

data StateMachine = 
  StateMachine {
    initialState :: State ,

    states :: [State],

    transitions :: [Transition]

  }



setInitialState :: State -> Transformation StateMachine
setInitialState s _ (Product p) = 
  Product $ p { initialState = s }

setTransitionsList :: [Transition] -> Transformation StateMachine
setTransitionsList ts _ (Product p) =
  Product $ p { transitions = ts }

setStates :: [State] -> Transformation StateMachine
setStates ss _ (Product p) =
  Product $ p { states = ss }