module Data.StateMachine.Data.Types where

-- import Data.SPL

data State =
    InitialState String
  | FinalState String
  | State String
  deriving (Show)

type Transition = (State, State)

data StateMachine =
  StateMachine {

    states :: [State],

    transitions :: [Transition]
  }
  deriving (Show)

-- Type checks
-- - A state in a transition MUST exist in states
-- - Exists InitialState and FinalState

vendingMachine :: StateMachine
vendingMachine =
  StateMachine
    [InitialState "start", State "insertMoney", State "countMoney", State "buyProduct", State "moneyError", FinalState "deliverProduct"]
    [(InitialState "start", State "insertMoney"),
     (State "insertMoney", State "countMoney"),
     (State "countMoney", State "buyProduct"),
     (State "buyProduct", State "moneyError"),
     (State "moneyError", State "insertMoney"),
     (State "buyProduct", FinalState "deliverProduct")
    ]



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
