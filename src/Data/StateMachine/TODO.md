* Finish state machine type implementations

* Test all transformations and final builded product

* Before build, it needs to type check for the following:
  * has initial state
  * transitions are deterministic
  * has final state

* Exported format for FSM interpreter:
  * will have builded state machine, but what about its       navigation?
  * interpreter needs to read:
    - initial state
    - states
    - transitions


* Derive initial SM through a DSL -> Parser
