[Level 11. Elevator](https://ethernaut.openzeppelin.com/level/0x6DcE47e94Fa22F8E2d8A7FDf538602B1F86aBFd2)

## In A Nutshell

> Functions without `pure` or `view` modifiers may lead to unexpected state modifications.

## Concept

1. `pure` and `view` modifiers.
2. Be careful when inheriting contracts.

## Level Target

1. Reach the top of the building, aka make the state variable `top` to `true`.

## Breakdown & Analysis

1. In Solidity, boolean values are default set to `false` if not explicitly initialized.
2. In contract `Elevator`, the only code that modifies the value of `top` is located in function `goTo`, specifically inside `if` statement.
3. To execute the code inside `if` statement, `isLastFloor(_floor)` should return `false`.
4. Inside the `if` statement, `top` can be set to `true` only if `isLastFloor(_floor)`  returns `true`.

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut_Writeup/blob/main/11.%20Elevator%20%E2%98%85%E2%98%85%E2%98%86%E2%98%86%E2%98%86/Attack.sol).

## State Modifier - `pure` & `view`

