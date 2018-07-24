{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeSynonymInstances #-}

module Data.StateMachine.Data.Types where

import Data.SPL hiding (Target)
import Control.Lens

type Trace     = [State]

type Var       = String
type Label     = String
type Event     = String

type Origin    = State
type Target    = State

type Action    = [(Var -> (Int -> Int) -> StateMachine -> StateMachine)]
type Condition = [(Var -> (Int -> Bool) -> StateMachine -> Bool)]

type Memory = [(Var, Int)]

data State =
    InitialState
  | FinalState
  | State Label
  deriving (Show, Eq)

type Transition = (Origin, Event, Condition, Action, Target)

data StateMachine =
  StateMachine {
    _states :: [State],
    _transitions :: [Transition],
    _memory :: Memory
  }
makeLenses ''StateMachine



-- Transformations

-- modifyMemory :: Var -> Int -> Transformation StateMachine
-- modifyMemory v i (Product sm) = undefined

addState :: State -> Transformation StateMachine
addState s _ = fmap $ over (states) (s :)

addTransition :: Transition -> Transformation StateMachine
addTransition t _ = fmap $ over (transitions) (t :)

removeState :: State -> Transformation StateMachine
removeState s _ = fmap $ over (states) (removeFromList s)

removeTransition :: Transition -> Transformation StateMachine
removeTransition t _ = fmap $ over (transitions) (removeFromList t)



removeFromList :: (Eq a) => a -> [a] -> [a]
removeFromList el xs = filter (\x -> x /= el) xs


-- typeChecker :: StateMachine -> Bool
-- typeChecker = undefined

-- run :: StateMachine -> [Event] -> (Trace, Memory)
-- run = undefined


-- Type checks
-- - A state in a transition MUST exist in states
-- - Exists InitialState and FinalState

-- start, insert, count, buy, error, end :: State
-- start = InitialState
-- insert = State "insertMoney"
-- count = State "countMoney"
-- buy = State "buyMoney"
-- error = State "moneyError"
-- end = FinalState

-- vendingMachine :: StateMachine
-- vendingMachine =
--   StateMachine
--     [start, insert, count, buy, error, end]
--     [(start, ""insert

--        (InitialState "start", State "insertMoney"),
--      (State "insertMoney", State "countMoney"),
--      (State "countMoney", State "buyProduct"),
--      (State "buyProduct", State "moneyError"),
--      (State "moneyError", State "insertMoney"),
--      (State "buyProduct", FinalState "deliverProduct")
--     ]
