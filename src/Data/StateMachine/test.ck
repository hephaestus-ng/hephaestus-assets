

vendingMachine => [addState("waiting"), addState("checkMoney"), addState("deliver")]

beverage => [editMemory("coca", 10), editMemory("sprite", 10)]


Not(soda) => [removeTransition("state1", )]
