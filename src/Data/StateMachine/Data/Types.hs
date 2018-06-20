module Data.StateMachine.Data.Types where

-- import Data.SPL

type Trace = [State]
type Var = String
type Label     = String
type Origin    = State
type Target    = State
type Event     = String
type Action    = [(Var -> (Int -> Int) -> StateMachine -> StateMachine)]
type Condition = [(Var -> (Int -> Bool) -> StateMachine -> Bool)]
type Memory = [(Var, Int)]

data State =
    InitialState 
  | FinalState
  | State Label
  deriving (Show)

type Transition =  (Origin, Event, Condition, Action, Target)

data StateMachine =
  StateMachine {
    states :: [State],
    transitions :: [Transition],
    memory :: Memory
  }


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



-- Transformations
--
-- setInitialState :: State -> Transformation StateMachine
-- setInitialState s _ (Product p) =
--   Product $ p { initialState = s }
--
-- setTransitionsList :: [Transition] -> Transformation StateMachine
-- setTransitionsList ts _ (Product p) =
--   Product $ p { transitions = ts }
--
-- setStates :: [State] -> Transformation StateMachine
-- setStates ss _ (Product p) =
--   Product $ p { states = ss }
